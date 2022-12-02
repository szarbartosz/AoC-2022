import java.util.Map;
import java.util.HashMap;
import java.io.File;
import java.util.Scanner;
import java.io.FileNotFoundException;

public class Solution {
    public static void main(String[] args) {
        Scanner scanner = readFile("input.txt");
        Integer pointsEarnedPt1 = 0;
        Integer pointsEarnedPt2 = 0;
        Map<String, Integer> outcomeMapPt1 = new HashMap<String, Integer>();
        outcomeMapPt1.put("AX", 3 + 1);
        outcomeMapPt1.put("AY", 6 + 2);
        outcomeMapPt1.put("AZ", 0 + 3);
        outcomeMapPt1.put("BX", 0 + 1);
        outcomeMapPt1.put("BY", 3 + 2);
        outcomeMapPt1.put("BZ", 6 + 3);
        outcomeMapPt1.put("CX", 6 + 1);
        outcomeMapPt1.put("CY", 0 + 2);
        outcomeMapPt1.put("CZ", 3 + 3);
        Map<String, Integer> outcomeMapPt2 = new HashMap<String, Integer>();
        outcomeMapPt2.put("AX", 0 + 3);
        outcomeMapPt2.put("AY", 3 + 1);
        outcomeMapPt2.put("AZ", 6 + 2);
        outcomeMapPt2.put("BX", 0 + 1);
        outcomeMapPt2.put("BY", 3 + 2);
        outcomeMapPt2.put("BZ", 6 + 3);
        outcomeMapPt2.put("CX", 0 + 2);
        outcomeMapPt2.put("CY", 3 + 3);
        outcomeMapPt2.put("CZ", 6 + 1);

        while (scanner.hasNextLine()) {
            String data = scanner.nextLine().replaceAll("\\s","");
            pointsEarnedPt1 += outcomeMapPt1.get(data);
            pointsEarnedPt2 += outcomeMapPt2.get(data);
        }

        System.out.println(pointsEarnedPt1);
        System.out.println(pointsEarnedPt2);
    }

    private static Scanner readFile(String filename) {
        try {
            File file = new File("input.txt");
            return new Scanner(file);
        } catch (FileNotFoundException e) {
            System.out.println("File not found!");
            e.printStackTrace();
        }

        return null;
    }
}
