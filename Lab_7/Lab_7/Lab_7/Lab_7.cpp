// Lab_7.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <vector>
class Visitor {
public:
	int offers;
	int time;
	int age;
	int el_queue;
	int timeIn;
	Visitor(int time, int age) {
		this->time = time;
		this->age = age;
		this->offers = 0;
		if (age < 18) {
			this->el_queue = (rand() % 100) <= 20;
		}	
		else if (age > 65) {
			this->el_queue = (rand() % 100) <= 5;
		}
		else {
			this->el_queue = (rand() % 100) <= 70;
		}
	}
	Visitor(Visitor const& visitor) {
		this->offers = visitor.offers;
		this->time = visitor.time;
		this->age = visitor.age;
		this->el_queue = visitor.el_queue;
		this->timeIn = visitor.timeIn;
	}
};
class Window {
public:
	Visitor* theVis;
	Window(Visitor* theVis) :
		theVis(theVis)
	{}
};
class Org {
public:
	std::vector <Window*> windows;
	std::vector <Visitor*> visitors;
	int k;
	Org(std::vector <Window*> windows, std::vector <Visitor*> visitors):
		windows(windows),
		visitors(visitors),
		k(0)
	{}
	void winServ(int w_time) {
		for (int i = 0; i < this->visitors.size(); i++) {
			if (this->visitors[i]->age < 18) {
				this->visitors[i]->time = rand() % (10 - 5) + 5;
			}
			else if (visitors[i]->age > 65) {
				this->visitors[i]->time = rand() % (9 - 7) + 7;
			}
			else {
				this->visitors[i]->time = rand() % (5 - 2) + 2;
			}
			this->visitors[i]->timeIn = 0;
		}
		for (int i = 0; i < w_time; i++) {
			if (i % 2 == 0) {
				int a = rand() % 100;
				if (a <= 5) {
					this->visitors.push_back(new Visitor(rand() % (10 - 5) + 5, 10));
				}
				else if ((a > 5) && (a <= 45)) {
					this->visitors.push_back(new Visitor(rand() % (5 - 2) + 2, 30));
				}
				else if ((a > 45) && (a <= 75)) {
					this->visitors.push_back(new Visitor(rand() % (9 - 7) + 7, 70));
				}
				this->visitors[this->visitors.size() - 1]->timeIn = i;
			}
			this->sortVis();
			for (int j = 0; j < this->windows.size(); j++) {
				if (this->windows[j]->theVis->time <= 0) {
					for (int i1 = this->k; i1 < this->visitors.size(); i1++) {
						if (this->visitors[i1]->offers == 0) {
							this->windows[j]->theVis = visitors[i1];
							this->visitors[i1]->offers = 1;
							break;
						}
					}
				}
			}
			for (int j = 0; j < this->windows.size(); j++) {
				this->windows[j]->theVis->time--;
			}
		}
	}
	void sortVis(){
		int fl = 1;
		int t;
		while (fl == 1) {
			fl = 0;
			int k = this->k;
			for (int i = k; i < this->visitors.size() - 1; i++) {
				if ((this->visitors[i]->el_queue < this->visitors[i + 1]->el_queue) && this->visitors[i]->offers != 1) {
					t = this->visitors[i]->el_queue;
					this->visitors[i]->el_queue = this->visitors[i + 1]->el_queue;
					this->visitors[i + 1]->el_queue = t;
					fl = 1;
				}
				if ((this->visitors[i]->timeIn > this->visitors[i + 1]->timeIn) 
					&& this->visitors[i]->offers != 1 
					&& (this->visitors[i]->el_queue == this->visitors[i + 1]->el_queue)) {
					t = this->visitors[i]->el_queue;
					this->visitors[i]->el_queue = this->visitors[i + 1]->el_queue;
					this->visitors[i + 1]->el_queue = t;
					fl = 1;
				}
			}
		}
	}
	
};

int main()
{
	std::vector <Window*> the_windows = { new Window(new Visitor(0, 5)), new Window(new Visitor(0, 5)) };
	std::vector <Visitor*> queue = { 
		new Visitor(0, 5),
		new Visitor(0, 45),
		new Visitor(0, 55),
		new Visitor(0, 65),
		new Visitor(0, 75),
		new Visitor(0, 35),
		new Visitor(0, 35),
		new Visitor(0, 35) 
	};
	Org Organization(the_windows, queue);
	Organization.winServ(480);
	for (int i = 0; i < Organization.visitors.size(); i++) {
		std::cout << Organization.visitors[i]->el_queue << " " << Organization.visitors[i]->timeIn << " " << Organization.visitors[i]->time << " " << Organization.visitors[i]->offers << std::endl;
	}

}

