void main() {
  List data = ['Omar', 1, 'Ahmed', 1.5, 10, 'Mohamed', 1.25];

  List<String> stringData = [];
  List<int> intData = [];
  List<double> doubleData = [];

  for (var element in data) {
    if (element.runtimeType == int) {
      addDataToList(intData, element);
    } else if (element.runtimeType == double) {
      addDataToList(doubleData, element);
    } else {
      addDataToList(stringData, element);
    }
  }

  print(stringData);
  print(intData);
  print(doubleData);

  // int x = 5;
  // changeData(x);
  // print(x);
}

void changeData(int data) {
  data = 10;
}

void addDataToList(List myListData, dynamic element) {
  myListData.add(element);
}
