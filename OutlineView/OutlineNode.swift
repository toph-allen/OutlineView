//
//  OutlineData.swift
//  OutlineView
//
//  Created by Toph Allen on 4/13/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import Foundation

let foldersHaveContent: Bool = false


protocol OutlineRepresentable: ObservableObject, Identifiable, Hashable {
    var name: String { get }
    var children: [Self] { get }
    var parent: Self? { get }
    var hasContent: Bool { get }
}
// TODO: The way to go forward with this is to then give OutlineNode an `init()` method for OutlineRepresentable objects, and then maybe to give RootItem a similar method? And also to make a class? of object called OutlineViewData, and give it a method to init from a random access collection of OutlineRepresentable items.
// Maybe I need to move the equatable and hashable requirements to *here*, because then OutlineNode's equatable and hashable things will be based off of its .item. Like its `.hash()` function would just be `.item.hash()`?



// TODO (tentative): I should probably split folders out to be a subclass?
class OutlineNode<T: OutlineRepresentable>: ObservableObject, Identifiable, Hashable {
    // var id: UUID = UUID()
    var item: T
    var children: [OutlineNode]
    // var parent: OutlineNode?
    var selectable: Bool = true
    @Published var open: Bool = false
    
    // Make it conform to identifiable etc. by using its item's properties
    var id: T.ID {
        get {
            return self.item.id
        }
    }
    
    var name: String {
        get {
            return self.item.name
        }
    }
    
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
    
    init(item: T) {
        self.item = item
        self.children = [OutlineNode]()
        self.selectable = item.hasContent
        for child in item.children {
            self.children.append(OutlineNode(item: child))
        }
    }
    
    // init<T: OutlineRepresentable>(item: T, parent: OutlineNode) {
    //     self.children = [OutlineNode]()
    //     self.parent = parent
    //     self.selectable = item.hasContent
    //     for child in item.children {
    //         self.children.append(OutlineNode(item: child, parent: self))
    //     }
    // }
    
    static func == (lhs: OutlineNode, rhs: OutlineNode) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
    

