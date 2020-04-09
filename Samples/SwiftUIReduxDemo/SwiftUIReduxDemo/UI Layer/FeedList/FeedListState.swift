import SwiftUI
import SwiftUIRedux
import CZUtils

class ThunkMiddleware: Subscriber {
  
  public override func reduce(action: ReduxActionProtocol) {
    switch action {
    case let command as FetchFeedsCommand:
      Services.shared.fetchFeeds(endPoint: command.endPoint) { feeds in
        // Dispatch `FetchFeedsResultAction` on completion of fetchFeeds.
        dispatch(action: FetchFeedsResultAction(feeds: feeds, error: nil))
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
    
    switch action {
    case let fetchFeedsResultAction as FetchFeedsResultAction:
      // Action with fetch feeds results.
      guard let feeds = fetchFeedsResultAction.feeds else {
        assertionFailure("Failed to fetch feeds. Error - \(fetchFeedsResultAction.error).")
        return
      }
      self.feeds = feeds
      break
    default:
      // No need of deep copy, SwiftUI decides wether to reload by List diff.
      feeds = feeds.map { $0.reduce(action: action) }
    }
    
    

  }
  
}
