// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

let owlBear = RWMonster(name: "Owl Bear", hitPoints: 30)
var enemies: [RWMonster] = [owlBear]
owlBear.hitPoints += 10
print(enemies)  // 40, not 30.  Reference semantics :[


struct Monster: CustomStringConvertible {
    private var _monster: SwiftReference<RWMonster>
    
    private var _mutatingMonter: RWMonster {
        mutating get {
            if !isKnownUniquelyReferenced(&_monter) {
                print("Making copy")
                _monter = SwiftReference(_monter.object.copy()) as! RWMonter
            }
            else {
                print("No Copy")
            }
            return _monter.object
        }
    }
    
    init(name: String, )
    
}


