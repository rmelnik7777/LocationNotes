//
//  BannerVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 12.03.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

struct Pages {
    var name: String
    var description: String
}

class BannerVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Outlets

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollview: UIScrollView!
    //    @IBOutlet weak var labelsView: UIView!
    
    // MARK: - Properties
    var timer: Timer!
    var updateCounter = 0
    var slides:[Slide] = []
    var pages: [Pages] = [Pages(name: "11111qwewqe", description: "qweqwe"), Pages(name: "2222qwewqe", description: "qweqwe"), Pages(name: "3333qwewqe", description: "qweqwe")]
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateTimer()
//        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(BannerVC.updateTimer), userInfo: nil, repeats: true)
        scrollview.delegate = self
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    
//    // MARK: - UI
//    func prepareUI() {
//        titleLabel.font = R.font.grinched(size: 22)
//    }
    
    @objc internal func updateTimer() {
//        if (updateCounter < pages.count) {
//            pageControl.currentPage = updateCounter
//            titleLabel.text = pages[updateCounter].name
//            updateCounter += 1
//        } else {
//            updateCounter = 0
//        }
    }
    
    

    func createSlides() -> [Slide] {

            let slide1: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide1.titleLabel.text = "GOMOSEKI"
//            slide1.image.image = UIImage(named: "ic_onboarding_1")
            
            let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide2.titleLabel.text = "2 GOMOSEKI"
//            slide2.image.image = UIImage(named: "ic_onboarding_1")
            
            let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide3.titleLabel.text = "3GOMOSEKI"
//            slide3.image.image = UIImage(named: "ic_onboarding_1")
        
            let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide4.titleLabel.text = "4GOMOSEKI"
//            slide4.image.image = UIImage(named: "ic_onboarding_1")
            
            
            return [slide1, slide2, slide3, slide4]
        }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollview.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollview.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollview.isPagingEnabled = true
        
        for index in 0 ..< slides.count {
            slides[index].frame = CGRect(x: view.frame.width * CGFloat(index), y: 0, width: view.frame.width, height: view.frame.height)
            scrollview.addSubview(slides[index])
        }
    }
    
    

    // MARK: - Actions
  
    @IBAction func subscribeFullButtonTapped(_ sender: Any) {
    }
    
    @IBAction func subscribeExtendedButtonTapped(_ sender: Any) {
    }
    
    @IBAction func restoreButtonTapped(_ sender: Any) {
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

        /*
         * default function called when view is scolled. In order to enable callback
         * when scrollview is scrolled, the below code needs to be called:
         * slideScrollView.delegate = self or
         */
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageControl.currentPage = Int(pageIndex)
            
            let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
            let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
            
            // vertical
            let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
            let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
            
            let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
            let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
            
            
            /*
             * below code changes the background color of view on paging the scrollview
             */
    //        self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
            
        
            /*
             * below code scales the imageview on paging the scrollview
             */
            let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
            
            if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
                
                slides[0].image.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
                slides[1].image.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
                
            } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
                slides[1].image.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
                slides[2].image.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
                
            } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
                slides[2].image.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
                slides[3].image.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
                
            } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
                slides[3].image.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
                slides[4].image.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
            }
        }
    

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         /*
          *
          */
        setupSlideScrollView(slides: slides)
    }
}
