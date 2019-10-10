import AVFoundation
import UIKit

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    let songs = ["note1", "note2", "note3", "note4", "note5", "note6", "note7"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
        play(tag: sender.tag)
    }

    // 创建发出声音的功能函数
    func play(tag: Int) {
        let url = Bundle.main.url(forResource: songs[tag - 1], withExtension: "wav")

        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player.play()
        } catch {
            print(error)
        }
    }
}
