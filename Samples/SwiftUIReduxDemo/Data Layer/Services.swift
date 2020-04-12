import Foundation

class Services {
  static let shared = Services()
  
  func fetchFeeds(endPoint: String,
                  params: [String: AnyObject] = [:],
                  completion: @escaping ([Feed]) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      let feeds = Feed.mocks
      completion(feeds)
    }
  }
}
