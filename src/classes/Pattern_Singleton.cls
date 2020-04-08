/**
 * Created by mryzhkouskaya on 04.12.2019.
 */

public class Pattern_Singleton {

    public static Integer counter = 0;

    private  static Pattern_Singleton instance = new Pattern_Singleton();

    private Pattern_Singleton(){
        counter++;
    }


    public static Pattern_Singleton getSingleton(){

        return instance;

    }

    //для однопоточной среды
//    public static Integer counter = 0;
//
//    private  static Pattern_Singleton instance;
//    private Pattern_Singleton(){
//        counter++;
//    }
//
//    public static Pattern_Singleton getSingleton(){
//        if(instance == null){
//            instance = new Pattern_Singleton();
//        }
//            return instance;
//
//    }
}