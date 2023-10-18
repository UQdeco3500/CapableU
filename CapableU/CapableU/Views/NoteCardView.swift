//
//  NoteCardView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 27/9/2023.
//

import SwiftUI
import Combine

struct NoteCardView: View {
	@State var location: CGPoint = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
	@GestureState private var fingerLocation: CGPoint? = nil
	@GestureState private var startLocation: CGPoint? = nil
	@State private var keyboardHeight: CGFloat = 0
	
	@State var note: Note
	var board: BoardModel
	
	var simpleDrag: some Gesture {
		DragGesture()
			.onChanged { value in
				var newLocation = startLocation ?? location
				newLocation.x += value.translation.width
				newLocation.y += value.translation.height
				self.location = newLocation
			}.updating($startLocation) { (value, startLocation, transaction) in
				startLocation = startLocation ?? location
			}
	}
	
	var body: some View {
		ZStack(alignment: .bottomLeading){
			TextField("Looks delicious!", text: $note.content, axis: .vertical)
				.multilineTextAlignment(.leading)
				.lineLimit(7, reservesSpace: false)
				.padding()
				.background(
					RoundedRectangle(cornerRadius: 10)
						.foregroundColor(note.color))
			if let owner = note.owner {
				Image(owner.profilePhotoString)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: 50, height: 50)
					.cornerRadius(15)
					.offset(x: -30, y: 30)
			}
			HStack{
				Spacer()
				ContextMenuButton(model: board) {
					board.notes.remove(at: board.notes.firstIndex(of: note)!)
				}
				.buttonStyle(.plain)
				.foregroundColor(.white)
				
			}.padding()
		}
		.shadow(radius: 5)
		.position(x: location.x, y:keyboardHeight == 0 ? location.y : keyboardHeight / 2)
		.gesture(simpleDrag)
		.onReceive(Publishers.keyboardHeight) {
			self.keyboardHeight = $0
		}
		.dropDestination(for: Profile.self) { items, location in
			note.owner = items.first!
			note.color = board.favouriteColors[board.profiles.firstIndex(of: items.first!)!]
			return true
		}
		.frame(width: 200)
	}
}

extension Publishers {
	// 1.
	static var keyboardHeight: AnyPublisher<CGFloat, Never> {
		// 2.
		let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
			.map { $0.keyboardHeight }
		
		let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
			.map { _ in CGFloat(0) }
		
		// 3.
		return MergeMany(willShow, willHide)
			.eraseToAnyPublisher()
	}
}

extension Notification {
	var keyboardHeight: CGFloat {
		return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
	}
}

#Preview {
	NoteCardView(note: Note(owner: Profile(name: "Jane Doe",
										   initials: "JD",
										   profilePhotoString: "jane-doe",
										   alergens: [.seafood]),
							content: "Test",
							color: .blue,
							x: 0, y:0), board: BoardModel())
}
