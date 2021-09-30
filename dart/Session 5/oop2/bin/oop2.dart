// void main(List<String> arguments) {
//   Student stu = Student(
//     '1',
//     10,
//     name: 'name',
//     ssn: 'ssn',
//     address: 'address',
//     age: 20,
//   );
// }

// abstract class Person {
//   String name, ssn, address;
//   int age;

//   Person({
//     required this.name,
//     required this.ssn,
//     required this.address,
//     required this.age,
//   });

//   void personData();
//   // {
//   //   print('SSN: $ssn');
//   //   print('Name: $name');
//   //   print('Age: $age');
//   // }

//   void personData2() {
//     print('data');
//   }
// }

// class Student extends Person {
//   String id;
//   int level;

//   Student(
//     this.id,
//     this.level, {
//     required String name,
//     required String ssn,
//     required String address,
//     required int age,
//   }) : super(
//           name: name,
//           ssn: ssn,
//           address: address,
//           age: age,
//         );

//   void studentData() {
//     print('Id: $id');
//     print('Level: $level');
//   }

//   @override
//   void personData() {
//     // hghg
//   }

//   @override
//   void personData2() {
//     // TODO: implement personData2
//   }
// }

void main(List<String> args) {
  Person p = Person();
  Fish f = Fish();
  p.sleep();
  p.walk();

  f.fish();
  f.swim();
}

class Fly {
  void fly() => print('Can Fly');
}

class Walk {
  void walk() => print('Can Walk');
}

class Swim {
  void swim() => print('Can Swim');
}

class Sleep {
  void sleep() => print('Can Sleep');
}

class Person with Walk, Sleep {}

class Fish with Swim, Sleep {
  void fish() => print('I\'m Fish');
}
