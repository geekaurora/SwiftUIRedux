import Foundation

class Services {
  static let shared = Services()
  
  func fetchFeeds(completion: ([Feed]) -> Void) {
    let feeds = Feed.mocks    
    completion(feeds)
  }
  
}
