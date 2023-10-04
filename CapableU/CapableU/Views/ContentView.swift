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
		ToolbarView(model: board)
			.frame(height: 75)
			.padding()
		Spacer()
		
		BoardView(board: board)
	}
}

#Preview {
    ContentView()
}
