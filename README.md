# ecommerce-data-analysis
E-commerce Sales and Customer Behavior Analysis using SQL and Python

# 电商用户消费行为与销售表现分析

## 项目简介

基于Kaggle Olist巴西电商数据集，使用MySQL和Python开展销售趋势、商品品类及用户消费行为分析，通过数据清洗、多表关联、指标计算和可视化，识别平台销售特征并提出业务优化建议。

**技术栈：** MySQL、Python（Pandas、NumPy、Matplotlib）、Jupyter Notebook

## 核心分析发现

- **销售表现：** 2017年11月商品销售额环比增长52.37%，主要伴随订单量增长（62.77%），而非平均订单金额提升。
- **商品品类：** 销售额Top 10品类合计贡献约63.28%的商品销售额，部分非头部品类在特定月份表现突出。
- **用户行为：** Top 10%高消费用户贡献约41.10%的商品销售额，累计复购率约3%，复购用户人均累计消费金额高于单次购买用户。

## 项目文件

| 分析模块 | SQL代码 | Python分析 |
|---|---|---|
| 数据预处理 | [data_pretent.sql](data_pretent.sql) | — |
| 销售表现 | [sell_analysis.sql](sell_analysis.sql) | [sell_analysis.ipynb](sell_analysis.ipynb) |
| 商品品类 | [products_analysis.sql](products_analysis.sql) | [products_analysis.ipynb](products_analysis.ipynb) |
| 用户行为 | [user_analysis.sql](user_analysis.sql) | [user_analysis.ipynb](user_analysis.ipynb) |

## 完整分析报告

[点击查看完整分析报告（PDF）](电商分析报告.pdf)

**数据来源：** [Kaggle — Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

**统计口径：** 商品销售额不含运费，仅统计已交付订单；销售与品类分析主要覆盖2017年1月至2018年8月，用户行为分析采用数据集覆盖期间的全部已交付订单。
