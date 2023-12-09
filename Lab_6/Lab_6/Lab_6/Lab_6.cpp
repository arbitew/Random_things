// Lab_6.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <vector>

class Aim {
public:
    int hp;
    int distance;
    bool moving;
    Aim(int hp, int distance, bool moving) {
        this->hp = hp;
        this->distance = distance;
        this->moving = moving;
    }
    Aim() {
        this->hp = 100;
        this->distance = 100;
        this->moving = false;
    }
    virtual int square() = 0;
    virtual double hitChance() = 0;
};
class RoundAim : public Aim {
public:
    int rad;
    RoundAim(int hp, int distance, bool moving, int rad) :
        rad(rad),
        Aim(hp, distance, moving)
    {}
    RoundAim() :
        rad(10),
        Aim()
    {}
    int square() {
        int rad = this->rad;
        return (int)(3.14 * rad * rad);
    }
    double hitChance() {
        int move = 0;
        if (this->moving) {
            move = 1;
        }
        return  (50.0 + 20.0 * ((double)move) + (double)this->distance)/ ((double)this->square());
    }
};
class TriangleAim : public Aim {
public:
    int h;
    int side;
    TriangleAim(int hp, int distance, bool moving, int h, int side) :
        side(side),
        h(h),
        Aim(hp, distance, moving)
    {}
    TriangleAim() :
        side(5),
        h(5),
        Aim()
    {}
    int square() {
        int h = this->h;
        int side = this->side;
        return (int)(h * side);
    }
    double hitChance() {
        int move = 0;
        if (this->moving) {
            move = 1;
        }
        return  (50.0 + 20.0 * ((double)move) + (double)this->distance)/ ((double)this->square());
    }
};
class Weapon {
public:
    int bullets;
    int count_bullets;
    int damage;
    Weapon(int bullets, int damage) :
        bullets(bullets),
        count_bullets(this->bullets),
        damage(damage)
    {}
    Weapon() :
        bullets(10),
        count_bullets(10),
        damage(10)
    {}
};
class ShottingRange {
public:
    std::vector <Aim*> aims;
    Weapon* weapon;
    ShottingRange(std::vector <Aim*> aims, Weapon* weapon) {
        this->aims = aims;
        this->weapon = weapon;
    }
    void normal_shoot(int aim_num) {
        double hitchance = (double)(rand() % 100);
        if (this->aims[aim_num % aims.size()]->hp <= 0) {
            std::cout << "It destroed" << std::endl;
        }
        else if (hitchance / 100.0 < this->aims[aim_num % aims.size()]->hitChance()) {
            std::cout << "Miss" << std::endl;
        }
        else if (weapon->count_bullets <= 0) {
            std::cout << "no bullets" << std::endl;
        }
        else {
            this->aims[aim_num % aims.size()]->hp -= weapon->damage;
        }
        std::cout << "Aim's hp = " << this->aims[aim_num % aims.size()]->hp << std::endl;
    }
    void serial_shoot(int aim_num, int count) {
        for (int i = 0; i < count; i++) {
            double hitchance = (double)(rand() % 100);
            if (this->aims[aim_num % aims.size()]->hp <= 0) {
                std::cout << "It destroed" << std::endl;
                break;
            }
            if (weapon->count_bullets <= 0) {
                std::cout << "No bullets" << std::endl;
                break;
            }
            if (hitchance / 100.0 < this->aims[aim_num % aims.size()]->hitChance()) {
                std::cout << this->aims[aim_num % aims.size()]->hitChance() << std::endl;
                std::cout << "Miss" << std::endl;
                continue;
            }
            this->aims[aim_num % aims.size()]->hp -= weapon->damage;
        }
        std::cout << "Aim's hp = " << this->aims[aim_num % aims.size()]->hp << std::endl;
    }
};

int main()
{
    std::vector <Aim*> MyAims= { new RoundAim(130, 15, true, 10), new TriangleAim(150, 10, false, 20, 15) };
    Weapon TommyGun(100, 10);
    ShottingRange MyShRange(MyAims, &TommyGun);
    MyShRange.serial_shoot(2, 20);
}

