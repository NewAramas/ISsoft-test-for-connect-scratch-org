/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Composite_Computer implements Composite_Component{

    Integer identificator;
    public Composite_Computer(Integer identificator){
        this.identificator = identificator;
    }

    public void description (){

        System.debug('Computer with identificator = '+ identificator);
    }
}