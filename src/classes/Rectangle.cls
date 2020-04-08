/**
 * Created by mryzhkouskaya on 21.11.2019.
 */

public  class Rectangle implements Shape{
    public Integer width;
    public Integer height;

    public Rectangle(Integer width, Integer height){
        this.height = height;
        this.width = width;
    }
    public Rectangle(){
    }
//    public Integer getWidth() {
//        return width;
//    }
//    public Integer getHeight() {
//        return height;
//    }
    public Double getSquare (){
        Double rectangleSquare = height * width;
        System.debug('Square square is '+ rectangleSquare);
        return rectangleSquare;
    }

    public void draw() {
        System.debug('Rectangle is drawing');
    }


}