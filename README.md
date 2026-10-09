<div align="center">

# 圣穹幽墟 · Sky Sanctum: The Hollow

**一款基于 Unreal Engine 5.6 的双人局域网联机 · 剧情向动作解谜游戏**

两名猎魔人受委托进入尘封百年的黑石修道院，调查全员失踪惨案，
在畸变横行的绝境中解谜求生，层层揭开教会秘辛。

`第三人称越肩视角` `双人协作` `密室压迫感` `宗教恐怖氛围` `UE 写实暗黑画质`

**👉 [点此下载游戏（Windows 64 位）](../../releases/latest) 👈**

</div>

---

## 下载与安装

游戏为 **免安装绿色版**，下载解压后双击即可运行，无需安装引擎或任何运行库依赖（如系统缺少 VC++ 运行库，压缩包内已附带）。

### 方式一：一键脚本（推荐）

下载仓库中的 [`download.bat`](download.bat)，放到任意空文件夹中双击运行。脚本会自动完成：

1. 从 Releases 下载全部 3 个分卷（支持断点续传，中途断了重跑即可）
2. 合并分卷并解压

解压完成后进入生成的 `Sky_Sanctum_The_Hollow` 文件夹，双击 `ArcheryBattle_5_6_1.exe` 即可开始游戏。

### 方式二：手动下载

1. 打开 **[Releases 页面](../../releases/latest)**，下载以下 **3 个分卷文件**（缺一不可）：

   | 文件 | 说明 |
   | --- | --- |
   | `Sky_Sanctum_The_Hollow_v1.0.0_Windows.zip.001` | 分卷 1 |
   | `Sky_Sanctum_The_Hollow_v1.0.0_Windows.zip.002` | 分卷 2 |
   | `Sky_Sanctum_The_Hollow_v1.0.0_Windows.zip.003` | 分卷 3 |

2. 把三个文件放在**同一个文件夹**里，合并成一个完整的 zip：

   - **装了 7-Zip**：直接右键 `.001` 文件 → 「7-Zip」→「提取到当前文件夹」，会自动识别后续分卷，**无需手动合并**。
   - **没装 7-Zip**：在文件夹地址栏输入 `cmd` 回车，执行下面这行命令合并，再用系统自带的解压功能解压：

     ```bat
     copy /b Sky_Sanctum_The_Hollow_v1.0.0_Windows.zip.001+Sky_Sanctum_The_Hollow_v1.0.0_Windows.zip.002+Sky_Sanctum_The_Hollow_v1.0.0_Windows.zip.003 Sky_Sanctum_The_Hollow_v1.0.0_Windows.zip
     ```

3. 解压得到的文件夹里双击 `ArcheryBattle_5_6_1.exe` 开始游戏。

> **为什么要分卷？** GitHub 单个附件有 2GB 上限，游戏本体约 4.6GB，因此切成 3 卷。

---

## 运行说明

| 步骤 | 说明 |
| --- | --- |
| 1 | 解压后**不要**单独把 exe 拖出来，`ArcheryBattle_5_6_1`、`Engine` 等文件夹必须与 exe 保持同级 |
| 2 | 双击根目录的 `ArcheryBattle_5_6_1.exe` 启动 |
| 3 | 首次启动如提示缺少 `VCRUNTIME140.dll` 等，运行 `Engine/Extras/Redist/en-us/vc_redist.x64.exe` 后重试 |
| 4 | 如遇 Windows Defender SmartScreen 蓝色警告：点「更多信息」→「仍要运行」（未签名个人项目的正常提示） |

**磁盘空间**：解压后约 5GB，请预留 6GB 以上空间。

---

## 联机教程（2 人局域网 / IP 直连）

游戏不使用 Steam 等平台，**无需联网账号**，通过局域网或 IP 直连合作，其中一人作为主机。

1. **确认网络**：两台电脑连同一个路由器 / 同一个 Wi-Fi，或处于可互通的网段。
2. **主机**：启动游戏 → 在主菜单选择**创建房间**（以 Listen Server 身份运行）。
3. **客机**（二选一）：
   - **搜索会话**：在主菜单选择搜索房间，会自动列出局域网内已广播的房间，点选加入；
   - **输入 IP**：直接填入主机的内网 IP 地址（主机可在 `cmd` 中执行 `ipconfig` 查看 IPv4 地址）。
4. 两名玩家到齐后即可开始，关卡推进需要**两人同时进入关卡终点的触发区**才会加载下一关。

> 跨网段或公网联机需要自行做端口映射 / 使用虚拟局域网工具（如 ZeroTier、Radmin VPN、蒲公英等），把双方放进同一虚拟局域网后按上述步骤操作即可。

---

## 操作说明

| 按键 | 功能 |
| --- | --- |
| `Q` / `E` | 切换**近战刀** / **弓箭** 双武器 |
| 鼠标 | 视角；越肩瞄准（持弓时开镜有 FOV 过渡与上半身独立朝向） |
| 弓箭 | 拉弓可蓄力（半拉 → 满拉 → 过拉），蓄力越满威力越大 |
| 移动 | 支持**翻滚**、**慢走**（潜行 / 解谜时用）、跳跃，部分场景可用**摆荡点 / 抓钩**跨越 |

