//
//  NoteCardView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 27/9/2023.
//

import SwiftUI

struct NoteCardView: View {
	@State private var location: CGPoint = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
	@GestureState private var fingerLocation: CGPoint? = nil
	@GestureState private var startLocation: CGPoint? = nil
	
	@State var textContent: String = ""
	
	var simpleDrag: some Gesture {
		DragGesture()
			.onChanged { value in
				var newLocation = startLocation ?? location
				newLocation.x += value.translation.width
				newLocation.y += value.translation.height
				self.location = newLocation
			}.updating($startLocation) { (value, startLocation, transaction) in
				startLocation = startLocation ?? location
			}
	}
	
	var body: some View {
		TextField("Looks delicious!", text: $textContent, axis: .vertical)
			.multilineTextAlignment(.center)
			.frame(maxWidth: 200)
			.lineLimit(10)
			.padding()
			.background(
				RoundedRectangle(cornerRadius: 10)
					.foregroundColor(.yellow))
			.position(location)
			.gesture(simpleDrag)
	}
}

#Preview {
    NoteCardView()
}
