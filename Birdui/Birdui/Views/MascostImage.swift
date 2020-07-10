//
//  MascostImage.swift
//  Birdui
//
//  Created by Shruti Sharma on 7/10/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

//This is the view for Mascot Image

struct MascotImage: View {
  
  let IMAGE_WIDTH: CGFloat = 50
  let MASCOT_IMAGE = "mascot_swift-badge"

  // Content Body
    var body: some View {
      
        Image(MASCOT_IMAGE)
          .resizable()
          .frame(width: IMAGE_WIDTH, height: IMAGE_WIDTH, alignment: .leading)
    }

}

//MARK: - Preview

struct MascotImage_Previews: PreviewProvider {
    static var previews: some View {
        MascotImage()
    }
}
