/**
 * Created by mryzhkouskaya on 21.11.2019.
 */

public class Employee {
    private String name;
    private String dept;
    private Integer salary;
    private List<Employee> subordinates;

    // constructor
    public Employee(String name, String dept, Integer sal) {
        this.name = name;
        this.dept = dept;
        this.salary = sal;
        subordinates = new List<Employee>();
    }

    public void addEmployee(Employee e) {
        subordinates.add(e);
    }

    public List<Employee> getSubordinates(){
        return subordinates;
    }

}