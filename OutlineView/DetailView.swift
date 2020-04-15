//
//  DetailView.swift
//  OutlineView
//
//  Created by Toph Allen on 4/14/20.
//  Copyright © 2020 Toph Allen. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var item: OutlineData?
    
    @ViewBuilder
    var body: some View {
        VStack {
            if item != nil {
                Text(item!.name)
                    .font(.title)
                    .padding()
                    .frame(alignment: .topLeading)
                // Spacer()
            } else {
                Text("No Item Selected")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding()
                    .frame(alignment: .center)
            }
        }
        .frame(minWidth: 100, maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let item = OutlineData(name: "Item 1.1")
        
        return Group {
            DetailView(item: item)
            DetailView(item: nil)
        }
    }
}
