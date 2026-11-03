# Crypto Direction Predictor

**在线体验 · Live demo → https://xxxjjjhhhh.github.io/bitcoin-5m-betting-simulator/**

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

### 四个页面

| 页面 | 内容 |
|---|---|
| **行情** | K 线图（7 档周期）+ 预测面板 + 8 因子拆解 + 自动结算统计 |
| **买涨跌** | 二元合约模拟盘：实时价格曲线、结算倒计时、买涨/买跌/**插针**、赔率与期望值、庄家账本 |
| **庄家** | 庄家模拟器：10/50/100 个虚拟散户、行为偏差模型、情绪系统、返水与暗箱、历史回放 |
| **合约** | 永续合约终端：1–125x 杠杆、全仓/逐仓、市价限价止损、强平、资金费、网格、TWAP |

### 为什么好玩

不用真钱，但**该有的刺激一个都不少**：

- **押注**：选方向、选金额，看着赔率随盘口跳动，按下去那一刻的期待感是真的。
- **瞬间爆仓**：把金额拉到 MAX 全押一边，一分钟后反向 —— 余额直接归零。这种感觉在真实市场里要花真金白银才能买到，这里免费，而且可以重来。
- **被抽水磨死**：连续玩几十局，你会清楚看到余额不是被某一次大亏吃掉的，而是被每笔 1% 的价差一点点磨光的。
- **反过来当庄家**：切到「庄家」页，站到抽水的那一侧，看 50 个虚拟散户怎么把钱输给你 —— 或者在你把暗箱偏移调高之后，怎么一个个跑光。

零成本、零风险，但得出的结论是真的。

### 插针与「该不该接针」

买涨跌页多了一档玩法：**赌这个 5 分钟区间会不会被扎一针**，以及**扎了之后该不该接**。

- **插针线**：`2.0 × 每分钟波动`，区间开盘时冻结。区间内任意 30 秒窗口的振幅越过它就算插针，上下都算。
- **赔率**：单窗口概率用幂律拟合（正态分布在尾部会低估两个数量级），再按剩余时间累计。用 100 个真实区间标定，实测命中率 18%，模型 17.6%。
- **触发即收盘**：事件已经发生就不能再买，否则是白送钱。
- **立即判断**：随时点一下，用当前区间的量能、回吐、针尖距 15m 支撑的距离、1h 趋势给出四档结论（激进接针 / 等待二次确认 / 严禁接针 / 暂无插针）。
- **复制给 AI**：把上面这些真实数据填进一份完整的分析提示词，一键复制，粘给任意大模型继续深挖。

### 永续合约

「合约」页是一个完整的永续合约终端。

**行情（真实数据）**：标记价、指数价、基差、资金费率与结算倒计时、持仓量、多空账户比、1 分钟 K 线、全市场爆仓流，全部来自币安合约公开接口。

**账户（本地模拟）**：纯静态页面没有后端也没有密钥，下单不会真的送到交易所。但保证金、强平、资金费、手续费全部按币安规则算：

| 项目 | 规则 |
|---|---|
| 维持保证金率 | BTC 0.4% / ETH 0.5% / 其它 1% |
| 最大杠杆 | BTC 125x / ETH 100x / SOL·BNB·XRP 75x / 其它 50x |
| 手续费 | taker 0.05% / maker 0.02% |
| 资金费 | 取真实费率，演示中每分钟按 1/480 结算 |

**逐仓强平价** = `开仓价 × (1 ∓ 1/杠杆) / (1 ∓ 维持保证金率)`，实测与理论值误差为 0。逐仓爆仓最多亏掉该仓位的保证金，全仓则用整个账户兜底。

**订单**：市价 / 限价 / 止损，支持只减仓与 GTC/IOC/FOK/POST_ONLY。委托在离开合约页后仍会继续撮合。

**止盈止损**：开仓时可以直接带上，也可以事后在持仓行点「止盈止损」修改。触发价按标记价判断，触发后按市价平掉整个仓位。方向填反了会当场拦住，不会静默失败。

**K 线周期**：1m / 5m / 15m / 1h / 4h / 1d 六档，切换后重拉对应周期的合约 K 线。

**网格**：给定上下界和格数，在区间内均匀挂单，成交后自动在相邻格反向补单。

**TWAP**：把大单拆成 N 片，按时间匀速执行。

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
git clone https://github.com/xxxjjjhhhh/bitcoin-5m-betting-simulator.git
cd bitcoin-5m-betting-simulator
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
| **Trade** | Binary-contract paper trading: live price curve, settlement countdown, buy up/down/**wick**, odds & expected value, house ledger |
| **House** | House simulator: 10/50/100 virtual retail players, behavioural-bias models, mood system, rebate & hidden skew, historical replay |
| **Futures** | Perpetual terminal: 1–125x leverage, cross/isolated, market/limit/stop, liquidation, funding, grid, TWAP |

### Why it's fun

No real money, but **none of the thrill is missing**:

- **Placing a bet**: pick a side, pick an amount, watch the odds tick with the book, and feel that moment of anticipation as you click.
- **Instant liquidation**: slide the stake to MAX, put it all on one side, and watch it go the other way a minute later — balance straight to zero. In a real market that feeling costs real money; here it is free, and you can start over.
- **Ground down by the rake**: play a few dozen rounds and you will see plainly that the balance was not killed by one big loss, but worn away by 1% of spread on every single trade.
- **Switch to the house side**: open the House page and stand on the raking end instead — watch 50 virtual retail players hand you their money, or watch them all leave once you crank up the hidden skew.

Zero cost, zero risk, real conclusions.

### Wicks — and whether to catch them

The Trade page has one more market: **bet on whether this 5-minute interval gets wicked**, and **once it does, whether to catch it**.

- **Wick line**: `2.0 × per-minute volatility`, frozen when the interval opens. Any 30-second window whose range crosses it counts as a wick — either direction.
- **Odds**: single-window probability fitted as a power law (a normal distribution understates the tail by two orders of magnitude), then compounded over the remaining time. Calibrated on 100 real intervals: 18% observed, 17.6% modelled.
- **Closes on trigger**: once the wick happens the market shuts, otherwise buying at 0.99 would be free money.
- **Judge now**: one click, any time, scores volume, retrace, distance from the tip to 15m support, and the 1h trend into one of four verdicts (catch it / wait for retest / do not catch / no wick yet).
- **Copy for AI**: fills all of the above into a complete analysis prompt and copies it, ready to paste into any model.

### Perpetual futures

The Futures page is a full perpetual terminal.

**Market data (real)**: mark price, index price, basis, funding rate and countdown, open interest, long/short account ratio, 1m candles, and the market-wide liquidation feed — all from Binance's public futures API.

**Account (simulated locally)**: a static page has no backend and no keys, so orders never reach the exchange. Margin, liquidation, funding and fees are still computed by Binance's rules:

| Item | Rule |
|---|---|
| Maintenance margin | BTC 0.4% / ETH 0.5% / others 1% |
| Max leverage | BTC 125x / ETH 100x / SOL·BNB·XRP 75x / others 50x |
| Fees | taker 0.05% / maker 0.02% |
| Funding | real rate, settled at 1/480 per minute in the demo |

**Isolated liquidation price** = `entry × (1 ∓ 1/leverage) / (1 ∓ maintenance rate)` — verified to match theory exactly. An isolated position can only lose its own margin; cross uses the whole account.

**Orders**: market / limit / stop, with reduce-only and GTC/IOC/FOK/POST_ONLY. Resting orders keep matching after you leave the page.

**TP / SL**: attach them when opening, or edit later from the position row. Triggers use the mark price and close the whole position at market. A wrong-side price is rejected on the spot instead of failing silently.

**Timeframes**: 1m / 5m / 15m / 1h / 4h / 1d — switching reloads that interval's candles.

**Grid**: give it a range and a grid count, it quotes evenly and re-quotes the adjacent level after each fill.

**TWAP**: slices a large order into N parts over time.

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
git clone https://github.com/xxxjjjhhhh/bitcoin-5m-betting-simulator.git
cd bitcoin-5m-betting-simulator
```

Double-click `启动.bat` (starts a local server and opens a chrome-less window), or just open `index.html` in a browser.

> Opening via `file://` works too, but the browser restricts some local file reads.

### Data sources

Binance public endpoints — read-only, no API key, no trading:

- WebSocket `wss://data-stream.binance.vision` — live klines + aggTrades + 20-level depth
- REST `https://data-api.binance.vision` — historical klines, 24h stats, depth snapshots

**The page connects to Binance from the visitor's own browser.** If your network cannot reach Binance, you will see "market server connection failed" — you can still click "demo mode" to browse the UI with simulated data.
