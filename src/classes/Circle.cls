/**
 * Created by mryzhkouskaya on 21.11.2019.
 */

public class Circle implements Shape {
    public Integer radius;

    public Circle(Integer radius){
        this.radius = radius;
    }
//    public Circle(){
//    }
//
//    public Integer getWidth() {
//        return radius * 2;
//    }
//    public Integer getHeight() {
//        return radius * 2;
//    }
    public Double getSquare (){
        Double circleSquare = Math.PI * radius * radius;
        System.debug('Circle square is'+ circleSquare);
        return circleSquare;
    }

    public void draw() {
        System.debug('Circle is drawing');
    }


}