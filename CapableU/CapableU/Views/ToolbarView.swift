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
	
	@State private var expanded = true
	
    var body: some View {
		ZStack {
			Button{
				showingQR.toggle()
				operation = {
					model.recipes.append(model.recipes.first!)
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
				model.notes.append(Note(content: "Heres another note.",
										x: UIScreen.main.bounds.midX,
										y: UIScreen.main.bounds.midY))
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
