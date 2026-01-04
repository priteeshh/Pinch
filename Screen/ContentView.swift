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
    @State private var baseScale: CGFloat = 1
    
    let pages: [Page] = pageData
    @State private var pageIndex : Int = 0
    @State private var isDrawerOpen: Bool = false

    func resetImage() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
            lastDragOffset = .zero
            baseScale = 1
        }
    }
    
    func currentPage() -> String {
        pages[pageIndex].imageName
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear

                Image(currentPage())
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
                                baseScale = 5
                            }
                        } else {
                            resetImage()
                            baseScale = 1
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
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                // Compute scale relative to the scale at the start of the gesture
                                let proposed = baseScale * value
                                // Clamp between 1 and 5
                                imageScale = min(max(proposed, 1), 5)
                            }
                            .onEnded { value in
                                // Commit the new base scale, clamped
                                baseScale = min(max(baseScale * value, 1), 5)
                                if baseScale <= 1 {
                                    resetImage()
                                    baseScale = 1
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
            .overlay(
                DrawerView(pages: pages, pageIndex: $pageIndex)
            )
            .overlay(
                Group {
                    HStack {
                        Button {
                            if imageScale > 1 {
                                imageScale -= 1
                                baseScale = imageScale
                                
                                if imageScale <= 1 {
                                    resetImage()
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        
                        Button {
                            resetImage()
                            baseScale = 1
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                    imageScale += 1
                                    baseScale = imageScale
                                    
                                    if imageScale > 5 {
                                        imageScale = 5
                                        baseScale = imageScale
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                }.padding(30),
                alignment: .bottom
            )
        }
    }
}

#Preview {
    ContentView()
}
