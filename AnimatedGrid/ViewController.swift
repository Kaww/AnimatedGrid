//
//  ViewController.swift
//  AnimatedGrid
//
//  Created by kaww on 30/11/2019.
//  Copyright © 2019 KAWRANTIN LE GOFF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let pixelPerRow = 10
    var pixelPerColumn: Int!
    
    var pixels = [String: UIView]()
    
    var selectedPixel: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let width = view.frame.width / CGFloat(pixelPerRow)
        let ratio = view.frame.height / view.frame.width
        pixelPerColumn = Int(CGFloat(pixelPerRow) * ratio) + 1
        
        for j in 0..<pixelPerColumn {
            
            for i in 0..<pixelPerRow {
                let pixel = UIView()
                pixel.backgroundColor = randomColor()
                pixel.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                pixel.layer.cornerRadius = 5//width / 2
                view.addSubview(pixel)
                
                pixels["\(i):\(j)"] = pixel
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleTouch)))
    }
    
    @objc func handleTouch(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        
        let width = view.frame.width / CGFloat(pixelPerRow)
        let x = Int(location.x / width)
        let y = Int(location.y / width)
        
        guard let pixel = pixels["\(x):\(y)"] else { return }
        
        view.bringSubviewToFront(pixel)
        
        if selectedPixel != pixel {
            UIView.animate(withDuration: 0.25, delay: 0, options: [], animations: {
                self.selectedPixel?.transform = .identity
            })
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            pixel.transform = CGAffineTransform(scaleX: 5, y: 5)
        })
        
        selectedPixel = pixel
        
        if gesture.state == .ended {
//            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
//                self.selectedPixel?.transform = .identity
//            })
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.selectedPixel?.transform = .identity
            })
        }
    }
    
    fileprivate func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }


}
