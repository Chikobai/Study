//
//  QuestionsViewController.swift
//  Study
//
//  Created by I on 3/10/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class QuestionsViewController: UIViewController, LessonDrawlable {

    private(set) lazy var variantCollectionView: VariantCollectionView = VariantCollectionView()
    private(set) lazy var questionsLabelView: UILabel = UILabel()
    private var lessonQuestion: LessonPage

    init(with lessonQuestion: LessonPage) {
        self.lessonQuestion = lessonQuestion
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

}

