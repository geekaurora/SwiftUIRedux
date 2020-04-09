import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct FeedDetailsView: View {
  @ObservedObject var state: FeedDetailsState
  
  init(feed: Feed) {
    self.state = FeedDetailsState(feed: feed)
  }
  
  var body: some View {
    print(state.feed)    
    return FeedCell(feed: state.feed)
  }
}
