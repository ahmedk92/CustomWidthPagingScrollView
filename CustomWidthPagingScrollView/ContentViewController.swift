//
//  ContentViewController.swift
//  CustomWidthPagingScrollView
//
//  Created by Ahmed Khalaf on 10/29/18.
//  Copyright © 2018 Ahmed Khalaf. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    var index = 0
    
    @IBOutlet private var barView: UIView!
    @IBOutlet private var label: UILabel!
    @IBOutlet private var xLabel: UILabel!
    @IBOutlet private var wLabel: UILabel!

    
    class func newInstance(withIndex index: Int) -> ContentViewController {
        let instance = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(ContentViewController.self)") as! ContentViewController
        instance.index = index
        return instance
    }
    
    private func positionBarView() {
        let barAnchors = [barView.trailingAnchor, barView.leadingAnchor]
        let viewAnchors = [view.trailingAnchor, view.leadingAnchor]
        
        let index = self.index % 2
        
        barAnchors[index].constraint(equalTo: viewAnchors[index]).isActive = true
        
        if index == 1 {
            barView.transform = .init(scaleX: -1, y: 1)
        }
    }
    
    private func setBackgroundColor() {
        view.backgroundColor = index % 2 == 0 ? .orange : .purple
    }
    
    private func setLabelText() {
        label.text = "\(index)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        positionBarView()
        setBackgroundColor()
        setLabelText()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        xLabel.text = "\(view.frame.origin.x)"
        wLabel.text = "\(view.frame.origin.x + barView.frame.origin.x)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class ContentView: UIView {
    override var intrinsicContentSize: CGSize {
        var size = UIScreen.main.bounds.size
        size.width -= 50
        return size
    }
}
