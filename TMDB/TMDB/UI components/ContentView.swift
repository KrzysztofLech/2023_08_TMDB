//  ContentView.swift
//  Created by Krzysztof Lech on 26/08/2023.

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var viewModel: HomeViewModel

	var body: some View {
		ZStack {
			Colors.background.ignoresSafeArea()

			VStack(alignment: .leading, spacing: 32) {

				ScrollView(.horizontal, showsIndicators: true) {
					HStack(alignment: .center, spacing: 16) {
						ForEach(viewModel.nowPlaying) { item in
							CoverView(
								imageUrl: item.posterUrl,
								size: CGSize(width: 200, height: 300)
							)
						}
					}
				}

				ScrollView(.horizontal, showsIndicators: true) {
					HStack(alignment: .center, spacing: 16) {
						ForEach(viewModel.nowPlaying) { item in
							CoverView(
								imageUrl: item.backdropUrl,
								size: CGSize(width: 500, height: 281)
							)
						}
					}
				}
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(HomeViewModel(dataService: DataService()))
	}
}
