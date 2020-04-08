/**
 * Created by mryzhkouskaya on 21.11.2019.
 */

public class ShapeMaker {
    private Shape circle;
    private Shape rectangle;
    private Shape square;

    public ShapeMaker() {
        circle = new Circle();
        rectangle = new Rectangle();
        square = new Square();
    }

    public void drawShapeMaker(){
        circle.draw();
        rectangle.draw();
        square.draw();
    }

}