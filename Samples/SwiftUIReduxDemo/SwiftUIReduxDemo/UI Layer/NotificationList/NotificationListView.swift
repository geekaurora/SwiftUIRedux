import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct NotificationCell: View {
  let notification: Notification
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("\(notification.title)")
        .modifier(HeadlineTextStyle())
      
      HStack {
        Text(notification.feed.title)
        Spacer()
        Button(action: {
          print("tapped like.")
          dispatch(action: FeedLikeAction(feed: self.notification.feed))
        }) {
          Text(notification.feed.isLiked ? "UnLike" : "Like")
        }
        .modifier(NormalButtonStyle())
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
        NavigationLink(destination: NotificationDetailsView(notification: notification)) {
          NotificationCell(notification: notification)
        }
      }
    }
  }
}

struct NotificationListView_Previews: PreviewProvider {
  static var previews: some View {
    NotificationListView()
  }
}
