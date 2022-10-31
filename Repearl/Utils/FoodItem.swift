import Foundation
import SwiftUI

class FoodItem : Codable {
    var ItemId: String!
    var Items: [String]!
    var RestName: String!
    var ItemDesc: String!
    var ItemPrice: String!
    init(_ ItemName: String) {
        RestName = "";
        ItemId = String.getRandomString(length: 8)
        ItemDesc = ""
        ItemPrice = ""
    }
}
