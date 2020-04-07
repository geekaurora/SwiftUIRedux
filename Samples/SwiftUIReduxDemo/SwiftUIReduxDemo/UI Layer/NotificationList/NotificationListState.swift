import SwiftUI
import SwiftUIRedux
import CZUtils

class NotificationListState: Subscriber, ObservableObject {
  
  @Published var notifications: [Notification] = Notification.mocks
  
  @discardableResult
  public override func reduce(action: ReduxActionProtocol) -> Self {
    self.notifications = notifications.map { $0.reduce(action: action) }
    return self
  }
  
}
