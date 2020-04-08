/**
 * Created by mryzhkouskaya on 21.11.2019.
 */

public class Box implements Shape{
    List<Shape> components = new List<Shape>();

    public void addShape(Shape shape) {
        components.add(shape);
    }

    public void draw(){
        for(Shape component: components){
            component.draw();
        }
    }

    public Double getSquare(){
        Double generalSquareOBox = 0;
        for(Shape component: components){
            generalSquareOBox += component.getSquare();
        }
        System.debug('Box square is '+ generalSquareOBox);
        return generalSquareOBox;
    }
}