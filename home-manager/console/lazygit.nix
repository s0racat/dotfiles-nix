{
  programs.lazygit = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      gui.language = "ja";
      os.editPreset = "nvim";
      git.parseEmoji = true;
      customCommands = [
        {
          key = "C";
          command = ''git commit -m "{{ .Form.Type }}{{if .Form.Scopes}}({{ .Form.Scopes }}){{end}}: {{ .Form.Description }}"'';
          description = "commitizen でコミットする";
          context = "files";
          prompts = [
            {
              type = "menu";
              title = "コミットする変更の種類を選んでください。";
              key = "Type";
              options = [
                {
                  name = "Feature";
                  description = "新しい機能";
                  value = "feat";
                }
                {
                  name = "Fix";
                  description = "バグ修正";
                  value = "fix";
                }
                {
                  name = "Documentation";
                  description = "ドキュメントのみの変更";
                  value = "docs";
                }
                {
                  name = "Styles";
                  description = "コードの意味に影響しない変更（空白、フォーマット、セミコロンの追加漏れなど）";
                  value = "style";
                }
                {
                  name = "Code Refactoring";
                  description = "バグ修正や機能追加ではないコードの変更";
                  value = "refactor";
                }
                {
                  name = "Performance Improvements";
                  description = "パフォーマンスを向上させるコード変更";
                  value = "perf";
                }
                {
                  name = "Tests";
                  description = "不足しているテストの追加や既存テストの修正";
                  value = "test";
                }
                {
                  name = "Builds";
                  description = "ビルドシステムや外部依存関係に影響する変更（例: gulp, broccoli, npm）";
                  value = "build";
                }
                {
                  name = "Continuous Integration";
                  description = "CI設定ファイルやスクリプトの変更（例: Travis, Circle, BrowserStack, SauceLabs）";
                  value = "ci";
                }
                {
                  name = "Chores";
                  description = "srcやtestファイルを変更しないその他の変更";
                  value = "chore";
                }
                {
                  name = "Reverts";
                  description = "前のコミットを取り消す";
                  value = "revert";
                }
              ];
            }
            {
              type = "input";
              title = "この変更のスコープ（範囲）を入力してください。";
              key = "Scopes";
            }
            {
              type = "input";
              title = "変更内容の短い説明を入力してください。";
              key = "Description";
            }
            {
              type = "confirm";
              title = "コミットメッセージは正しいですか？";
              body = "{{ .Form.Type }}{{if .Form.Scopes}}({{ .Form.Scopes }}){{end}}: {{ .Form.Description }}";
            }
          ];
        }
      ];
    };
  };
}
