// Lab_9.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <vector>
class NatDiv {
private:
    int num;
    std::vector <int> div;
public:
    NatDiv(int num) :
        num(num)
    {
        for (int i = 1; i < (int)(num / 2) + 1; i++) {
            if ((num % i) == 0) {
                div.push_back(i);
            }
        }
        div.push_back(num);
    }
    NatDiv& operator=(const NatDiv&);
    friend std::ostream& operator<<(std::ostream& out, NatDiv& vec);
    void thisDel(int a) {
        //std::cout << std::count_if(div.begin(), div.end(), [](int i) { return i % 4 == 0; });
    }
    void numAvg() {
        int avgsum = 0;
        for (int i : div) {
            avgsum += i;
        }
        std::cout << avgsum / div.size() << std::endl;
    }
    int thatNum() {
        return num;
    }
    std::vector<int> vecDiv() {
        return div;
    }
    void myCopy(NatDiv second) {
        num = second.thatNum();
        div = second.vecDiv();
    }
    void gcd(NatDiv second) {
        int gcd = 0;
        std::vector <int> vec1 = div;
        std::reverse(vec1.begin(), vec1.end());
        std::vector <int> vec2 = second.vecDiv();
        auto n = std::find_if(vec1.begin(), vec1.end(), [vec2](int a) {
            for (int i = 0; i < vec2.size(); i++) {
                if ((a == vec2[i])) {
                    return true;
                }
            }
        return false;
            }
        );
        std::cout << n[0];
    }
};

std::ostream& operator<<(std::ostream& out, NatDiv& vec) {
    std::copy(vec.div.begin(), vec.div.end(), std::ostream_iterator<int>(out, " "));
    return out;
}

int main()
{
    NatDiv a(10);
    std::cout << a << std::endl;
    a.numAvg();
    NatDiv b(9);
    b.myCopy(a);
    std::cout << b << std::endl;
    NatDiv c(8);
    a.gcd(c);
}

// Запуск программы: CTRL+F5 или меню "Отладка" > "Запуск без отладки"
// Отладка программы: F5 или меню "Отладка" > "Запустить отладку"

// Советы по началу работы 
//   1. В окне обозревателя решений можно добавлять файлы и управлять ими.
//   2. В окне Team Explorer можно подключиться к системе управления версиями.
//   3. В окне "Выходные данные" можно просматривать выходные данные сборки и другие сообщения.
//   4. В окне "Список ошибок" можно просматривать ошибки.
//   5. Последовательно выберите пункты меню "Проект" > "Добавить новый элемент", чтобы создать файлы кода, или "Проект" > "Добавить существующий элемент", чтобы добавить в проект существующие файлы кода.
//   6. Чтобы снова открыть этот проект позже, выберите пункты меню "Файл" > "Открыть" > "Проект" и выберите SLN-файл.
