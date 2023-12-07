//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct JuiceMaker {
    enum JuiceMenu: String, CustomStringConvertible {
        case strawberry = "딸기 쥬스"
        case banana = "바나나 쥬스"
        case pineapple = "파인애플 쥬스"
        case kiwi = "키위 쥬스"
        case mango = "망고 쥬스"
        case strawberryBanana = "딸바 쥬스"
        case mangoKiwi = "망키 쥬스"
        
        var description: String {
            self.rawValue
        }
        
        fileprivate func receiveRecipes() -> [(requiredFruit: Fruit, requestedAmount: Int)] {
            var recipe: [(Fruit, Int)]
            
            switch self {
            case .strawberry:
                recipe = [(.strawberry, 16)]
            case .banana:
                recipe = [(.banana, 2)]
            case .kiwi:
                recipe = [(.kiwi, 3)]
            case .pineapple:
                recipe = [(.pineapple, 2)]
            case .mango:
                recipe = [(.mango, 3)]
            case .strawberryBanana:
                recipe = [(.strawberry, 10), (.banana, 1)]
            case .mangoKiwi:
                recipe = [(.mango, 2), (.kiwi, 1)]
            }
            return recipe
        }
    }
    
    enum JuiceMakingResult {
        case success(message: String)
        case failure(description: String)
    }
    
    let fruitStore: FruitStore
    
    func produce(_ menuName: JuiceMenu) -> JuiceMakingResult {
        let recipes = menuName.receiveRecipes()
        var outcomeCreated: JuiceMakingResult 
        
        do {
            try fruitStore.consumeStocks(recipes)
            
            let completeOrderMessage = "주문한 메뉴 나옴"
            outcomeCreated = .success(message: "\(menuName) \(completeOrderMessage)")
        } catch  FruitStore.InventoryError.inventoryError(description: let message) {
            outcomeCreated = .failure(description: message)
        } catch {
            outcomeCreated = .failure(description: "Error")
        }
        return outcomeCreated
    }
    
}

