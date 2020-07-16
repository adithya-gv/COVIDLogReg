import java.io.*;
import javax.json.*;
import java.net.*;
import java.util.*;

public class CACaseGather {

    public static void main(String[] args) throws IOException{
        Calendar calendar = Calendar.getInstance(TimeZone.getDefault());
        int year = calendar.get(Calendar.YEAR);
        int dayOfYear = calendar.get(Calendar.DAY_OF_YEAR);
        while (year > 2020) {
            dayOfYear = dayOfYear + 365;
            year--;
        }
        int upper = (dayOfYear - 197) + 133;
        URL url = new URL("https://covidtracking.com/api/v1/states/ca/daily.json");
        InputStream is = url.openStream();
		JsonReader reader = Json.createReader(new InputStreamReader(is, "UTF-8"));
        JsonArray jo = reader.readArray();
        ArrayList<Integer> cases = new ArrayList<Integer>();
        for (int i = 0; i < upper + 1; i++) {
            JsonObject jo1 = jo.getJsonObject(i);
            int caseCount = jo1.getInt("positive");
            cases.add(caseCount);
        }
        PrintStream output1 = new PrintStream("CACaseCount.dat");
        PrintStream output2 = new PrintStream("day.dat");
        int j = 1;
        for (int i = cases.size() - 1; i >= 0; i--) {
            System.setOut(output2);
            System.out.println(j);
            j++;
            System.setOut(output1);
            int caseDay = cases.get(i);
            System.out.println(caseDay);
        }
    }

}