//
//  CapableUModel.swift
//  CapableU
//
//  Created by Lachlan Corrie on 27/9/2023.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

@Observable class BoardModel {
	var notes: [Note] = []
	var recipes: [Recipe] = []
	var profiles: [Profile] = [
		Profile(name: "Jane Doe", initials: "JD", profilePhotoString: "jane-doe"),
		Profile(name: "John Smith", initials: "JS", profilePhotoString: "john-smith")]
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
	var id = UUID()
	
	var title : String
	var coverPhotoString : String
	var description: String
}

struct Profile : Identifiable, Hashable, Codable, Transferable {
	static var transferRepresentation: some TransferRepresentation {
		CodableRepresentation(for: Profile.self, contentType: .profile)
	}
	
	var id = UUID()
	
	var name: String
	var initials: String
	var profilePhotoString: String
}

extension UTType {
	static var profile: UTType { UTType(exportedAs: "com.capableu.profile") }
}


