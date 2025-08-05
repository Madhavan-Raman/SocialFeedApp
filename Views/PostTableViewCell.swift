
import UIKit

class PostTableViewCell: UITableViewCell {
    static let identifier = "PostCell"

    let usernameLabel = UILabel()
    let contentLabel = UILabel()
    let contentImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with post: Post) {
        usernameLabel.text = "@\(post.username)"
        contentLabel.text = post.contentText

        if let urlStr = post.contentImageURL, let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.contentImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        } else {
            contentImageView.image = nil
        }
    }

    private func setupUI() {
        usernameLabel.font = .boldSystemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        contentImageView.contentMode = .scaleAspectFill
        contentImageView.clipsToBounds = true

        let stack = UIStackView(arrangedSubviews: [usernameLabel, contentLabel, contentImageView])
        stack.axis = .vertical
        stack.spacing = 8
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
