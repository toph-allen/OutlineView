//
//  OutlineNode.swift
//  OutlineView
//
//  Created by Toph Allen on 4/13/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import Foundation

let foldersHaveContent: Bool = false


protocol OutlineRepresentable: ObservableObject, Identifiable, Hashable {
    var name: String { get }
    var children: [Self]? { get }
    var parent: Self? { get }
    var hasContent: Bool { get }
}
// TODO: The way to go forward with this is to then give OutlineNode an `init()` method for OutlineRepresentable objects, and then maybe to give RootItem a similar method? And also to make a class? of object called OutlineViewData, and give it a method to init from a random access collection of OutlineRepresentable items.
// Maybe I need to move the equatable and hashable requirements to *here*, because then OutlineNode's equatable and hashable things will be based off of its .item. Like its `.hash()` function would just be `.item.hash()`?


class OutlineNode<T: OutlineRepresentable>: ObservableObject, Identifiable, Hashable {
    // var id: UUID = UUID()
    var representedObject: T?
    var children: [OutlineNode]?
    var parent: OutlineNode?
    var selectable: Bool = true
    @Published var open: Bool = false
    
    // Make it conform to identifiable etc. by using its item's properties
    var id: T.ID? {
        get {
            return self.representedObject?.id
        }
    }
    
    var name: String {
        get {
            return self.representedObject?.name ?? ""
        }
    }
    
    var isLeaf: Bool {
        get {
            if self.children == nil {
                return true
            } else {
                return self.children!.count == 0
            }
        }
    }
    
    var childrenFoldersFirst: [OutlineNode]? {
        get {
            guard self.children != nil else {
                return nil
            }
            return self.children!.sorted { c1, c2 in
                if c1.isLeaf == c2.isLeaf {
                    return c1.name < c2.name
                } else {
                    return !c1.isLeaf && c2.isLeaf // This sorts the trues last?
                }
            }
        }
    }
    
    // Should these also be defined using the item
    static func == (lhs: OutlineNode, rhs: OutlineNode) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(representedObject: T?, parent: OutlineNode? = nil) {
        self.representedObject = representedObject
        
        // If represented objects have children, make child nodes, passing self as parent.
        if self.representedObject?.children != nil {
            self.children = [OutlineNode]()
            for child in representedObject!.children! {
                self.children!.append(OutlineNode(representedObject: child, parent: self))
            }
        }
        
        // If we were given a parent, store it.
        if parent != nil {
            self.parent = parent
        }
    }
    
    init(children: [OutlineNode]) {
        self.children = children
    }
}

// This change should make it so that I can initialize this with any random access collection.
class OutlineTree<T: OutlineRepresentable, U: RandomAccessCollection>: ObservableObject where U.Element == T {
    var representedObjects: U
    var rootNode: OutlineNode<T>
    var name: String?
    
    init(representedObjects: U, name: String? = nil) {
        self.representedObjects = representedObjects
        let rootChildren = representedObjects.filter({
            $0.parent == nil
        }).map({ representedObject in
            OutlineNode(representedObject: representedObject)
        })
        self.rootNode = OutlineNode(children: rootChildren)
        self.name = name
    }
}



