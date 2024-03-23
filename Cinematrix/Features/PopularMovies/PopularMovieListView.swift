//
//  PopularMovieListView.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import SwiftUI

struct PopularMovieListView: View {
    
    @StateObject var viewModel: PopularMoviesViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var items: FetchedResults<Movie>
    @State var position: ScrollPositionValue = .init(size: .zero, position: .zero)
    private let coordinateSpaceName = UUID()
    
    init() {
        let pageSize = 20
        _items = .init(fetchRequest: Movie.pageSizeRequest(of: pageSize))
        _viewModel = .init(wrappedValue: PopularMoviesViewModel(pageSize: pageSize))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                PositionObservingView(
                    coordinateSpace: .named(coordinateSpaceName),
                    position: $position,
                    content: { getList(geometry.size.width) })
                if viewModel.loading, !viewModel.refreshing {
                    loadingView
                }
            }
            .onChange(of: position, {
                handlePositionUpdate(position, viewHeight: geometry.size.height)
            })
            .coordinateSpace(name: coordinateSpaceName)
            .refreshable {
                await viewModel.refresh()
            }
        }
        .alert(isPresented: .constant(viewModel.error != nil), content: {
            Alert(title: Text(LocalizableStrings.errorTitle),
                  message: Text(viewModel.error!.localizedDescription),
                  dismissButton: .cancel(Text(LocalizableStrings.ok),
                                         action: {
                viewModel.error = nil
            }))
        })
        .navigationTitle(LocalizableStrings.popularMoviesHeader)
    }
    
    func handlePositionUpdate(_ newValue: ScrollPositionValue, viewHeight: CGFloat) {
        let didPullUp = newValue.position != .zero && ((newValue.size.height - abs(newValue.position.y)) < (viewHeight - 20))
        
        if didPullUp {
            Task {
                await viewModel.fetchMore()
            }
        }
    }
    
    @ViewBuilder var loadingView: some View {
        HStack {
            Spacer()
            VStack {
                ProgressView().id(UUID())
                Text(LocalizableStrings.fetching)
                    .padding(5)
                    .font(.system(size: 12, weight: .bold))
            }
            Spacer()
        }
    }
    
    @ViewBuilder func getList(_ parentWidth: CGFloat) -> some View {
        let space: Double = 10
        let spacing: Double = (space * 2) / 3
        let width = ((parentWidth / 2) - space)
        
        LazyVGrid(columns: [GridItem(.fixed(width), spacing: spacing),
                            GridItem(.fixed(width), spacing: 0)],
                  alignment: .center, spacing: spacing) {
            ForEach(items, id: \.id) { movie in
                NavigationLink {
                    MovieDetailsView(id: movie.id)
                } label: {
                    PopularMovieCell(summary: .init(movie), width: width)
                }
            }
        }
    }
}
