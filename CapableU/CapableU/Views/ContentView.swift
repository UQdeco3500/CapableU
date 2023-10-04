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
		ZStack {
			BoardView(board: board)
			
			VStack {
				HStack{
					ToolbarView(model: board)
						.frame(height: 75)
						.padding()
					Spacer()
				}
				Spacer()
				HStack{
					ProfileBarView(profiles: board.profiles)
						.padding()
				}
			}
		}
	}
}

#Preview {
    ContentView()
}
