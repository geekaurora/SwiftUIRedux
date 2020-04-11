import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

class FeedDetailsState: ReduxSubscriber, ObservableObject {
  @Published var feed: Feed
  
  override init() { fatalError("init() has not been implemented") }

  init(feed: Feed) {
    self.feed = feed
  }
  
  public override func reduce(action: ReduxActionProtocol) {
    self.feed = feed.reduce(action: action)
  }
}
