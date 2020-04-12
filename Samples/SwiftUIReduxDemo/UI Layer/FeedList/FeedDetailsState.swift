import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

class FeedDetailsState: ReduxReducer, ObservableObject {
  @Published var feed: Feed
  
  override init() { fatalError("init() has not been implemented") }

  init(feed: Feed) {
    self.feed = feed
  }
  
  // MARK: - ReduxReducerProtocol
  
  public override func reduce(action: ReduxActionProtocol) {
    self.feed = feed.reduce(action: action)
  }
}
