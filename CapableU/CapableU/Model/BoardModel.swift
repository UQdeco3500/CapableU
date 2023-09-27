//
//  CapableUModel.swift
//  CapableU
//
//  Created by Lachlan Corrie on 27/9/2023.
//

import Foundation

@Observable class BoardModel {
	var notes: [Note] = []
}

struct Note : Identifiable, Hashable {
	var id: UUID
	
	var content : String
	
	init(_ content: String) {
		id = UUID()
		self.content = content
	}
}


