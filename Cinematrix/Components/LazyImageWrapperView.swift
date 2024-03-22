//
//  LazyImageWrapperView.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation
import SwiftUI
import NukeUI

struct LazyImageWrapperView: View {
		@State var url: URL
		@State var imageViewId = UUID()

		var body: some View {
				VStack {
						LazyImage(url: url) { state in
								if let image = state.image {
										image.resizable()
												.scaledToFill()
								} else if let _ = state.error {
									Button(action: {
										imageViewId = UUID()
									}, label: {
										VStack {
											Image(systemName: "arrow.clockwise")
											Text(LocalizableStrings.tapToReload)
										}
									})
								} else {
										ProgressView()
								}
						}
						.id(imageViewId)
				}
		}
}
