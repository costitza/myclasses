#include <bits/stdc++.h>

using namespace std;

template <typename T>
class IObserver {
public:
    virtual void update(T val) = 0;
    virtual ~IObserver() = default;
};



template <typename T>
class ConsoleLogger : public IObserver<T> {
public:
    void update(T val) override {
        cout << "Element nou detectat: " << val << "\n";
    }
};



template <typename T>
class DataCounter : public IObserver<T> {
private:
    int count = 0;
public:
    void update(T val) override {
        count++;
        cout << "Total elemente in sistem: " << count << "\n";
    }
};


template <typename T>
class Observable {
protected:
    std::vector<IObserver<T>*> observers;
public:
    void addObserver(IObserver<T>* obs) {
        observers.push_back(obs);
    }
    
    void notificare(T val) {
        for (auto obs : observers) {
            obs->update(val);
        }
    }
    
    virtual ~Observable() = default;
};


template<typename T>
class AbstractContainer {
protected:
    std :: vector <T> elemente;

public:
    virtual void push(T val) = 0;
    virtual T pop() = 0;
    virtual ~AbstractContainer() = default;
};


template <typename T>
class ObservableContainer : public AbstractContainer<T>, public Observable<T>{
public:
    virtual ~ObservableContainer() = default;
};


template <typename T>
class Mystack : public ObservableContainer<T>{
    using ObservableContainer<T> :: elemente;
    using ObservableContainer<T> :: notificare;
public:
    void push(T val) override{
        this -> elemente.push_back(val);
        this -> notificare(val);
    }

    T pop() override {
        T trimis {};
        if (!this -> elemente.empty()) {
            trimis = this -> elemente.back();
            this -> elemente.pop_back();
        } else {
            cout << "Stiva este goala!\n";
        }
        return trimis;
    }
};


template <typename T>
class MyQueue : public ObservableContainer<T>{
public:
    void push(T val) override{
        this -> elemente.push_back(val);
        this -> notificare(val);
    }

    T pop() override{
        T trimis {};
        if (!this -> elemente.empty()){
            trimis = this -> elemente.front();

            this -> elemente.erase(this -> elemente.begin());
        }
        else{
            cout << "Coada goala\n";
        }
        return trimis;
    }
};


template<typename T>
class ContainerFactory{
public:
    static unique_ptr <AbstractContainer <T>> create(string tip){
        if (tip == "stiva"){
            return make_unique <Mystack <T>> ();
        }
        else if (tip == "coada"){
            return make_unique <MyQueue <T>> ();
        }
        return nullptr;
    }
};


int main(){
    ContainerFactory<int> factory;

    auto container = factory.create("coada");

    if (container != nullptr){
        ConsoleLogger <int> console;
        DataCounter <int> data;

        auto* obsContainer = dynamic_cast<ObservableContainer <int>*> (container.get());

        if (obsContainer != nullptr){
            obsContainer -> addObserver(&console);
            obsContainer -> addObserver(&data);


            obsContainer->push(10);
            obsContainer->push(20);
            obsContainer->push(30);
            obsContainer->push(40);

            int extras = obsContainer->pop();
            cout << "Obiectul extras este: " << extras << '\n';
        }
    }
    return 0;
}