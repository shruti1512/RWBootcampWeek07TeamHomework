//
//  PostListView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

//This view is the home screen of the app wherein the user can see the mediaposts and also saerch, filter and edit them

struct PostListView: View {
  
  //MARK: - Observed Properties

  @ObservedObject var input = UserInput()
  @ObservedObject var postViewModel = PostViewModel()
  
  //MARK: - State Properties
  
  @State private var searchText = ""
  @State private var isModalPresented = false
  @State private var isSortActionSheetPresented = false
  @State private var isFilterActionSheetPresented = false
  
  //MARK: - Default values
  
    let CREATE_NEW_POST = "Create New Post"

  //MARK: - Get Media Posts Based on Search, Sort and Filtering Options

  private var posts: [MediaPost] {
    
    if searchText.isEmpty && !isFilterActionSheetPresented && !isSortActionSheetPresented {
      return postViewModel.getPostsBy(filterType: self.input.filterCase, sortType: self.input.sortCase)
    }
    else if !searchText.isEmpty {
      return postViewModel.searchMediaPostsBy(searchText)
    }
    else if isFilterActionSheetPresented {
      return postViewModel.filterPostsBy(self.input.filterCase)
    }
    else if isSortActionSheetPresented {
      return postViewModel.sortPostsBy(self.input.sortCase)
    }
    return [MediaPost]()
  }
  
  //MARK: - Content Body of the View

  var body: some View {
    
    NavigationView {
      
      ZStack(alignment: .bottomTrailing) {
        
        VStack {
          
          // Spacer between search bar and navigation bar
          
          Spacer()
          
          // Search Bar
          
          SearchBar(text: $searchText)
            .padding(.bottom)
          
          // Create New Post Button
          
          HStack {
            
            Button(CREATE_NEW_POST) {
              self.isModalPresented = true
            }
            Spacer()
          }
          .padding(.leading)
          
          // List View to show posts
          
          List {
            ForEach(posts, id: \.id) { post in
              PostView(post: post)
            }
            .onDelete { indexSet in
              self.postViewModel.posts.remove(atOffsets: indexSet)
            }
          }
          
        }
        
        // Add(+) button in the bottom right corner
        
        FloatingAddButton(action: {
          self.isModalPresented = true
        })
      }
        

        // Navigation Bar Items
        
        .navigationBarTitle("Birdie", displayMode: .inline)
        .navigationBarItems(
          leading: EditButton(),
          trailing:
          
          // Sort Bar Button
          
          HStack {
            BarButtonItem(buttonType: .sort, input: self.input) {
              print("Sort button tapped")
              self.isSortActionSheetPresented = true
            }
            
            Spacer()
            
            // Filter Bar Button
            
            BarButtonItem(buttonType: .filter, input: self.input) {
              print("Filter button tapped")
              self.isFilterActionSheetPresented = true
            }
          }
      )
        // Present New Post View in a Modal Sheet
        
        .sheet(isPresented: $isModalPresented) {
          NewPostView(postHandler: self.postViewModel)
      }
    }
  }
  
}

struct PostListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView()
  }
}
