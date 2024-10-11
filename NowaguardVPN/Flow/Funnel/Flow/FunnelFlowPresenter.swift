//
//  FunnelFlowPresenter.swift
//  GrowVPN
//
//  Created by Александр on 29.08.2024.
//

import Foundation
import StoreKit

protocol FunnelFlowPresenterDelegate: AnyObject {
    func funnelFlowDidEnterBackground(presenter: FunnelFlowPresenterInterface)
    func funnelFlowDidCaptureScreen(presenter: FunnelFlowPresenterInterface)
    func funnelFlowDidEndFlow(presenter: FunnelFlowPresenterInterface)
}

protocol FunnelFlowPresenterInterface: AnyObject {
    
    func viewDidLoad()
    func viewDidEnterBackground()
    func viewCaptureScreen()
    
    func nextIteration()
    func subscribe() async
    
}

class FunnelFlowPresenter {
    
    weak var view: FunnelFlowView?
    weak var delegate: FunnelFlowPresenterDelegate?
    
    private var funnelModel: FunnelModel
    private var currentOrder: Int = 0
    //    private let conversionInfo: [AnyHashable: Any]?
    
    init(view: FunnelFlowView, funnelModel: FunnelModel) {
        self.view = view
        self.funnelModel = funnelModel
        //        self.conversionInfo = AnalyticsValues.conversionInfo
    }
    
    @MainActor
    private func purchase(id: String) async {
        let productId = [id]
        self.view?.showHUD()
        
        do {
            if let product = try await Product.products(for: productId).first {
                
                let result = try await product.purchase()
                
                DispatchQueue.main.async {
                    self.view?.hideHUD()
                    
                    switch result {
                    case .success(let verificationResult):
                        self.trackSubscribeEvent()
                        UserDefaults.standard.set(true, forKey: "premium")
                        self.purchased()
                    default:
                        if let fail = self.funnelModel.failAlert {
                            self.view?.showRCAlert(alert: fail)
                        } else {
                            self.view?.showTryAgainError()
                        }
                    }
                }
                
            }
        } catch {
            print("error purchase \(id)")
        }
    }
    
}

extension FunnelFlowPresenter: FunnelFlowPresenterInterface {
    
    func viewDidLoad() {
        if let first = self.funnelModel.iterations.first {
            self.view?.initial(firstIteration: first)
        }
        
        //        self.sendEventFirstScreen()
    }
    
    func viewDidEnterBackground() {
        self.delegate?.funnelFlowDidEnterBackground(presenter: self)
    }
    
    func viewCaptureScreen() {
        self.delegate?.funnelFlowDidCaptureScreen(presenter: self)
    }
    
    func nextIteration() {
        let iteration = self.funnelModel.iterations[self.currentOrder]
        
        if iteration.key == "highRisk" {
            Task {
                await self.subscribe()
            }
            
            return
        }
        
        if currentOrder + 1 < self.funnelModel.iterations.count {
            self.currentOrder += 1
            let iteration = self.funnelModel.iterations[self.currentOrder]
            self.view?.show(iteration: iteration)
            
            if iteration.key == "highRisk" {
                //                self.sendEventPaywall()
            }
            
            if currentOrder + 1 == self.funnelModel.iterations.count {
                //                self.sendEventLastScreen()
            }
        } else {
            self.delegate?.funnelFlowDidEndFlow(presenter: self)
        }
    }
    
    func purchased() {
        //        self.sendEventSuccessfullPurchase()
        if currentOrder + 1 < self.funnelModel.iterations.count {
            self.currentOrder += 1
            let iteration = self.funnelModel.iterations[self.currentOrder]
            self.view?.show(iteration: iteration)
        }
    }
    
    func trackSubscribeEvent() {
        guard let subscriptionId = funnelModel.subscriptionId else {
            return
        }
        print("tracking subscribe \(Date().timeIntervalSince1970)")
        //        TODO
        //        ApiManager.shared.sendEvent(event: "subscribe",
        //                                    afStatus: AnalyticsValues.afStatus ?? "",
        //                                    product: subscriptionId,
        //                                    isFirstLaunch: AnalyticsValues.isFirstLaunch ?? true,
        //                                    af_data: self.conversionInfo ?? [AnyHashable: Any]()) { _ in }
    }
    
    @MainActor
    func subscribe() async {
        guard let subscriptionId = funnelModel.subscriptionId else {
            return
        }
        
        self.view?.showHUD()
        
        let productId = [subscriptionId]
        do {
            if let product = try await Product.products(for: productId).first {
                
                let result = try await product.purchase()
                
                DispatchQueue.main.async {
                    self.view?.hideHUD()
                    
                    switch result {
                    case .success(let verificationResult):
                        self.trackSubscribeEvent()
                        UserDefaults.standard.set(true, forKey: "premium")
                        self.purchased()
                    default:
                        if let fail = self.funnelModel.failAlert {
                            self.view?.showRCAlert(alert: fail)
                        } else {
                            self.view?.showTryAgainError()
                        }
                    }
                }
                
            }
        } catch {
            self.view?.hideHUD()
            print("error purchase \(subscriptionId)")
        }
        
        
        //        PurchaseService.purchase(subscriptionId) { [unowned self] result in
        //            self.view?.hideHUD()
        //
        //            switch result {
        //            case .success(let isPurchased):
        //                if isPurchased {
        //                    trackSubscribeEvent()
        //                    UserDefaults.standard.set(true, forKey: "premium")
        //                    self.purchased()
        //                    // Go To Main Screen
        //                }
        //            case .failure(let error):
        //                if let fail = self.funnelModel.failAlert {
        //                    self.view?.showRCAlert(alert: fail)
        //                } else {
        //                    self.view?.showTryAgainError()
        //                }
        //            }
        //        }
    }
    
    //    private func sendEventFirstScreen() {
    //        if self.funnelModel.identifier == 1 {
    //            AnalyticService.shared.sendEvent(.firstScreen1)
    //        } else if  self.funnelModel.identifier == 155 {
    //            AnalyticService.shared.sendEvent(.firstScreen2)
    //        }
    //    }
    //
    //    private func sendEventLastScreen() {
    //        if self.funnelModel.identifier == 1 {
    //            AnalyticService.shared.sendEvent(.lastScreen1)
    //        } else if  self.funnelModel.identifier == 155 {
    //            AnalyticService.shared.sendEvent(.lastScreen1)
    //        }
    //    }
    //
    //    private func sendEventSuccessfullPurchase() {
    //        if self.funnelModel.identifier == 1 {
    //            AnalyticService.shared.sendEvent(.sub1)
    //        } else if  self.funnelModel.identifier == 155 {
    //            AnalyticService.shared.sendEvent(.sub2)
    //        }
    //    }
    //
    //    private func sendEventPaywall() {
    //        if self.funnelModel.identifier == 1 {
    //            AnalyticService.shared.sendEvent(.sub1)
    //        } else if  self.funnelModel.identifier == 155 {
    //            AnalyticService.shared.sendEvent(.sub2)
    //        }
    //    }
    
}
