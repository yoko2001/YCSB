import os
import re

# 设置要处理的文件夹路径
directory = './'

# 遍历文件夹中的所有文件
for filename in os.listdir(directory):
    if re.match(r'endmemstat\.\d{3}-\d{3}-final-expo-migroute-\d+min-run\d{1,2}', filename):
        filepath = os.path.join(directory, filename)
        fre_values = {}
        fre_fast_values = {}

        with open(filepath, 'r') as file:
            for line in file:
                # 查找 fre 和 fre_fast 的值
                # fre_match = re.match(r'^(fre\d+)\s+(\d+)', line)
                # fre_fast_match = re.match(r'^(fre_fast\d+)\s+(\d+)', line)
                fre_match = re.match(r'^(fre(?:\d+|x))\s+(\d+)', line)
                fre_fast_match = re.match(r'^(fre_fast(?:\d+|x))\s+(\d+)', line)
                if fre_match:
                    key, value = fre_match.groups()
                    fre_values[key] = int(value)
                elif fre_fast_match:
                    key, value = fre_fast_match.groups()
                    fre_fast_values[key] = int(value)

        # 打印文件名及提取的数字
        print(f"File: {filename}")
        for i in range(31):
            print(fre_values.get(f'fre{i}', 0))
        print(fre_values.get('frex'))
        for i in range(31):
            print(fre_fast_values.get(f'fre_fast{i}', 0))
        print(fre_fast_values.get('fre_fastx'))

print("Data extraction completed.")