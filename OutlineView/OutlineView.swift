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
                    Image(open == false ? "arrowtriangle.right.fill.13-regular-small" : "arrowtriangle.down.fill.13-regular-small")
                        .renderingMode(.template)
                        .foregroundColor(Color.secondary)
                } else {
                    Image("arrowtriangle.right.fill.13-regular-small")
                        .opacity(0)
                }
            }.frame(width: 16, height: 16)
            Image(item.children.count > 0 ? "folder.13-regular-medium" : "doc.13-regular-medium")
                .renderingMode(.template)
                .foregroundColor(Color.primary)
                .frame(width: 16, height: 16)
            Text(item.name)
                .truncationMode(.tail)
                .allowsTightening(true)
            Spacer()
        }
        .padding(4)
    }
}


struct OutlineBranch: View {
    var item: OutlineData
    @State var open: Bool = false
    
    @ViewBuilder
    var body: some View {
        VStack(spacing: 0) {
            Section {
                if item.isRoot {
                    EmptyView()
                } else {
                    OutlineRow(item: item, open: $open)
                        .onTapGesture {
                            self.open.toggle()
                    }
                }
            }
            if open == true || item.isRoot == true {
                ForEach(item.children, id: \.name) { item in
                    OutlineBranch(item: item)
                }
                .padding(.leading, item.isRoot ? 0 : 24)

                // FIXME: Animation is super-jank
                // .transition(.move(edge: .top))
                // .animation(.linear(duration: 0.1))
            }
        }
    }
}

struct OutlineContainer: View {
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
        let root = OutlineData.getRoot()
        return OutlineBranch(item: root)
            .frame(width: 200)
    }
}
