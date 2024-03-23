//
//  MovieCastListView.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import SwiftUI

struct MovieCastListView: View {
    
    let cast: [MovieDetails.CastMember]
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizableStrings.cast)
                .font(.headline)
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(cast, id: \.id) { item in
                        VStack {
                            castImage(item)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                            
                            VStack {
                                Text(item.name)
                                    .font(.system(size: 17))
                                Text(item.character)
                                    .font(.system(size: 12))
                                Spacer()
                            }
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(maxHeight: .infinity)
                        }.frame(width: 120)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func castImage(_ item: MovieDetails.CastMember) -> some View {
        if let image = item.profileURL {
            LazyImageWrapperView(url: image)
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
        }
    }
}

#Preview {
    MovieCastListView(cast: [.init(cast: .init(id: 1, name: "Timothée Chalamet", profilePath: "/BE2sdjpgsa2rNTFa66f7upkaOP.jpg", character: "Paul Atreides", order: 0), imageBaseURL: .init(string: "https://image.tmdb.org/t/p")!), .init(cast: .init(id: 2, name: "Timothée Chalamet", profilePath: nil, character: "Paul Atreides", order: 0), imageBaseURL: .init(string: "https://image.tmdb.org/t/p")!)])
}
