# Neovim Config

WSL 上で使うことを前提にした Neovim 設定です。`lazy.nvim` でプラグインを管理し、見た目、LSP、補完、ファイラ、検索、Git 操作、基本的な編集補助をひと通り入れています。

## インストール

既存の設定がある場合は先に退避してください。

```sh
mv ~/.config/nvim ~/.config/nvim.bak
```

この設定を `~/.config/nvim` に配置します。

```sh
git clone <this-repository-url> ~/.config/nvim
```

Neovim を起動すると `lazy.nvim` が自動で bootstrap され、設定済みプラグインが読み込まれます。

```sh
nvim
```

プラグインを明示的に同期したい場合:

```vim
:Lazy sync
```

LSP サーバーは `mason.nvim` / `mason-lspconfig.nvim` で管理しています。現在は `lua_ls`, `pyright`, `ruff`, `ts_ls`, `vue_ls`, `zls` が自動インストール対象です。

```vim
:Mason
```

## 外部依存

最低限必要なもの:

- `nvim`
- `git`
- Nerd Font 対応フォント

あると使う機能:

- `lazygit`: `<leader>gg` で Neovim 内から lazygit を開く
- WSL + `powershell.exe`: Windows クリップボード連携
- Dev Containerを表示する端末のOSC 52対応: コンテナからWindowsへのyank連携
- `ripgrep`: `mini.pick` の grep 系検索で推奨

WSL では Windows 側クリップボードと同期します。通常の `y` が Windows クリップボードに入り、Windows 側でコピーした文字列も Neovim から貼り付けできます。日本語が文字化けしないよう、PowerShell 経由で UTF-8 を明示しています。

Dev Container内ではOSC 52を使い、通常の`y`をWindows側クリップボードへ送ります。多くの端末はセキュリティ上OSC 52によるクリップボード読み取りに対応しないため、Windowsからコンテナ内Neovimへ貼り付ける場合は、VS Code Terminalなら`Ctrl+Shift+V`、Windows Terminalなら`Ctrl+Shift+V`など端末側の貼り付け操作を使います。Neovimの`p`は内部レジスタの貼り付けとして動作します。

## 基本方針

- leader key は `Space`
- colorscheme は `solarized.nvim` の dark
- 行番号は絶対行番号 + 相対行番号
- カーソル行を強調表示
- `j` / `k` は折り返し表示行を考慮して移動
- terminal mode からは `<Esc><Esc>` で normal mode に戻る

## 主なキーマップ

ファイル操作:

| Key | Action |
| --- | --- |
| `-` | Oil で親ディレクトリを開く |
| `<leader>e` | Oil を開く |
| `l` | Oil 上でファイル/ディレクトリを開く |
| `h` | Oil 上で親ディレクトリへ移動 |

検索:

| Key | Action |
| --- | --- |
| `<leader>ff` | ファイル検索 |
| `<leader>fg` | live grep |
| `<leader>fb` | buffer 検索 |
| `<leader>fh` | help 検索 |
| `<leader>fo` | oldfiles |
| `<leader>fk` | keymaps |
| `<leader>fc` | commands |
| `<leader>fd` | current buffer diagnostics |
| `<leader>fD` | workspace diagnostics |
| `<leader>fs` | document symbols |

LSP:

| Key | Action |
| --- | --- |
| `gd` | 定義へ移動 |
| `gD` | 宣言へ移動 |
| `gr` | references |
| `gi` | implementation |
| `K` | hover |
| `<leader>rn` | rename |
| `<leader>ca` | code action |
| `<leader>ld` | line diagnostics |
| `[d` | 前の diagnostic |
| `]d` | 次の diagnostic |

補完:

| Key | Action |
| --- | --- |
| `Tab` | 補完候補を確定 |
| `<C-n>` | 次の候補 |
| `<C-p>` | 前の候補 |
| `Enter` | 補完せず改行 |

Git:

| Key | Action |
| --- | --- |
| `<leader>gg` | lazygit を開く |
| `<leader>gf` | 現在ファイル対象で lazygit を開く |

Treesitter:

| Key | Action |
| --- | --- |
| `<leader>ti` | InspectTree |
| `<leader>tc` | Inspect highlight capture |

その他:

| Key | Action |
| --- | --- |
| `<Esc><Esc>` | terminal mode から normal mode へ戻る |
| `j` / `k` | 折り返し表示行を考慮して上下移動 |

## 使っているプラグイン

管理:

- `folke/lazy.nvim`: plugin manager

見た目:

- `maxmx03/solarized.nvim`: colorscheme
- `nvim-lualine/lualine.nvim`: statusline
- `nvim-tree/nvim-web-devicons`: file icons
- `nvim-mini/mini.starter`: start screen

ファイル操作:

- `stevearc/oil.nvim`: file explorer

検索:

- `nvim-mini/mini.pick`: picker
- `nvim-mini/mini.extra`: additional pickers

LSP / 補完:

- `mason-org/mason.nvim`: external tool installer UI
- `mason-org/mason-lspconfig.nvim`: LSP server install / enable integration
- `neovim/nvim-lspconfig`: LSP configuration
- `saghen/blink.cmp`: completion
- `rafamadriz/friendly-snippets`: snippets

Syntax / 構文:

- `nvim-treesitter/nvim-treesitter`: syntax highlighting, indentation, folding

編集補助:

- `nvim-mini/mini.ai`: textobjects
- `nvim-mini/mini.surround`: surround 操作
- `nvim-mini/mini.pairs`: auto pairs
- `nvim-mini/mini.comment`: comment 操作
- `nvim-mini/mini.cursorword`: カーソル下の単語を強調
- `nvim-mini/mini.indentscope`: 現在の indent scope を表示
- `nvim-mini/mini.diff`: git diff 表示
- `chentoast/marks.nvim`: mark を signcolumn に表示

Git:

- `kdheepak/lazygit.nvim`: Neovim 内で lazygit を開く
- `nvim-lua/plenary.nvim`: lazygit.nvim の依存

## Treesitter parser

現在自動インストール対象にしている parser:

- `bash`
- `css`
- `html`
- `javascript`
- `json`
- `lua`
- `markdown`
- `markdown_inline`
- `python`
- `query`
- `toml`
- `tsx`
- `typescript`
- `vim`
- `vimdoc`
- `vue`
- `yaml`
- `zig`

## LSP

現在の自動インストール対象:

- `lua_ls`
- `pyright`
- `ruff`
- `ts_ls`
- `vue_ls`
- `zls`

Python は `pyright` と `ruff` を同居させています。型チェックや補完は主に `pyright`、lint / import 周りは `ruff` が担当します。

Vue は `vue_ls` と `ts_ls` を hybrid mode で同居させています。Vue SFC のテンプレートやスタイルは主に `vue_ls`、JavaScript / TypeScript は `ts_ls` が担当します。

## メンテナンス

プラグイン更新:

```vim
:Lazy sync
```

LSP / formatter / linter など Mason 管理ツールの確認:

```vim
:Mason
```

設定を変更したあと、headless で起動確認する例:

```sh
nvim --headless +qa
```
