//
//  GitEmptyStateView.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

struct GitEmptyStateViewModel {
    var avatarImage: UIImage?
    var title: String?
    var descriptionContent: String?
    var actionButtonTitle: String?
}

protocol GitEmptyStateViewDelegate: class {
    func didTapActionButton()
}

class GitEmptyStateView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    weak var delegate: GitEmptyStateViewDelegate?
    var viewModel: GitEmptyStateViewModel? {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        contentView = loadFromNib(named: GitEmptyStateView.nibName)!
        addSubview(contentView)
        pinItemToEdges(item: contentView)
        
        actionButton.tintColor = GitColor.darkBlue.value
        actionButton.roundCorners(withRadius: 10,
                                  borderWidth: 1,
                                  borderColor: GitColor.darkBlue.value)
    }
    
    private func configure() {
        guard let viewModel = viewModel else {
           return
        }
        
        if let avatar = viewModel.avatarImage {
            avatarImageView.image = avatar
        }
        
        if let title = viewModel.title {
            titleLabel.isHidden = false
            titleLabel.text = title
        } else {
            titleLabel.isHidden = true
        }
        
        if let descriptionContent = viewModel.descriptionContent {
            descriptionLabel.isHidden = false
            descriptionLabel.text = descriptionContent
        } else {
            descriptionLabel.isHidden = true
        }
        
        if let buttonTitle = viewModel.actionButtonTitle {
            actionButton.isHidden = false
            actionButton.setTitle(buttonTitle, for: .normal)
        } else {
            actionButton.isHidden = true
        }
        
    }
    
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        print("ActionButton tapped ...")
        delegate?.didTapActionButton()
    }
    
}
