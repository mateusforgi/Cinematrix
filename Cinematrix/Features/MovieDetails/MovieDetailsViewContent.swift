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
                    ZStack {
                        LazyImageWrapperView(url: movie.posterURL)
                            .scaledToFit()
                            .frame(width: proxy.size.width, height: proxy.size.width * 1.5)
                        
                        VStack {
                            HStack(alignment: .bottom, spacing: 5) {
                                Spacer()
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                
                                Text("**\(String(format: "%.1f", movie.voteAverage))** / 10")
                                
                            }.foregroundColor(.white)
                            
                            Spacer()
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                        .font(.system(size: 17, weight: .bold))
                                    Text(movie.tagline)
                                }.foregroundColor(.white)
                                
                                Spacer()
                            }.frame(maxWidth: .infinity)
                        }.padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.clear, Color.clear, Color.black]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                ).opacity(0.5)
                            )
                    }
                    
                    infoView
                }
                
            }.navigationTitle(movie.title)
                .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    @ViewBuilder
    var infoView: some View {
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
    let movie = MovieDetails.init(genres: ["Action", "Horror", "Thriller"], id: 1, overview: "Characters from different backgrounds are thrown together when the plane they're travelling on crashes into the Pacific Ocean. A nightmare fight for survival ensues with the air supply running out and dangers creeping in from all sides.", posterURL: URL(string: "https://image.tmdb.org/t/p/w300/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg")!, releaseDate: "2024-01-18", tagline: "Brace yourself.", title: "No Way Up", voteAverage: 7)
    return MovieDetailsViewContent(movie: movie)
}
