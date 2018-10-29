//
//  ViewController.swift
//  CustomWidthPagingScrollView
//
//  Created by Ahmed Khalaf on 10/29/18.
//  Copyright © 2018 Ahmed Khalaf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var constraint: NSLayoutConstraint!
    
    private func populateStackView() {
        for i in 0...10 {
            let contentVC = ContentViewController.newInstance(withIndex: i)
            stackView.addArrangedSubview(contentVC.view)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        populateStackView()
    }


}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var kCellWidth = scrollView.frame.size.width
        let kCellSpacing: CGFloat = 0
        
        let kMaxIndex: CGFloat = 10
        let targetX: CGFloat = scrollView.contentOffset.x + velocity.x
        var targetIndex: CGFloat = targetX / (kCellWidth + kCellSpacing)
        if velocity.x > 1 {
            targetIndex = ceil(targetIndex)
        } else {
            targetIndex = floor(targetIndex)
        }
        if (targetIndex < 0) {
            targetIndex = 0
        }
        if (targetIndex > kMaxIndex) {
            targetIndex = kMaxIndex
        }
        
        var x = targetIndex * (kCellWidth + kCellSpacing)
        if Int(targetIndex) % 2 != 0 {
            x -= 50
        }
        
        targetContentOffset.pointee.x = x
    }
}

class CustomPagedScrollView: UIScrollView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var bounds = self.bounds
        bounds.size.width += 50
        return bounds.contains(point)
    }
}
