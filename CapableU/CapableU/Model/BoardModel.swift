//
//  CapableUModel.swift
//  CapableU
//
//  Created by Lachlan Corrie on 27/9/2023.
//

import Foundation
import SwiftUI

@Observable class BoardModel {
	var notes: [Note] = []
	var recipes: [Recipe] = []
}

struct Note : Identifiable, Hashable {
	var id: UUID
	
	var content : String
	
	init(_ content: String) {
		id = UUID()
		self.content = content
	}
}

struct Recipe : Identifiable, Hashable {
	init(title: String, coverPhoto: String, description: String) {
		self.id = UUID()
		self.title = title
		self.coverPhotoString = coverPhoto
		self.description = description
	}
	
	var id: UUID
	var title : String
	var coverPhotoString : String
	var description: String
}


