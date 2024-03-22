//
//  PopularMovieCell.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import SwiftUI

struct PopularMovieCell: View {
    let summary: MovieSummary
    let width: Double
    
    var body: some View {
        ZStack(alignment: .bottom) {
            LazyImageWrapperView(url: summary.thumbnailURL)
                .frame(width: width, height: width * 1.5)
            
            VStack(alignment: .leading) {
                if summary.isPopular {
                    HStack {
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .padding()
                    }
                }
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading){
                        Text(summary.title)
                            .lineLimit(2)
                            .font(.system(size: 14, weight: .bold))
                        Text(summary.overview)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 12))
                        
                    }
                    .padding(10)
                    
                    Spacer()
                }.frame(maxWidth: .infinity)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.clear, Color.clear, Color.black]),
                    startPoint: .top,
                    endPoint: .bottom
                ).opacity(0.5)
            )
            .allowsHitTesting(false)
            
            .foregroundColor(.white)
        }.frame(width: width, height: width * 1.5)
            .cornerRadius(10)
            .clipped()
    }
}

#Preview {
    PopularMovieCell(summary: MovieSummary(id: 1,
                                           overview: "The overview of the ",
                                           title: "Spider Man",
                                           voteAverage: 8, thumbnailURL: URL(string: "https://image.tmdb.org/t/p/w300/tVMddOS5bi3YPVPgTPlEw0TOWoF.jpg")!), width: 200)
}
