//
//  RepositoryTableViewCell.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit
import SDWebImage

struct RepositoryTableViewCellViewModel {
    var name: String
    var ownerAvatar: URL
    var description: String
    private var numberOfForks: Int
    private var numberOfWatchers: Int
    var indexPath: IndexPath
    
    var forksString: String {
        let forksTitle = (numberOfForks > 1) ? "forks":"fork"
        return numberOfForks.description + " " + forksTitle
    }
    
    var watchersString: String {
        let watchersTitle = (numberOfWatchers > 1) ? "watchers":"watcher"
        return numberOfWatchers.description + " " + watchersTitle
    }
}

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak fileprivate var ownerAvatarImageView: UIImageView!
    @IBOutlet weak fileprivate var nameLabel: UILabel!
    @IBOutlet weak fileprivate var descriptionLabel: UILabel!
    @IBOutlet weak fileprivate var numberOfForksLabel: UILabel!
    @IBOutlet weak fileprivate var numberOfWatchersLabel: UILabel!
    
    var viewModel: RepositoryTableViewCellViewModel? {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
