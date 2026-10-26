import java.util.Scanner;

public class Bankapp {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        double balance = 10000;

        System.out.println("Welcome to Kiran Bank");
        System.out.println("Opening Balance: Rs.10000");

        while (true) {
            System.out.println("\n1. Check Balance");
            System.out.println("2. Deposit Money");
            System.out.println("3. Withdraw Money");
            System.out.println("4. Exit");
            System.out.print("Enter choice: ");

            int choice;
            try {
                choice = Integer.parseInt(sc.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Invalid choice.");
                continue;
            }

            if (choice == 1) {
                System.out.printf("Current Balance: Rs.%.2f%n", balance);
            } else if (choice == 2) {
                System.out.print("Enter deposit amount: ");

                try {
                    double amount = Double.parseDouble(sc.nextLine());

                    if (amount > 0) {
                        balance += amount;
                        System.out.println("Deposit successful.");
                        System.out.printf("Updated Balance: Rs.%.2f%n", balance);
                    } else {
                        System.out.println("Enter an amount greater than zero.");
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Invalid deposit amount.");
                }

            } else if (choice == 3) {
                System.out.print("Enter withdrawal amount: ");

                try {
                    double amount = Double.parseDouble(sc.nextLine());

                    if (amount <= 0) {
                        System.out.println("Enter an amount greater than zero.");
                    } else if (amount > balance) {
                        System.out.println("Transaction failed: Insufficient balance.");
                        System.out.printf("Current Balance: Rs.%.2f%n", balance);
                    } else {
                        balance -= amount;
                        System.out.println("Withdrawal successful.");
                        System.out.printf("Updated Balance: Rs.%.2f%n", balance);
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Invalid withdrawal amount.");
                }

            } else if (choice == 4) {
                System.out.println("Thank you for banking with us. Goodbye!");
                break;
            } else {
                System.out.println("Invalid choice. Please try again.");
            }
        }

        sc.close();
    }
}