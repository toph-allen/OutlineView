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


struct OutlineRow<T: OutlineRepresentable>: View {
    typealias NodeType = OutlineNode<T>
    @ObservedObject var node: NodeType
    var level: CGFloat

    var body: some View {
        HStack {
            
            Group {
                if node.children.count > 0 {
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
            
            Image(node.children.count > 0 ? "folder.13-regular-medium" : "doc.13-regular-medium")
                .renderingMode(.template)
                .frame(width: 16, height: 16)
                .padding(.leading, -4)
            

            Text(node.name)
                .lineLimit(1) // If this is not present, non-leaf items will wrap
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
    typealias NodeType = OutlineNode<T>
    @ObservedObject var node: NodeType
    @Binding var selectedItem: NodeType?
    var level: CGFloat
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 2) { // spacing: 2 is what List uses
            if level == -1 {
                EmptyView()
            } else {
                VStack {
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
                }
            }
            if node.open == true || level == -1 {
                ForEach(node.childrenFoldersFirst, id: \.id) { node in
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

struct OutlineSection<T: OutlineRepresentable>: View {
    typealias NodeType = OutlineNode<T>
    var rootNode: NodeType
    @Binding var selectedItem: NodeType?
    
    init(rootItem: T, selectedItem: Binding<NodeType?>) {
        self.rootNode = OutlineNode(item: rootItem)
        self._selectedItem = selectedItem
    }
    
    var body: some View {
        // Embedding it in a List rather than a ScrollView might let me tag items for selection.
        // It also definitely gives it different metrics — a margin in the window, for example. Not sure which is better.
        List {
            // The padding in the section header is there to adjust for the inset hack.
            Section(header: Text(self.rootNode.name).padding(.leading, 8)) {
                OutlineBranch(node: rootNode, selectedItem: self.$selectedItem, level: -1)
                // ForEach(rootNode.childrenFoldersFirst, id: \.id) { node in
                //     OutlineBranch(node: node, selectedItem: self.$selectedItem, level: 1)
                // }
                // Spacer()
            }
            .collapsible(false)
        }
        .listStyle(SidebarListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.leading, -8)
        // A hack for list row insets not working. This hack also applies to the section header though.
    }
}

// extension OutlineSection {
//     init(item: T) {
//         self.rootNode = OutlineNode(item: item)
//         // self.selectedItem = nil
//     }
// }



// struct Outline_Previews: PreviewProvider {
//     static var previews: some View {
//         let example = exampleData()
//         
//         return OutlineSection(rootItem: example, selectedItem: .constant(nil))
//             .frame(width: 200)
//     }
// }
