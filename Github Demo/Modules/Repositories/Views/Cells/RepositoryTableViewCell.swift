//
//  RepositoryTableViewCell.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit
import SDWebImage

struct RepositoryViewModel {
    var name: String
    var ownerAvatar: URL?
    var description: String
    private var numberOfForks: Int
    private var numberOfWatchers: Int
    var indexPath: IndexPath?
    
    var forksString: String {
        let forksTitle = (numberOfForks > 1) ? "forks":"fork"
        return numberOfForks.description + " " + forksTitle
    }
    
    var watchersString: String {
        let watchersTitle = (numberOfWatchers > 1) ? "watchers":"watcher"
        return numberOfWatchers.description + " " + watchersTitle
    }
    
    init(name: String,
         ownerAvatar: URL?,
         description: String,
         numberOfForks: Int,
         numberOfWatchers: Int) {
        self.name = name
        self.ownerAvatar = ownerAvatar
        self.description = description
        self.numberOfWatchers = numberOfWatchers
        self.numberOfForks = numberOfForks
    }
    
}

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak fileprivate var containerView: UIView!
    @IBOutlet weak fileprivate var ownerAvatarImageView: UIImageView!
    @IBOutlet weak fileprivate var nameLabel: UILabel!
    @IBOutlet weak fileprivate var descriptionLabel: UILabel!
    @IBOutlet weak fileprivate var numberOfForksLabel: UILabel!
    @IBOutlet weak fileprivate var numberOfWatchersLabel: UILabel!
    
    var viewModel: RepositoryViewModel? {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupView()
    }
    
    private func setupView() {
        numberOfForksLabel.textColor = GitColor.darkBlue.value
        numberOfWatchersLabel.textColor = GitColor.darkBlue.value
        containerView.roundCorners(withRadius: 10)
        ownerAvatarImageView.roundCorners(withRadius: 10,
                                          borderWidth: 1,
                                          borderColor: .darkGray)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        ownerAvatarImageView.sd_setImage(with: viewModel.ownerAvatar,
                                         placeholderImage: #imageLiteral(resourceName: "Octocat"),
                                         completed: nil)
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        numberOfForksLabel.text = viewModel.forksString
        numberOfWatchersLabel.text = viewModel.watchersString
    }
    
}
