// Lab_8.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
template <typename T>
class MyVector {
private:
    T* container = nullptr;
    int length = 0;
public:
    class Iterator {
        private: 
            MyVector <T>* container;
            int index;
        public:
            Iterator(int index, MyVector <T>* container) :
                container(container),
                index(index > container->length ? -1 : index)
            {}
            Iterator& operator++() {
                if (index != container->length - 1) {
                    index++;
                }
                else {
                    index = -1;
                }
                return *this;
            }
            T& operator* () {
                return (*container)[index];
            }
            bool operator!=(Iterator& it) {
                return it.index != index;
            }
        };
    MyVector(int N) :
        length(N),
        container(new T[N])
    {
        for (int i = 0; i < length; i++) {
            container[i] = NULL;
        }
    }
    T& operator[](int i) {
        return container[i];
    }
    int getLen() {
        return length;
    }
    void addEl(T el) {
        T* new_cont = new T[length + 1];
        for (int i = 0; i < length; i++) {
            new_cont[i] = container[i];
        }
        new_cont[length] = el;
        length++;
        container = new_cont;
    }
    void delEl(int n_el) {
        n_el = abs(n_el) % length;
        T* new_cont = new T[length - 1];
        for (int i = 0; i < length - 1; i++) {
            if (i < n_el) {
                new_cont[i] = container[i];
            }
            else if (i >= n_el) {
                new_cont[i] = container[i + 1];
            }
        }
        length--;
        container = new_cont;
    }
    void isVoid() {
        int flag = 0;
        for (int i = 0; i < length; i++) {
            if (container[i] != NULL) {
                flag = 1;
                std::cout << "it isn't void";
                break;
            }
        }
        if (flag == 0) {
            std::cout << "it's void";
        }
        
    }
    Iterator& begin() {
        return *(new Iterator(0, this));
    }
    Iterator& end() {
        return *(new Iterator(-1, this));
    }
    template <typename TF>
    friend std::ostream& operator<<(std::ostream& out, MyVector<TF>& my_vec);
};

template <typename T>
std::ostream& operator<<(std::ostream& out, MyVector<T>& my_vec) {
    out << "[";
    for (int i = 0; i < my_vec.length; i++) {
        if (i < my_vec.length - 1) {
            out << my_vec[i] << ", ";
        }
        else {
            out << my_vec[i];
        }
    }
    out << "]";
    return out;
}
int main()
{
    MyVector <int> vec(2);
    vec.isVoid();
    std::cout << "\n\n";
    vec[0] = 1;
    vec[1] = 2;
    for (auto el : vec)
        std::cout << el << " ";
    std::cout << "\n\n";
    for (int el : vec) {
        std::cout << el << " ";
    }
    std::cout << "\n\n";
    std::cout << vec << " " << vec.getLen() << std::endl;
    vec.addEl(5);
    std::cout << vec << " " << vec.getLen() << std::endl;
    vec.delEl(1);
    std::cout << vec;
    vec.isVoid();
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
