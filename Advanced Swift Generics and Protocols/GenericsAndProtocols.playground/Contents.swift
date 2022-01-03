// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

struct Stack<Element> {
  
  private var storage: [Element] = []
  
  mutating func push(_ element: Element) {
    storage.append(element)
  }
  
  mutating func pop() -> Element? {
    return storage.popLast()
  }
  
  var top: Element? {
    return storage.last
  }
  
  var isEmpty: Bool {
    return top == nil
  }
  
}

extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.storage = elements
    }
}

var stack: Stack = [1,2,3]
stack.push(1)
stack.pop()

func add<T>(_ a:T, _ b: T) -> T {
    return a + b
}

print(add(1, 2))



