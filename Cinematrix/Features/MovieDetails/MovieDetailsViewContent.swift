//
//  MovieDetailsViewContent.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import SwiftUI

struct MovieDetailsViewContent: View {
    let movie: MovieDetails
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    MovieBackdropsView(movie: movie, width: proxy.size.width)
                    
                    MovieGeneralInfoView(movie: movie)
                        .padding([.leading, .trailing])
                    
                    MovieCastListView(cast: movie.cast)
                }
            }.navigationTitle(movie.title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let movie = MovieDetails.init(genres: ["Action", "Horror", "Thriller"], id: 1, overview: "Characters from different backgrounds are thrown together when the plane they're travelling on crashes into the Pacific Ocean. A nightmare fight for survival ensues with the air supply running out and dangers creeping in from all sides.", releaseDate: "2024-01-18", tagline: "Brace yourself.", title: "No Way Up", voteAverage: 7)
    return MovieDetailsViewContent(movie: movie)
}
