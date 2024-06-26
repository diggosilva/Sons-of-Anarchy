//
//  CharacterViewController.swift
//  SonsOfAnarchy
//
//  Created by Diggo Silva on 25/03/24.
//

import UIKit
import SDWebImage

class CharacterViewController: UIViewController {
    lazy var viewModel = CharacterViewModel()
    lazy var characterView = CharacterView(viewModel: viewModel)
    
    override func loadView() {
        super.loadView()
        view = characterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        handleStates()
        viewModel.loadDataCharacters()
    }
    
    private func setNavBar() {
        title = "Sons Of Anarchy"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        characterView.delegate = self
    }
    
    @objc private func didTapAddButton() {
        let filterVC = FilterViewController(filters: viewModel.filters, delegate: self)
        navigationController?.pushViewController(filterVC, animated: true)
    }
    
    func handleStates() {
        viewModel.state.bind { state in
            switch state {
            case .loading:
                self.showLoadingState()
            case .loaded:
                self.showLoadedState()
            case .error:
                self.showErrorState()
            }
        }
    }
    
    func showLoadingState() {
        characterView.removeFromSuperview()
    }
    
    func showLoadedState() {
        characterView.collectionViewCharacters.reloadData()
        characterView.spinner.stopAnimating()
    }
    
    func showErrorState() {
        let alert = UIAlertController(title: "Ocorreu um erro!", message: "Tentar Novamente?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Sim", style: .default) { action in
            self.viewModel.loadDataCharacters()
        }
        let nok = UIAlertAction(title: "Não", style: .cancel) { action in
            self.characterView.errorLabel.isHidden = false
            self.characterView.spinner.stopAnimating()
        }
        alert.addAction(ok)
        alert.addAction(nok)
        present(alert, animated: true)
    }
}

extension CharacterViewController: FilterViewControllerDelegate {
    func didUpdateFilters(filters: [Filter]) {
        viewModel.updateChampions(filters: filters)
    }
}

extension CharacterViewController: CharacterViewDelegate {
    func goToDetails(id: Int) {
        let detailsVC = DetailsViewController(id: id)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
