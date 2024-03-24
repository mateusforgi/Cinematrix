//
//  PopularMoviesViewModel.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation
import Combine

@MainActor
final class PopularMoviesViewModel: ObservableObject {
	@Published var loading = false
	@Published var error: Error?
	@Published var refreshing: Bool = false

	private let provider: MovieProvider
    private (set) var metadata: MovieListMetaData = .init(lastPage: 0, totalPages: 0)
	private var fetchTask: Task<(), Never>?
    private let pageSize: Int
	
    init(provider: MovieProvider = MovieService(), pageSize: Int) {
		self.provider = provider
        self.pageSize = pageSize
        listInitialization()
	}
    
    private func listInitialization() {
        if let metadata: MovieListMetaData = try? UserDefaultWrapper.get(.movieListMetaData) {
            self.metadata = metadata
        } else {
            Task {
                await fetchMore()
            }
        }
    }
	
	func refresh() async {
		fetchTask?.cancel()
		refreshing = true
		await fetch(1, refresh: true)
		refreshing = false
	}
    
	func fetchMore() async {
        await fetch(metadata.lastPage + 1)
	}
	
	private func fetch(_ nextPage: Int, refresh: Bool = false) async {
		guard !loading || refresh else { return }
		
        if nextPage > metadata.totalPages, metadata.totalPages != 0 {
			return
		}
		
		defer { loading = false }

		loading = true
		
		fetchTask = Task {
			do {
				let totalPages = try await provider.fetch(page: nextPage, pageSize: pageSize, deleteCache: refresh)
                metadata = .init(lastPage: nextPage, totalPages: totalPages)
                try UserDefaultWrapper.save(metadata, for: .movieListMetaData)
			} catch {
				if let _ = error as? CancellationError {
					return
				}

				self.error = error
			}
		}
		
		await fetchTask?.value
	}
    
    func parse(movie: Movie) -> MovieSummary {
        return .init(movie, imageBaseURL: provider.imageBaseURL)
    }
}
