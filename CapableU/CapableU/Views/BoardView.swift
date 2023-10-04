//
//  CardView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 21/9/2023.
//

import SwiftUI

struct BoardView: View {
	
	var board: BoardModel
	
	var body: some View {
		ForEach(board.notes, id: \.self) {
			NoteCardView(textContent: $0.content)
		}
		ForEach(board.recipes, id: \.self) {
			RecipeCardView(recipe: $0)
		}
	}
}

#Preview {
    BoardView(board: BoardModel())
}
