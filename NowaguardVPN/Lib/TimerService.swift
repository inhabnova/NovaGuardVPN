import Foundation

enum TimerServiceResult {
    case error(String)
    case inProgress(String)
    case finish
}

protocol TimerServiceDelegate: AnyObject {
    func finish()
}

final class TimerService {
    
    private var timer: DispatchSourceTimer?
    private var totalSeconds: Int = 0
    
    static let shared = TimerService()
    
    private init() {}
    
    func startTimer(timeString: String, completion: @escaping (TimerServiceResult) -> Void ) {
        
        timer = DispatchSource.makeTimerSource(flags: [],
                                               queue: DispatchQueue(label: "serial.queue.TimerService"))
        
        let timeComponents = timeString.split(separator: ":").compactMap { Int($0) }
        guard timeComponents.count == 3 else {
            completion(.error("timeComponents. count == " + "\(timeComponents.count)" + "."))
            return
        }
        
        let hours = timeComponents[0]
        let minutes = timeComponents[1]
        let seconds = timeComponents[2]
        
        totalSeconds = hours * 3600 + minutes * 60 + seconds
        
        timer?.schedule(deadline: .now(), repeating: 1)
        timer?.setEventHandler(handler: { [weak self] in
            self?.updateTimer { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        })
        timer?.activate()
    }
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    private func updateTimer(completion: @escaping (TimerServiceResult) -> Void ) {
//        if totalSeconds > 0 {
            totalSeconds += 1
            
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds % 3600) / 60
            let seconds = totalSeconds % 60
            
            completion(.inProgress(String(format: "%02d:%02d:%02d", hours, minutes, seconds)))
//        } else {
//            timer?.cancel()
//            timer = nil
//            
//            completion(.finish)
//        }
    }
}
