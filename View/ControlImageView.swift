//
//  ControlImageView.swift
//  Pinch
//
//  Created by Preeteesh Remalli on 03/01/26.
//

import SwiftUI

struct ControlImageView: View {
    
    let icon: String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ControlImageView(icon: "circle.fill")
        .padding()
}
