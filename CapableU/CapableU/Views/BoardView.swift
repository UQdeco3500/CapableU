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
		ZStack{
			ForEach(board.recipes, id: \.self) {
				RecipeCardView(location: CGPoint(x: $0.x, y: $0.y),
							   recipe: $0,
							   model: board)
					.frame(maxWidth: 200)
			}
			ForEach(board.photos, id: \.self) {
				PhotoCardView(location: CGPoint(x: $0.x, y: $0.y),
							  photo: $0,
						      model: board)
				.frame(maxWidth: 200)
			}
			ForEach(board.notes, id: \.self) {
				NoteCardView(location: CGPoint(x: $0.x, y: $0.y),note: $0, board: board)
			}
			ForEach(board.stickers, id: \.self) {
				let location = CGPoint(x: $0.x, y: $0.y)
				ProfileStickerView(location: location, profile: $0.profile)
			}
		}
	}
}

#Preview {
    BoardView(board: BoardModel())
}
