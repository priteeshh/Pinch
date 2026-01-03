//
//  ContentView.swift
//  Pinch
//
//  Created by Preeteesh Remalli on 03/01/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    @State private var lastDragOffset: CGSize = .zero
    
    func resetImage() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
            lastDragOffset = .zero
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear

                Image("magazine-front-cover")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        }
                        else {
                            resetImage()
                        }
                    })
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                imageOffset = CGSize(
                                    width: lastDragOffset.width + value.translation.width,
                                    height: lastDragOffset.height + value.translation.height
                                )
                            }
                            .onEnded { _ in
                                lastDragOffset = imageOffset
                                if imageScale <= 1 {
                                    resetImage()
                                    lastDragOffset = .zero
                                }
                            }
                    )
            }
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { withAnimation(.linear(duration: 1)) { isAnimating = true } }
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30),
                alignment: .top
            )
        }
    }
}

#Preview {
    ContentView()
}
