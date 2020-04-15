//
//  OutlineData.swift
//  OutlineView
//
//  Created by Toph Allen on 4/13/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import Foundation

let foldersHaveContent: Bool = false

// TODO: I should probably split folders out to be a subclass.
class OutlineNode: ObservableObject, Identifiable, Hashable {
    var id: UUID = UUID()
    let name: String
    var children: [OutlineNode]
    var parent: OutlineNode?
    @Published var open: Bool = false
    var isRoot: Bool = false
    var hasContent: Bool = true
    
    var isFolder: Bool {
        get {
            return self.children.count > 0
        }
    }
    
    var childrenFoldersFirst: [OutlineNode] {
        get {
            return self.children.sorted { c1, c2 in
                if c1.isFolder == c2.isFolder {
                    return c1.name < c2.name
                } else {
                    return c1.isFolder && !c2.isFolder // This sorts the trues first
                }
            }
        }
    }
    
    init(name: String) {
        self.name = name
        self.children = []
    }
    
    init(name: String, children: [OutlineNode]) {
        self.name = name
        self.children = children
        for child in self.children {
            child.parent = self
        }
        self.hasContent = foldersHaveContent
    }
    
    static func == (lhs: OutlineNode, rhs: OutlineNode) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
    
    
class RootNode: OutlineNode {
    init(name: String, children: [OutlineNode], isRoot: Bool) {
        super.init(name: name, children: children)
        self.isRoot = isRoot
        self.open = self.isRoot
    }

    class func getRoot() -> RootNode {
        let i11 = OutlineNode(name: "Item 1.1")
        let i12 = OutlineNode(name: "Item 1.2")
        let i13 = OutlineNode(name: "Item 1.3")
        
        let i1 = OutlineNode(name: "Item 1", children: [i11, i12, i13])
        
        let i221 = OutlineNode(name: "Item 2.2.1")
        let i222 = OutlineNode(name: "Item 2.2.2")
        let i223 = OutlineNode(name: "Item 2.2.3")
        
        let i21 = OutlineNode(name: "Item 2.1")
        let i22 = OutlineNode(name: "Item 2.2", children: [i221, i222, i223])
        let i23 = OutlineNode(name: "Item 2.3")
        
        let i2 = OutlineNode(name: "Item 2", children: [i21, i22, i23])
        
        let i31 = OutlineNode(name: "Item 3.1")
        let i32 = OutlineNode(name: "Item 3.2")
        let i33 = OutlineNode(name: "Item 3.3")
        
        let i3 = OutlineNode(name: "Item 3", children: [i31, i32, i33])
        
        let i421 = OutlineNode(name: "Item 4.2.1")
        let i422 = OutlineNode(name: "Item 4.2.2")
        let i423 = OutlineNode(name: "Item 4.2.3")
        let i424 = OutlineNode(name: "Item 4.2.4")
        let i425 = OutlineNode(name: "Item 4.2.5")
        let i426 = OutlineNode(name: "Item 4.2.6")
        let i427 = OutlineNode(name: "Item 4.2.7")
        let i428 = OutlineNode(name: "Item 4.2.8")
        
        let i441 = OutlineNode(name: "Item 4.4.1")
        let i442 = OutlineNode(name: "Item 4.4.2")
        let i443 = OutlineNode(name: "Item 4.4.3")
        let i444 = OutlineNode(name: "Item 4.4.3")
        
        let i41 = OutlineNode(name: "Item 4.1")
        let i42 = OutlineNode(name: "Item 4.2", children: [i421, i422, i423, i424, i425, i426, i427, i428])
        let i43 = OutlineNode(name: "Item 4.3")
        let i44 = OutlineNode(name: "Item 4.4", children: [i441, i442, i443, i444])
        
        let i4 = OutlineNode(name: "Item 4", children: [i41, i42, i43, i44])
        
        let root = RootNode(name: "Root", children: [i1, i2, i3, i4], isRoot: true)
        return root
    }
}
