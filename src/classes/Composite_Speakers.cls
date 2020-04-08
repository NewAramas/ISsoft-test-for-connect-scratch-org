/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Composite_Speakers implements Composite_Component{
    Integer identificator;
    public Composite_Speakers(Integer identificator){
        this.identificator = identificator;
    }

    public void description () {
        System.debug('Speakers with identificator = '+ identificator);
    }
}