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
      
      FeedCell(feed: notification.feed)
    }
  }
}

struct NotificationListView: View {
  @ObservedObject
  var state = NotificationListState()
  
  var body: some View {
    List {
      ForEach(state.notifications, id: \.diffId) { notification in
        NavigationLink(destination: NotificationDetailsView(notification: notification)) {
          NotificationCell(notification: notification)
        }
      }
    }
  }
}
