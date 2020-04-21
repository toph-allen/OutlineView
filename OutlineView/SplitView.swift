// //
// //  SplitView.swift
// //  OutlineView
// //
// //  Created by Toph Allen on 4/14/20.
// //  Copyright © 2020 Toph Allen. All rights reserved.
// //
// 
// import SwiftUI
// 
// struct SplitView<T: OutlineRepresentable>: View {
//     typealias NodeType = OutlineNode<T>
//     var rootItem: T
//     @State var selectedItem: OutlineNode<T>?
// 
//     var body: some View {
//         NavigationView {
//             OutlineSection(rootItem: rootItem, selectedItem: $selectedItem)
//                 .frame(minWidth: 200, maxHeight: .infinity)
//             DetailView(item: selectedItem)
//                 .frame(maxHeight: .infinity)
//         }
//     }
// }
// 
// struct SplitView_Previews: PreviewProvider {
//     static var previews: some View {
//         let item = exampleData()
//         
//         return SplitView(rootItem: item)
//     }
// }
