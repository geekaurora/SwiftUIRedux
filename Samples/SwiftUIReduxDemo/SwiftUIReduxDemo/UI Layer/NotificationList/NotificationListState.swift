import SwiftUI
import SwiftUIRedux
import CZUtils

class NotificationListState: Subscriber, ObservableObject {
  
  @Published var notifications: [Notification] = Notification.mocks
  
  public override func reduce(action: ReduxActionProtocol) {
    notifications = notifications.map { $0.reduce(action: action) }
  }
  
}
