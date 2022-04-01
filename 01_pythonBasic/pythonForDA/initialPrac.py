from base64 import decode, encode
import pandas as pd
import matplotlib.pyplot as plt

csv_data = pd.read_csv("제주도.csv", engine="python", encoding="utf-8")

sorted = csv_data.sort_values(by="총계")

#   print(sorted.head())

# 그래프 사이즈 지정하기
plt.figure(figsize=(14, 7))
# day로 그룹화하여 모든 그룹에 반복하기
for name, group in sorted.groupby("관광지"):
    # 각 그룹에 맞게 점 그리기
    plt.scatter(group["관광지"], group["총계"], label=name)
# 축 이름 지정하기
plt.xlabel("관광지")
plt.ylabel("총계")
# 범례 추가
plt.legend()
plt.show()
