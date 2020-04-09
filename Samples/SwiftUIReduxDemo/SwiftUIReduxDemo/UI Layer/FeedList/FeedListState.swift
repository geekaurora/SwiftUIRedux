import SwiftUI
import SwiftUIRedux
import CZUtils

public class FeedListState: ReduxSubscriber, ObservableObject {
  static let feedEndpoint = "http://instagram.com/feeds"
  
  @Published var feeds: [Feed] = []
    
  public override init() {
    super.init()    
    Services.shared.fetchFeeds(endPoint: Self.feedEndpoint) { feeds in
      dispatch(action: FetchFeedsResultAction(feeds: feeds, error: nil))
    }
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
    default:
      // No need of deep copy, SwiftUI decides wether to reload by List diff.
      feeds = feeds.map { $0.reduce(action: action) }
    }

  }
  
}
