# 上传到 GitHub 的完整流程

这份文档对应仓库已经做好的状态：本地 `git` 仓库已初始化并完成首次提交。
剩下要做的只是「建远程仓库 + 推上去」。

---

## 0. 前置检查

```bash
git --version          # 需要 2.23 以上
git config --global user.name
git config --global user.email
```

如果后两条是空的，先设置（提交记录会带上这些信息）：

```bash
git config --global user.name "你的名字"
git config --global user.email "你的邮箱"
```

---

## 1. 在 GitHub 上创建空仓库

1. 打开 https://github.com/new
2. **Repository name** 填 `crypto-direction-predictor`（随便起）
3. 选 **Public** 或 **Private**
4. **不要**勾选 "Add a README file"、"Add .gitignore"、"Choose a license"
   —— 本地已经有这些文件了，勾了会在推送时冲突
5. 点 **Create repository**

创建完页面会显示一段命令，形如：

```
git remote add origin https://github.com/<你的用户名>/crypto-direction-predictor.git
git branch -M main
git push -u origin main
```

---

## 2. 关联远程仓库并推送

在本项目目录下执行：

```bash
cd /d/BitcoinPredictor

# 关联远程仓库（origin 是给这个地址起的别名）
git remote add origin https://github.com/<你的用户名>/crypto-direction-predictor.git

# 把默认分支从 master 改名成 main（GitHub 现在的默认叫法）
git branch -M main

# 第一次推送，-u 表示记住这个对应关系，以后直接 git push 就行
git push -u origin main
```

推送时会要求认证。GitHub 从 2021 年起**不再支持账号密码**，必须用下面两种之一。

---

## 3. 认证方式（二选一）

### 方式 A：Personal Access Token（HTTPS，最简单）

1. 打开 https://github.com/settings/tokens
2. **Generate new token** → **Generate new token (classic)**
3. Note 随便填，Expiration 选 90 天
4. 勾选 **repo** 这一项（整个大类的勾）
5. 点 **Generate token**，把 `ghp_xxxxxxxx` 复制下来（**只显示一次**）

推送时：
- Username：你的 GitHub 用户名
- Password：**粘贴刚才那个 token**（不是账号密码）

想免去每次输入：

```bash
git config --global credential.helper manager
```

Windows 会弹窗让你输一次，之后存进系统凭据管理器。

### 方式 B：SSH 密钥（一次配置，长期免密）

```bash
# 1. 生成密钥（一路回车即可）
ssh-keygen -t ed25519 -C "你的邮箱"

# 2. 复制公钥内容
cat ~/.ssh/id_ed25519.pub
```

把输出的整段内容粘贴到 https://github.com/settings/keys → **New SSH key**。

```bash
# 3. 测试
ssh -T git@github.com

# 4. 把远程地址改成 SSH 形式
git remote set-url origin git@github.com:<你的用户名>/crypto-direction-predictor.git
```

---

## 4. 日常流程（以后每次改代码）

```bash
git status                 # 看哪些文件改了
git diff                   # 看具体改了什么

git add index.html         # 暂存指定文件
git add -A                 # 或暂存全部改动

git commit -m "fix: 修正区间模式的倒计时"    # 提交到本地
git push                   # 推到 GitHub
```

三条命令记住就够用：**add → commit → push**。

---

## 5. 这个仓库特意排除的文件

`.gitignore` 里已经写好，这些不会被上传：

| 文件 | 原因 |
|---|---|
| `model/*.csv` | 行情原始数据，单个 42MB，10 个币种 400MB+，可用脚本重拉 |
| `model/*.joblib` | sklearn 二进制模型，可由 `train.py` 重新生成 |
| `__pycache__/`、`*.pyc` | Python 缓存 |
| `_*.png`、`_*.js` | 临时测试文件 |

如果哪天误把大文件提交了：

```bash
git rm --cached model/btc_1m.csv     # 只从版本控制移除，本地文件保留
git commit -m "chore: 移除大文件"
```

> 注意：如果大文件已经被 push 过，光 `git rm` 不够，历史里还在。
> 这种情况要用 `git filter-repo` 重写历史，或者直接删仓库重建。

---

## 6. 常见问题

**Q: 推送报 `rejected - non-fast-forward`**
远程有你本地没有的提交（通常是建仓库时勾了 README）。先拉下来合并：

```bash
git pull --rebase origin main
git push
```

**Q: 中文文件名显示成 `\344\275\277\347\224\250...`**
只是终端的转义显示，不影响内容。想看清楚：

```bash
git config --global core.quotepath false
```

**Q: 每次提交都提示 `LF will be replaced by CRLF`**
Windows 换行符警告，无害。想统一：

```bash
git config --global core.autocrlf true
```

**Q: 不想用命令行**
装 [GitHub Desktop](https://desktop.github.com/)，图形界面做同样的事：
Add local repository → 选 `D:\BitcoinPredictor` → Publish repository。

---

## 7. 推上去之后可以做什么

- **GitHub Pages 直接托管**：仓库 Settings → Pages → Source 选 `main` / `root`
  → 得到一个 `https://<用户名>.github.io/<仓库名>/` 的在线地址
  （注意：模型 JSON 是相对路径，能正常加载；但访客浏览器要能连上币安）
- **Actions 自动跑训练**：把 `model/train_coins.py` 挂到定时任务，每天自动更新模型
- **Release 发版**：打 tag（`git tag v1.0 && git push --tags`），打包 zip 供下载
