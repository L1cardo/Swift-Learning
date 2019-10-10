import UIKit

class ViewController: UIViewController {
    let questions = [
        Question(text: "马云是中国首富", correctAnswer: true),
        Question(text: "刘强东最早是在中关村卖光盘的", correctAnswer: true),
        Question(text: "苹果公司是目前世界上最牛的科技公司", correctAnswer: true),
        Question(text: "只要坚持下去就能学好代码", correctAnswer: true),
        Question(text: "王思聪是80后", correctAnswer: true),
        Question(text: "在国内能正常访问google.com", correctAnswer: false),
        Question(text: "敲完1万行代码之后可以成为编程高手", correctAnswer: true),
        Question(text: "撒贝宁说过清华还行", correctAnswer: false),
        Question(text: "一直努力学习编程就可以成为大牛", correctAnswer: true),
        Question(text: "网上说苹果不好用安卓好用的人大多数是水军", correctAnswer: true),
        Question(text: "豆瓣网是一个和你分享刚编的故事的网站", correctAnswer: false),
        Question(text: "优酷比B站牛", correctAnswer: false),
        Question(text: "我很帅", correctAnswer: true),
    ]

    // 问题序号
    var questionNum = 0
    var score = 0

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet var progressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[questionNum].questionText
    }

    @IBAction func answerPressed(_ sender: UIButton) {
        checkAnswer(tag: sender.tag)
        questionNum += 1
        nextQuestion()
        updateUI()
    }

    // 更新界面视图
    func updateUI() {
        progressLabel.text = "\(questionNum + 1)/13"
        progressBar.frame.size.width = (view.frame.width / 13) * CGFloat(questionNum + 1)
    }

    // 控制器获取下一个问题
    func nextQuestion() {
        if questionNum <= 12 {
            questionLabel.text = questions[questionNum].questionText
        } else {
            startOver()
        }
    }

    // 判断答案正确与错误
    func checkAnswer(tag: Int) {
        if tag == 1 {
            if questions[questionNum].answer == true {
                score += 1
                scoreLabel.text = "总得分：\(score)"
                noticeSuccess("答对啦！", autoClear: true, autoClearTime: 1)
            } else {
                noticeError("答错啦！", autoClear: true, autoClearTime: 1)
            }
        } else {
            if questions[questionNum].answer == true {
                noticeError("答错啦！", autoClear: true, autoClearTime: 1)
            } else {
                score += 1
                scoreLabel.text = "总得分：\(score)"
                noticeSuccess("答对啦！", autoClear: true, autoClearTime: 1)
            }
        }
    }

    // 重新开始
    func startOver() {
        questionNum = 0
        score = 0

        // 弹出框
        let alert = UIAlertController(title: "漂亮！", message: "您已完成所有的问题，再来一遍吧！", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "再来一遍", style: .default, handler: { _ in
            self.questionLabel.text = self.questions[0].questionText
            self.scoreLabel.text = "总得分：0"
            self.updateUI()
        }))
        present(alert, animated: true, completion: nil)
    }
}
