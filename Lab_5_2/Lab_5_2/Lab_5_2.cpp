
// Lab_5_2.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <vector>
class Spares {
public:
	int replCost;
	int repCost;
	int repTime;
	int workTime;
	int frazzle;
	std::string probFind;
	std::string workType;
	Spares(int replCost, int repCost, int repTime, int workTime, int frazzle) {
		this->replCost = replCost;
		this->repCost = repCost;
		this->repTime = repTime;
		this->workTime = workTime;
		this->frazzle = frazzle;
	}
	Spares(const Spares& spares) {
		this->replCost = spares.replCost;
		this->repCost = spares.repCost;
		this->repTime = spares.repTime;
		this->workTime = spares.workTime;
		this->frazzle = spares.frazzle;
	}
	Spares() {
		this->replCost = 0;
		this->repCost = 0;
		this->repTime = 0;
		this->workTime = 0;
		this->frazzle = 0;
	}
};
class Shaft : public Spares {
public:
	std::string probFind = "look at shaft";
	std::string workType = "work1";
	Shaft(int replCost, int repCost, int repTime, int workTime, int frazzle) :
		Spares(replCost, repCost, repTime, workTime, frazzle),
		workType("work1")
	{}
	Shaft() :
		Spares()
	{}
}; 
class ElDrive : public Spares {
public:
	std::string probFind = "look at ElDrive";
	std::string workType = "work2";
	ElDrive(int replCost, int repCost, int repTime, int workTime, int frazzle) :
		Spares(replCost, repCost, repTime, workTime, frazzle)
	{}
	ElDrive() :
		Spares()
	{}
};
class ConPannel : public Spares {
public:
	std::string probFind = "look at control pannel";
	std::string workType = "work1";
	ConPannel(int replCost, int repCost, int repTime, int workTime, int frazzle) :
		Spares(replCost, repCost, repTime, workTime, frazzle)
	{}
	ConPannel() :
		Spares()
	{}
};
class SlHead : public Spares {
public:
	std::string probFind = "look at Slhead";
	std::string workType = "work3";
	SlHead(int replCost, int repCost, int repTime, int workTime, int frazzle) :
		Spares(replCost, repCost, repTime, workTime, frazzle)
	{}
	SlHead() :
		Spares()
	{}
};
class Machine {
public:
	std::vector <Spares*> spare_parts;
	Machine(std::vector <Spares*> spare_parts):
		spare_parts(spare_parts)
	{}
	Machine() :
		spare_parts()
	{}
	void work1(int time) {
		int flag = 0;
		for (int i = 0; i < this->spare_parts.size(); i++) {
			if (this->spare_parts[i]->frazzle >= 100) {
				std::cout << "it does not work";
				flag = 1;
				break;
			}
			if (this->spare_parts[i]->workTime <= 0) {
				std::cout << "it does not work";
				flag = 1;
				break;
			}
		}	

		if (flag != 1) {
			for (int i = 0; i < this->spare_parts.size(); i++) {
				if (((Shaft*)this->spare_parts[i])->workType == (new Shaft())->workType) {
					spare_parts[i]->frazzle += 5 * time;
					this->spare_parts[i]->workTime -= time;
				}
				std::cout << this->spare_parts[i]->frazzle << ", " << this->spare_parts[i]->workTime  << std::endl;
			}
		}
	}
	void work2(int time) {
		int flag = 0;
		for (int i = 0; i < this->spare_parts.size(); i++) {
			if (this->spare_parts[i]->frazzle >= 100) {
				std::cout << "it does not work";
				flag = 1;
				break;
			}
			if (this->spare_parts[i]->workTime <= 0) {
				std::cout << "it does not work";
				flag = 1;
				break;
			}
		}

		if (flag != 1) {
			for (int i = 0; i < this->spare_parts.size(); i++) {
				if (((Shaft*)this->spare_parts[i])->workType == "work2") {
					this->spare_parts[i]->frazzle += 3 * time;
					this->spare_parts[i]->workTime -= time;
				}

				std::cout << this->spare_parts[i]->frazzle << ", " << this->spare_parts[i]->workTime << std::endl;
			}
		}
	}
	void work3(int time) {
		int flag = 0;
		for (int i = 0; i < this->spare_parts.size(); i++) {
			if (this->spare_parts[i]->frazzle >= 100) {
				std::cout << "it does not work";
				flag = 1;
				break;
			}
			if (this->spare_parts[i]->workTime <= 0) {
				std::cout << "it does not work";
				flag = 1;
				break;
			}
		}
		if(flag!=1){
			for (int i = 0; i < this->spare_parts.size(); i++) {
				if (((Shaft*)this->spare_parts[i])->workType == "work3") {
					this->spare_parts[i]->workTime -= time;
					this->spare_parts[i]->frazzle += 4 * time;
				}

				std::cout << this->spare_parts[i]->frazzle <<", " << this->spare_parts[i]->workTime << std::endl;
			}
		}
	}
	
};
int main()
{
    std::cout << "Hello World!\n";
	std::vector <Spares*> spare_p = {
		new Shaft(12, 32, 4, 5, 0),
		new ElDrive(4, 32, 5, 6, 0),
		new ConPannel(4, 32, 5, 6, 0),
		new SlHead(4, 32, 5, 6, 0)
	};
	Machine a(spare_p);
	a.spare_parts = spare_p;
	int work = 1;
	int time_w = -1;
	while (work != 0)
	{
		std::cout << "Choose type of work" << std::endl;
		std::cin >> work;

		std::cout << "Choose work time" << std::endl;
		std::cin >> time_w;
		while (time_w < 0) {
			std::cout << "Choose another work time" << std::endl;
			std::cin >> time_w;
		}
		switch (work % 4)
		{
		case 1:
			a.work1(time_w);
			break;
		case 2:
			a.work2(time_w);
			break;
		case 3:
			a.work3(time_w);
			break;
		default:
			break;
		}
	}
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
