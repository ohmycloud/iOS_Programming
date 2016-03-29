//
//  ViewController.swift
//  字符串扩展
//
//  Created by chenyf on 16/2/27.
//  Copyright © 2016年 chenyf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuesionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        ++currentQuestionIndex
        if  currentQuestionIndex == questions.count {
            currentQuestionIndex = 0 // 如果到达数组末尾就从头开始
        }
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text   = question
        answerLabel.text     = "???"
        animateLabelTransitions()
        
    }
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String  = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animateLabelTransitions() {
    
        // Animate the alpha
//        UIView.animateWithDuration(0.5, animations: {
//            // 淡出当前 questionLabel, 淡入 nextQuestionLabel
//            self.currentQuestionLabel.alpha = 0
//            self.nextQuestionLabel.alpha    = 1
//        })
        
        let screenWidth = view.frame.width
        self.nextQuesionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: [],
            animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha    = 1
                
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuesionLabelCenterXConstraint)
                self.updateOffScreenLabel()
        })
    }
    
    // 模型层
    let questions: [String]       = ["法国白兰地的组成是什么?", "7+7等于几?", "福蒙特州的首都是?"]
    let answers: [String]         = ["葡萄", "14", "蒙彼利埃"]
    var currentQuestionIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
   
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuesionLabelCenterXConstraint.constant =  -screenWidth
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex   = self.startIndex.advancedBy(r.endIndex)
            
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
}

