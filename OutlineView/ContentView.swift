//
//  ContentView.swift
//  OutlineView
//
//  Created by Toph Allen on 4/13/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    let rootItem: ExampleClass = exampleData()
    @State var selectedItem: OutlineNode<ExampleClass>? = nil
    
    var body: some View {
        NavigationView {
            OutlineSection(rootItem: rootItem, selectedItem: $selectedItem)
                .frame(minWidth: 200, maxHeight: .infinity)
            DetailView(item: selectedItem?.item)
                .frame(maxHeight: .infinity)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
