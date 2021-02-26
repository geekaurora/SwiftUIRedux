import CZUtils

/// Middleware that logs all dispatched actions.
/// To apply the middleware, call `ReduxRootStore.shared.applyMiddleware(ActionLogMiddleware)`when initializing app.
public func ActionLogMiddleware(_ nextDispatchFunction: @escaping DispatchFunction) -> DispatchFunction {
  return { action in
    dbgPrint("[ActionLogMiddleware] Received Action = \(action).")
    nextDispatchFunction(action)
  }
}
