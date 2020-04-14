//
//  ContentView.swift
//  OutlineView-iOS
//
//  Created by Toph Allen on 4/13/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let outlineData = OutlineData.rootItem()
    var body: some View {
        OutlineView(item: outlineData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
