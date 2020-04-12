import SwiftUI
import SwiftUIRedux
import CZUtils

class NotificationListState: ReduxReducer, ObservableObject {
  
  @Published var notifications: [Notification] = Notification.mocks
  
  // MARK: - ReduxReducerProtocol
  
  public override func reduce(action: ReduxActionProtocol) {
    notifications = notifications.map { $0.reduce(action: action) }
  }
}
