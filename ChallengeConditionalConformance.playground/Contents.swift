// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

struct Pair<Element> {
    var first: Element
    var second: Element
}

extension Pair {
    var flipped: Pair { return Pair(first: second, second: first) }
    
    func min(by areIncreasingOrder: (Element, Element) -> Bool) -> Element {
        areIncreasingOrder(first, second) ? first : second
    }
    
    func max(by areIncreasingOrder: (Element, Element) -> Bool) -> Element {
        !areIncreasingOrder(first, second) ? first : second
    }
    
    func sorted(by areIncreasingOrder: (Element, Element) -> Bool) -> Pair {
        areIncreasingOrder(first, second) ? self : flipped
    }
}

extension Pair: Equatable where Element: Equatable {
}

extension Pair: Comparable where Element: Comparable {
    static func < (lhs: Pair<Element>, rhs: Pair<Element>) -> Bool {
        return lhs.first < rhs.second
    }
}

protocol Orderable {
    associatedtype Element
    func min() -> Element
    func max() -> Element
    func sorted() -> Self
}

extension Pair: Orderable where Element: Comparable {
    func min() -> Element { return min(by: <) }
    func max() -> Element { return max(by: <) }
    func sorted() -> Pair { return sorted(by: <) }
}

extension Pair: Hashable where Element: Hashable {
}

extension Pair: Codable where Element: Codable {
}

let bools = Pair(first: true, second: false)
let ints = Pair(first: 1000, second: 300)

ints.sorted()
ints.max()
