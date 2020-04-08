/**
 * Created by mryzhkouskaya on 21.11.2019.
 */

public class Client {
    public static void main(String[] args) {

        Employee CEO = new Employee('John','CEO', 30000);

        Employee headSales = new Employee('Robert','Head Sales', 20000);

        Employee headMarketing = new Employee('Michel','Head Marketing', 20000);

        Employee clerk1 = new Employee('Laura','Marketing', 10000);
        Employee clerk2 = new Employee('Bob','Marketing', 10000);

        Employee salesExecutive1 = new Employee('Richard','Sales', 10000);
        Employee salesExecutive2 = new Employee('Rob','Sales', 10000);

        CEO.addEmployee(headSales);
        CEO.addEmployee(headMarketing);

        headSales.addEmployee(salesExecutive1);
        headSales.addEmployee(salesExecutive2);

        headMarketing.addEmployee(clerk1);
        headMarketing.addEmployee(clerk2);

        //print all employees of the organization
        System.debug(CEO);

        for (Employee headEmployee : CEO.getSubordinates()) {
            System.debug(headEmployee);

            for (Employee employee : headEmployee.getSubordinates()) {
                System.debug(employee);
            }
        }
    }
}