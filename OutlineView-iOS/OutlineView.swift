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
    var item: OutlineData
    @Binding var open: Bool
    var body: some View {
        HStack {
            Group {
                if item.children.count > 0 {
                    Image(systemName: open == false ? "arrowtriangle.right.fill" : "arrowtriangle.down.fill")
                        .renderingMode(.template)
                        .foregroundColor(Color.secondary)
                } else {
                    Image(systemName: "arrowtriangle.right.fill")
                        .opacity(0)
                }
            }.frame(width: 16, height: 16)
            Image(systemName: item.children.count > 0 ? "folder" : "doc")
                .frame(width: 16, height: 16)
            Text(item.name)
                .truncationMode(.tail)
                .allowsTightening(true)
            // FIXME: I should get rid of the spacer so you can tap anywhere on the row to open the folder.
            Spacer()
        }
        .padding()
    }
}


struct OutlineBranch: View {
    var item: OutlineData
    @State var open: Bool = false
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
            Section {
                OutlineRow(item: item, open: $open)
                    .onTapGesture {
                        self.open.toggle()
                }
            }
            if open == true {
                ForEach(item.children, id: \.name) { item in
                    OutlineBranch(item: item)
                }
                .padding(.leading, 24)

                // FIXME: Animation is super-jank
                // .transition(.opacity)
                // .animation(.easeInOut)
            }
        }
    }
}

struct OutlineView: View {
    var item: OutlineData
    
    var body: some View {
        ScrollView {
            OutlineBranch(item: item)
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



struct Outline_Previews: PreviewProvider {
    static var previews: some View {
        let root = OutlineData.rootItem()
        return OutlineBranch(item: root)
            .frame(width: 200)
    }
}
