import SwiftUI
import SwiftUIRedux
import CZUtils

class NotificationListState: Subscriber, ObservableObject {
  @Published var notifications: [Notification] = Notification.mocks
  
  public override func reduce(action: DispatcherActionProtocol) {
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
