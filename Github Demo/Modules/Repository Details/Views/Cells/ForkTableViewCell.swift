//
//  ForkTableViewCell.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit

struct ForkViewModel {
    var username: String
    private var userAvatarUrl: String
    var indexPath: IndexPath?
    
    var avatarUrl: URL? {
        return URL(string: userAvatarUrl)
    }
    
    var forkNumberString: String? {
        if let indexPath = indexPath {
            return "fork #" + indexPath.row.description
        }
        return nil
    }
    
    init(username: String, avatarUrl: String) {
        self.username = username
        self.userAvatarUrl = avatarUrl
    }
}

class ForkTableViewCell: UITableViewCell {

    @IBOutlet weak fileprivate var containerView: UIView!
    @IBOutlet weak fileprivate var forkNumberLabel: UILabel!
    @IBOutlet weak fileprivate var avataImageView: UIImageView!
    @IBOutlet weak fileprivate var nameLabel: UILabel!
    @IBOutlet weak fileprivate var leftSeparatorView: UIView!
    @IBOutlet weak fileprivate var rightSeparatorView: UIView!
    
    var viewModel: ForkViewModel? {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        leftSeparatorView.backgroundColor = GitColor.darkBlue.value
        forkNumberLabel.textColor = GitColor.darkBlue.value
        rightSeparatorView.backgroundColor = GitColor.darkBlue.value
        nameLabel.textColor = GitColor.primary.value
    }
    
    private func configure() {
        guard let viewModel = viewModel else {
            return
        }
        forkNumberLabel.text = viewModel.forkNumberString ?? ""
        nameLabel.text = viewModel.username
        if let url = viewModel.avatarUrl {
            avataImageView.sd_setImage(with: url,
                                       placeholderImage: #imageLiteral(resourceName: "Octocat"),
                                       completed: nil)
        }
    }
}
