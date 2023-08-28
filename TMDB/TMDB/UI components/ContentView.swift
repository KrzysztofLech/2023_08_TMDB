//  ContentView.swift
//  Created by Krzysztof Lech on 26/08/2023.

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var viewModel: HomeViewModel

	private let inset: CGFloat = 16

	var body: some View {
		ZStack {
			Colors.background.ignoresSafeArea()

			VStack(alignment: .center, spacing: 32) {
				header
				movieCarousels
			}
		}
	}

	@ViewBuilder
	private var header: some View {
		VStack(alignment: .center, spacing: 0) {
			Image("logoTMDB")
				.padding(.top, 16)
		}
	}

	@ViewBuilder
	private var movieCarousels: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: inset) {
				ForEach(viewModel.data, id:\.0) { item in
					if item.type == viewModel.landscapeMovieType {
						landscapeCarousel(data: item)
					} else {
						portraitCarousel(data: item)
					}
				}
			}
		}
	}

	@ViewBuilder
	private func landscapeCarousel(data: MovieCollection) -> some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(data.type.title)
				.carouselTitleStyle(withInset: inset)

			ScrollView(.horizontal, showsIndicators: false) {
				HStack(alignment: .center, spacing: inset) {
					ForEach(Array(data.movies.enumerated()), id: \.offset) { index, movie in
						VStack(alignment: .center, spacing: 0) {
							CoverView(
								imageUrl: movie.backdropUrl,
								size: viewModel.landscapeCoverSize
							)

							Text(movie.title)
								.foregroundColor(Colors.background)
								.font(.headline.bold())
								.padding(8)
						}
						.background(Colors.superLight)
						.cornerRadius(8)
						.padding(.leading, index == 0 ? inset : 0)
						.padding(.trailing, index == (data.movies.count - 1) ? inset : 0)
					}
				}
			}
		}
	}

	@ViewBuilder
	private func portraitCarousel(data: MovieCollection) -> some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(data.type.title)
				.carouselTitleStyle(withInset: inset)

			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 16) {
					ForEach(Array(data.movies.enumerated()), id: \.offset) { index, movie in
						CoverView(
							imageUrl: movie.posterUrl,
							size: viewModel.portraitCoverSize,
							cornerRadius: 8
						)
						.padding(.leading, index == 0 ? inset : 0)
						.padding(.trailing, index == (data.movies.count - 1) ? inset : 0)
					}
				}
			}
		}
		.padding(.top, 8)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(HomeViewModel(dataService: DataService()))
	}
}
