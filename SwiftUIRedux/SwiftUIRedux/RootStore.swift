import CZUtils

/// Convenience method to dispatch `action` to reducers of shared `ReduxRootStore`.
public func dispatch(action: ReduxActionProtocol) {
  ReduxRootStore.shared.dispatch(action: action)
}

/// Root store of Redux that is responsible to dispatch `ReduxAction` to Reducers.
///
/// - Note:
/// Root store only holds weak reference to reducers, no need to explicitly call `unsubscribe()` when deinit.
public class ReduxRootStore {
  
  public static let shared = ReduxRootStore()
  
  private var reducers = NSHashTable<AnyObject>.weakObjects()
  
  // MARK: - Dispatch
  
  /// Notifies all reducers with `action`. Note that reducers can filter action and choose how to
  /// `reduce(action:)`.
  ///
  /// - Parameter action: The action to be dispatched to reducers.
  public func dispatch(action: ReduxActionProtocol) {
    reducers.allObjects
      .compactMap { ($0 as? ReduxReducerProtocol).assertIfNil }
      .forEach { reducer in
        if Thread.isMainThread {
          reducer.reduce(action: action)
        } else {
          DispatchQueue.main.async {
            reducer.reduce(action: action)
          }
        }
    }
  }
  
  // MARK: - Subscribe
    
  /// Subscribes `reducer` to root store, root store will dispatch `ReduxAction` to `reducer`.
  ///
  /// - Parameter reducer: The reducer to be subscribed to root store.
  public func subscribe(_ reducer: ReduxReducerProtocol) {
    guard !contains(reducer) else { return }
    reducers.add(reducer)
  }
  
  /// Unsubscribes `reducer` to root store, root store will stop dispatching `ReduxAction` to `reducer`.
  ///
  /// - Parameter reducer: The reducer to be unsubscribed from root store.
  public func unsubscribe(_ reducer: ReduxReducerProtocol) {
    reducers.remove(reducer)
  }
  
  /// Returns whether root store contains the specified `reducer`.
  ///
  /// - Parameter reducer: The reducer to be checked.
  /// - Returns: Whether root store contains the specified `reducer`.
  private func contains(_ reducer: ReduxReducerProtocol) -> Bool {
    return reducers.contains(reducer)
  }
}
