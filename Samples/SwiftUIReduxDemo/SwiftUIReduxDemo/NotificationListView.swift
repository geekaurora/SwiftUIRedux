import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct NotificationCell: View {
  let notification: Notification
  
  var body: some View {
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

class NotificationListState: NSObject, ObservableObject, SubscriberProtocol {
  @Published var notifications: [Notification] = Notification.mocks
  
  public override init() {
    super.init()
    // Subscribe to the root dispatcher.
    RootDispatcher.shared.addSubscriber(self)
  }
  
  public func reduce(action: DispatcherActionProtocol) {
    switch action {
    case let action as FeedLikeAction:
      // Update corresponding feed `isLiked`, and then reload UI by set `self.feeds`.
      self.notifications = notifications.map { notification in
        if notification.feed.Id == action.feed.Id {
          notification.id = UUID()
          notification.feed.isLiked = !notification.feed.isLiked
        }
        return notification
      }
    default:
      break
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
