//
//  OutlineView.swift
//  OutlineView
//
//  Created by Toph Allen on 4/13/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//
import Foundation
import SwiftUI


struct OutlineRow: View {
    @ObservedObject var item: OutlineNode
    var level: CGFloat

    var body: some View {
        HStack {
            
            Group {
                if item.children.count > 0 {
                    Image(item.open == false ? "arrowtriangle.right.fill.13-regular-small" : "arrowtriangle.down.fill.13-regular-small")
                        .renderingMode(.template)
                        .foregroundColor(Color.secondary)
                } else {
                    Image("arrowtriangle.right.fill.13-regular-small")
                        .opacity(0)
                }
            }
            .frame(width: 16, height: 16)
            .onTapGesture {
                self.item.open.toggle()
            }
            
            Image(item.children.count > 0 ? "folder.13-regular-medium" : "doc.13-regular-medium")
                .renderingMode(.template)
                .frame(width: 16, height: 16)
                .padding(.leading, -4)
            
            Text(item.name)
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


struct OutlineBranch: View {
    @ObservedObject var item: OutlineNode
    @Binding var selectedItem: OutlineNode?
    var level: CGFloat
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 2) { // spacing: 2 is what List uses
            if item.isRoot {
                EmptyView()
            } else {
                VStack {
                    if item == selectedItem {
                        OutlineRow(item: item, level: level)
                            .background(Color.accentColor)
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    } else {
                        OutlineRow(item: item, level: level)
                        .onTapGesture {
                            if self.item.hasContent == true {
                                self.selectedItem = self.item
                            }
                        }
                    }
                }
            }
            if item.open == true || item.isRoot == true {
                ForEach(item.childrenFoldersFirst, id: \.id) { item in
                    OutlineBranch(item: item, selectedItem: self.$selectedItem, level: self.level + 1)
                }
                // .padding(.leading, item.isRoot ? 0 : 24)

                // FIXME: Animation is super-jank
                // .transition(.move(edge: .top))
                // .animation(.linear(duration: 0.1))
            }
        }
    }
}

struct OutlineSection: View {
    @ObservedObject var rootItem: RootNode
    @Binding var selectedItem: OutlineNode?
    
    var body: some View {
        // Embedding it in a List rather than a ScrollView might let me tag items for selection.
        // It also definitely gives it different metrics — a margin in the window, for example. Not sure which is better.
        List {
            // The padding in the section header is there to adjust for the inset hack.
            Section(header: Text(rootItem.name).padding(.leading, 8)) {
                ForEach(rootItem.childrenFoldersFirst, id: \.id) { item in
                    OutlineBranch(item: item, selectedItem: self.$selectedItem, level: 0)
                }
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



struct Outline_Previews: PreviewProvider {
    static var previews: some View {
        let root = RootNode.getRoot()
        return Group {
            OutlineSection(rootItem: root, selectedItem: .constant(root.children[1]))
                .frame(width: 200)
            OutlineBranch(item: root, selectedItem: .constant(root.children[1]), level: 0)
                .frame(width: 200)
        }
    }
}
