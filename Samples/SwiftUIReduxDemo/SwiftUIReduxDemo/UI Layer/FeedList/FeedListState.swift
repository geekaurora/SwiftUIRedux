import SwiftUI
import SwiftUIRedux
import CZUtils

class ThunkMiddleware: Subscriber {
  
  public override func reduce(action: ReduxActionProtocol) {
    switch action {
    case let command as FetchFeedsCommand:
      Services.shared.fetchFeeds(endPoint: command.endPoint) { feeds in
        //self.feeds = feeds
      }
      break
    default:
      break
    }
  }
}

public class FeedListState: Subscriber, ObservableObject {

  @Published var feeds: [Feed] = []
  
  static let feedEndpoint = "http://instagram.com/feeds"
  
  var thunkMiddleware = ThunkMiddleware()
  
  public override init() {
    super.init()    
    // Dispatch asynchronous Command - fetch feeds.
    dispatch(action: FetchFeedsCommand(endPoint: Self.feedEndpoint))
  }
  
  public override func reduce(action: ReduxActionProtocol) {
    // No need of deep copy, SwiftUI decides wether to reload by List diff.
    feeds = feeds.map { $0.reduce(action: action) }
  }
  
}
