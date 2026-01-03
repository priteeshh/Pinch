//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Preeteesh Remalli on 03/01/26.
//

import SwiftUI

struct InfoPanelView: View {
    
    var scale : CGFloat
    var offset: CGSize
    
    @State private var isInfoPanelVisuable: Bool = false

    var body: some View {
        HStack {
            Image(systemName: "circle.circle")
                .resizable()
                .symbolRenderingMode(.hierarchical)
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1, perform: {
                    withAnimation(.easeInOut) {
                        isInfoPanelVisuable.toggle()
                    }
                })
            Spacer()
            
            HStack {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text(verbatim: String(format: "%.2f", scale))

                Image(systemName: "arrow.left.and.right")
                Text(verbatim: String(format: "%.2f", offset.width))
                
                Image(systemName: "arrow.up.and.down")
                Text(verbatim: String(format: "%.2f", offset.height))
                
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisuable ? 1 : 0)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    InfoPanelView(scale: 1, offset: .zero)
        .padding()
}
