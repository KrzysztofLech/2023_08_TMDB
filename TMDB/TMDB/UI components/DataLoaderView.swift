//  DataLoaderView.swift
//  Created by Krzysztof Lech on 26/08/2023.

import SwiftUI

struct DataLoaderView: View {
    var body: some View {
		VStack(alignment: .center, spacing: 16) {
			ProgressView {
				Text("Data loading ...")
			}
			.tint(Colors.primaryAccent)
			.foregroundColor(Colors.primaryAccent)
		}
    }
}

struct DataLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        DataLoaderView()
			.previewLayout(.sizeThatFits)
    }
}
