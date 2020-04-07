import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct NotificationDetailsView: View {
  @ObservedObject var state: NotificationDetailsState
  
  init(notification: Notification) {
    self.state = NotificationDetailsState(notification: notification)
  }
  
  var body: some View {
    HStack {
      Text(state.notification.title)
        .modifier(ContentTextStyle())
      
      Spacer()      
      Button(action: {
        dispatch(action: FeedLikeAction(feed: self.state.notification.feed))
      }) {
        Text(state.notification.feed.isLiked ? "UnLike" : "Like")
      }.modifier(NormalButtonStyle())
    }
  }
}
