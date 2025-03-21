//
//  FavoriteCoinRepository.swift
//  Het-Je-iOS
//
//  Created by 박신영 on 3/10/25.
//

import Foundation

import RealmSwift

protocol FavoriteCoinRepositoryProtocol {
    func getFileURL()
    func fetchAll() -> Results<FavoriteCoinTable>
    func createItem(data: FavoriteCoinTable, handler: @escaping (Bool) -> Void)
    func deleteItem(data: FavoriteCoinTable, handler: @escaping (Bool) -> Void)
    func checkFavoriteCoin(list: Results<FavoriteCoinTable>, currentCoinId: String) -> Bool
    func getFavoriteCoinDataByCoinId(list: Results<FavoriteCoinTable>, currentCoinId: String) -> FavoriteCoinTable?
//    func updateItem(data: FavoriteCoinTable)
}

// Realm CRUD
final class FavoriteCoinRepository: FavoriteCoinRepositoryProtocol {
   
    //realm에 접근
    private let realm = try! Realm() //default.realm
    
    func getFileURL() {
        print(realm.configuration.fileURL ?? "getFileURL Error", "getFileURL")
    }
    
    func fetchAll() -> Results<FavoriteCoinTable> {
        return realm.objects(FavoriteCoinTable.self)
    }
    
    //Create
    func createItem(data: FavoriteCoinTable, handler: @escaping (Bool) -> Void) {
        do {
            try realm.write {
                realm.add(data)
                print("realm 저장 성공한 경우")
                handler(true)
            }
        } catch {
            print("realm 저장이 실패한 경우")
            handler(false)
        }
    }
    
    //Delete
    func deleteItem(data: FavoriteCoinTable, handler: @escaping (Bool) -> Void) {
        do {
            try realm.write {
                realm.delete(data)
                print("realm 데이터 삭제 성공")
                handler(true)
            }
        } catch {
            print("realm 데이터 삭제 실패")
            handler(false)
        }
    }
    
    func getFavoriteCoinDataByCoinId(list: Results<FavoriteCoinTable>, currentCoinId: String) -> FavoriteCoinTable? {
        if let data = list.filter("coinId == %@", currentCoinId).first {
            return data
        } else {
            return nil
        }
    }
    
    //
    func checkFavoriteCoin(list: Results<FavoriteCoinTable>, currentCoinId: String) -> Bool {
        if list.filter("coinId == %@", currentCoinId).first != nil {
            return true
        } else {
            return false
        }
    }
    
    //Update
//    func updateItem(data: FavoriteCoinTable) {
//        do {
//            try realm.write {
//                realm.create(FavoriteCoinTable.self, value: ["id": data.id, "'업데이트 할 변수'": '값']], update: .modified)
//            }
//        } catch {
//            print("realm 데이터 삭제 실패")
//        }
//    }
    
    
    //추후 폴더로 코인, nft 등을 추가할 때 사용하면 좋을듯
//    func createItemInFolder(folder: FolderTable, data: FavoriteCoinTable) {
//        do {
//            try realm.write {
//                folder.detail.append(data)
//                print("realm 저장 성공한 경우")
//            }
//        } catch {
//            print("realm 저장이 실패한 경우")
//        }
//    }
    
}

