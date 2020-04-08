/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Composite_Composite implements Composite_Component{

    Integer identificator;
    public Composite_Composite(Integer identificator){
        this.identificator = identificator;
    }

    List<Composite_Component> components = new List<Composite_Component>();

    public void addComponent(Composite_Component component) {
        components.add(component);
    }
//    remove??

    public void description (){
        for(Composite_Component component: components){
            component.description();
        }
    }
}