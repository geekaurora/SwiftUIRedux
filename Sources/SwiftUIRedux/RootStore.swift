import Foundation
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
  
  /// Thead safe array that only holds weak reference to containing items.
  private(set) var reducers = ThreadSafeWeakArray<ReduxReducerProtocol>()
  
  /// Thead safe middlewares array.
  private(set) var middlewares = ThreadSafeArray<Middleware>()
  
  // MARK: - Dispatch
  
  /// Notifies all reducers with `action`. Note that reducers can filter action and choose how to
  /// `reduce(action:)`.
  ///
  /// - Parameter action: The action to be dispatched to reducers.
  public func dispatch(action: ReduxActionProtocol) {
    // Iterate through `middlewares` to retrieve the final `dispatchFunction`.
    let dispatchFunction = middlewares
      .allObjects
      .reduce(_dispatch, { prevDispatch, middleware in
        middleware(prevDispatch)
      })
    // Dispatch action.
    dispatchFunction(action)
  }
  
  private func _dispatch(action: ReduxActionProtocol) {
    reducers.allObjects
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
    guard !reducers.contains(reducer) else { return }
    reducers.append(reducer)
  }
  
  /// Unsubscribes `reducer` to root store, root store will stop dispatching `ReduxAction` to `reducer`.
  ///
  /// - Parameter reducer: The reducer to be unsubscribed from root store.
  public func unsubscribe(_ reducer: ReduxReducerProtocol) {
    reducers.remove(reducer)
  }
  
  // MARK: - Middlware
  
  /// Append `middleware` to middlewares that transform dispatch function.
  /// `middleware` is useful to decorate functionality of Dispatch function.
  /// e.g. middleware to log all dispatched actions etc.
  public func appendMiddleware(_ middleware: @escaping Middleware) {
    guard !middlewares.contains(middleware) else { return }
    middlewares.append(middleware)
  }
}
