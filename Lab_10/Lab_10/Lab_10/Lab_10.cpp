// Lab_10.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <vector>
class Obj {
public:
	virtual std::string whatObj() = 0;
	virtual std::string objName() = 0;
	virtual void del() = 0;
	virtual void rename(std::string) = 0;
};
class File: public Obj{
private:
	std::string name;
	~File() {}
public:
	std::string whatObj() {
		return "file";
	}
	File(std::string name) :
		name(name)
	{}
	std::string objName() {
		return name;
	}
	void del() {
		this->~File();
	}
	void rename(std::string name) {
		this->name = name;
	}
};
class Dir : public Obj{
private:
	std::string name;
	std::vector <Obj*> dir_f;
	~Dir(){}
public:
	std::string whatObj() {
		return "dir";
	}
	Dir(std::string name, std::vector <Obj*> dir_f) :
		name(name),
		dir_f(dir_f)
	{}
	void createF(std::string name) {
		this->dir_f.push_back(new File (name));
	}
	std::string objName() {
		return name;
	}
	void delF(std::string file_name) {
		for (int i = 0; i < dir_f.size(); i++) {
			if (dir_f[i]->objName() == file_name) {
				dir_f[i]->del();
				dir_f.erase(dir_f.begin() + i, dir_f.begin() + i + 1);
			}
		}
	}
	void remove(std::string name) {
		for (int i = 0; i < dir_f.size(); i++) {
			if (dir_f[i]->objName() == name) {
				dir_f.erase(dir_f.begin() + i, dir_f.begin() + i + 1);
			}
		}
	}
	void get(Obj* a) {
		dir_f.push_back(a);
	}
	void del() {
		if (dir_f.empty() == 1) {
			this->~Dir();
		}
		else {
			throw "There are files here";
		}
	}
	void rename(std::string name) {
		this->name = name;
	}
	void createD(std::string name) {
		this->dir_f.push_back(new Dir(name, {}));
	}
	Obj* findD(std::string name) {
		for (int i = 0; i < dir_f.size(); i++) {
			if (dir_f[i]->objName() == name) {
				return (dir_f[i]);
			}
		}
		std::cout << "not found";
	}
};
class FTree {
private:
	Dir* MainDir;
	Dir* CurrDir;
	std::string tree_obj;
public:
	FTree(std::vector <Obj*> tree){
		MainDir = new Dir("main", {});
		CurrDir = MainDir;
		tree_obj = "main\\";
		std::cout << tree_obj << std::endl;
	}
	void createDir(std::string name) {
		CurrDir->createD(name);
	}
	void createFile(std::string name) {
		CurrDir->createF(name);
	}
	void renameDir(std::string name) {
		CurrDir->rename(name);
	}
	void move(std::string from, std::string to) {
		Obj* a = CurrDir->findD(from);
		Obj* b = CurrDir->findD(to);
		if (b->whatObj() != "dir") {
			throw "Not dir";
		}
		((Dir*)b)->get(a);
		CurrDir->remove(a->objName());
	}
	void delDir(std::string name) {
		Dir* a = (Dir*)CurrDir->findD(name);
		a->del();
	}
	void delF(std::string name) {
		CurrDir->delF(name);
	}
	void changeD(std::string name) {
		if (CurrDir->findD(name)->whatObj() != "dir") {
			throw "Not dir";
		}
		CurrDir = (Dir*)CurrDir->findD(name);
		this->tree_obj = this->tree_obj + CurrDir->objName() + "\\";
	}
	void changeDU() {
		CurrDir = MainDir;
		for (int i = this->tree_obj.size() - 2; i > 0; i--) {
			if (this->tree_obj[i] == '\\') {
				this->tree_obj = this->tree_obj.substr(0, i+1);
				std::cout << this->tree_obj;
				break;
			}
		}
		std::string s = this->tree_obj;
		int str_n = 0;
		for (int i = 0; i < s.size(); i++) {
			if (s[i] == '\\') {
				if (str_n != 0) {
					CurrDir = (Dir*)CurrDir->findD(s.substr(str_n, i - str_n));
				}
				str_n = i + 1;
			}
		}
	}
	std::string showTree() {
		return tree_obj;
	}


};
int main()
{
	FTree MyTree({});
	std::string a = " ";
	MyTree.createDir("wow");
	MyTree.changeD("wow");
	MyTree.createDir("thow");
	MyTree.changeD("thow");
	MyTree.changeDU();
	while (a != "0") {
		std::cin >> a;
		if (a.substr(0, 11) == (std::string)"create_dir_") {
			MyTree.createDir(a.substr(11, a.size() - 11));
		}
		if (a.substr(0, 12) == (std::string)"create_file_") {
			MyTree.createFile(a.substr(12, a.size() - 12));
		}
		if (a.substr(0, 8) == (std::string)"rename_") {
			MyTree.renameDir(a.substr(8, a.size() - 8));
		}
		if (a.substr(0, 11) == (std::string)"change_dir_") {
			try {
				MyTree.changeD(a.substr(11, a.size() - 11));
			}
			catch (...) {
				std::cout << "Not dir";
			}
		}
		if (a.substr(0, 11) == (std::string)"delete_dir_") {
			try {
				MyTree.delDir(a.substr(11, a.size() - 11));
			}
			catch (...) {
				std::cout << "there are files in dir";
			}
		}
		if (a.substr(0, 12) == (std::string)"delete_file_") {
			MyTree.delF(a.substr(12, a.size() - 12));
		}
		if (a == (std::string)"show_tree") {
			std::cout << MyTree.showTree();
		}
		if (a == (std::string)"..") {
			MyTree.changeDU();
		}
		if (a.substr(0, 5) == (std::string)"move_") {
			std::string b;
			std::cout << "move to ..." << std::endl;
			std::cin >> b;
			try {
				MyTree.move(a.substr(5, a.size() - 5), b);
			}
			catch (...) {
				std::cout << b, " is not dir";
			}
		}
	}
}

