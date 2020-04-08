/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Facade_Computer implements Facade_Interface_Computer{

    Facade_Power power = new Facade_Power();
    Facade_DVDRom dvd = new Facade_DVDRom();
    Facade_HDD hdd = new Facade_HDD();

    public void copy(){
        power.onPower();
        dvd.load();
        hdd.copyFromDVD(dvd);
    }
}