//  Language.swift
//  Created by Krzysztof Lech on 28/08/2023.

import Foundation

enum Language {
	case pl, us

	var code: String {
		switch self {
		case .pl: return "pl-PL"
		case .us: return "en-US"
		}
	}
}
