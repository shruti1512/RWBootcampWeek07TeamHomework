//
//  FloatingAddButton.swift
//  Birdui
//
//  Created by Shruti Sharma on 7/10/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

//This view is for floating add button on the home screen to add new post

struct FloatingAddButton: View {
  
  //MARK: - Properties
  
  let action: () -> Void
  let ADD_IMAGE = "icons8-add"
  let IMAGE_WIDTH: CGFloat = 100
  
  //MARK: - Initializer with parameter for button action

  init(action: @escaping () -> Void) {
    self.action = action
  }
  
  //MARK: - Content Body

  var body: some View {
    
    //Button with image content
      Button(action: action) {
        Image(ADD_IMAGE).renderingMode(.original)
      }
        .frame(width: IMAGE_WIDTH, height: IMAGE_WIDTH)
  }
}

//MARK: - Preview

struct FloatingAddButton_Previews: PreviewProvider {
  
    static var previews: some View {
      FloatingAddButton(action: {
        print("Floating button pressed")
      })
    }
}
