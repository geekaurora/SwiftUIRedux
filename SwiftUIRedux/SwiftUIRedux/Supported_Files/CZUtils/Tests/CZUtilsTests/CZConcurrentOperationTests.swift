import XCTest
@testable import CZUtils

class CZConcurrentOperationTests: XCTestCase {
  let methodExecutionManager = MethodExecutionManager.shared
  var operation: CZConcurrentOperation!

  override func setUp() {
    operation = CZConcurrentOperation()
  }

  override func tearDown() {
    methodExecutionManager.reset()
  }

  // MARK: - State

  func testIsExecuting() {
    operation.state = .executing
    XCTAssertEqual(operation.state, .executing)
    XCTAssertTrue(operation.isExecuting)
  }

  func testIsFinished() {
    operation.state = .finished
    XCTAssertEqual(operation.state, .finished)
    XCTAssertTrue(operation.isFinished)
  }

  // MARK: - Methods

  func testStartMethod() {
    // Verify state
    operation.state = .ready
    XCTAssertEqual(operation.state, .ready)

    // Call start() method
    operation.start()
    XCTAssertEqual(operation.state, .executing)

    // Verify execute() is called
    XCTAssertTrue(methodExecutionManager.isMethodExecuted("executeReplacement()"))
  }

  func testStartMethodIfCancelled() {
    // Verify state
    operation.state = .ready
    XCTAssertEqual(operation.state, .ready)

    // Call cancel() method
    operation.cancel()

    // Call start() method
    operation.start()

    // Verify finish() is called
    XCTAssertTrue(methodExecutionManager.isMethodExecuted("finishReplacement()"))

    // Verify execute() isn't called
    XCTAssertFalse(methodExecutionManager.isMethodExecuted("executeReplacement()"))
  }

  func testCancelMethodIfIsExecuting() {
    // Verify state
    operation.state = .executing
    XCTAssertEqual(operation.state, .executing)

    // Call cancel() method
    operation.cancel()

    // Verify finish() is called
    XCTAssertTrue(methodExecutionManager.isMethodExecuted("finishReplacement()"))
  }

  func testCancelMethodIfNotExecuting() {
    // Verify state
    operation.state = .finished
    XCTAssertEqual(operation.state, .finished)

    // Call cancel() method
    operation.cancel()

    // Verify finish() isn't called
    XCTAssertFalse(methodExecutionManager.isMethodExecuted("finishReplacement()"))
  }

  func testFinishMethod() {
    // Verify state
    operation.state = .executing
    XCTAssertEqual(operation.state, .executing)

    // Call finish() method
    operation.finish()
    XCTAssertEqual(operation.state, .finished)
  }

}

extension CZConcurrentOperation {
  @_dynamicReplacement(for:execute())
  func executeReplacement() {
    MethodExecutionManager.shared.insertExecutedMethod(#function)
  }

  @_dynamicReplacement(for:finish())
  func finishReplacement() {
    MethodExecutionManager.shared.insertExecutedMethod(#function)
    finish()
  }
}
