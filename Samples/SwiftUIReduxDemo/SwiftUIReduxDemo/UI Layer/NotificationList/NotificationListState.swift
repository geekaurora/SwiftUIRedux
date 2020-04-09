import SwiftUI
import SwiftUIRedux
import CZUtils

class NotificationListState: ReduxSubscriber, ObservableObject {
  
  @Published var notifications: [Notification] = Notification.mocks
  
  public override func reduce(action: ReduxActionProtocol) {
    notifications = notifications.map { $0.reduce(action: action) }
  }
  
}
