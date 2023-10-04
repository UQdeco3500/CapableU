//
//  ToolbarView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 21/9/2023.
//

import SwiftUI

struct ToolbarView: View {
	
	var model: BoardModel
	
	@State private var showingQR = false
	
	@State private var operation = {}
	
    var body: some View {
		HStack {
			Button{
				showingQR.toggle()
				operation = {
					model.recipes.append(Recipe(
						title: "Poke Bowl",
						coverPhotoString: "poke-bowl",
						description: "These delicious Poke Bowls are healthy and delicious!"))
				}
			} label: {
				Image(systemName: "fork.knife.circle")
					.resizable()
					.scaledToFit()
			}
			Button{
				showingQR.toggle()
				operation = {
					model.notes.append(Note("Heres another note."))
				}
			} label: {
				Image(systemName: "square.and.pencil.circle")
					.resizable()
					.scaledToFit()
			}
			Button{
				showingQR.toggle()
				operation = {
					
				}
			} label: {
				Image(systemName: "photo.circle")
					.resizable()
					.scaledToFit()
			}
			
		}
		.buttonBorderShape(.roundedRectangle(radius: 15))
		.buttonStyle(.bordered)
		.sheet(isPresented: $showingQR, onDismiss: operation) {
			QRSheetView()
		}
	}
}

#Preview {
	ToolbarView(model: BoardModel()).frame(height: 50)
}
