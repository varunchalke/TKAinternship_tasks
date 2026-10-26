import java.util.*;

public class CabBookingChatbot {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        Random random = new Random();

        String[] cabs = {"Auto", "Sedan", "SUV"};
        int[] rates = {12, 18, 25};
        String[] sources = {"Pune Station", "Swargate", "Hinjawadi"};
        String[] destinations = {"Shivajinagar", "Kothrud", "Wakad"};
        int[] distances = {5, 8, 10};

        while (true) {
            System.out.println("\nWelcome to Cab Booking Chatbot");
            System.out.println("1. Book Ride");
            System.out.println("2. Exit");
            System.out.print("Enter choice: ");

            int choice;
            try {
                choice = Integer.parseInt(sc.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Invalid choice.");
                continue;
            }

            if (choice == 2) {
                System.out.println("Thank you for using our service!");
                break;
            }

            if (choice != 1) {
                System.out.println("Invalid choice.");
                continue;
            }

            System.out.println("1. Auto - Rs.12/km");
            System.out.println("2. Sedan - Rs.18/km");
            System.out.println("3. SUV - Rs.25/km");
            System.out.print("Choose cab: ");

            int cab;
            try {
                cab = Integer.parseInt(sc.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Invalid cab choice.");
                continue;
            }

            if (cab < 1 || cab > 3) {
                System.out.println("Invalid cab choice.");
                continue;
            }

            System.out.println("1. Pune Station to Shivajinagar - 5 km");
            System.out.println("2. Swargate to Kothrud - 8 km");
            System.out.println("3. Hinjawadi to Wakad - 10 km");
            System.out.print("Choose route: ");

            int route;
            try {
                route = Integer.parseInt(sc.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Invalid route choice.");
                continue;
            }

            if (route < 1 || route > 3) {
                System.out.println("Invalid route choice.");
                continue;
            }

            int i = route - 1;
            int fare = distances[i] * rates[cab - 1];

            System.out.println("\nCab: " + cabs[cab - 1]);
            System.out.println("Source: " + sources[i]);
            System.out.println("Destination: " + destinations[i]);
            System.out.println("Distance: " + distances[i] + " km");
            System.out.println("Rate: Rs." + rates[cab - 1] + "/km");
            System.out.println("Total Fare: Rs." + fare);

            System.out.println("1. Confirm & Share OTP");
            System.out.println("2. Cancel Ride");
            System.out.print("Enter choice: ");

            int confirm;
            try {
                confirm = Integer.parseInt(sc.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Invalid choice. Ride not booked.");
                continue;
            }

            if (confirm == 2) {
                System.out.println("Ride cancelled. No OTP shared.");
            } else if (confirm == 1) {
                int otp = 1000 + random.nextInt(9000);
                System.out.println("Your OTP is: " + otp);
                System.out.println("Booking confirmed!");
                System.out.println("Cancellation is not allowed after OTP sharing.");
            } else {
                System.out.println("Invalid choice. Ride not booked.");
            }
        }

        sc.close();
    }
}