import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct FeedListView: View {
  @ObservedObject
  var state = FeedListState()
  
  var body: some View {
    List {
      ForEach(state.feeds, id: \.diffId) { feed in
        NavigationLink(destination: FeedDetailsView(feed: feed)) {
          FeedCell(feed: feed)
        }
      }
    }
  }
}
