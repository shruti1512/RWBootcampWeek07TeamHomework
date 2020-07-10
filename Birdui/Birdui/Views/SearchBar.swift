//
//  SearchBar.swift
//  Birdui
//
//  Created by Shruti Sharma on 7/10/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

//This view is a reusable custom component Search Bar to implement search functionality

struct SearchBar: View {
  
  //MARK: - Property Bindings
  
  @Binding var text: String
  @State private var isEditing = false
  
  //MARK: - Default Values

  let SEARCH_ICON = "magnifyingglass"
  let SEARCH_DELETE_ICON = "multiply.circle.fill"
  let SEARCH_TEXT = "Search"
  let CANCEL_TEXT = "Cancel"

  //MARK: - Content Body

  var body: some View {
    
    HStack {
      
      //Search TextField
      
      TextField(SEARCH_TEXT, text: $text)
        .padding(7)
        .padding(.horizontal, 25)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        
        //Search Icon Magnifying Glass inside Search TextField
        
        .overlay(
          HStack {
            Image(systemName: SEARCH_ICON)
              .foregroundColor(.gray)
              .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
              .padding(.leading, 8)
            
            //Delete image inside Search TextField to delete the all text at once
            
            if isEditing {
              Button(action: {
                self.text = ""
              }) {
                Image(systemName: SEARCH_DELETE_ICON)
                  .foregroundColor(.gray)
                  .padding(.trailing, 8)
              }
            }
          }
      )
        .padding(.horizontal, 10)
        .onTapGesture {
          self.isEditing = true
      }
      
      //Show Cancel Search Button when isEditing is true
      
      if isEditing {
        Button(action: {
          self.isEditing = false
          self.text = ""
          // Dismiss the keyboard
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
          
        }) {
          Text(CANCEL_TEXT)
        }
        .padding(.trailing, 10)
        .transition(.move(edge: .trailing))
        .animation(.default)
      }
    }
  }
}

//MARK: - Preview

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    SearchBar(text: .constant(""))
  }
}
