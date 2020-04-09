import CZUtils
import SwiftUIKit

/// Convenience method to dispatch `action` to subscribers of `ReduxRootStore.shared`.
public func dispatch(action: ReduxActionProtocol) {
  ReduxRootStore.shared.dispatch(action: action)
}

/// Root store of the app that is responsible to notify subscribers.
///
/// - Note:
/// Dispatcher only holds weak reference to subscribers, no need to explicitly call `unsubscribe()` when deinit.
public class ReduxRootStore {

  public static var shared = ReduxRootStore()

  private var subscribers = NSHashTable<AnyObject>.weakObjects()

  // MARK: - Dispatch
  
  public func dispatch(action: ReduxActionProtocol = ReduxReloadAction()) {
    // Notify all subscribers. Note that subscribers can filter action and choose whether to respond.
    subscribers.allObjects
      .compactMap { ($0 as? ReduxSubscriber).assertIfNil }
      .forEach { $0.reduce(action: action) }
  }
  
  // MARK: - Subscribe
  
  public func subscribe(_ subscriber: ReduxSubscriber) {
    guard !contains(subscriber) else { return }
    subscribers.add(subscriber)
  }

  public func unsubscribe(_ subscriber: ReduxSubscriber) {
    subscribers.remove(subscriber)
  }

  public func contains(_ subscriber: ReduxSubscriber) -> Bool {
    return subscribers.contains(subscriber)
  }  
  
}
