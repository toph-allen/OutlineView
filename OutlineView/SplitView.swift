// //
// //  SplitView.swift
// //  OutlineView
// //
// //  Created by Toph Allen on 4/14/20.
// //  Copyright © 2020 Toph Allen. All rights reserved.
// //

import SwiftUI

struct SplitView: View {
    @EnvironmentObject var exampleData: ExampleData
    @State var selectedItem: OutlineNode<ExampleClass>? = nil
    @State var outlineTree: OutlineTree<ExampleClass> = ExampleData.
    
    var body: some View {
        NavigationView {
            OutlineSection(outlineTree: outlineTree, selectedItem: $selectedItem)
                .frame(minWidth: 200, maxHeight: .infinity)
            DetailView(item: selectedItem?.representedObject)
                .frame(maxHeight: .infinity)
        }
    }
}
// 
// struct SplitView_Previews: PreviewProvider {
//     static var previews: some View {
//         let item = exampleData()
//         
//         return SplitView(rootItem: item)
//     }
// }
