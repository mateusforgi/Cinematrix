//
//  MovieBackdropsView.swift
//  Cinematrix
//
//  Created by Mateus on 23/03/2024.
//

import SwiftUI

struct MovieBackdropsView: View {
    let movie: MovieDetails
    let width: Double
    
    var body: some View {
        ZStack {
            TabView {
                ForEach(movie.backdrops, id: \.id) { item in
                    LazyImageWrapperView(url: item.url)
                        .frame(width: width, height: width / item.aspectRatio)
                        .scaledToFit()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always)) // Step 11: Customize TabView Style
            .frame(width: width, height: width / (movie.backdrops.first?.aspectRatio ?? 1.5))
        }
    }
}

