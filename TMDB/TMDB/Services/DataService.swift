//  DataService.swift
//  Created by Krzysztof Lech on 26/08/2023.

import Combine
import Foundation

typealias MovieCollection = (type: MoviesDataType, movies: [Movie])

protocol DataServiceProtocol {
	var dataDownloadingInProgressPublisher: Published<Bool>.Publisher { get }
	var data: [MovieCollection] { get }
	func getData()
}

final class DataService: DataServiceProtocol {
	private var cancellables = Set<AnyCancellable>()

	private let apiKey = "7b9e86f73d32a2cd520b8c757fe87c3b"
	private let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YjllODZmNzNkMzJhMmNkNTIwYjhjNzU3ZmU4N2MzYiIsInN1YiI6IjY0ZTFhMjUyNGE1MmY4MDEzYmQzZTUzNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7-WFMTGY1C2Tq5XKMvMNVAwZF7U-JZkrgkZkM4qRf_A"

	private let session = URLSession.shared

	private func getUrlRequestFor(_ dataType: MoviesDataType, andLanguage language: Language) -> URLRequest? {
		let fullUrlString = dataType.path + "?language=\(language.code)&page=1"
		guard let url = URL(string: fullUrlString) else { return nil }

		let headers = [
			"accept": "application/json",
			"Authorization": "Bearer \(token)"
		]

		var urlRequest = URLRequest(
			url: url,
			cachePolicy: .useProtocolCachePolicy,
			timeoutInterval: 10.0
		)
		urlRequest.httpMethod = "GET"
		urlRequest.allHTTPHeaderFields = headers

		return urlRequest
	}

	@Published var dataDownloadingInProgress = true
	var dataDownloadingInProgressPublisher: Published<Bool>.Publisher { $dataDownloadingInProgress }

	var data: [(type: MoviesDataType, movies: [Movie])] = [] {
		didSet {
			if data.count == MoviesDataType.allCases.count {
				dataDownloadingInProgress = false
			}
		}
	}

	func getData() {
		let language = Language.pl

		MoviesDataType.allCases.forEach { type in
			getMoviesData(type, language: language)
		}
	}

	private func getMoviesData(_ dataType: MoviesDataType, language: Language) {
		guard let urlRequest = getUrlRequestFor(dataType, andLanguage: language) else { return }

		session.dataTaskPublisher(for: urlRequest)
			.map { $0.data }
			.decode(type: MoviesData.self, decoder: JSONDecoder())
			.sink(
				receiveCompletion: { _ in },
				receiveValue: { decodedData in
					self.data.append((dataType, decodedData.movies))
					print("\(dataType.rawValue) downloaded")
				}
			)
			.store(in: &cancellables)
	}
}
