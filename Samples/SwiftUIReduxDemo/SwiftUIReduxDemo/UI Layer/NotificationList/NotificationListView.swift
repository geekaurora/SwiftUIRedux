import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct NotificationCell: View {
  let notification: Notification
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("\(notification.title)")
      
      HStack {
        Text(notification.feed.title)
        Spacer()
        Button(action: {
          print("tapped like.")
          dispatch(action: FeedLikeAction(feed: self.notification.feed))
        }) {
          Text(notification.feed.isLiked ? "UnLike" : "Like")
        }
      }
    }
  }
}

struct NotificationListView: View {
  @ObservedObject
  var state = NotificationListState()
  
  var body: some View {
    return List {
      ForEach(state.notifications) { notification in
        NotificationCell(notification: notification)
      }
    }
  }
}

struct NotificationListView_Previews: PreviewProvider {
  static var previews: some View {
    NotificationListView()
  }
}
