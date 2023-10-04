//
//  QRSheetView.swift
//  CapableU
//
//  Created by Lachlan Corrie on 5/10/2023.
//

import SwiftUI

import CoreImage.CIFilterBuiltins

struct QRSheetView: View {
	
	let context = CIContext()
	let filter = CIFilter.qrCodeGenerator()
	
	let link = ""
	
    var body: some View {
		Image(uiImage: generateQRCode(from: "\(link)"))
			.interpolation(.none)
			.resizable()
			.scaledToFit()
			.frame(width: 200, height: 200)
    }
	
	func generateQRCode(from string: String) -> UIImage {
		filter.message = Data(string.utf8)
		
		if let outputImage = filter.outputImage {
			if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
				return UIImage(cgImage: cgimg)
			}
		}
		
		return UIImage(systemName: "xmark.circle") ?? UIImage()
	}

}

#Preview {
	QRSheetView()
}
