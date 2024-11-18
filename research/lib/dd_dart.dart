class Entry {
  static test() {
    /*
I am animal
abstract loud
LoudSoundMixin00::: loud
LoudSoundMixin01::: loud
LoudSoundMixin02::: loud
LoudSoundMixin03::: loud
LoudSoundMixin04::: loud
* */
    // final dog = Dog();
    // final student = Student(score: '98');
    final teacher = Teacher(name:  'Space', score: '100');
    // teacher.makeHair();
    teacher.teachHaircut();
  }
}

abstract class Animal {
  Animal() {
    print('I am animal');
    makeSound();
  }
  void makeSound() {
    print('abstract loud');
  }
}

// 表示类 如何需要嵌入LoudSoundMixin 必须要实现Animal 才可以，这就是on 的作用
mixin LoudSoundMixin00 on Animal {
  @override
  void makeSound() {
    super.makeSound();
    print('LoudSoundMixin00::: loud');
  }
}

mixin LoudSoundMixin01 on Animal {
  @override
  void makeSound() {
    super.makeSound();
    print('LoudSoundMixin01::: loud');
  }
}

mixin LoudSoundMixin02 on Animal {
  @override
  void makeSound() {
    super.makeSound();
    print('LoudSoundMixin02::: loud');
  }
}

mixin LoudSoundMixin03 on Animal {
  @override
  void makeSound() {
    super.makeSound();
    print('LoudSoundMixin03::: loud');
  }
}

mixin LoudSoundMixin04 on Animal {
  @override
  void makeSound() {
    super.makeSound();
    print('LoudSoundMixin04::: loud');
  }
}


// 这个如果需要使用BigMix ，使用 BigMix 的类必须 同时混入
// LoudSoundMixin00,LoudSoundMixin01,LoudSoundMixin02,LoudSoundMixin03
mixin BigMix on LoudSoundMixin00,LoudSoundMixin01,LoudSoundMixin02,LoudSoundMixin03 {

}

class BigSnake extends Animal with LoudSoundMixin00,LoudSoundMixin01,LoudSoundMixin02,LoudSoundMixin03, BigMix {

}

// 这里由于 LoudSoundMixin 提供了实现，所以dog 会优先调用LoudSoundMixin 的实现
// 当然，由于是extends 如果 abstract 类有默认实现，那么Dog 也是不强制实现这个方法的
// 如果一个类混入了多个 mixin，同名方法那么最右边的mixin 会覆盖前面的mixin
// 如果同名方法调用super，比如LoudSoundMixin04 调用了super,那么就会调用 LoudSoundMixin03 的 方法，再回到LoudSoundMixin04 调用原方法。
// 混入了多个 带有同名方法的mixin 感觉像编译器生成了一个方法链表，默认调用链表最后的方法，如果调用了super，就往前找一个方法调用，
// 注意，如果 被混入的抽象类也实现了 同名方法，那么链表头是抽象类的默认实现方法

class Dog extends Animal
    with
        LoudSoundMixin00,
        LoudSoundMixin01,
        LoudSoundMixin02,
        LoudSoundMixin03,
        LoudSoundMixin04 {}

class Snake extends Animal {}

//当一个类使用 implements 时，它表示这个类需要显式实现接口中定义的所有成员（方法和属性）。
// 换句话说，implements 是用来表示 "实现接口" 的，它强制类提供接口中所有成员的具体实现，而不会继承接口的实现。


abstract class Person {
  final String name;
  Person({required this.name}){
    print('I am person');
  }
  @override
  teachHaircut(){
    print('Person ---- teachHaircut');
  }
}

class Student extends Person {

  final String score;
  // 这个是位置参数
  // 调用构造函数时，必须按照定义的顺序传递参数
  // Student(this.score) : super('Space'){
  //   print('I am Student');
  // }

  // 这个是命名参数
  // 调用构造函数时，可以以命名的方式传递参数，顺序不重要
  Student({required this.score}) : super(name: 'Space'){
    print('I am Student');
  }
  // 使用位置参数时，必须按顺序提供参数；使用命名参数时，可以自由地以名称提供参数，提高了可读性。
  // 选择使用哪种参数类型取决于具体的使用场景和需求。
}

class Teacher extends Person with NiceHair {

  final String score;
  Teacher({required this.score, required super.name}){
    print('I am Student');
  }

  @override
  teachHaircut(){
    super.teachHaircut();
    print('Teacher ---- teachHaircut');
  }

}





mixin NiceHair on Person {
  void makeHair(){
    print("NiceHair ---- makeHair");
  }

  @override
  void teachHaircut(){
    super.teachHaircut();
    print('NiceHair ::: teachHaircut');
  }

}