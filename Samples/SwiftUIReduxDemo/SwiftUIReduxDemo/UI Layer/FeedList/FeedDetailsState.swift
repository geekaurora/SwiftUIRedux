import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

class FeedDetailsState: Subscriber, ObservableObject {
  @Published var feed: Feed
  
  init(feed: Feed) {
    self.feed = feed
  }
  
  public override func reduce(action: ReduxActionProtocol) {
    feed = feed.codableCopy().reduce(action: action)
  }
}
