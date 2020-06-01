//
//  ExampleData.swift
//  OutlineView
//
//  Created by Toph Allen on 4/20/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import Foundation


final class ExampleClass: OutlineRepresentable, ObservableObject, Identifiable, Hashable {
    let id: UUID = UUID()
    let name: String
    var children: [OutlineRepresentable]?
    var parent: OutlineRepresentable?
    let hasContent: Bool
    
    static func == (lhs: ExampleClass, rhs: ExampleClass) -> Bool {
        return lhs.id == rhs.id
    }

    init(name: String, children: [ExampleClass] = []) {
        self.name = name
        self.children = children
        self.parent = nil
        if children.count == 0 {
            self.hasContent = true
        } else {
            self.hasContent = false
        }
        for child in children {
            child.parent = self
        }
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // init(name: String, children: [ExampleClass]) {
    //     self.name = name
    //     self.children = children
    //     self.hasContent = false
    // }
}


func exampleRoot() -> ExampleClass {
    let i11 = ExampleClass(name: "Item 1.1")
    let i12 = ExampleClass(name: "Item 1.2")
    let i13 = ExampleClass(name: "Item 1.3")
    
    let i1 = ExampleClass(name: "Item 1", children: [i11, i12, i13])
    
    let i221 = ExampleClass(name: "Item 2.2.1")
    let i222 = ExampleClass(name: "Item 2.2.2")
    let i223 = ExampleClass(name: "Item 2.2.3")
    
    let i21 = ExampleClass(name: "Item 2.1")
    let i22 = ExampleClass(name: "Item 2.2", children: [i221, i222, i223])
    let i23 = ExampleClass(name: "Item 2.3")
    
    let i2 = ExampleClass(name: "Item 2", children: [i21, i22, i23])
    
    let i31 = ExampleClass(name: "Item 3.1")
    let i32 = ExampleClass(name: "Item 3.2")
    let i33 = ExampleClass(name: "Item 3.3")
    
    let i3 = ExampleClass(name: "Item 3", children: [i31, i32, i33])
    
    let i421 = ExampleClass(name: "Item 4.2.1")
    let i422 = ExampleClass(name: "Item 4.2.2")
    let i423 = ExampleClass(name: "Item 4.2.3")
    let i424 = ExampleClass(name: "Item 4.2.4")
    let i425 = ExampleClass(name: "Item 4.2.5")
    let i426 = ExampleClass(name: "Item 4.2.6")
    let i427 = ExampleClass(name: "Item 4.2.7")
    let i428 = ExampleClass(name: "Item 4.2.8")
    
    let i441 = ExampleClass(name: "Item 4.4.1")
    let i442 = ExampleClass(name: "Item 4.4.2")
    let i443 = ExampleClass(name: "Item 4.4.3")
    let i444 = ExampleClass(name: "Item 4.4.3")
    
    let i41 = ExampleClass(name: "Item 4.1")
    let i42 = ExampleClass(name: "Item 4.2", children: [i421, i422, i423, i424, i425, i426, i427, i428])
    let i43 = ExampleClass(name: "Item 4.3")
    let i44 = ExampleClass(name: "Item 4.4", children: [i441, i442, i443, i444])
    
    let i4 = ExampleClass(name: "Item 4", children: [i41, i42, i43, i44])
    
    let root = ExampleClass(name: "Root", children: [i1, i2, i3, i4])
    return root
}


func exampleArray() -> [ExampleClass] {
    let i11 = ExampleClass(name: "Item 1.1")
    let i12 = ExampleClass(name: "Item 1.2")
    let i13 = ExampleClass(name: "Item 1.3")
    
    let i1 = ExampleClass(name: "Item 1", children: [i11, i12, i13])
    
    let i221 = ExampleClass(name: "Item 2.2.1")
    let i222 = ExampleClass(name: "Item 2.2.2")
    let i223 = ExampleClass(name: "Item 2.2.3")
    
    let i21 = ExampleClass(name: "Item 2.1")
    let i22 = ExampleClass(name: "Item 2.2", children: [i221, i222, i223])
    let i23 = ExampleClass(name: "Item 2.3")
    
    let i2 = ExampleClass(name: "Item 2", children: [i21, i22, i23])
    
    let i31 = ExampleClass(name: "Item 3.1")
    let i32 = ExampleClass(name: "Item 3.2")
    let i33 = ExampleClass(name: "Item 3.3")
    
    let i3 = ExampleClass(name: "Item 3", children: [i31, i32, i33])
    
    let i421 = ExampleClass(name: "Item 4.2.1")
    let i422 = ExampleClass(name: "Item 4.2.2")
    let i423 = ExampleClass(name: "Item 4.2.3")
    let i424 = ExampleClass(name: "Item 4.2.4")
    let i425 = ExampleClass(name: "Item 4.2.5")
    let i426 = ExampleClass(name: "Item 4.2.6")
    let i427 = ExampleClass(name: "Item 4.2.7")
    let i428 = ExampleClass(name: "Item 4.2.8")
    
    let i441 = ExampleClass(name: "Item 4.4.1")
    let i442 = ExampleClass(name: "Item 4.4.2")
    let i443 = ExampleClass(name: "Item 4.4.3")
    let i444 = ExampleClass(name: "Item 4.4.3")
    
    let i41 = ExampleClass(name: "Item 4.1")
    let i42 = ExampleClass(name: "Item 4.2", children: [i421, i422, i423, i424, i425, i426, i427, i428])
    let i43 = ExampleClass(name: "Item 4.3")
    let i44 = ExampleClass(name: "Item 4.4", children: [i441, i442, i443, i444])
    
    let i4 = ExampleClass(name: "Item 4", children: [i41, i42, i43, i44])
    
    return [i11, i12, i13, i1, i221, i222, i223, i21, i22, i23, i2, i31, i32, i33, i3, i421, i422, i423, i424, i425, i426, i427, i428, i441, i442, i443, i444, i41, i42, i43, i44, i4]
}



