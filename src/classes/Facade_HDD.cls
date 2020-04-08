/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Facade_HDD {

    public void copyFromDVD(Facade_DVDRom dvd){
        
        if(dvd.hasData()){
            System.debug('Происходит копирование с диска');
        } else{
            System.debug('Вставьте диск с данными');
        }
    }

}