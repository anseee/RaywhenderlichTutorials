// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

func compute(_ a: inout Int, _ b: inout Int) {
    b = 100
    a = 10
}

var x = 0
var y = 0

compute(&x, &y)
dump((x,y))

//compute(&x, &x)

extension MutableCollection {
    mutating func mutateEach(_ body: (inout Element) -> Void) {
        for index in indices {
            body(&self[index])
        }
    }
}

var array = [1,2,3]

array.mutateEach {
    $0 *= 2
}

array.append(contentsOf: Array(repeating: 42, count: array.count))
