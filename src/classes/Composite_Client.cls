/**
 * Created by mryzhkouskaya on 02.12.2019.
 */

public class Composite_Client {
    public static void main(String[] args) {

        Composite_Computer computer = new Composite_Computer(1);
        Composite_Computer computer2 = new Composite_Computer(4);
        Composite_WashingMachine washingMachine = new Composite_WashingMachine(2);
        Composite_Speakers speakers = new Composite_Speakers(3);


        Composite_Composite smallBox = new Composite_Composite(5);
        Composite_Composite mediumBox = new Composite_Composite(6);
        Composite_Composite bigBox = new Composite_Composite(7);

        smallBox.addComponent(washingMachine);

        mediumBox.addComponent(computer);
        mediumBox.addComponent(speakers);

        bigBox.addComponent(smallBox);
        bigBox.addComponent(mediumBox);
        bigBox.addComponent(computer2);

        bigBox.description();
    }
}