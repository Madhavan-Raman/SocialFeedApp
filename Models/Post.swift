
import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let username: String
    let profileImageURL: String
    let contentText: String
    let contentImageURL: String?
}
