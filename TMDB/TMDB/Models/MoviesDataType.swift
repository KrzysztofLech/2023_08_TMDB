//  MoviesDataType.swift
//  Created by Krzysztof Lech on 28/08/2023.

import Foundation

enum MoviesDataType: String, CaseIterable {
	case nowPlaying, topRates, popular, upcoming

	var path: String {
		switch self {
		case .nowPlaying:
			return "https://api.themoviedb.org/3/movie/now_playing"
		case .topRates:
			return "https://api.themoviedb.org/3/movie/top_rated"
		case .popular:
			return "https://api.themoviedb.org/3/movie/popular"
		case .upcoming:
			return "https://api.themoviedb.org/3/movie/upcoming"

		}
	}

	var title: String {
		switch self {
		case .nowPlaying:
			return "Movies in theatres"
		case .topRates:
			return "Top rated movies"
		case .popular:
			return "Popular movies"
		case .upcoming:
			return "Upcoming movies"
		}
	}
}
