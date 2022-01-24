// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

protocol Distribution {
    associatedtype Value: Numeric
    func sample<G: RandomNumberGenerator>(using generator: inout G) -> Value
    func sample<G: RandomNumberGenerator>(count: Int, using generator: inout G) -> [Value]
}

extension Distribution {
    func sample<G: RandomNumberGenerator>(count: Int, using generator: inout G) -> [Value] {
        var g = SystemRandomNumberGenerator()
        return (1...count).map { _ in sample(using: &g) }
    }
    
    func sample() -> Value {
        var g = SystemRandomNumberGenerator()
        return sample(using: &g)
    }
    
    func sample(count: Int) -> [Value] {
        var g = SystemRandomNumberGenerator()
        return sample(count: count, using: &g)
    }
}

struct UniformDistribution: Distribution {
    var range: ClosedRange<Int>
    
    func sample<G: RandomNumberGenerator>(using generator: inout G) -> Int {
        return Int.random(in: range, using: &generator)
    }
}

let ud = UniformDistribution(range: 1...10)
var rand = SystemRandomNumberGenerator()
ud.sample(using: &rand)

