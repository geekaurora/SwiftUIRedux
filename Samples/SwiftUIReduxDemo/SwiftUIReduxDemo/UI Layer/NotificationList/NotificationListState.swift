import SwiftUI
import SwiftUIRedux
import CZUtils

class NotificationListState: Subscriber, ObservableObject {
  
  @Published var notifications: [Notification] = Notification.mocks
  
  public override func reduce(action: ReduxActionProtocol) {
    switch action {
    case let action as FeedLikeAction:
      // Update corresponding feed `isLiked`, and then reload UI by set `self.feeds`.
      self.notifications = notifications.map { notification in
        if notification.feed.feedId == action.feed.feedId {
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
