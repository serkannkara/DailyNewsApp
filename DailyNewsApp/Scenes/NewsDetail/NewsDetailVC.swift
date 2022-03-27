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
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -220),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    func configureTitleLabel(){
        view.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    func configureDateLabel(){
        view.addSubview(dateLabel)
        dateLabel.textAlignment = .right
        dateLabel.textColor = .systemGray
        
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureDescription(){
        view.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    func configureLearnMoreButton(name: String){
        view.addSubview(learnMoreButton)
        learnMoreButton.addTarget(self, action: #selector(learnMoreButtonTapped), for: .touchUpInside)
        self.named = name
        
        NSLayoutConstraint.activate([
            learnMoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: learnMoreButton.trailingAnchor, constant: 30),
            learnMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            learnMoreButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func learnMoreButtonTapped(){
        let url = URL(string: named ?? "")
        let safariVC = SFSafariViewController(url: url!)
        self.present(safariVC, animated: true)
    }
}
