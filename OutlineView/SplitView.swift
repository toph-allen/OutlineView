//
//  SplitView.swift
//  OutlineView
//
//  Created by Toph Allen on 4/14/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import SwiftUI

struct SplitView: View {
    var containers: OutlineData
    @State var selectedItem: OutlineData?

    var body: some View {
        NavigationView {
            OutlineSection(rootItem: containers, selectedItem: $selectedItem)
                .frame(idealWidth: 150, maxHeight: .infinity)
            DetailView(item: selectedItem)
        }
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        let item = OutlineData.getRoot()
        
        return SplitView(containers: item)
    }
}
