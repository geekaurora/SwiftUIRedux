import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

// MARK: - Feed

struct FetchFeedsCommand: ReduxActionProtocol {
  let endPoint: String
  let params: [String: AnyObject] = [:]
}
