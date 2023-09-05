//
//  ViewController.swift
//  RCMarvel
//
//  Created by user on 23/08/23.
//

import UIKit

class PersonagensViewController: UIViewController {
    private var personagens: [Personagem] = [
//        .init(nome: "Homem-Aranha", desc: "Louco e sonhador", imageURL: ""),
//        .init(nome: "Doutor Estranho", desc: "Louco e sonhador", imageURL: ""),
//        .init(nome: "Homem de Ferro", desc: "Louco e sonhador", imageURL: ""),
//        .init(nome: "Kang", desc: "Louco e sonhador", imageURL: "")
    ]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Marvel"
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        addViewsInHierarchy()
        setupConstraints()
        fetchMarvelAPI()
    }
    
    private func addViewsInHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchMarvelAPI() {
        let randomInt = Int.random(in: 1...1542)
        
        let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?ts=1&apikey=e9dc5d6707354193bb5d3888a982edd8&hash=693320e9fed8e912f4091c684875d92b&offset=\(randomInt)")!
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil { return }
            
            guard let personagensData = data else { return }
            
            let decoder = JSONDecoder()
            guard let remotePersonagens = try? decoder.decode(MarvelAPIRemotePersonagens.self, from: personagensData) else { return }
            
            self.personagens = remotePersonagens.data.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        task.resume()
    }
}

extension PersonagensViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PersonagemCell()
        let personagem = personagens[indexPath.row]
        cell.configure(personagem: personagem)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        personagens.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Detail", bundle: Bundle(for: DetailViewController.self))
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        detailViewController.personagem = personagens[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
