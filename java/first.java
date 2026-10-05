import java.util.Arrays;
import java.util.Scanner;

public class first {
    public static void main(String[] args) {

        System.out.println("hello world...Varun");

        // Task 2
        int cost_price = 25;
        int selling_price = 20;
        int total = cost_price + selling_price;

        System.out.println("total price = " + total);

        // Task 3
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter a number: ");
        int num = sc.nextInt();

        if (num % 2 == 0) {
            System.out.println("The number is Even");
        } else {
            System.out.println("The number is Odd");
        }

        // Task 4
        System.out.print("Enter your age: ");
        int age = sc.nextInt();

        if (age < 0) {
            System.out.println("Invalid age");
        } else if (age >= 18) {
            System.out.println("You are eligible for voting");
        } else {
            System.out.println("You are not eligible for voting");
        }

        // Task 5
        sc.nextLine();

        System.out.print("Enter word1: ");
        String word1 = sc.nextLine();

        System.out.print("Enter word2: ");
        String word2 = sc.nextLine();

        char[] a = word1.toLowerCase().toCharArray();
        char[] b = word2.toLowerCase().toCharArray();

        Arrays.sort(a);
        Arrays.sort(b);

        if (Arrays.equals(a, b)) {
            System.out.println("The words are Anagrams");
        } else {
            System.out.println("The words are not Anagrams");
        }

        sc.close();
    }
}