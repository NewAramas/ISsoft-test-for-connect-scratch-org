/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Composite_ClientWithDevelopers {

    public static void main(String[] args) {

        Composite_Team team = new Composite_Team();

        Composite_JavaDeveloper firstDeveloper = new Composite_JavaDeveloper();
        Composite_JavaDeveloper secondDeveloper = new Composite_JavaDeveloper();
        Composite_CppDeveloper thirdDeveloper = new Composite_CppDeveloper();

        team.addDeveloper(firstDeveloper);
        team.addDeveloper(secondDeveloper);
        team.addDeveloper(thirdDeveloper);

//        team.createProject();
        team.writeCode();

    }
}