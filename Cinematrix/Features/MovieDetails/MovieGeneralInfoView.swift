//
//  MovieGeneralInfoView.swift
//  Cinematrix
//
//  Created by Mateus on 23/03/2024.
//

import SwiftUI

struct MovieGeneralInfoView: View {

    let movie: MovieDetails
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text(movie.overview)
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.leading)
            
            Text(movie.releaseDate)
                .font(.system(size: 12, weight: .regular))
            
            Text(LocalizableStrings.genresSection)
                .font(.headline)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [.init(.adaptive(minimum: 50, maximum: 100), spacing: 10)], alignment: .top, spacing: 10) {
                    ForEach(movie.genres, id: \.self) { genre in
                        BorderedText(text: genre, borderWidth: 1)
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    let movie = MovieDetails.init(genres: ["Action", "Horror", "Thriller"], id: 1, overview: "Characters from different backgrounds are thrown together when the plane they're travelling on crashes into the Pacific Ocean. A nightmare fight for survival ensues with the air supply running out and dangers creeping in from all sides.", releaseDate: "2024-01-18", tagline: "Brace yourself.", title: "No Way Up", voteAverage: 7)
    return MovieGeneralInfoView(movie: movie)
}
