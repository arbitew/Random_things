
#include <iostream>

using namespace std;
/*
 * Вывод простых чисел
 *
 * @param mass_len число до которого выводим.
 */
 void simpleNums(int const mass_len) { // количество чисел
    int *nums = new int [mass_len]; // массив чисел
    for (int i = 1; i < mass_len; i++) { // заполнение массива
        nums[i] = i + 1;
    }
    nums[0] = 0; // единица не является простым числом
    for (int i = 0; i < mass_len; i++) { // цикл
        if (nums[i] != 0) { // если число не равно нулю (простое)
            printf("%d\n", nums[i]); // выводим простое число
            for (int j = nums[i] * nums[i] - 1; j <= mass_len; j+=nums[i]) { // просматриваем, делятся ли числа на данное простое число
                nums[j] = 0;
            }
        }
    }   
}

int main()
{   
    simpleNums(100);
    return 0;
}

 