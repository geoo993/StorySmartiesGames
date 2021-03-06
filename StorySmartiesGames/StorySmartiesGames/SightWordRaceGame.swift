//
//  FlipCard.swift
//  StorySmartiesGames
//
//  Created by GEORGE QUENTIN on 13/01/2017.
//  Copyright © 2017 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit

public class SightWordRaceGame: GameViewBase {
    
    public var back = QuickButton()//UIImageView!
    public var front = QuickButton()//UIImageView!
    var showingBack = true
    
    var wordList = [String]()
    var lifeTime : TimeInterval = 0
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(frame: CGRect, words: [String], switchDuration: TimeInterval) {
        super.init(frame: frame)
        ViewController.titleLabel.text = "Sight Word Race Game"
        ViewController.descriptionLabel.text = "Say The Sight Word"
        ViewController.fontSize = 50.0
        
        wordList = words
        lifeTime = switchDuration
        let font = UIFont.systemFont(ofSize: ViewController.fontSize)
        
        front = QuickButton(frame: frame)
        front.buttonElements(wordList.chooseOne(), font, UIColor.black)
        front.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        
        back = QuickButton(frame: frame)
        back.buttonElements(wordList.chooseOne(), font, UIColor.green)
        back.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        
        self.addSubview(back)
        
    }
    
    
    
    func tapped(_ but: UIButton) {
        
//        let curlTransition : [UIViewAnimationOptions] = 
//            [
//                .transitionCurlUp, 
//                .transitionCurlDown
//            ]
//        
        let leftRightTransition : [UIViewAnimationOptions] = 
            [
                .transitionFlipFromLeft, 
                .transitionFlipFromRight
            ]
//        let topBottomTransition : [UIViewAnimationOptions] = 
//            [
//                .transitionFlipFromTop, 
//                .transitionFlipFromBottom
//            ]
        
        if (showingBack) {
            UIView.transition(from: back, to: front, duration: lifeTime, options: leftRightTransition[0], completion: { completed in 
                self.back.updateColor(color: UIColor.randomColor(), word: self.wordList.chooseOne()) 
            })
            showingBack = false
        } else {
            UIView.transition(from: front, to: back, duration: lifeTime, options: leftRightTransition[0], completion: { completed in
                self.front.updateColor(color: UIColor.randomColor(), word: self.wordList.chooseOne()) 
            })
            showingBack = true
        }
    }

}

