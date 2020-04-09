import Foundation

class Services {
  static let shared = Services()
  
  func fetchFeeds(completion: @escaping ([Feed]) -> Void) {
    // Mock asynchronous callback of fetching feeds.
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      let feeds = Feed.mocks
      completion(feeds)
    }
  }
  
}
