/**
 * Created by mryzhkouskaya on 21.11.2019.
 */

public class Client_WithShapes {
    public static void main(String[] args) {
        Circle circle = new Circle(3);
        Rectangle rectangle = new Rectangle(5,4);
        Square square = new Square(6);

        Box boxWithCircleAndSquare = new Box();
        boxWithCircleAndSquare.addShape(circle);
        boxWithCircleAndSquare.addShape(square);
//        boxWithCircleAndRectangle.draw();
        boxWithCircleAndSquare.getSquare();

        Box boxWithTwoRectangles = new Box();
        boxWithTwoRectangles.addShape(rectangle);
        boxWithTwoRectangles.addShape(rectangle);

        Box bowWithCircleAndBoxWithTwoRectangles = new Box();
        bowWithCircleAndBoxWithTwoRectangles.addShape(circle);
        bowWithCircleAndBoxWithTwoRectangles.addShape(boxWithTwoRectangles);
//        bowWithCircleAndBoxWithTwoRectangles.draw();

        Box boxWith3boxes = new Box();
        boxWith3boxes.addShape(boxWithCircleAndSquare);
        boxWith3boxes.addShape(boxWithTwoRectangles);
        boxWith3boxes.addShape(bowWithCircleAndBoxWithTwoRectangles);
        boxWith3boxes.draw();
        boxWith3boxes.getSquare();



    }

}