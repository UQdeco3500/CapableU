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
	
	@State private var expanded = false
	
    var body: some View {
		ZStack {
			Button{
				showingQR.toggle()
				operation = {
					var newRecipe = model.possibleRecipes.remove(at: 0)
					newRecipe.x = UIScreen.current!.bounds.midX - 300
					newRecipe.y = UIScreen.current!.bounds.midY
					model.recipes.append(newRecipe)
				}
			} label: {
				VStack {
					Image(systemName: "fork.knife")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 17, height: 17)
						.padding(3)
						
					Text("Recipe")
						.font(.caption)
						.fixedSize()
				}
				.padding(9)
				.frame(width: 30, height: 30)
			}
			.offset(x: expanded ? 80 : 0)
			
			Button{
				model.notes.append(Note(content: "", x: UIScreen.current!.bounds.midX, y: UIScreen.current!.bounds.midY))
			} label: {
				VStack(spacing: 0) {
					Image(systemName: "note.text.badge.plus")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 25, height: 25)
						.offset(x:3)
					
					Text("Note")
						.font(.caption)
						.fixedSize()
				}
				.padding(9)
				.frame(width: 30, height: 30)
			}
			.offset(x: expanded ? 80 : 0, y: expanded ? 80 : 0)
			
			Button{
				showingQR.toggle()
				operation = {
					var newPhoto = model.possiblePhotos.remove(at: 0)
					newPhoto.x = UIScreen.current!.bounds.midX
					newPhoto.y = UIScreen.current!.bounds.midY
					model.photos.append(newPhoto)
				}
			} label: {
				VStack {
					Image(systemName: "photo")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 25, height: 25)
					
					Text("Photo")
						.font(.caption)
						.fixedSize()
				}
				.padding(9)
				.frame(width: 30, height: 30)
			}
			.offset(y: expanded ? 80 : 0)
			
			Button{
				withAnimation{
					expanded.toggle()
				}
			} label: {
				Image(systemName: "plus")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 40, height: 40)
			}
			.rotationEffect(expanded ? .degrees(45) : .zero)
			
		}
		.buttonBorderShape(.circle)
		.buttonStyle(ToolbarButtonStyle())
		.sheet(isPresented: $showingQR, onDismiss: operation) {
			QRSheetView()
		}
	}
}

struct ToolbarButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.background(Color(white: 0.9), in: Capsule())
			.foregroundColor(configuration.isPressed ? .blue.opacity(0.5) : .blue)
	}
}

#Preview {
	ToolbarView(model: BoardModel()).frame(height: 75)
}
