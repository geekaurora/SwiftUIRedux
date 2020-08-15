import CZUtils

/// Middleware that logs all dispatched actions.
/// To apply the middleware, call `ReduxRootStore.shared.appendMiddleware(ActionLogMiddleware)`when initializing app.
public func ActionLogMiddleware(_ dispatchFunction: @escaping DispatchFunction) -> DispatchFunction {
  return { action in
    dbgPrint("[ActionLogMiddleware] Received Action = \(action).")
    dispatchFunction(action)
  }
}
