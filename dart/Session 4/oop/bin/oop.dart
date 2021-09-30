// void main(List<String> arguments) {
//   Car car1 = Car('BMW', 'Blue', 1);
//   Car car2 = Car('KIA', 'Black', 2);

//   Car car3 = Car.bmw(3);
//   Car car4 = Car.kia(4);

//   print(car1.model);
//   print(car2.model);
//   print(car3.model);
//   print(car4.model);
// }

// class Car {
//   String model, color;
//   int serial;

//   Car(this.model, this.color, this.serial);

//   Car.bmw(this.serial)
//       : model = 'BMW',
//         color = 'White';

//   Car.kia(this.serial)
//       : model = 'KIA',
//         color = 'White';

//   void driving() {
//     print('Driving');
//   }
// }

import 'dart:io';

import 'dart:math';

import 'dart:svg';

void main() {
  Points points = Points();
  // points.addPoint(1, 2);
  // points.addPoint(5, 6);
  // points.addOriginPoint();
  // points.printPoints();
  points.addRect();
  points.printShapes();
}

class Point {
  int x, y;

  Point(this.x, this.y);
  Point.origin()
      : x = 0,
        y = 0;
}

class Points {
  List<Point> _points = [];

  Map<String, List<Point>> _shapes = {};

  void addPoint(int x, int y) {
    _points.add(Point(x, y));
  }

  void addOriginPoint() {
    _points.add(Point.origin());
  }

  void addRect() {
    List<Point> userPoints = [];
    for (int i = 1; i < 5; i++) {
      print('Enter x$i, y$i');
      String points = stdin.readLineSync()!;
      userPoints.add(
        Point(
          int.parse(points.split(', ')[0]),
          int.parse(points.split(', ')[1]),
        ),
      );
    }
    _shapes.addAll({
      'Rectangle': userPoints,
    });
  }

  void addTriangle() {
    List<Point> hamda = [];

    int a;
    for (a = 1; a < 4; a++) {
      print('please enter x$a');
      int x;
      x = int.parse(stdin.readLineSync()!);

      print('please enter y$a');
      int y;
      y = int.parse(stdin.readLineSync()!);
      hamda.add(Point(x, y));
    }
    _shapes.addAll({'triangle': hamda});
  }

  void calcRectPerimeter() {
    List<Point> hamada = _shapes['Rectangle']!;
    double h, w;
    h = sideLength(hamada[1].x, hamada[1].y, hamada[2].x, hamada[2].y);
    w = sideLength(hamada[0].x, hamada[0].y, hamada[1].x, hamada[1].y);
    print(2 * (h + w));
  }

  void calTriPerimeter() {
    List<Point> hamada = _shapes['triangle']!;
    double s1 = sideLength(hamada[0].x, hamada[0].y, hamada[1].x, hamada[1].y);
    double s2 = sideLength(hamada[1].x, hamada[1].y, hamada[2].x, hamada[2].y);
    double s3 = sideLength(hamada[2].x, hamada[2].y, hamada[0].x, hamada[0].y);
    print(s1 + s2 + s3);
  }

  double sideLength(int x1, int y1, int x2, int y2) {
    double length = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2));
    return length;
  }

  void printPoints() {
    for (var point in _points) {
      print('(${point.x}, ${point.y})');
    }
  }

  void printShapes() {
    _shapes.forEach((key, value) {
      print('Your Shape is $key');
      for (var point in value) {
        print('(${point.x}, ${point.y})');
      }
    });
  }
}
