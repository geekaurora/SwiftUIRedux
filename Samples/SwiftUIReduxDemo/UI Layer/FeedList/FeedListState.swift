import SwiftUI
import SwiftUIRedux
import CZUtils

public class FeedListState: ReduxReducer, ObservableObject {
  static let feedEndpoint = "localmock.feeds"
  
  @Published var feeds: [Feed] = []
    
  public required init() {
    super.init()
    // Fetch feeds - dispatch Redux-Thunk async action `fetchFeedsAsyncAction`.
    let fetchFeedsAsyncAction = ReduxAsyncBlockAction(type: "FetchFeedsAsyncAction") {
      // Fetch feeds from end point.
      Services.shared.fetchFeeds(endPoint: Self.feedEndpoint) { feeds in
        // On fetch completion, dispatch action `FetchFeedsResultAction` to reducers to produce new States.
        dispatch(action: FetchFeedsResultAction(feeds: feeds, error: nil))
      }
    }
    dispatch(action: fetchFeedsAsyncAction)
  }
  
  // MARK: - ReduxReducerProtocol
  
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
      // Propagates `action` to substate tree.
      // Setting `self.feeds` with new feeds triggers list UI reloading
      // and SwiftUI will diff efficiently based on list identifier.
      feeds = feeds.map { $0.reduce(action: action) }
    }
  }
}
