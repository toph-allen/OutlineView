// //
// //  SectionTest.swift
// //  OutlineView
// //
// //  Created by Toph Allen on 4/14/20.
// //  Copyright © 2020 Toph Allen. All rights reserved.
// //
// 
// import SwiftUI
// 
// struct SectionTestBranch: View {
//     @ObservedObject var item: OutlineNode
//     @Binding var selectedItem: OutlineNode?
//     var level: CGFloat
//     
//     @ViewBuilder
//     var body: some View {
//         VStack(spacing: 0) {
//             // List {
//             Section() {
//                 if item.isRoot {
//                     EmptyView()
//                 } else {
//                     OutlineRow(item: item, level: level)
//                         .onTapGesture {
//                             self.selectedItem = self.item
//                     }
//                     // .border(Color.gray)
//                 }
//             }
//             if item.open == true || item.isRoot == true {
//                 ForEach(item.children, id: \.id) { item in
//                     OutlineBranch(item: item, selectedItem: self.$selectedItem, level: self.level + 1)
//                 }
//                 // .padding(.leading, item.isRoot ? 0 : 24)
//                 
//                 // FIXME: Animation is super-jank
//                 // .transition(.move(edge: .top))
//                 // .animation(.linear(duration: 0.1))
//             }
//         }
//     }
// }
// 
// struct SectionTest: View {
//     @ObservedObject var rootItem: OutlineNode
//     @Binding var selectedItem: OutlineNode?
//     
//     var body: some View {
//         // Embedding it in a List rather than a ScrollView might let me tag items for selection.
//         // It also definitely gives it different metrics — a margin in the window, for example. Not sure which is better.
//         List(selection: $selectedItem) {
//             Section(header: Text(self.item)) {
//                 ForEach(rootItem.children, id: \.id) { item in
//                     OutlineBranch(item: item, selectedItem: self.$selectedItem, level: 0)
//                 }
//                 // Spacer()
//             }.collapsible(false)
//         }
//         .listStyle(SidebarListStyle())
//         .frame(maxWidth: .infinity, maxHeight: .infinity)
//         .padding(.leading, -8)
//         // A hack for list row insets not working. This hack also applies to the section header though.
//         
//     }
// }
// 
// struct SectionTest_Previews: PreviewProvider {
//     static var previews: some View {
//         let root = OutlineNode.getRoot()
//         return Group {
//             SectionTest(rootItem: root, selectedItem: .constant(root.children[0]))
//                 .frame(width: 200)
//             SectionTestBranch(item: root, selectedItem: .constant(root.children[1]), level: 0)
//                 .frame(width: 200)
//         }
//     }
// }
