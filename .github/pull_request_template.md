## 📝 概要

**変更内容の概要を一行で記載**
<!-- このPRで何をしたのか、簡潔に書いてください -->

### 目的

<!-- 変更目的を書いてしてください。 -->

### 背景

<!-- 変更に至った経緯や背景を書いてしてください。 -->

### 期待する動作

<!-- 変更による期待する動作を書いてしてください。 -->

## 🛠️ 変更内容

<!-- 具体的な変更箇所や修正内容を箇条書きで書いてください -->
- 
- 

## 🧪 テスト・動作確認
<!-- 動作確認した内容や、確認に使用した環境を書いてください -->
- [ ] 


### 証跡
<!-- 動作確認した際の証跡がある場合は、書いてください -->

<!-- 例： -->
- テスト実行前に、既に出力されていたログはバックアップを取り、削除しました。

| No. | テスト項目 | 操作 | 期待する動作 | 結果(OK/NG) | スクリーンショット |
|:--|:--|:--|:--|:--|:--|
| 1 | 機能Aの実行 | パラメーターに1<=N<100の任意の自然数を指定して機能Aを実行 | 正常に実行されること | OK | <img src="https://raw.githubusercontent.com/lepra-sekine/.github/refs/heads/main/.github/imgs/sample_window.png" alt="sample window" /> |
| 2 | 機能Aの実行 | パラメーターに`1`を指定して機能Aを実行 | 正常に実行されること | OK | <img src="https://raw.githubusercontent.com/lepra-sekine/.github/refs/heads/main/.github/imgs/sample_window.png" alt="sample window" /> |
| 3 | 機能Aの実行 | パラメーターに`99`を指定して機能Aを実行 | 正常に実行されること | OK | <img src="https://raw.githubusercontent.com/lepra-sekine/.github/refs/heads/main/.github/imgs/sample_window.png" alt="sample window" /> |
| 4 | 機能Aの実行 | パラメーターに`0`を指定して機能Aを実行 | 「不正な入力です」とエラーメッセージが表示され、機能Aが実行されないこと | OK | <img src="https://raw.githubusercontent.com/lepra-sekine/.github/refs/heads/main/.github/imgs/sample_window.png" alt="sample window" /> |
| 5 | 機能Aの実行 | パラメーターに`100`を指定して機能Aを実行 | 「不正な入力です」とエラーメッセージが表示され、機能Aが実行されないこと | OK | <img src="https://raw.githubusercontent.com/lepra-sekine/.github/refs/heads/main/.github/imgs/sample_window.png" alt="sample window" /> |
| 6 | 機能Aの実行 | パラメーターに`0.99`を指定して機能Aを実行 | 「不正な入力です」とエラーメッセージが表示され、機能Aが実行されないこと | OK | <img src="https://raw.githubusercontent.com/lepra-sekine/.github/refs/heads/main/.github/imgs/sample_window.png" alt="sample window" /> |
| 7 | 機能Aの実行 | パラメーターに`99.9`を指定して機能Aを実行 | 「不正な入力です」とエラーメッセージが表示され、機能Aが実行されないこと | OK | <img src="https://raw.githubusercontent.com/lepra-sekine/.github/refs/heads/main/.github/imgs/sample_window.png" alt="sample window" /> |
| 8 | 機能Aの実行 | パラメーターに`-1`を指定して機能Aを実行 | 「不正な入力です」とエラーメッセージが表示され、機能Aが実行されないこと | OK | <img src="https://raw.githubusercontent.com/lepra-sekine/.github/refs/heads/main/.github/imgs/sample_window.png" alt="sample window" /> |
| 9 | 機能Aの実行 | パラメーターに`test`を指定して機能Aを実行 | 「不正な入力です」とエラーメッセージが表示され、機能Aが実行されないこと | OK | <img src="https://raw.githubusercontent.com/lepra-sekine/.github/refs/heads/main/.github/imgs/sample_window.png" alt="sample window" /> |
| 10 | 機能Aのログ | No.1~No.9までのテストを実施 | ログに下記のみ記載されていること<br><pre><code>Y-m-d H:i:s FunctionA - insert (1)<br>Y-m-d H:i:s FunctionA - insert (99)</code></pre> | OK | <img src="https://raw.githubusercontent.com/lepra-sekine/.github/refs/heads/main/.github/imgs/sample_window.png" alt="sample window" /> |

## 🔗 関連Issue

<!-- 関連するIssueがあればリンクを貼ってください（例: #12） -->
- Fixes #
