
#include <iostream>

class Figure {
public:
    void* figure_obj;
    std::string figure_type;
    Figure(void* figure_obj, std::string figure_type) {
        this->figure_obj = figure_obj;
        this->figure_type = figure_type;
    }
    Figure() {
        figure_obj = nullptr;
        figure_type = "";
    }
};
class Square {
public:
    int side;
    void print_adress() {
        std::cout << this;
    }
    int square_s() {
        return side * side;
    }
    Square() {
        side = 5;
    }
    Square(int side) {
        this->side = side;
    }
    Square(const Square& square) {
        this->side = square.side;
    }
};
class Circle {
public:
    int rad;
    void print_adress() {
        std::cout << this;
    }
    int circle_s() {
        return (int)(rad * rad * 3.14);
    }
    Circle(int rad) {
        this->rad = rad;
    }
    Circle(const Circle& circle) {
        this->rad = circle.rad;
    }
};
class Rectangle {
public:
    int width;
    int height;
    int rectangle_s() {
        return width * height;
    }
    Rectangle(int width, int height) {
        this->width = width;
        this->height = height;
    }
    Rectangle(const Rectangle& rectangle) {
        this->width = rectangle.width;
        this->height = rectangle.height;
    }
};
class Triangle {
public:
    int side1 = 1;
    int side2 = 1;
    int side3 = 1;
    int triangle_s() {
        int p = (int)((side1 + side2 + side3) / 2);
        return (int)(sqrt(p * (p - side1) * (p - side2) * (p - side3)));
    }
    void print_adress() {
        std::cout << this;
    }
    Triangle(int side1, int side2, int side3) {
        this->side1 = side1;
        this->side2 = side2;
        this->side3 = side3;
    }
    Triangle(const Triangle& triangle) {
        this->side1 = triangle.side1;
        this->side2 = triangle.side2;
        this->side3 = triangle.side3;
    }
};
class Scene {
public:
    Figure* Figures;
    int s;
    Scene(Figure* Figures, int s) {
        this->Figures = Figures;
        this->s = s;
    }
    void figS(int len) {
        int s = 0;
        for (int i = 0; i < len; i++) {
            if (this->Figures[i].figure_type == "circle") {
                s += ((Circle*&)this->Figures[i].figure_obj)->circle_s();
            }
            if (this->Figures[i].figure_type == "square") {
                s += ((Square*&)this->Figures[i].figure_obj)->square_s();
            }
            if (this->Figures[i].figure_type == "rectangle") {
                s += ((Rectangle*&)this->Figures[i].figure_obj)->rectangle_s();
            }
            if (this->Figures[i].figure_type == "triangle") {
                s += ((Triangle*&)this->Figures[i].figure_obj)->triangle_s();
            }
        }
        std::cout << s << std::endl;
    }
};
int main()
{
    int n = 0;
    while (n < 1) {
        std::cin >> n;
    }
    Scene MyScene(new Figure[n], 1000);
    for (int i = 0; i < n; i++) {
        int a = rand() % 4;
        if (a == 0) {
            std::cout << "circle" << std::endl;
            MyScene.Figures[i] = Figure(new Circle(rand() % 10), "circle");
        }
        if (a == 1) {
            std::cout << "Square" << std::endl;
            MyScene.Figures[i] = Figure(new Square(rand() %10), "square");
        }
        if (a == 2) {
            std::cout << "rectangle" << std::endl;
            MyScene.Figures[i] = Figure(new Rectangle(rand() % 10, rand() %5), "rectangle");
        }
        if (a == 3) {
            std::cout << "triangle" << std::endl;
            MyScene.Figures[i] = Figure(new Triangle(rand() % 10, rand() % 19, rand() % 20), "triangle");
        }
    }
    MyScene.figS(n);
}   

