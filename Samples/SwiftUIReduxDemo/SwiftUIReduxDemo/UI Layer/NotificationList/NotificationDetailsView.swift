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
    print(state.notification.feed)
    
    return VStack(alignment: .leading) {
      Text("\(state.notification.title)")
        .modifier(HeadlineTextStyle())
      
      HStack {
        Text(state.notification.feed.title)
        Spacer()
        Button(action: {
          print("tapped like.")
          dispatchLikeFeedAction(feed: self.state.notification.feed)
        }) {
          Text(state.notification.feed.isLiked ? "UnLike" : "Like")
        }
        .modifier(NormalButtonStyle())
      }
    }
    
  }
}
