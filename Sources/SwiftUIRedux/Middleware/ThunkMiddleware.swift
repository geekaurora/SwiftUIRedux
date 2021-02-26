import CZUtils

/// Middleware that executes Async Redux Action automatically.
/// To apply the middleware, call `ReduxRootStore.shared.applyMiddleware(ReduxThunkMiddleware)`when initializing app.
public func ReduxThunkMiddleware(_ nextDispatchFunction: @escaping DispatchFunction) -> DispatchFunction {
  return { action in
    if let action = action as? ReduxAsyncBlockAction {
      dbgPrint("[ReduxThunkMiddleware] Execute Async Action - \(action.type).")
      action.executionBlock()
      return
    }
    nextDispatchFunction(action)
  }
}
