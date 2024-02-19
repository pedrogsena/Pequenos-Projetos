import java.util.Scanner;

public class Circle {


    // attributes
    private double centerX;
    private double centerY;
    private double radius;
    private double PI=3.1415926535897;

    // constructor
    public Circle (double centerX, double centerY, double radius) {
        this.centerX = centerX;
        this.centerY = centerY;
        this.radius = radius;
    }

    // getters and setters

    public double getCenterX () {
        return this.centerX;
    }

    public void setCenterX (double centerX) {
        this.centerX = centerX;
    }

    public double getCenterY () {
        return this.centerY;
    }

    public void setCenterY (double centerY) {
        this.centerY = centerY;
    }

    public double getRadius () {
        return this.radius;
    }

    public void setRadius (double radius) {
        this.radius = radius;
    }

    // other methods

    public double getArea () {
        return PI * radius * radius;
    }

    public double getPerimeter () {
        return 2 * PI * radius;
    }

    public int whereIsPoint (double pointX, double pointY) {
        int answer;
        double squareDistance = 0;
        squareDistance += (centerX - pointX) * (centerX - pointX);
        squareDistance += (centerY - pointY) * (centerY - pointY);
        if (squareDistance < (radius * radius)) {
            answer = -1;
        }
        else if (squareDistance > (radius * radius)) {
            answer = 1;
        }
        else {
            answer = 0;
        }
        return answer;
    }

    // main
    public static void main (String args[]) {

        Scanner dataInput = new Scanner(System.in);
        Circle myCircle = new Circle(0.0, 0.0, 0.0);

        System.out.print("circle's radius: ");
        myCircle.setRadius(dataInput.nextDouble());
        System.out.print("circle's center's x coordinate: ");
        myCircle.setCenterX(dataInput.nextDouble());
        System.out.print("circle's center's y coordinate: ");
        myCircle.setCenterY(dataInput.nextDouble());
        System.out.println("circle has area equal to " + myCircle.getArea() + " and perimeter equal to " + myCircle.getPerimeter());

        double pointX, pointY;
        boolean keepGoing = true;
        int answer = 1;

        while (keepGoing) {
            System.out.print("point's x coordinate: ");
            pointX = dataInput.nextDouble();
            System.out.print("point's y coordinate: ");
            pointY = dataInput.nextDouble();
            if (myCircle.whereIsPoint(pointX,pointY) > 0) {
                System.out.println("your point is outside the circle");
            }
            else if (myCircle.whereIsPoint(pointX,pointY) < 0) {
                System.out.println("your point is inside the circle");
            }
            else {
                System.out.println("your point is in the circumference of the circle");
            }
            System.out.print("keep going? (yes: 1 / no: 0) ");
            answer = dataInput.nextInt();
            if (answer == 0) {
                keepGoing = false;
            }
        }

    }

}
