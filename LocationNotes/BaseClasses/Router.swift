//
//  Router.swift
//  LocationNotes
//
//  Created by Роман Мельник on 12.03.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class Router: NSObject {

    static let shared = Router()
    var window: UIWindow?

    // MARK: - Init
    
    override private init() {
        super.init()
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }
    


    func showInitialVC() {
        window?.rootViewController = menuNavVC()
        window?.makeKeyAndVisible()
    }
    
    
//    func rootMainViewController() {
//        //        let mainTabbarVC = R.storyboard.mainTabBar.mainTabBarViewController()
//        window?.rootViewController = TabBarManager.shared.tabBarController
//        window?.makeKeyAndVisible()
//    }

    
    // MARK: - Getters
    
    func tabNavBar() -> UITabBarController? {
        return R.storyboard.main.tabNavBar()
    }
    
    func menuNavVC() -> UINavigationController? {
        return R.storyboard.menu.menuNavVC()
    }
    
    func bannerVC() -> BannerVC? {
        return R.storyboard.banner.bannerVC()
    }
    
//    func bannerVC() -> BannerVC {
//        return R.storyboard.banner.bannerVC()!
//    }
    
    
//    func loginVC() -> LoginViewController? {
//        return R.storyboard.login.loginViewController()
//    }
//
//    func recoveryPassVC() -> RecoveryPasswordViewController? {
//        return R.storyboard.login.recoveryPasswordViewController()
//    }
//
//    func newsDetailVC() -> NewsDetailsViewController? {
//        return R.storyboard.news.newsDetailsViewController()
//    }
//
//    func ticketVC() -> TicketViewController? {
//        return R.storyboard.ticket.ticketViewController()
//    }
//
//    func menuVC() -> MenuViewController? {
//        return R.storyboard.menu.menuViewController()
//    }
}