> 完整键位以游戏内提示与实际设置为准。

---

## 系统要求

| 项 | 最低 | 推荐 |
| --- | --- | --- |
| 操作系统 | Windows 10 64 位 | Windows 11 64 位 |
| 图形 API | **DirectX 12 / Shader Model 6**（必需） | DirectX 12 / SM6 |
| 显卡 | 支持 DX12 的独立显卡 | 支持硬件光追的中高端显卡 |
| 内存 | 16 GB | 16 GB 及以上 |
| 存储 | 6 GB 可用空间 | 固态硬盘 |
| 其他 | 双人游玩需两台电脑处于同一局域网 | — |

游戏使用 **Lumen 动态全局光照 + 虚拟阴影贴图（VSM）+ Nanite + World Partition**，对显卡有一定要求；画面设置中已按画质档位预设，帧率不足时可在设置里下调。打包目标为 50+ FPS（优化前约 10 FPS）。

---

## 文件校验

下载完成后可自行校验文件完整性（可选）：

```bat
certutil -hashfile Sky_Sanctum_The_Hollow_v1.0.0_Windows.zip.001 SHA256
```

各分卷的 SHA-256 与 `SHA256SUMS.txt` 中的记录一致即为下载完整。

| 文件 | 大小 | SHA-256 |
| --- | --- | --- |
| `..._Windows.zip.001` | 1900.0 MB | `0645006d706ff44ff4ff03f473a9adefc7edd26ecf8cd1fff6297dc5eb23c4c1` |
| `..._Windows.zip.002` | 1900.0 MB | `273a0223a520d03f9e0c87ab2f9a01c83df54f62a9bcb17d8cd3365109a22c78` |
| `..._Windows.zip.003` | 868.2 MB | `7cf1b79c9d4cd947b19780534746ca978bfd8ec61b569675fc7001b8f9727881` |
| 合并后的完整 zip | 4668.2 MB | `269be3466c4bf5994c419a4057ade2e01f6077cabb6d1680a3e977b81aad5e6c` |

分卷合计 4.6 GB，解压后约 4.9 GB。`download.bat` 会自动逐卷校验 SHA-256，校验不通过的卷会删除并提示重下。

---

## 常见问题

<details>
<summary><b>启动后黑屏 / 闪退？</b></summary>

确认显卡驱动已更新到较新版本，并确认显卡支持 DirectX 12。若仍无法启动，尝试右键 exe → 属性 → 兼容性 → 勾选「以管理员身份运行」。
</details>

<details>
<summary><b>分卷下载到一半断了？</b></summary>

重新运行 `download.bat` 即可，脚本会自动**断点续传**，无需从头下载。
</details>

<details>
<summary><b>客机搜不到房间？</b></summary>

检查两台电脑是否在同一网段、防火墙是否拦截了游戏程序（首次运行时会弹窗询问，需选择「允许访问」）。也可以直接改用「输入 IP」方式直连。
</details>

<details>
<summary><b>能不能单人玩？</b></summary>

游戏的关卡推进、解谜与联机逻辑是按**双人合作**设计的，单人无法正常推进流程，建议找一位朋友一起。
</details>

---

## 关于本项目

| 项 | 内容 |
| --- | --- |
| 游戏名 | 圣穹幽墟 / Sky Sanctum: The Hollow |
| 引擎版本 | Unreal Engine 5.6（DX12 / SM6） |
| 游戏类型 | 双人协作 · 剧情向 · 动作解谜 · 恐怖 |
| 视角 | 第三人称越肩（Over-the-Shoulder） |
| 联机 | 局域网 / IP 直连，2 人合作（Listen Server，`OnlineSubsystem = Null`，无第三方平台依赖） |
| 关卡 | 4 关（复用 3 张地图）：修道院门口 → 教堂 → 回廊与墓地 → 地牢 |
| 开发方式 | 全蓝图（Blueprint）+ Enhanced Input |

**本仓库是游戏的打包成品（Release 分发）仓库。** 想查看工程源码、玩法实现与开发文档，请移步：

- 🛠️ **源码工程仓库**：[ChaserCY/TwoPersonArcheryBattle5-6-1](https://github.com/ChaserCY/TwoPersonArcheryBattle5-6-1)

### 第三方资产说明

本项目场景与角色美术资产来自 Epic 官方示例及 Fab / 虚幻商城素材包（Cathedral / Dungeon / Castle、Insane Character Pack 01、Third Person Template、Mixamo、Realistic Starter VFX Pack Vol.2、Arrow Trail FX、LevelPrototyping、DirtTerrainPack 等），**全部玩法逻辑、AI、联机、UI 与关卡串联均为自主开发**。

### 授权说明

本项目为**个人学习作品**，免费提供下载游玩，欢迎交流反馈。
请勿用于任何商业用途，请勿二次打包售卖或声称原创。

---

<div align="center">

*Unreal Engine 5.6 · Blueprint · 双人局域网联机*

</div>
