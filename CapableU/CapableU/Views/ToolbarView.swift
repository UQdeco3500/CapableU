//
//  ToolbarView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 21/9/2023.
//

import SwiftUI

struct ToolbarView: View {
	
    var body: some View {
		HStack {
			ZStack {
				Circle()
				Image(systemName: "plus.circle")
					.resizable()
					.scaledToFit()
					.padding()
					.foregroundColor(.white)
				
			}
		}
	}
}

#Preview {
    ToolbarView()
}
