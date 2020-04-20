//
//  ContentView.swift
//  OutlineView
//
//  Created by Toph Allen on 4/13/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    let rootNode = exampleData()
    var body: some View {
        Text("Hello World!")
        // SplitView(rootNode: rootNode)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
