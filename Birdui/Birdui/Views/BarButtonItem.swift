//
//  BarButtonItem.swift
//  Birdui
//
//  Created by Shruti Sharma on 7/10/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

// Button Type Enum for sort and filter bar buttons

enum ButtonType: String {
  case sort = "Sort"
  case filter = "Filter"
}

// UserInput class to hold user selected sortCase and filetrCase
// Marked 'ObservableObject' so that any chnages to these properties are reflected in PostList View
// The list in PostListView refreshes accordingly based on the sort and filter options selected here

class UserInput: ObservableObject {
  @Published var sortCase = MediaPostsSortAttribute.dateNewestFirst
  @Published var filterCase = MediaPostsFilterAttribute.allPosts
}

//This view is for BarButtonItem (Sort and Filter) in the navigation bar on the home screen

struct BarButtonItem: View {
  
  //MARK: - State Properties
  
  @State var isActionSheetPresented = false
  
  //MARK: - Properties
  
  let action: () -> Void
  let buttonType: ButtonType
  let input: UserInput
  
  //MARK: - Initializer with button type, button input and button action
  
  init(buttonType: ButtonType, input: UserInput, action: @escaping () -> Void) {
    self.buttonType = buttonType
    self.input = input
    self.action = action
  }
  
  //MARK: - Content Body
  
  var body: some View {
    
    Button(action: {
      self.isActionSheetPresented = true
    }) {
      Text(self.buttonType.rawValue)
    }
    .actionSheet(isPresented: $isActionSheetPresented) {
      showActionSheetFor(self.buttonType)
    }
  }
  
  //MARK: - Method to show action sheet on button touch event
  
  private func showActionSheetFor(_ buttonType: ButtonType) -> ActionSheet {
    
    var actionButtons = [Alert.Button]()
    let cancelBtn = Alert.Button.cancel()
    
    switch buttonType {
      
      //Create alert action buttons for Filter Action Sheet
      
    case .filter:
      let filterCases = MediaPostsFilterAttribute.allCases
      filterCases.forEach { (filterCase) in
        let btn = Alert.Button.default(Text(filterCase.rawValue)) {
          self.input.filterCase = filterCase
        }
        actionButtons.append(btn)
      }
      
      //Create alert action buttons for Sort Action Sheet
      
    case .sort:
      let sortCases = MediaPostsSortAttribute.allCases
      sortCases.forEach { (sortCase) in
        let btn = Alert.Button.default(Text(sortCase.rawValue)) {
          self.input.sortCase = sortCase
        }
        actionButtons.append(btn)
      }
    }
    actionButtons.append(cancelBtn)
    
    return ActionSheet(title: Text(buttonType.rawValue), message: nil, buttons: actionButtons)
  }
  
}

//MARK: - Preview

struct BarButtonItem_Previews: PreviewProvider {
  
  static var previews: some View {
    
    BarButtonItem(buttonType: .sort, input: UserInput()) {
      print("Sort button tapped")
    }
  }
}
