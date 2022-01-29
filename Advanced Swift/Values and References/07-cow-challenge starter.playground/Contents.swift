// Copyright (c) 2019 Razeware LLC
// See Copyright Notice page for details about the license.

// The other use case for implementing COW is to reduce reference counting
// traffic.  The following InventoryItem struct has value semantics
// because the all of the internal components have value semantics.
// However, everytime an object is copied you get 6 reference counts
// Use COW so that there is only one reference count bump when an
// InventoryItem is copied.

import class UIKit.UIColor
import class UIKit.UIImage

struct InventoryItem {
    
    // Make an internal storage class (Indirect Storage)
    private final class Storage {
        var name: String
        var barcode: String
        var cost: String
        var color: UIColor
        var images: [UIImage]
        var comment: String
        init(name: String, barcode: String, cost: String, color: UIColor, images: [UIImage], comment: String) {
            self.name = name
            self.barcode = barcode
            self.cost = cost
            self.color = color
            self.images = images
            self.comment = comment
        }
        
        // here is the C in COW....Moooo
        func copy() -> Storage {
            print("returning copy")
            return Storage(name: name, barcode: barcode, cost: cost,
                           color: color, images: images, comment: comment)
        }
    }
    
    init(name: String, barcode: String, cost: String, color: UIColor, images: [UIImage], comment: String) {
        self._storage = Storage(name: name, barcode: barcode, cost: cost, color: color, images: images, comment: comment)
    }
    
    private var _storage: Storage
    private var _mutatingStorage: Storage {
        mutating get {
            if !isKnownUniquelyReferenced(&_storage) {
                _storage = _storage.copy()
            }
            return _storage
        }
    }
    
    var name: String {
        get {
            return _storage.name
        }
        set {
            return _mutatingStorage.name = newValue
        }
    }
    
    var barcode: String {
        get {
            return _storage.barcode
        }
        set {
            return _mutatingStorage.barcode = newValue
        }
    }
    
    var cost: String {
        get {
            return _storage.cost
        }
        set {
            return _mutatingStorage.cost = newValue
        }
    }
    
    var color: UIColor {
        get {
            return _storage.color
        }
        set {
            return _mutatingStorage.color = newValue
        }
    }
    
    var images: [UIImage] {
        get {
            return _storage.images
        }
        set {
            return _mutatingStorage.images = newValue
        }
    }
    
    var comment: String {
        get {
            return _storage.comment
        }
        set {
            return _mutatingStorage.comment = newValue
        }
    }
}

var chair = InventoryItem(name: "Chair", barcode: "001204", cost: "$20", color: .black, images: [], comment: "placeholder")
var other = chair

other.name = "Desk"

chair.name
other.name

chair.name = "Rocking Chair"
chair.name

other.name
