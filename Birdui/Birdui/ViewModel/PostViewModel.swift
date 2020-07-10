//
//  PostViewModel.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

//MARK: - Global Enums

enum MediaPostsSortAttribute: String, CaseIterable {
  case dateOldestFirst = "Date (Oldest First)"
  case dateNewestFirst = "Date (Newest First)"
}

enum MediaPostsFilterAttribute: String, CaseIterable {
  case allPosts = "All Posts"
  case textPosts = "Text Posts"
  case imagePosts = "Image Posts"
}

class PostViewModel: ObservableObject {
  
  //MARK: - Properties

  @Published var posts: [MediaPost] = []
  
  //MARK: - Initializer

  init() {
    
    let imagePost1 = MediaPost(textBody: "I love debugging software!",
                               userName: "Jay", timestamp: Date(timeIntervalSinceNow: -123456),
                               uiImage: UIImage(named: "chop")!,
                               reaction: Reaction.allCases.randomElement()!)
    
    let imagePost2 = MediaPost(textBody: "Went to the Aquarium today :]",
                               userName: "Audrey",
                               timestamp: Date(timeIntervalSinceNow: -9876),
                               uiImage: UIImage(named:  "octopus")!,
                               reaction: Reaction.allCases.randomElement()!)

    
    let textPost1 = MediaPost(textBody: "Hello World!",
                             userName: "Bhagat",
                             timestamp: Date(timeIntervalSinceNow: -67890),
                             uiImage: nil,
                             reaction: Reaction.allCases.randomElement()!)

    
    let textPost2 = MediaPost(textBody: "This is my favorite social media app! This is my favorite social media app! This is my favorite social media app!",
                             userName: "Jeff",
                             timestamp: Date(timeIntervalSinceNow: -2345),
                             uiImage: nil,
                             reaction: Reaction.allCases.randomElement()!)

    
    posts = [imagePost1, imagePost2, textPost1, textPost2].sorted(by: { $0.timestamp > $1.timestamp })
  }
  
  //MARK: - Add Post

  func addPost(post: MediaPost) {
      posts.append(post)
      posts = posts.sorted(by: { $0.timestamp > $1.timestamp })
  }
  
    //MARK: - Delete Post
  
    func deletePost(atOffsets offsets: IndexSet) {
        posts.remove(atOffsets: offsets)
    }
  
  //MARK: - Sort Posts

  func sortPostsBy(_ sortType: MediaPostsSortAttribute) -> [MediaPost] {
      if sortType == .dateNewestFirst {
        return posts.sorted { $0.timestamp > $1.timestamp }
      }
      else {
        return posts.sorted {$0.timestamp < $1.timestamp }
      }
    }
    
  //MARK: - Filter Posts

  func filterPostsBy(_ filterType: MediaPostsFilterAttribute) -> [MediaPost] {
    
    switch filterType {
      case .allPosts:
        return self.posts
      case .imagePosts:
        return posts.filter { ($0.uiImage) != nil }
      case .textPosts:
        return posts.filter { ($0.uiImage) == nil }
    }
  }

  //MARK: - Search Posts

  func searchMediaPostsBy(_ searchTerm: String) -> [MediaPost] {
    
    let filteredPosts = posts.filter { post in
      var postBodySearchResult = false
      if let textBody = post.textBody {
        postBodySearchResult = textBody.localizedCaseInsensitiveContains(searchTerm)
      }
      let postTitleSearchResult = post.userName.contains(searchTerm)
      return postTitleSearchResult || postBodySearchResult
    }
    return filteredPosts
  }
  
  //MARK: - Get Posts By Sort Case and Filter Case

  func getPostsBy(filterType: MediaPostsFilterAttribute, sortType: MediaPostsSortAttribute) -> [MediaPost] {
    
    let mediaPosts = filterPostsBy(filterType)
    if sortType == .dateNewestFirst {
      return mediaPosts.sorted { $0.timestamp > $1.timestamp }
    }
    else {
      return mediaPosts.sorted {$0.timestamp < $1.timestamp }
    }
  }


}
