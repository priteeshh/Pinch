//
//  DrawerView.swift
//  Pinch
//
//  Created by Preeteesh Remalli on 04/01/26.
//

import SwiftUI

struct DrawerView: View {
    var pages: [Page]
    @State private var isDrawerOpen: Bool = false
    @Binding var pageIndex: Int

    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 12) {
                Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                    .padding(8)
                    .foregroundStyle(.secondary)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            isDrawerOpen.toggle()
                        }
                    }

                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(content: {
                        ForEach(pages) { item in
                            Image(item.thumnailImageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .cornerRadius(4)
                                .shadow(radius: 4)
                                .opacity(isDrawerOpen ? 1 : 0)
                                .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                                .onTapGesture(perform: {
                                    pageIndex = item.id - 1
                                })
                            
                        }
                        Spacer()
                    })
                })
            }
            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .padding(.top, proxy.size.height / 12)
            .offset(x: isDrawerOpen ? 20 : proxy.size.width - 50)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DrawerView(pages: pageData, pageIndex: .constant(0))
}
