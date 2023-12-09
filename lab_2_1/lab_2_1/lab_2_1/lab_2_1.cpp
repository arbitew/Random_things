
#include <iostream>
#include <iomanip>

using namespace std;
/*
 * Вывод массива на экран
 *
 * @param a главный массив.
 * @param N размерность массива.
 */
void printArr(int** a, int N) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            cout << setw(5) << a[i][j];
        }
        cout << "\n";
    }
}
/*
 * Стандартное заполнение массива
 *
 * @param a главный массив.
 * @param N размерность массива.
 */
void fillNorm(int** a, int N) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            a[i][j] = (i + 1) * (j + 1);

        }
    }
}
/*
 * Заполнение массива наоборот
 *
 * @param a главный массив.
 * @param N размерность массива.
 */
void fillRev(int** a, int N) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            a[i][j] = (N - i) * (N - j);
        }
    }
}
/*
 * Заполнение массива по основной диагонали
 *
 * @param a главный массив.
 * @param N размерность массива.
 */
void fillDiag(int** a, int N) {
    //1 3 6
    //2 5 8
    //4 7 9
    int i = 0, j = 0, i0 = 0, j0 = 0, flag = 0, num = 1;
    while ((i0 <= N - 1) && (j0 <= N - 1)) {
        if (flag == 0) {
            i = i0;
            j = j0;
            a[i][j] = num;
            num++;
            while (i > 0) {
                j++;
                i--;
                a[i][j] = num;
                num++;
            }
            i0++;
            if (i0 > N - 1) {
                flag = 1;
                i0 = N - 1;
                j0 = 1;
            }
            
        }
        else {
            i = i0;
            j = j0;
            a[i][j] = num;
            num++;
            while (j < N - 1) {
                j++;
                i--;
                a[i][j] = num;
                num++;
            }
            j0++;
            
        }
    }

}
/*
 * Заполнение массива по побочной диагонали
 *
 * @param a главный массив.
 * @param N размерность массива.
 */
void fillSecDiag(int** a, int N) {
    int i = 0, j = N - 1, i0 = 0, j0 = N - 1, flag = 0, num = 1;
    while ((i0 <= N - 1) && (j0 >= 0)) {
        if (flag == 0) {
            i = i0;
            j = j0;
            a[i][j] = num;
            num++;
            while (i > 0) {
                j--;
                i--;
                a[i][j] = num;
                num++;
            }
            i0++;
            if (i0 > N - 1) {
                flag = 1;
                i0 = N - 1;
                j0 = N - 2;
            }

        }
        else {
            i = i0;
            j = j0;
            a[i][j] = num;
            num++;
            while (j > 0) {
                j--;
                i--;
                a[i][j] = num;
                num++;
            }
            j0--;

        }
    }
}
/*
 * Заполнение массива спирально
 *
 * @param a главный массив.
 * @param N размерность массива.
 */
void fillSpiral(int** a, int N) {
    int counter = 2;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            a[i][j] = 0;
        }
    }
    a[0][0] = 1;
    int stop = 0;
    int fl = 0;
    int i = 0;
    int j = 0;
    while (fl == 0) {
        switch (stop % 4) {
        case 0:
            if (a[i][j + 1] != 0) {
                fl = 1;
                break;
            }
            while (j < N - 1) {
                if (a[i][j + 1] != 0) {
                    stop++;
                    break;
                }
                j++;
                a[i][j] = counter;
                counter++;
                if (j == N - 1) {
                    stop++;
                }
            }
            break;
        case 1:
            if (a[i + 1][j] != 0) {
                fl = 1;
                break;
            }
            while (i < N - 1) {
                if (a[i + 1][j] != 0) {
                    stop++;
                    break;
                }
                i++;
                a[i][j] = counter;
                counter++;
                if (i == N - 1) {
                    stop++;
                }
            }
            break;
        case 2:
            if (a[i][j - 1] != 0) {
                fl = 1;
                break;
            }
            while (j > 0) {
                if (a[i][j - 1] != 0) {
                    stop++;
                    break;
                }
                j--;
                a[i][j] = counter;
                counter++;
                if (j == 0) {
                    stop++;
                }
            }
            break;
        case 3:
            if (a[i - 1][j] != 0) {
                fl = 1;
                break;
            }
            while (i > 0) {
                if (a[i - 1][j] != 0) {
                    stop++;
                    break;
                }
                i--;
                a[i][j] = counter;
                counter++;
                if (i == 0) {
                    stop++;
                }
            }
            break;
        }
    }
}
/*
 * Основная функция заполнения массива
 *
 * @param N размерность массива.
 */
void arrfill(int N) {
    int** arr;
    arr = new int* [N];
    for (int i = 0; i < N; i++) {
        arr[i] = new int[N];
    }
    fillNorm(arr, N);
    printArr(arr, N);
    int oper = 1;
    while (oper != 0) {
        cin >> oper;
        switch (oper) {
        case 1:
            fillNorm(arr, N);
            printArr(arr, N);
            break;
        case 2:
            fillRev(arr, N);
            printArr(arr, N);
            break;
        case 3:
            fillDiag(arr, N);
            printArr(arr, N);
            break;
        case 4:
            fillSecDiag(arr, N);
            printArr(arr, N);
            break;
        case 5:
            fillSpiral(arr, N);
            printArr(arr, N);
            break;
        default: break;
        }
    }
}
int main()
{
    int n;
    cin >> n;
    arrfill(n);
}
