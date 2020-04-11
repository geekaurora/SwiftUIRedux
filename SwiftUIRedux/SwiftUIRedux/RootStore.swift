import CZUtils
import SwiftUIKit

/// Convenience method to dispatch `action` to subscribers of shared `ReduxRootStore`.
public func dispatch(action: ReduxActionProtocol) {
  ReduxRootStore.shared.dispatch(action: action)
}

/// Root store of Redux that is responsible to notify subscribers.
///
/// - Note:
/// Dispatcher only holds weak reference to subscribers, no need to explicitly call `unsubscribe()` when deinit.
public class ReduxRootStore {
  
  public static let shared = ReduxRootStore()
  
  private var subscribers = NSHashTable<AnyObject>.weakObjects()
  
  // MARK: - Dispatch
  
  public func dispatch(action: ReduxActionProtocol) {
    // Notify all subscribers with `action`. Note that subscribers can
    // filter action and choose how to `reduce(action:)`.
    subscribers.allObjects
      .compactMap { ($0 as? ReduxSubscriberProtocol).assertIfNil }
      .forEach { subscriber in
        if Thread.isMainThread {
          subscriber.reduce(action: action)
        } else {
          DispatchQueue.main.async {
            subscriber.reduce(action: action)
          }
        }
    }
  }
  
  // MARK: - Subscribe
  
  public func subscribe(_ subscriber: ReduxSubscriberProtocol) {
    guard !contains(subscriber) else { return }
    subscribers.add(subscriber)
  }
  
  public func unsubscribe(_ subscriber: ReduxSubscriberProtocol) {
    subscribers.remove(subscriber)
  }
  
  public func contains(_ subscriber: ReduxSubscriberProtocol) -> Bool {
    return subscribers.contains(subscriber)
  }
}
