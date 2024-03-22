//
//  BorderedText.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import SwiftUI

struct BorderedText: View {
    var text: String
    var borderWidth: CGFloat
    
    var body: some View {
        Text(text)
            .padding(Edge.Set([.top, .bottom]), 5)
            .padding(Edge.Set([.leading, .trailing]), 10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: borderWidth)
            )
    }
}

#Preview {
    BorderedText(text: "Action", borderWidth: 1)
}
