import CZUtils
import SwiftUIKit

/// Convenience method to dispatch `action` to subscribers of `RootStore.shared`.
public func dispatch(action: ReduxActionProtocol) {
  RootStore.shared.dispatch(action: action)
}

/// Root dispatcher of the app, responsible to notify SubDispatchers - tabs.
///
/// - Note:
/// Dispatcher only holds weak reference to subscribers, no need to explicitly call `removeSubscriber()` when deinit.
public class RootStore {

  public static var shared = RootStore()

  private var subscribers = NSHashTable<AnyObject>.weakObjects()

  public func dispatch(action: ReduxActionProtocol = ReduxReloadAction()) {
    // Notify all subscribers. Note that subscribers can filter action and choose whether to respond.
    subscribers.allObjects
      .compactMap { ($0 as? Subscriber).assertIfNil }
      .forEach { $0.reduce(action: action) }
  }

  public func addSubscriber(_ subscriber: Subscriber) {
    guard !containsSubscriber(subscriber) else { return }
    subscribers.add(subscriber)
  }

  public func removeSubscriber(_ subscriber: Subscriber) {
    subscribers.remove(subscriber)
  }

  public func containsSubscriber(_ subscriber: Subscriber) -> Bool {
    return subscribers.contains(subscriber)
  }

}
