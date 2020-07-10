//
//  AppDelegate.swift
//  Birdui
//
//  Created by Audrey Tam on 3/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

enum Reaction: String, Hashable, Identifiable, CaseIterable {
  case love = "😍"
  case funnny = "😂"
  case unsure = "😢"
  case shock = "😱"
  case exlpodingHead = "🤯"
  case starryEyes = "🤩"
  
  var id: Reaction {self}
}

struct MediaPost: Identifiable {

  let id = UUID()
  let textBody: String?
  let userName: String
  let timestamp: Date
  let uiImage: UIImage?
  var reaction: Reaction?

}
