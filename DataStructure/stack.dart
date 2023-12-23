class Stack {
  List<dynamic> _elements = [];

  void push(dynamic element) {
    _elements.add(element);
  }

  dynamic pop() {
    if (_elements.isNotEmpty) {
      return _elements.removeLast();
    } else {
      print("Stack is empty");
      return null;
    }
  }

  void display() {
    print("Stack: $_elements");
  }
}

void main() {
  Stack myStack = Stack();

  myStack.push(1);
  myStack.push("Hello");
  myStack.push(3.14);

  myStack.display(); // Output: Stack: [1, Hello, 3.14]

  var poppedElement = myStack.pop();
  print("Popped element: $poppedElement"); // Output: Popped element: 3.14

  myStack.display(); // Output: Stack: [1, Hello]
}
