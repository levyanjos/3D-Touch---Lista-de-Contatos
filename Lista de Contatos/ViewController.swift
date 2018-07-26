//
//  ViewController.swift
//  Lista de Contatos
//
//  Created by Ada 2018 on 24/07/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

struct  Contato {
    var nome: String
    var fone : String
    var img : UIImage
}

protocol AdicionarContatoDelegate {
    func adicionar(contato: Contato)
}

class ViewController: UIViewController {

    var contatos = [Contato]()
    var alertController: UIAlertController?
    
    @IBOutlet weak var btCadastrar: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contatos.append(Contato(nome: "teste", fone: "555-5555", img: UIImage.init(named: "1")!))

        self.table.delegate = self
        self.table.dataSource = self
        self.table.register(UINib(nibName: "ContatoTableViewCell", bundle: nil), forCellReuseIdentifier: "celula")
        //----------------------------------------------------------------------------------------------
        // Verificando se o dispositivo tem suporte ao 3D Touch.
        if traitCollection.forceTouchCapability == .available {
            // Registra a view para ter a preview com o 3D Touch. Basicamente precisa dizer primeiro
            // quem implementa o delegate (UIViewControllerPreviewingDelegate), e depois qual é a view
            // que será alvo do preview.
            registerForPreviewing(with: self, sourceView: self.table)
        } else {
            alertController = UIAlertController(title: "3D Touch Not Available", message: "Unsupported device.", preferredStyle: .alert)
        }
        //----------------------------------------------------------------------------------------------

    }

    override func viewWillAppear(_ animated: Bool) {
        if traitCollection.forceTouchCapability == .available {
            let defaults = UserDefaults.standard
            
            if let row = defaults.object(forKey: "UltimoContato") as? Int {
                let contato = contatos[row]
                //--------------------------------------------------------------------------------------
                // Cadastrando a quick action dinâmica. Ela somente aparece se
                // algum outro contato já tenha sido visualizado, isso fica salvo no
                // `UserDefaults`.
                let shortcutItem = UIApplicationShortcutItem(
                    type: "UltimoContato",
                    localizedTitle: "\(contato.nome)",
                    localizedSubtitle: "\(contato.fone)",
                    icon: UIApplicationShortcutIcon.init(type: .contact),
                    userInfo: nil)
                
                UIApplication.shared.shortcutItems = [shortcutItem]
                //--------------------------------------------------------------------------------------

            }
        }
        
        self.table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionarContatoSegue" {
            let navigation: UINavigationController = segue.destination as! UINavigationController
            let destination = navigation.topViewController as! AdicionarContatoViewController
            destination.delegate = self
        }
        
        if segue.identifier == "verContatoSegue" {
            let destination = segue.destination as! ContatoViewController
            let contato = sender as! Contato
            
            destination.nameStr = contato.nome
            destination.foneStr = contato.fone
            destination.imgTemp = contato.img
        }
    }
    
    @IBAction func adicionarContato(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "adicionarContatoSegue", sender: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contatos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula") as! ContatoTableViewCell
        
        cell.contatoName.text = contatos[indexPath.row].nome
        cell.contatoFone.text = contatos[indexPath.row].fone
        cell.contatoIMG.image = contatos[indexPath.row].img
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        defaults.set(indexPath.row, forKey: "UltimoContato")
        
        performSegue(withIdentifier: "verContatoSegue", sender: contatos[indexPath.row])
    }
}

//--------------------------------------------------------------------------------------------------
// É preciso implementar o protocolo UIViewControllerPreviewingDelegate para funcionar o preview.
extension ViewController: UIViewControllerPreviewingDelegate {
    
    // Cria um preview da ViewController para ser exibida no "Peek".
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {

        // Obtém o indexPath da celula pressionada.
        guard let indexPath = table.indexPathForRow(at: location),
            let cell = table.cellForRow(at: indexPath) else { return nil }
        
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "ContatoViewController") as? ContatoViewController else { return nil }
        
        let previewDetail = contatos[(indexPath as NSIndexPath).row]
        detailViewController.nameStr = previewDetail.nome
        detailViewController.foneStr = previewDetail.fone
        detailViewController.imgTemp = previewDetail.img
        
        // Define a altura da preview. A Largura (width) deve ser zero, porque estamos utilizando a
        // preview no modo retrato. A Altura (height) pode ser definida em 3 tamanhos: "Larger" cujo o
        // valor é 0.0 (ele é o default), "Medium" é 320.0 e "Small" é 160.
        detailViewController.preferredContentSize = CGSize(width: 0.0, height: 0.0)
        
        // Set do source rect para o frame da celula, os elementos ao redor terão blurred.
        previewingContext.sourceRect = cell.frame
        
        return detailViewController
    }
    
    // Exibe o View Controller da ação "Pop".
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        // Reusa a ViewController mostrada no "Peek" para ser apresentada.
        show(viewControllerToCommit, sender: self)
    }
}

//--------------------------------------------------------------------------------------------------

extension ViewController: AdicionarContatoDelegate {
    func adicionar(contato: Contato) {
        self.contatos.append(contato)
    }
}



