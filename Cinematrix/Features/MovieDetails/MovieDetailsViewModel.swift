//
//  MovieDetailsViewModel.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//


import Combine

@MainActor
final class MovieDetailsViewModel: ObservableObject {
	
	@Published var state: MovieDetailsViewModel.State?
	
	let client: MovieClient
	let id: Int
	
	init(id: Int, client: MovieClient = MovieNetworkClient()) {
		self.client = client
		self.id = id
	}
	
	func getMovie() {
		guard state != .loading else {
			return
		}
		state = .loading
		Task {
			do {
				let movie = try await client.movieDetails(id)
                state = .success(movie: .init(movie, imageBaseURL: client.imageBaseURL))
			} catch {
				state = .error(error: error)
			}
		}
	}
}

extension MovieDetailsViewModel {
	enum State: Equatable {
		static func == (lhs: MovieDetailsViewModel.State, rhs: MovieDetailsViewModel.State) -> Bool {
			switch (lhs, rhs) {
			case (.loading, .loading):
				return true
			case let (.success(lhsMovie), .success(rhsMovie)):
				return lhsMovie.id == rhsMovie.id
			case let (.error(lhsError), .error(rhsError)):
				return lhsError.localizedDescription == rhsError.localizedDescription
			default:
				return false
			}
		}
		
		case loading
		case success(movie: MovieDetails)
		case error(error: Error)
	}
}
