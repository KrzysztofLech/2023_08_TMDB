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

	// MARK: - Data -

	@Published var nowPlaying: [NowPlayingResult] = []

	private func setupSynchronisationWithDataService() {
		dataService.nowPlayingPublisher
			.receive(on: RunLoop.main)
			.assign(to: \.nowPlaying, on: self)
			.store(in: &cancellables)
	}

	func getData() {
		dataService.getData()
	}
}
