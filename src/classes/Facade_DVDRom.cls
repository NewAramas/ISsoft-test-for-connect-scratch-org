/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Facade_DVDRom {

    private boolean data = false;

    public  boolean hasData(){
        return data;
    }
    public void load(){
        System.debug('Диск загружен');
        data = true;
    }
    public void unload(){
        data = false;
    }

}