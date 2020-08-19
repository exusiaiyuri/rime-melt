# 融合拼音(rime_melt)
融合了[【袖珍简化字拼音】](https://github.com/rime/rime-pinyin-simp/)[【Rime 简体中文用户定制文件】](https://github.com/huaxianyan/Rime)和【Easy English】以实现中英文混合输入，故名融合拼音(rime_melt)。   
因此本仓库实际是包含了这2种输入方案的「配方」。Rime新手使用此方案，可以快速上手简体中文和常用英语的混合输入。

## 意义
* Rime新手使用此方案，可以快速上手简体中文和常用英语的混合输入。 
* 众所周知，拼音输入是使用人数最多的中文输入方式；而rime默认拼音方案为明月拼音，该方案使用了繁体词库，通过脚本转换得到中文，而转换的结果事实上并不理想。故使用简体字典输入中文是很有必要的。
* 本方案使用的英文词库与Easy English词汇量差异极大，只保留了较常用的词汇，并非单纯为了提高混打中英文时的打字速度，而是借用字典机制对输入的单词进行自动校正。基于@tanzi制作的包含2016考研词汇大纲和六级单词词库进行更新，故更名为Easy English Nano。
* 如果你已经安装Easy English方案，与本方案互不影响。
* 如果你已经安装袖珍简化拼音，但是没有修改对应的custom文件，那么既可以选择使用本方案的文件替换冲突的文件，也可以选择保留原有文件，两者基本没有差别。   

## 使用方法
* 目前本方案没有加入东风破，需要下载文件并放置到方案目录来使用。 
1. 将文件下载并复制到 Rime 用户文件夹内。用戶資料夾位置：  
    * 【中州韻】 ~/.config/ibus/rime/ （0.9.1 以下版本爲 ~/.ibus/rime/）
    * 【小狼毫】 %APPDATA%\Rime
    * 【鼠鬚管】 ~/Library/Rime/
2. 启用[袖珍简化字拼音]和［Easy English Nano]方案。
3. 打开 Rime 方案选单（输入状态下按Ctrl + ~），切换至「融合拼音」即可开始使用。


## 问题
* 输入的英语不会生成自造词（我认为这是一个好的特性，避免了输入错误造成的字典污染）


## 文件组成及授权

[【袖珍简化字拼音】](https://github.com/rime/rime-pinyin-simp/)项目使用**Apache 2.0**协议，涉及的文件包含：  
* pinyin_simp.dict.yaml
* pinyin_simp.schema.yaml

[【Rime 简体中文用户定制文件】](https://github.com/huaxianyan/Rime)项目使用**MIT**协议，涉及的文件包含：
- `pinyin_simp.custom.yaml` ：袖珍简化字拼音方案的客制化配置文件。
- `pinyin_simp.main.dict.yaml` ：词库中心文件。词库内容由 [袖珍简化字拼音](https://github.com/rime/rime-pinyin-simp) 默认词库pinyin_simp.dict.yaml修改而来，故合并两者并保持同步。
- `pinyin_simp_base.dict.yaml` ：基础词库，由额外词库文件引用使用，来源为项目 [https://github.com/alswl/Rime](https://github.com/alswl/Rime) 中的[「现代汉语常用词表」](https://raw.githubusercontent.com/alswl/Rime/master/luna_pinyin.xiandaihanyuchangyongcibiao.dict.yaml)。
- `pinyin_simp_custom.dict.yaml` ：自定义词语，由额外词库文件引用使用。如需添加自定义短语，建议编辑此文件。
-  `cn_en.dict.yaml`： 更名为 `melt_mult_language.dict.yaml`英文及中英混输词库，本人会着重（tumuyan）维护
- `pinyin_simp_pin.txt` ：候选固定，使用另一个翻译器并给极高权重来达到固定候选列表的目的，编辑时请记得给极高权重。

【Easy English Nano】
* `melt_eng.schema.yaml` 归属于【Easy English】，原作者是Patrick (ipatrickmac@gmail.com)，但是在Patrick的主页没有这个项目的仓库。
而github上BlindingDark（https://github.com/BlindingDark/rime-easy-en）有在维护，使用了**LGPLv3**协议，但是与本方案分属不同分支。
* `melt_eng.dict.yaml` 英文主词库，作者tanzi，没有找到相关信息。主要在2016考研词汇大纲和六级单词的基础上进行修订。

【融合拼音增补词库】
求人不如求己，用[【深蓝词库转换】](https://github.com/studyzy/imewlconverter)转换搜狗细胞词库，并手动更新。（然而显而易见，搜狗目前的策略并不是通过更新离线词库来改善用户的输入体验）
- `pinyin_simp_chengyu.dict.yaml`：搜狗成语俗语细胞词库 https://pinyin.sogou.com/dict/detail/index/15097
- `pinyin_simp_lishi.dict.yaml`: 搜狗历史细胞词库 https://pinyin.sogou.com/dict/detail/index/15130
- `pinyin_simp_gushi.dict.yaml`：搜狗古诗细胞词库 https://pinyin.sogou.com/dict/detail/index/2

**Note** 以上文件清单仅供参考，存在仓库增加了文件，但是本说明没有及时更新的情况。  


## 其他

<details>
<summary>以下内容来自袖珍简化字拼音的Readme</summary>

# 袖珍简化字拼音

配方： ℞ **pinyin-simp**

[Rime](https://rime.im) 袖珍简化字拼音輸入方案

## 安裝

[東風破](https://github.com/rime/plum) 安裝口令： `bash rime-install pinyin-simp`

授權條款：見 [LICENSE](LICENSE)
</details>