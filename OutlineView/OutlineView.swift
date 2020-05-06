//
//  OutlineView.swift
//  OutlineView
//
//  Created by Toph Allen on 4/13/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//
import Foundation
import SwiftUI
import Combine


// This view handles displaying the contents of each row for its object. Clicking its arrow image also toggles a node's open state.
struct OutlineRow<T: OutlineRepresentable>: View {
    @ObservedObject var node: OutlineNode<T>
    var level: CGFloat

    var body: some View {
        HStack {
            Group {
                if !node.isLeaf {
                    Image(node.open == false ? "arrowtriangle.right.fill.13-regular-small" : "arrowtriangle.down.fill.13-regular-small")
                        .renderingMode(.template)
                        .foregroundColor(Color.secondary)
                } else {
                    Image("arrowtriangle.right.fill.13-regular-small")
                        .opacity(0)
                }
            }
            .frame(width: 16, height: 16)
            .onTapGesture {
                self.node.open.toggle()
            }
            
            Image(!node.isLeaf ? "folder.13-regular-medium" : "doc.13-regular-medium")
                .renderingMode(.template)
                .frame(width: 16, height: 16)
                .padding(.leading, -4)

            Text(node.name)
                .lineLimit(1) // If lineLimit is not specified, non-leaf names will wrap
                .truncationMode(.tail)
                .allowsTightening(true)
            
            Spacer()
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .padding(.leading, level * 24)
    }
}


struct OutlineBranch<T: OutlineRepresentable>: View {
    @ObservedObject var node: OutlineNode<T>
    @Binding var selectedItem: OutlineNode<T>?
    var level: CGFloat
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 2) { // spacing: 2 is what List uses
            if level == -1 {
                EmptyView() // the root node is at
            } else {
                // VStack { // we might not need this to be in a VStack
                    if node == selectedItem {
                        OutlineRow(node: node, level: level)
                            .background(Color.accentColor)
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    } else {
                        OutlineRow(node: node, level: level)
                        .onTapGesture {
                            if self.node.selectable == true {
                                self.selectedItem = self.node
                            }
                        }
                    }
                // }
            }
            if node.isLeaf == false && (node.open == true || level == -1) {
                ForEach(node.childrenFoldersFirst!, id: \.id) { node in
                    OutlineBranch(node: node, selectedItem: self.$selectedItem, level: self.level + 1)
                }
                // .padding(.leading, node.isRoot ? 0 : 24)

                // FIXME: Animation is super-jank
                // .transition(.move(edge: .top))
                // .animation(.linear(duration: 0.1))
            }
        }
    }
}


struct OutlineSection<T: OutlineRepresentable, U: RandomAccessCollection>: View where U.Element == T {
    @Binding var outlineTree: OutlineTree<T, U>  // We need to keep the tree outside of the object itself.
    @Binding var selectedItem: OutlineNode<T>? // Maybe this could be a value for a subtree?
    
    // init(items: [T], selectedItem: Binding<NodeType?>) {
    //     self.outlineTree = OutlineTree(representedObjects: items)
    //     self._selectedItem = selectedItem
    // }
    
    // init(outlineTree: OutlineTree, selected
    
    var body: some View {
        List {
            // The padding in the section header is there to adjust for the inset hack.
            Section(header: Text(self.outlineTree.rootNode.name).padding(.leading, 8)) {
                OutlineBranch<T>(node: self.outlineTree.rootNode, selectedItem: self.$selectedItem, level: -1)
            }
            .collapsible(false)
        }
        .listStyle(SidebarListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.leading, -8)
        // A hack for list row insets not working. This hack also applies to the section header though.
    }
}




// struct Outline_Previews: PreviewProvider {
//     static var previews: some View {
//         return OutlineSection<<#T: OutlineRepresentable#>>(outlineTree: OutlineTree(representedObjects: exampleArray()), selectedItem: .constant(nil))
//             .frame(width: 200)
//     }
// }
