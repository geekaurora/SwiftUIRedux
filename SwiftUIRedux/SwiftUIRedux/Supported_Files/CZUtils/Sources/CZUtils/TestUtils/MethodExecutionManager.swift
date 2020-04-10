import Foundation

/// Manager that maintains method execution for tests.
/// - Note:
/// Should call `reset()` in `tearDown()` of tests.
public class MethodExecutionManager {

  public static let shared = MethodExecutionManager()
  private var executedMethods = Set<String>()

  public func insertExecutedMethod(_ methodName: String) {
    executedMethods.insert(methodName)
  }

  public func removeExecutedMethod(_ methodName: String) {
    executedMethods.remove(methodName)
  }

  public func isMethodExecuted(_ methodName: String) -> Bool {
    return executedMethods.contains(methodName)
  }

  public func reset() {
    executedMethods.removeAll()
  }

}
