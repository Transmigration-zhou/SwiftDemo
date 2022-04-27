//
//  ViewController.swift
//  ScrollView
//
//  Created by ByteDance on 2022/4/26.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    private let scrollView: UIScrollView = UIScrollView()
    private let image = UIImage(named: "image1")!
    private lazy var imageView = { () -> UIImageView in
        let imageView = UIImageView(image: self.image)
        return imageView
    }()
    
    private var currentImageSize: CGSize {
        let scale = scrollView.zoomScale
        return CGSize(width: image.size.width * scale, height: image.size.height * scale)
    }
    
    private var didFinishInitialLayout = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(scrollView)
        scrollView.backgroundColor = .yellow
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1000)
        
                scrollView.addSubview(imageView)
        scrollView.contentSize = image.size
        
        // zoom
        let minScale: CGFloat
        if image.size.width > image.size.height {
            minScale = view.frame.width / image.size.width
        } else {
            minScale = view.frame.height / image.size.height
        }
        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
        
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        
        //隐藏滚动条
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        //添加缩放手势
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleZoom))
        gesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(gesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame.size = view.frame.size
        scrollView.frame.origin.y = view.safeAreaInsets.top
        scrollView.frame.size.height -= view.safeAreaInsets.top + view.safeAreaInsets.bottom
        
        if !didFinishInitialLayout {
            // content insert
            let top: CGFloat = (scrollView.frame.height - currentImageSize.height) / 2
            scrollView.contentInset = UIEdgeInsets(top: top, left: 100, bottom: 0, right: 0)
            
            didFinishInitialLayout = true
        }
    }

    @objc private func toggleZoom() {
        if scrollView.zoomScale <= 1 {
//            scrollView.zoomScale = scrollView.maximumZoomScale
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        } else {
//            scrollView.zoomScale = scrollView.minimumZoomScale
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("did scroll \(scrollView.contentOffset)")
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // content insert
        let top: CGFloat = max(0, (scrollView.frame.height - currentImageSize.height) / 2)
        scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

