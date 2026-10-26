import java.util.*;

abstract class Passenger {
    String name;
    int age;

    Passenger(String name, int age) {
        this.name = name;
        this.age = age;
    }

    abstract double discount();
    abstract String type();
}

class Regular extends Passenger {
    Regular(String n, int a) { super(n, a); }
    double discount() { return 0; }
    String type() { return "Regular"; }
}

class Student extends Passenger {
    Student(String n, int a) { super(n, a); }
    double discount() { return 0.10; }
    String type() { return "Student"; }
}

class Flight {
    String code, airline, from, to;
    int seats;
    double fare;

    Flight(String c, String a, String f, String t, int s, double fare) {
        code = c;
        airline = a;
        from = f;
        to = t;
        seats = s;
        this.fare = fare;
    }

    void display() {
        System.out.println(code + " | " + airline + " | " + from + " to "
                + to + " | Seats: " + seats + " | Fare: Rs." + fare);
    }
}

class Booking {
    String id;
    Flight flight;
    Passenger passenger;
    int tickets;
    double total;

    Booking(String id, Flight f, Passenger p, int t) {
        this.id = id;
        flight = f;
        passenger = p;
        tickets = t;
        total = f.fare * t * (1 - p.discount());
    }

    void display() {
        double subtotal = flight.fare * tickets;
        System.out.println("\nBooking ID: " + id);
        System.out.println("Flight: " + flight.code + " | "
                + flight.from + " to " + flight.to);
        System.out.println("Passenger: " + passenger.name);
        System.out.println("Age: " + passenger.age);
        System.out.println("Type: " + passenger.type());
        System.out.println("Tickets: " + tickets);
        System.out.println("Subtotal: Rs." + subtotal);
        System.out.println("Discount: Rs." + (subtotal - total));
        System.out.println("Final Amount: Rs." + total);
    }
}

class FlightBookingSystem {
    Scanner sc = new Scanner(System.in);

    Flight[] flights = {
        new Flight("PN101", "Kiran Air", "Pune", "Delhi", 20, 4000),
        new Flight("MB102", "Kiran Air", "Mumbai", "Bengaluru", 25, 3500),
        new Flight("PH103", "Kiran Air", "Pune", "Hyderabad", 15, 3000)
    };

    Booking booking;
    int id = 1001;

    void viewFlights() {
        for (Flight f : flights)
            f.display();
    }

    Flight findFlight(String code) {
        for (Flight f : flights)
            if (f.code.equalsIgnoreCase(code))
                return f;
        return null;
    }

    void bookFlight() {
        try {
            System.out.print("Flight code: ");
            Flight f = findFlight(sc.nextLine().trim());

            System.out.print("Passenger name: ");
            String name = sc.nextLine().trim();

            System.out.print("Age: ");
            int age = Integer.parseInt(sc.nextLine());

            System.out.print("Passenger type (Regular/Student): ");
            String type = sc.nextLine().trim();

            System.out.print("Number of tickets: ");
            int n = Integer.parseInt(sc.nextLine());

            if (f == null || name.isEmpty() || age <= 0 || n <= 0 ||
                (!type.equalsIgnoreCase("Regular") &&
                 !type.equalsIgnoreCase("Student"))) {
                System.out.println("Invalid booking details.");
                return;
            }

            if (n > f.seats) {
                System.out.println("Not enough seats available.");
                return;
            }

            Passenger p = type.equalsIgnoreCase("Student")
                    ? new Student(name, age)
                    : new Regular(name, age);

            booking = new Booking("BK" + id++, f, p, n);
            f.seats -= n;

            System.out.println("Booking confirmed!");
            booking.display();

        } catch (NumberFormatException e) {
            System.out.println("Age and tickets must be valid numbers.");
        }
    }

    void start() {
        while (true) {
            System.out.println("\nWelcome to Kiran Air Booking");
            System.out.println("1. View Flights");
            System.out.println("2. Book Flight");
            System.out.println("3. View Booking");
            System.out.println("4. Exit");
            System.out.print("Enter choice: ");

            switch (sc.nextLine()) {
                case "1": viewFlights(); break;
                case "2": bookFlight(); break;
                case "3":
                    if (booking == null)
                        System.out.println("No booking found.");
                    else
                        booking.display();
                    break;
                case "4":
                    System.out.println("Thank you for using Kiran Air Booking!");
                    return;
                default:
                    System.out.println("Invalid choice.");
            }
        }
    }
}

public class chatbot {
    public static void main(String[] args) {
        new FlightBookingSystem().start();
    }
}