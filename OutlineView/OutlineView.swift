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
    @ObservedObject var item: OutlineData

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
            .onTapGesture { // Can I make this tap area bigger?
                self.item.open.toggle()
            }
            
            Image(item.children.count > 0 ? "folder.13-regular-medium" : "doc.13-regular-medium")
                .renderingMode(.template)
                .foregroundColor(Color.primary)
                .frame(width: 16, height: 16)
            
            Text(item.name)
                .lineLimit(1) // If this is not present, non-leaf items will wrap
                .truncationMode(.tail)
                .allowsTightening(true)
            
            Spacer()
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
    }
}


struct OutlineBranch: View {
    @ObservedObject var item: OutlineData
    @Binding var selectedItem: OutlineData?
    
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
        // List {
            Section() {
                if item.isRoot {
                    EmptyView()
                } else {
                    OutlineRow(item: item)
                    .onTapGesture {
                        self.selectedItem = self.item
                    }
                    // .border(Color.gray)
                }
            }
            if item.open == true || item.isRoot == true {
                ForEach(item.children, id: \.id) { item in
                    OutlineBranch(item: item, selectedItem: self.$selectedItem)
                }
                .padding(.leading, item.isRoot ? 0 : 24)

                // FIXME: Animation is super-jank
                // .transition(.move(edge: .top))
                // .animation(.linear(duration: 0.1))
            }
        }
    }
}

struct OutlineSection: View {
    @ObservedObject var rootItem: OutlineData
    @Binding var selectedItem: OutlineData?
    
    var body: some View {
        // Embedding it in a List rather than a ScrollView might let me tag items for selection.
        // It also definitely gives it different metrics — a margin in the window, for example. Not sure which is better.
        List(selection: $selectedItem) {
            Section {
                ForEach(rootItem.children, id: \.id) { item in
                        OutlineBranch(item: item, selectedItem: self.$selectedItem)
                }
                // Spacer()
            }.collapsible(false)
        }
        .listStyle(SidebarListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.leading, -8)
        // A hack for list row insets not working. This hack also applies to the section header though.
        
    }
}



struct Outline_Previews: PreviewProvider {
    static var previews: some View {
        let root = OutlineData.getRoot()
        return Group {
            OutlineSection(rootItem: root, selectedItem: .constant(root.children[0]))
                .frame(width: 200)
            OutlineBranch(item: root, selectedItem: .constant(root.children[1]))
                .frame(width: 200)
        }
    }
}
