//
//  DetailViewController.swift
//  RCMarvel
//
//  Created by user on 29/08/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var personagemDesc: UILabel!
    @IBOutlet weak var personagemImage: UIImageView!
    @IBOutlet weak var personagemNome: UILabel!
    
    var personagem: Personagem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personagemImage.layer.cornerRadius = 28
        personagemImage.layer.masksToBounds = true
        personagemImage.contentMode = .scaleAspectFit
        
        personagemNome.text = personagem.name
        personagemDesc.text = personagem.description
        personagemImage.download(url: personagem.thumbnail.path)
        
        
    }

}
