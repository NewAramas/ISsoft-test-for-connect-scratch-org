/**
 * Created by mryzhkouskaya on 25.11.2019.
 */

public class Square implements Shape{
    public Integer width;

    public Square(Integer width){
        this.width = width;
    }

    public Square(){
    }

    public Double getSquare (){
        Double squareSquare = width * width;
        System.debug('Square square is '+ squareSquare);
        return squareSquare;
    }

    public void draw() {
        System.debug('Square is drawing');
    }

}