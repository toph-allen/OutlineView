//
//  SplitView.swift
//  OutlineView
//
//  Created by Toph Allen on 4/14/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import SwiftUI

struct SplitView: View {
    var outlineTree: OutlineTree<ExampleClass, [ExampleClass]>
    @State var selectedItem: OutlineNode<ExampleClass>? = nil
    
    init(items: [ExampleClass]) {
        outlineTree = OutlineTree(representedObjects: items)
    }
    
    var body: some View {
        NavigationView {
            OutlineSection<ExampleClass, [ExampleClass]>(selectedItem: $selectedItem).environmentObject(outlineTree)
                .frame(minWidth: 200, maxHeight: .infinity)
            DetailView(item: selectedItem?.representedObject)
                .frame(maxHeight: .infinity)
        }
    }
}

// struct SplitView_Previews: PreviewProvider {
//     static var previews: some View {
//         let item = exampleData()
//         
//         return SplitView(rootItem: item)
//     }
// }
