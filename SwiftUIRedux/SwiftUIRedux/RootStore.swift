import CZUtils
import SwiftUIKit

/// Convenience method to dispatch `action` to subscribers of `RootStore.shared`.
public func dispatch(action: ReduxActionProtocol) {
  RootStore.shared.dispatch(action: action)
}

/// Root dispatcher of the app, responsible to notify SubDispatchers - tabs.
///
/// - Note:
/// Dispatcher only holds weak reference to subscribers, no need to explicitly call `unsubscribe()` when deinit.
public class RootStore {

  public static var shared = RootStore()

  private var subscribers = NSHashTable<AnyObject>.weakObjects()

  // MARK: - Dispatch
  
  public func dispatch(action: ReduxActionProtocol = ReduxReloadAction()) {
    // Notify all subscribers. Note that subscribers can filter action and choose whether to respond.
    subscribers.allObjects
      .compactMap { ($0 as? Subscriber).assertIfNil }
      .forEach { $0.reduce(action: action) }
  }
  
  // MARK: - Subscribe
  
  public func subscribe(_ subscriber: Subscriber) {
    guard !contains(subscriber) else { return }
    subscribers.add(subscriber)
  }

  public func unsubscribe(_ subscriber: Subscriber) {
    subscribers.remove(subscriber)
  }

  public func contains(_ subscriber: Subscriber) -> Bool {
    return subscribers.contains(subscriber)
  }
  
  // MARK: - Substate
  
  /// Retrieves the first matched substate with `StateType`from `subscribers` if presents, returns nil otherwise.
  ///
  /// - Note: shouldn't be used if there're multiple subscribers with the same type.
  ///
  /// e.g. let feedListState: FeedListState? = RootStore.shared.retrieveSubstate()
  public func retrieveSubstate<T>() -> T? {
    return subscribers.allObjects
      .compactMap { $0 as? T }
      .first
  }
  
}
