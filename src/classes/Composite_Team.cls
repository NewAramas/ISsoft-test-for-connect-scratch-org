/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Composite_Team implements Composite_Interface_Developer{

    private List<Composite_Interface_Developer> developers = new List<Composite_Interface_Developer>();

    public void addDeveloper(Composite_Interface_Developer developer){
        developers.add(developer);
    }

    public void writeCode(){
        System.debug('Team creates project...');
        for(Composite_Interface_Developer developer: developers){
            developer.writeCode();
        }
    }

//    public void createProject(){
//        System.debug('Team creates project...');
//        for(Composite_Interface_Developer developer: developers){
//            developer.writeCode();
//        }
//    }

}