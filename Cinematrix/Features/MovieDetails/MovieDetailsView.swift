//
//  MovieDetailsView.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import SwiftUI

struct MovieDetailsView: View {
	@StateObject var viewModel: MovieDetailsViewModel
	
	init(id: Int) {
		self._viewModel = StateObject(wrappedValue: MovieDetailsViewModel(id: id))
	}
	
	var body: some View {
		VStack {
			switch viewModel.state {
			case .loading:
				ProgressView()
			case .success(let movie):
				MovieDetailsViewContent(movie: movie)
			case .error(let error):
				VStack {
					Text(LocalizableStrings.errorTitle)
					Text(error.localizedDescription)
					Button(LocalizableStrings.retryButton) {
						viewModel.getMovie()
					}
				}
			case .none:
				EmptyView()
			}
		}.onAppear {
			viewModel.getMovie()
		}
	}
}
