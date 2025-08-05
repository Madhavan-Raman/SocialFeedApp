
import Foundation
import Combine

class FeedViewModel {
    @Published var posts: [Post] = []

    func fetchPosts() {
        guard let url = Bundle.main.url(forResource: "dummy_posts", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Post].self, from: data)
            self.posts = decoded
        } catch {
            print("Error loading posts:", error)
        }
    }
}
