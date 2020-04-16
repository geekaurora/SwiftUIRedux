import XCTest
@testable import SwiftUIRedux

final class TestRootStore: XCTestCase {
  static let total = 300
  static let queueLable = "com.swiftui.redux"
  private var rootStore: ReduxRootStore!
  
  override func setUp() {
    rootStore = ReduxRootStore()
  }
  
  func testSubscribe() {
    let reducer = TestReducer()
    rootStore.subscribe(reducer)
    XCTAssert(rootStore.contains(reducer))
  }
  
  func testUnsubscribe() {
    let reducer = TestReducer()
    rootStore.subscribe(reducer)
    XCTAssert(rootStore.contains(reducer))
    
    rootStore.unsubscribe(reducer)
    XCTAssert(!rootStore.contains(reducer))
  }
  
  func testWeakReference() {
    // Subscribe `reducer` to `rootStore`.
    var reducer: TestReducer? = TestReducer()
    rootStore.subscribe(reducer!)
    XCTAssert(rootStore.contains(reducer!))
    
    // After release `reducer`, it should be unsubscribed automatically from `rootStore`.
    reducer = nil
    XCTAssert(rootStore.reducers.count == 0)
  }
  
  func testMultiThread() {
    let dispatchGroup = DispatchGroup()
    let queue = DispatchQueue(label: Self.queueLable, attributes: .concurrent)
    
    // Test adding objects on multiple threads.
    let reducers = (0..<Self.total).map { _ in TestReducer() }
    reducers.forEach { item in
      dispatchGroup.enter()
      queue.async {
        self.rootStore.subscribe(item)
        dispatchGroup.leave()
      }
    }
    // Wait till group multi thread tasks complete.
    dispatchGroup.wait()
    // Verify `count` of reducers with the expected value.
    XCTAssertEqual(rootStore.reducers.count, Self.total)
  }
}

private class TestReducer: ReduxReducerProtocol {
  func reduce(action: ReduxActionProtocol) {}
}
