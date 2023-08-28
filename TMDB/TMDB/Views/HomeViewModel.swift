//  HomeViewModel.swift
//  Created by Krzysztof Lech on 26/08/2023.

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
	private let dataService: DataServiceProtocol
	private var cancellables = Set<AnyCancellable>()

	init(dataService: DataServiceProtocol) {
		self.dataService = dataService

		setupSynchronisationWithDataService()
	}

	// MARK: - UI -

	@Published var isLoaderVisible = true

	var landscapeMovieType: MoviesDataType = .nowPlaying
	var portraitCoverSize = CGSize(width: 200, height: 300)
	var landscapeCoverSize = CGSize(width: 500, height: 281)

	// MARK: - Data -

	lazy var data: [MovieCollection] = {
		var data: [MovieCollection] = []
		dataService.data.forEach { item in
			if item.type == landscapeMovieType {
				data.insert(item, at: 0)
			} else {
				data.append(item)
			}
		}
		return data
	}()

	private func setupSynchronisationWithDataService() {
		dataService.dataDownloadingInProgressPublisher
			.receive(on: RunLoop.main)
			.assign(to: \.isLoaderVisible, on: self)
			.store(in: &cancellables)
	}

	func getData() {
		dataService.getData()
	}
}
