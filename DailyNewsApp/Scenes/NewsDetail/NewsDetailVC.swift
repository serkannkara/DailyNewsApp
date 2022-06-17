//
//  NewsDetailVC.swift
//  DailyNewsApp
//
//  Created by Serkan on 25.03.2022.
//

import UIKit
import SafariServices

class NewsDetailVC: UIViewController {
    var imageView           = NImageView(frame: .zero)
    var titleLabel          = NLabel(fontSize: 15)
    var dateLabel           = NLabel(fontSize: 10)
    var descriptionTextView = UITextView()
    var learnMoreButton     = NButton(title: "Learn More", backgroundColor: .systemRed)
    
    var named: String?
    let padding: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        configureImageView()
        configureTitleLabel()
        configureDateLabel()
        configureDescription()
        configureLearnMoreButton(name: named ?? "")
    }
    
    
    func configureNavBar(){
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func configureImageView(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding*22),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    func configureTitleLabel(){
        view.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureDateLabel(){
        view.addSubview(dateLabel)
        dateLabel.textAlignment = .right
        dateLabel.textColor = .systemGray
        
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: padding*2)
        ])
    }
    
    func configureDescription(){
        view.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding*5)
        ])
    }
    
    func configureLearnMoreButton(name: String){
        view.addSubview(learnMoreButton)
        learnMoreButton.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
        self.named = name
        
        NSLayoutConstraint.activate([
            learnMoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding*3),
            view.trailingAnchor.constraint(equalTo: learnMoreButton.trailingAnchor, constant: padding*3),
            learnMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding*2.5),
            learnMoreButton.heightAnchor.constraint(equalToConstant: padding*5)
        ])
    }
    
    @objc func learnMoreButtonTapped(){
        let url = URL(string: named ?? "")
        let safariVC = SFSafariViewController(url: url!)
        self.present(safariVC, animated: true)
    }
}
