//
//  MachinesListViewController.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import UIKit

class MachinesListViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet private weak var leftBarView: DashboardBarView! {
        didSet {
            configureLeftBarView()
        }
    }
    
    @IBOutlet private weak var filterView: FilterView! {
        didSet {
            configureFilterView()
        }
    }
    
    @IBOutlet private weak var searchView: SearchView! {
        didSet {
            configureSearchView()
        }
    }
    
    @IBOutlet private weak var menuView: MenuView! {
        didSet {
            menuView.display(items: [.connect, .menu, .global])
            menuView.handler = { [weak self] type in
                self?.handleMenuButton(ofType: type)
            }
        }
    }
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            configureTableView()
        }
    }
    
    //MARK: Properites
    private var defaultState = TableState<MachineModel.ViewModel>.loading
    private var state = TableState<MachineModel.ViewModel>.loading {
        didSet {
            if case .populated = state {
                defaultState = state
            } else if case .paging = state {
                defaultState = state
            }
            tableView.setFooterView(forState: state)
            tableView.reloadData()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMachinesAtPage(page: 0)
    }

}

//MARK: - Configurations
private extension MachinesListViewController {
    
    func configureLeftBarView() {
        leftBarView.displayLogoImage(name: .ray, cornerRadius: 10)
        leftBarView.displayUserImage(name: .ray, circleCorner: true)
        leftBarView.displayBarBackground(color: .blueGray)
        leftBarView.handler = { [weak self] in
            self?.handleProfileButton()
        }
    }
    
    func configureSearchView() {
        searchView.display(placeholder: "Search")
        searchView.setAutocorrectionType(.no)
        searchView.setAutocapitalizationType(.none)
        searchView.displayBar(color: .darkGray)
        
        searchView.textHandler = { [weak self] text in
            self?.handleSearchBar(text: text)
        }
        
        searchView.actionHandler = { [weak self] type, searchBar in
            self?.handleSearchBar(searchBar, actionType: type)
        }
    }
    
    func configureFilterView() {
        filterView.displayFitler(title: "Filter by")
        filterView.displayFitlerItems([
            FilterViewModel(title: "All", type: .all, isSelected: true),
            FilterViewModel(title: "Active", type: .active),
            FilterViewModel(title: "Down", type: .down),
            FilterViewModel(title: "All Locations", type: .allLocations)
            ])
        
        filterView.handler = { [weak self] type in
            self?.handleFilter(type: type)
        }
    }
    func configureTableView() {
        tableView.register(headerFooterView: TableViewHeader.self)
        tableView.register(MachineCell.self)
        tableView.setupHeaderHeight()
        tableView.backgroundColor = Color.gray.rawValue
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func configureMachineCell(_ cell: MachineCell, at indexPath: IndexPath) {
        let machine = state.items[indexPath.row]
        cell.update(selectionStyle: .none)
        cell.display(backgroundColor: .gray)
        cell.displayImage(name: .switch)
        cell.display(country: machine.country)
        cell.display(model: machine.model)
        cell.display(ipAddress: machine.ipAddress)
        cell.display(macAddress: machine.macAddress)
        cell.setOptionButtonCircleCornerEnabled()
        cell.setStatusCircleCornerEnabled()
        cell.updateOption(items: machine.options)
        cell.displayStatusCircle(color: machine.status.color)
        
        let redItems = state.items.filter({ $0.status.id == 4 })
        menuView.display(counter: "\(redItems.count)")
        
        if machine.status.id == 4 {
            cell.displayStatusMessage(
                message: machine.status.message,
                color: machine.status.color
            )
        } else {
            cell.setStatusMessageHidden(true)
        }
        
        cell.optionHandler = { [weak self] button, index in
            guard let strongSelf = self else { return }
            strongSelf.handleMachineOption(button: button, selectedIndex: index)
        }
    }
}

//MARK: - Actions
private extension MachinesListViewController {
    
    func handleMachineOption(button: UIButton, selectedIndex: Int) {
        
        guard let indexPath = button.indexPath(tableView) else { return }
        
        let machine = state.items[indexPath.row]
        
        let option = machine.options[selectedIndex]
        
        option.isSelected = !option.isSelected
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func handleSearchBar(text: String) {
        if text.isBlank {
            state = defaultState
        } else {
            let items = defaultState.items.filter({
                return $0.country.lowercased().contains(text.lowercased()) ||
                    $0.model.lowercased().contains(text.lowercased()) ||
                    $0.ipAddress.lowercased().contains(text.lowercased())
            })
            state = items.count == 0 ? .error("No Results Found :("): .filtered(items)
        }
    }
    
    func handleSearchBar(_ searchBar: UISearchBar, actionType: SearchView.ActionType) {
        if actionType == .search {
            searchBar.resignFirstResponder()
        } else {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            state = defaultState
        }
        
    }
    
    func handleFilter(type: FilterViewModel.ButtonType) {
        print(type)
    }
    
    func handleMenuButton(ofType type: MenuButtonType) {
        print(type)
    }
    
    func handleProfileButton() {
        print("Profile Button Tapped")
    }
}

//MARK: - UITableViewDataSource
extension MachinesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MachineCell = tableView.dequeueReusableCell(at: indexPath)
        
        configureMachineCell(cell, at: indexPath)
        
        if case .paging(_, let nextPage) = state,
            indexPath.row == state.items.count - 3 {
            displayMachinesAtPage(page: nextPage)
        }
        
        return cell
    }
}


//MARK: - UITableViewDelegate
extension MachinesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch state {
        case .populated:
            let header: TableViewHeader = tableView.dequeueReusableHeaderFooterView()
            header.display(backgroundColor: .gray)
            header.display(title: "All Servers")
            return header
        default:
            return UIView(frame: .zero)
        }
        
    }
}

//MARK: - API
private extension MachinesListViewController {
    
    func displayMachinesAtPage(page: Int) {
        
        let apiClient: APIClient = AlamofireAPIClient()
        
        let gateway: MachineGateway = APIMachineGateway(apiClient: apiClient)
        
        let request = MachineRequest(page: page, size: 10)
        
        gateway.fetchMachines(request) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let value):
                
                var allItems = strongSelf.state.items
                
                allItems.append(contentsOf: value.viewModels)
                
                if value.page.hasMorePages {
                    strongSelf.state = .paging(allItems, next: value.page.nextPage)
                } else {
                    strongSelf.state = .populated(allItems)
                }

            case .failure(let message):
                strongSelf.state = .error(message)
            }
        }
    }
    
}
