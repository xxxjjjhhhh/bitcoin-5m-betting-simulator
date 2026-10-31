# Crypto Direction Predictor

**在线体验 · Live demo → https://xxxjjjhhhh.github.io/BitcoinPredictor/**

[简体中文](#简体中文) · [English](#english)

---

## ⚠️ 免责声明 · Disclaimer

> **本项目不构成任何投资建议。**
>
> - 这是一个**技术演示项目**，用于学习和研究，不是交易工具，也不是荐币服务。
> - 加密货币价格波动极大，**任何依据本工具做出的决策及其产生的盈亏，与作者完全无关**。作者不承担任何直接或间接责任。
> - 页面上的「预测概率」是对公开历史数据的统计计算，**不具备预测未来的能力**。实测 1 分钟方向命中率约 52.7%，扣除手续费后无法覆盖成本。
> - 模拟盘使用的是**虚拟资金**，不涉及任何真实资产。
> - 使用本项目即表示你已阅读并接受上述条款。如不同意，请立即停止使用。

> **This project is NOT investment advice.**
>
> - It is a **technical demo** for learning and research — not a trading tool, not a signal service.
> - Crypto assets are extremely volatile. **Any decision you make based on this tool, and any resulting profit or loss, has nothing to do with the author.** The author accepts no liability, direct or indirect.
> - The "probabilities" shown are statistical calculations over public historical data and **cannot predict the future**. Measured hit rate on 1-minute direction is about 52.7% — below the cost of trading fees.
> - The paper-trading account uses **virtual funds only**. No real assets are involved.
> - By using this project you accept the terms above. If you do not agree, stop using it immediately.

---

## 简体中文

### 这是什么

一个零依赖的单文件网页应用，直连币安公共行情接口，实时展示 K 线、盘口和逐笔成交。

它真正有意思的地方是：**让你在没有真实资金风险的前提下，完整体验一遍预测市场的运作方式** —— 下注、看赔率、等结算、被价差抽水、盯着余额慢慢变少，最后自己判断「这东西到底能不能赢」。

不是让你照着它去交易，而是让你亲眼看到为什么大多数人在这种产品里是亏的。

### 三个页面

| 页面 | 内容 |
|---|---|
| **行情** | K 线图（7 档周期）+ 预测面板 + 8 因子拆解 + 自动结算统计 |
| **买涨跌** | 二元合约模拟盘：实时价格曲线、结算倒计时、买涨/买跌、赔率与期望值、庄家账本 |
| **庄家** | 庄家模拟器：10/50/100 个虚拟散户、行为偏差模型、情绪系统、返水与暗箱、历史回放 |

### 能玩出什么

- **看价差怎么吃掉你**：每笔交易付 1% 价差，玩几十局后余额明显下滑，哪怕方向猜得还行。
- **看「高赔率」的陷阱**：庄家每份固定赚 0.01，换算成占本金的比例是 `0.01 ÷ 价格`。价格 0.10（10 倍赔率）时抽水 10%，是 0.50 时的 5 倍。
- **看散户的行为偏差**：庄家页里 55% 的玩家追涨、30% 犯赌徒谬误、15% 随机。连涨之后你能看到两拨人押注方向完全相反。
- **看庄家怕什么**：价差设 2% 跑二十局，累计期望稳定向上；但只要散户整体命中率到 51%，2% 的抽水就被吃穿了。

### 功能

- **10 个币种**：BTC / ETH / SOL / BNB / XRP / DOGE / ADA / AVAX / LINK / TRX
- **7 档图表周期**：1m / 5m / 15m / 30m / 1h / 4h / 1d，长周期实时增量合并
- **3 种预测模式**：1 分钟 / 5 分钟整点 / 区间（5m·15m·1h 内持续更新）
- **5 种语言**：简体中文 / English / 日本語 / 한국어 / Русский
- **接口区域**：全球站（binance.com）/ 美国站（binance.us）
- **断网降级**：推送断开自动重连 → REST 轮询 → 完全断网可进演示模式

### 本地运行

```bash
git clone https://github.com/xxxjjjhhhh/BitcoinPredictor.git
cd BitcoinPredictor
```

双击 `启动.bat`（自动起本地服务并用无地址栏窗口打开），或直接用浏览器打开 `index.html`。

> 用 `file://` 直接打开也能用，只是浏览器会限制部分本地文件读取。

### 数据来源

币安公共行情接口，只读、不需要 API Key、不涉及任何交易：

- WebSocket `wss://data-stream.binance.vision` — 实时 K 线 + 逐笔成交 + 20 档盘口
- REST `https://data-api.binance.vision` — 历史 K 线、24h 统计、深度快照

**页面是访客浏览器直连币安的。** 如果你的网络访问不了币安，会看到「行情服务器连接失败」，可以点「演示模式」用模拟数据看界面。

---

## English

### What is this

A zero-dependency, single-file web app that connects directly to Binance's public market-data endpoints and renders live candles, order book and trades.

The interesting part: **it lets you experience how a prediction market actually works, without risking real money** — place bets, watch the odds, wait for settlement, get eaten by the spread, and watch your balance slowly bleed until you decide for yourself whether this game is beatable.

It is not meant to be traded on. It is meant to show you, first-hand, why most people lose money in these products.

### Three pages

| Page | Contents |
|---|---|
| **Market** | Candlestick chart (7 timeframes) + prediction panel + 8-factor breakdown + auto-settled stats |
| **Trade** | Binary-contract paper trading: live price curve, settlement countdown, buy up/down, odds & expected value, house ledger |
| **House** | House simulator: 10/50/100 virtual retail players, behavioural-bias models, mood system, rebate & hidden skew, historical replay |

### Things you can discover

- **How the spread eats you**: every trade pays a 1% spread. After a few dozen rounds the balance visibly declines, even if your direction calls are okay.
- **The high-odds trap**: the house earns a fixed 0.01 per share, which as a fraction of your stake is `0.01 ÷ price`. At price 0.10 (10x odds) the rake is 10% — five times what it is at 0.50.
- **Retail behavioural bias**: in the house page, 55% of players chase trends, 30% fall for the gambler's fallacy, 15% are random. After a winning streak you can watch the two camps bet in opposite directions.
- **What the house fears**: run 20 rounds at a 2% spread and the expected P&L climbs steadily — but if the crowd's overall hit rate reaches 51%, the 2% rake is completely eaten.

### Features

- **10 symbols**: BTC / ETH / SOL / BNB / XRP / DOGE / ADA / AVAX / LINK / TRX
- **7 chart timeframes**: 1m / 5m / 15m / 30m / 1h / 4h / 1d, with live incremental aggregation
- **3 prediction modes**: 1-minute / 5-minute on the clock / interval (rolling inside 5m·15m·1h)
- **5 languages**: 简体中文 / English / 日本語 / 한국어 / Русский
- **API region**: global (binance.com) / US (binance.us)
- **Graceful degradation**: WebSocket reconnect → REST polling → demo mode when fully offline

### Run locally

```bash
git clone https://github.com/xxxjjjhhhh/BitcoinPredictor.git
cd BitcoinPredictor
```

Double-click `启动.bat` (starts a local server and opens a chrome-less window), or just open `index.html` in a browser.

> Opening via `file://` works too, but the browser restricts some local file reads.

### Data sources

Binance public endpoints — read-only, no API key, no trading:

- WebSocket `wss://data-stream.binance.vision` — live klines + aggTrades + 20-level depth
- REST `https://data-api.binance.vision` — historical klines, 24h stats, depth snapshots

**The page connects to Binance from the visitor's own browser.** If your network cannot reach Binance, you will see "market server connection failed" — you can still click "demo mode" to browse the UI with simulated data.
