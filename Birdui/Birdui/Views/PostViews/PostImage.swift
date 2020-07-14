//
//  PostImage.swift
//  Birdui
//
//  Created by Shruti Sharma on 7/10/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

//This is the view for media post image

struct PostImage: View {
  
  //MARK: - Property
  
  let uiImage: UIImage
  let IMAGE_WIDTH: CGFloat = 200
  
  //MARK: - Initializer

  init(uiImage: UIImage) {
    self.uiImage = uiImage
  }
  
  //MARK: - Content Body

  var body: some View {
    
    Image(uiImage: uiImage)
    .resizable()
    .cornerRadius(5)
    .frame(width: IMAGE_WIDTH, height: IMAGE_WIDTH, alignment: .center)
  }
  
}

struct PostImage_Previews: PreviewProvider {
    static var previews: some View {
      PostImage(uiImage: UIImage(named: "octopus")!)
    }
}
