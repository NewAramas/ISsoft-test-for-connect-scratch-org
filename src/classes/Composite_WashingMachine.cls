/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Composite_WashingMachine implements Composite_Component{

    Integer identificator;
    public Composite_WashingMachine(Integer identificator){
        this.identificator = identificator;
    }

    public void description () {
        System.debug('Washing Machine with identificator = '+ identificator);
    }
}