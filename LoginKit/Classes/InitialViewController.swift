//
//  InitialViewController.swift
//  LoginKit
//
//  Created by Daniel Lozano Valdés on 12/8/16.
//  Copyright © 2016 danielozano. All rights reserved.
//

import UIKit
//import EAIntroView

protocol InitialViewControllerDelegate: class {

    func didSelectSignup(_ viewController: UIViewController)

    func didSelectLogin(_ viewController: UIViewController)


}

class InitialViewController: UIViewController, BackgroundMovable {

    // MARK: - Properties

    weak var delegate: InitialViewControllerDelegate?

    weak var configurationSource: ConfigurationSource?

    // MARK: Background Movable

    var movableBackground: UIView {
        get {
            return backgroundImageView
        }
    }

    // MARK: Outlet's

    @IBOutlet weak var logoImageView: UIImageView!

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var signupButton: Buttn!

    @IBOutlet weak var loginButton: Buttn!


    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //showIntroWithCrossDissolve()

        _ = loadFonts
        initBackgroundMover()
        customizeAppearance()
    }

    override func loadView() {
        self.view = viewFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Setup

    func customizeAppearance() {
        configureFromSource()
        setupFonts()

        navigationController?.isNavigationBarHidden = true
        navigationController?.delegate = self
    }

    func configureFromSource() {
        guard let config = configurationSource else {
            return
        }

        backgroundImageView.image = config.backgroundImage
        
        signupButton.setTitle(config.signupButtonText, for: .normal)
        signupButton.setTitleColor(.purple, for: .normal)
        signupButton.borderColor = config.tintColor.withAlphaComponent(0.25)
        

        loginButton.setTitle(config.loginButtonText, for: .normal)
        loginButton.setTitleColor(.purple, for: .normal)
        loginButton.borderColor = config.tintColor.withAlphaComponent(0.25)
        
        
    }

    func setupFonts() {
        signupButton.titleLabel?.font = UIFont(name: "AvenirNext-UltraLight", size: 22.0)
        loginButton.titleLabel?.font = UIFont(name: "AvenirNext-UltraLight", size: 22.0)
        //loginButton.titleLabel?.font = Font.montserratRegular.get(size: 13)
        //signupButton.titleLabel?.font = Font.montserratRegular.get(size: 13)
    }

    // MARK: - Action's

    @IBAction func didSelectSignup(_ sender: AnyObject) {
        delegate?.didSelectSignup(self)
    }

    @IBAction func didSelectLogin(_ sender: AnyObject) {
        delegate?.didSelectLogin(self)
    }
    /*
    func showIntroWithCrossDissolve() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let rootViewController = appDelegate.window?.rootViewController as? UINavigationController else { return }
        guard let rootView = rootViewController.view else { return }
        
        
        let page1 = EAIntroPage()
        page1.title = NSLocalizedString("CrossByNeverMissed", comment: "")
        page1.desc = NSLocalizedString("page1desc", comment: "")
        page1.bgImage = UIImage(named: "bg2")
        
        let page2 = EAIntroPage()
        page2.title = NSLocalizedString("MeetisGood", comment: "")
        page2.desc = NSLocalizedString("page2desc", comment: "")
        page2.bgImage = UIImage(named: "bg2")
        
        let page3 = EAIntroPage()
        page3.title = NSLocalizedString("GiveFavor", comment: "")
        page3.desc = NSLocalizedString("page3desc", comment: "")
        page3.bgImage = UIImage(named: "bg2")
        
        let page4 = EAIntroPage()
        page4.title = NSLocalizedString("ChatEachother", comment: "")
        page4.desc = NSLocalizedString("page4desc", comment: "")
        page4.bgImage = UIImage(named: "bg2")
        
        guard let introView = EAIntroView(frame: rootView.bounds, andPages: [page1, page2, page3, page4]) else {
            return
        }
        
        let bounds = rootView.bounds
        
        
        let tutorFrame = CGRect(x: 0.23317 * bounds.width,
                                y: 0.13613 * bounds.height,
                                width: 0.53125 * bounds.width,
                                height: 0.53 * bounds.height)
        
        let tutorView1 = UIImageView(image: UIImage(named: "1c"))
        tutorView1.frame = tutorFrame
        page1.pageView.addSubview(tutorView1)
        
        let tutorView2 = UIImageView(image: UIImage(named: "2c"))
        tutorView2.frame = tutorFrame
        page2.pageView.addSubview(tutorView2)
        
        let tutorView3 = UIImageView(image: UIImage(named: "1c"))
        tutorView3.frame = tutorFrame
        page3.pageView.addSubview(tutorView3)
        
        let tutorView4 = UIImageView(image: UIImage(named: "4c"))
        tutorView4.frame = tutorFrame
        page4.pageView.addSubview(tutorView4)
        
        let frameView = UIImageView(image: UIImage(named: "iphoneframe"))
        frameView.frame = CGRect(x: 0.1897 * bounds.width,
                                 y: 0.05053 * bounds.height,
                                 width: 0.6182 * bounds.width,
                                 height: 0.709348 * bounds.height)
        introView.addSubview(frameView)
        introView.bringSubview(toFront: frameView)
        
        
        introView.skipButtonAlignment = .center
        introView.skipButtonY = 80.0
        introView.pageControlY = 42.0
        introView.delegate = self
        
        introView.show(in: rootView, animateDuration: 0.5)
        
    }
    */

}

// MARK: - UINavigationController Delegate

extension InitialViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveAnimation()
    }

}
