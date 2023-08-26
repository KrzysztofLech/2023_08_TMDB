//  HomeViewModel.swift
//  Created by Krzysztof Lech on 26/08/2023.

import Foundation

final class HomeViewModel: ObservableObject {
	private let dataService: DataServiceProtocol

	init(dataService: DataServiceProtocol) {
		self.dataService = dataService

		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			self.isLoaderVisible = false
		}
	}

	// MARK: - UI -

	@Published var isLoaderVisible = true
}
