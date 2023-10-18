//
//  ContextMenuButton.swift
//  CapableU
//
//  Created by Lachlan Corrie on 16/10/2023.
//

import SwiftUI

struct ContextMenuButton<OwnableObject: Ownable>: View {
	@State private var triggered = false
	
	var model: BoardModel
	
	@Binding var ownableObject: OwnableObject
	
	var deleteAction: () -> Void
	
    var body: some View {
		Menu{
			Button(role: .destructive, action: deleteAction) {
				Label("Delete", systemImage: "trash")
			}
			
			Button{
				model.notes.append(Note(content: "",
										x: 300,
										y: 300))
			} label: {
				Label("Add comment", systemImage: "text.bubble")
			}
			
			Menu() {
				ForEach (model.profiles) { profile in
					Button(profile.name,
						   image: ImageResource(name: profile.profilePhotoString, bundle: .main)) {
						ownableObject.owner = profile
					}
				}
			} label: {
				Label("Set Author", systemImage: "person.badge.plus")
			}
			
		} label: {
			Image(systemName: "ellipsis.circle")
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 30, height: 30)
				.offset(x:4, y:3)
		}
    }
}
