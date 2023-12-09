// lab_3.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <iomanip>

using namespace std;
enum FigureType {
    Cir,
    Rect,
    Tr,
    Sq,

};
struct Circle {
    int r;
    int S;
};
struct Rectangle {
    int len;
    int width;
    int S;
};
struct Triangle {
    int side1;
    int side2;
    int side3;
    int S;
};
struct Square {
    int len;
    int S;
};

FigureType randomType();
int randomLen(int min, int max);
int circleS(int r);
int rectangleS(int len, int width);
int triangleS(int side1, int side2, int side3);
int squareS(int len);
void figureS(void* figs);
int circleСS(int r);
int rectangleСS(int len, int width);
int triangleСS(int side, int h);
int squareСS(int len);

int main()
{
    const int N = 10;
    void* Figures[N];
    FigureType Types[N];
    FigureType Type;
    int flag = 1;
    int sum_s, min_s, min = 1, max = 10;
    int a[] = { 0, 0, 0, 0 };
    for (int i = 0; i < N; i++) {
        Type = randomType();
        switch (Type)
        {
        case Cir:
            Types[i] = Type;
            Figures[i] = new Circle;
            ((Circle*)Figures[i])->r = randomLen(min, max);
            ((Circle*)Figures[i])->S = circleS(((Circle*)Figures[i])->r);
            break;
        case Rect:
            Types[i] = Type;
            Figures[i] = new Rectangle;
            ((Rectangle*)Figures[i])->width = randomLen(min, max);
            ((Rectangle*)Figures[i])->len = randomLen(min, max);
            ((Rectangle*)Figures[i])->S = rectangleS(((Rectangle*)Figures[i])->len, ((Rectangle*)Figures[i])->width);
            break;
        case Tr:
            Types[i] = Type;
            Figures[i] = new Triangle;
            ((Triangle*)Figures[i])->side1 = randomLen(min, max);
            ((Triangle*)Figures[i])->side2 = randomLen(min, max);
            ((Triangle*)Figures[i])->side3 = randomLen(min, max);
            ((Triangle*)Figures[i])->S = triangleS(((Triangle*)Figures[i])->side1, ((Triangle*)Figures[i])->side2, ((Triangle*)Figures[i])->side3);
            break;
        case Sq:
            Types[i] = Type;
            Figures[i] = new Square;
            ((Square*)Figures[i])->len = randomLen(min, max);
            ((Square*)Figures[i])->S = squareS(((Square*)Figures[i])->len);
            break;
        default:
            break;
        }
    }
    /*for (int i = 0; i < N; i++) {
        switch (Types[i])
        {
        case Cir:
            cout << "That circle" << ((Circle*)Figures[i])->r << "\n";
            break;
        case Rect:
            cout << "That rectangle"<< ((Rectangle*)Figures[i])->len << "\n";
            break;
        case Tr:
            cout << "That triangle"<< ((Triangle*)Figures[i])->side << "\n";
            break;
        case Sq:
            cout << "That square"<< ((Square*)Figures[i])->len << "\n";
            break;
        default:
            break;
        }
    }*/

    while (flag != 0)
    {
        cin >> flag;
        switch (flag)
        {
        case 1:

            for (int i = 0; i < N; i++) {
                switch (Types[i])
                {
                case Cir:
                    sum_s += ((Circle*)Figures[i])->S;
                    break;
                case Rect:
                    sum_s += ((Rectangle*)Figures[i])->S;
                    break;
                case Tr:
                    sum_s += ((Triangle*)Figures[i])->S;
                    break;
                case Sq:
                    sum_s += ((Square*)Figures[i])->S;
                    break;
                default:
                    break;
                }
            }
            cout << sum_s << "\n";
            sum_s = 0;
            break;
        case 2:
            cout << "input minmal square";
            cin >> min_s;
            for (int i = 0; i < N; i++) {
                switch (Types[i])
                {
                case Cir:
                    if (((Circle*)Figures[i])->S < min_s) {
                        break;
                    }
                    cout << "That circle" << ((Circle*)Figures[i])->S << "\n";
                    break;
                case Rect:
                    if (((Rectangle*)Figures[i])->S < min_s) {
                        break;
                    }
                    cout << "That rectangle" << ((Rectangle*)Figures[i])->S << " " << "\n";
                    break;
                case Tr:
                    if (((Triangle*)Figures[i])->S < min_s) {
                        break;
                    }
                    cout << "That triangle" << ((Triangle*)Figures[i])->S << "\n";
                    break;
                case Sq:
                    if (((Square*)Figures[i])->S < min_s) {
                        break;
                    }
                    cout << "That square" << ((Square*)Figures[i])->S << "\n";
                    break;
                default:
                    break;
                }
            }
            break;
        case 3:
            for (int i = 0; i < N; i++) {
                switch (Types[i])
                {
                case Cir:
                    a[0] = 1;
                    break;
                case Rect:
                    a[1] = 1;
                    break;
                case Tr:
                    a[2] = 1;
                    break;
                case Sq:
                    a[3] = 1;
                    break;                
                default:
                    break;
                }
            }
            cout << a[0] + a[1] + a[2] + a[3];
            for (int i = 0; i < 3; i++) {
                a[i] = 0;
            }
            break;
        case 4: 

        default:
            break;
        }
    }
}
FigureType randomType() {
    int a, max = 4, min = 1;
    a = min + rand() % (max - min + 1);
    switch (a)
    {
    case(1):
        return Cir;
        break;
    case(2):
        return Tr;
        break;
    case(3):
        return Rect;
        break;
    default:
        return Sq;
        break;
    }
}
int circleS(int r) {
    return 3.14 * r * r / 2;
}
int rectangleS(int len, int width) {
    return len * width;

}
int triangleS(int side1, int side2, int side3) {
    int p = (side1 + side2 + side3)/2;
    return (int)sqrt(p* (p - side1)* (p - side2)* (p - side3));
}
int squareS(int len) {
    return len * len;
}
void figureS(void** figs, FigureType* mtypes, int N) {
    
}

int randomLen(int min, int max) {
    return  min + rand() % (max - min + 1);
}
int circleСS(int r) {
    return r;
}
int rectangleСS(int len, int width) {
    return sqrt(len * len + width* width);
}
int triangleСS(int side1, int side2, int side3) {
    int p = (side1 + side2 + side3) / 2;
    return (side1 * side2 * side3) / (int)sqrt(p * (p - side1) * (p - side2) * (p - side3));
}
int squareСS(int len) {
    return sqrt(len * len + len * len);
}
