//
//  ContentView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 20/9/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	
	var board = BoardModel()
	
	var body: some View {
		ZStack(alignment: .leading) {
			
			BoardView(board: board)
			VStack {
//				ToolbarView()
//					.frame(height: 100)
				Button {
					board.notes.append(Note("Heres another note."))
					print(board.notes)
				} label: {
					Image(systemName: "plus.circle")
						.resizable()
						.scaledToFit()
						.padding()
						.foregroundColor(.black)
						.frame(height: 100)
				}.buttonStyle(.borderedProminent)
				Spacer()
			}
			.padding()
				
		}
		
	}
}

#Preview {
    ContentView()
}
