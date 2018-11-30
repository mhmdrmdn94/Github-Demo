//
//  RepositoryTableViewCell.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit

struct RepositoryTableViewCellViewModel {
    var name: String
    var ownerAvatar: URL
    var description: String
    var numberOfForks: Int
    var numberOfWatchers: Int
    var indexPath: IndexPath
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
    }
    
}
