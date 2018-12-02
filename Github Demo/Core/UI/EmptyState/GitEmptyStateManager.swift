//
//  GitEmptyStateManager.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

enum GitEmptyStateType {
    case noResults
    case noInternetConnection
    case someThingWentWrong
    case noSearchKeywordLogged
    case loading
    
    private var avatarImage: UIImage {
        return #imageLiteral(resourceName: "Octocat")
    }
    private var title: String? {
        switch self {
        case .noResults:
            return "No Results!"
        case .noInternetConnection:
            return "No Internet Connection!"
        case .someThingWentWrong:
            return "Something went wrong!"
        case .noSearchKeywordLogged:
            return "No search keyword!"
        case .loading:
            return nil
        }
    }
    private var descriptionContent: String? {
        switch self {
        case .noResults:
            return "Sorry! we did not find any repositories matching this criteria."
        case .noInternetConnection:
            return "It's seems like you're not connected to the internet! Please try again later."
        case .someThingWentWrong:
            return "Opps! something went wrong! Please try again later"
        case .noSearchKeywordLogged:
            return "Sorry! you have to enter a search keyword."
        case .loading:
            return nil
        }
    }
    private var actionButtonTitle: String? {
        switch self {
        case .noResults:
            return nil
        case .noInternetConnection:
            return "Try again"
        case .someThingWentWrong:
            return "Try again"
        case .noSearchKeywordLogged:
            return nil
        case .loading:
            return nil
        }
    }
    
    var viewModel: GitEmptyStateViewModel {
        let emptyStateViewModel = GitEmptyStateViewModel(avatarImage: avatarImage,
                                               title: title,
                                               descriptionContent: descriptionContent,
                                               actionButtonTitle: actionButtonTitle)
        return emptyStateViewModel
    }
    
    
}
