//
//  Routes.swift
//  Everest_iOS
//
//  Created by Sathoshi Kumarawadu on 2016-11-24.
//  Copyright © 2016 Everest. All rights reserved.
//

import Foundation

struct Routes {
  struct Api {
    static let CreateNewUser: String = "/createNewUser"
    static let SetUpUserProfile: String = "/setUserProfileFields?id="
    static let CreateNewEvent: String = "/createEvent"
    static let SignInUser: String = "/signInUser"
    static let CreateNewChat: String = "/event/%@/createChat"
    static let FetchAllUsers: String = "/event/%@/fetchAllUsers"
  }
  struct Socket {
    struct NewsFeed {
      static let Subscribe: String = "newsfeed subscribe"
      static let AddPost: String = "add newsfeed post"
      static let NewPost: String = "new newsfeed posts"
    }
    struct Chat {
      static let Subscribe: String = "chat subscribe"
      static let AddMessage: String = "add chat message"
      static let NewMessage: String = "new chat message"
    }
  }
}
