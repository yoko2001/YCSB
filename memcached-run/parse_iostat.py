import re

# 文件名
log_file = 'iostatlog.txt'

# 用于存储 aqu-sz 值的列表
aqu_values = []

# 读取文件并解析
with open(log_file, 'r') as file:
    content = file.read()
    
    # 按行分割内容
    lines = content.splitlines()

    # 定义一个标志来检查是否在采集到的内容中
    in_device_section = False
    start_record = False
    for line in lines:
        # 检查是否是设备统计部分
        if 'Device' in line:
            in_device_section = True
            continue
        
        # 当在设备统计部分时，提取 aqu-sz 值
        if in_device_section:
            if line.strip():  # 确保行不为空
                # 使用正则表达式提取 aqu-sz
                match = re.search(r'(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)', line)
                if match:
                    aqu_sz = match.group(22)  # aqu-sz 在正则表达式中的位置
                    # print(match.groups(), '-> ', aqu_sz)

                    if float(aqu_sz) > 0:
                        start_record = True
                    if start_record:
                        aqu_values.append(float(aqu_sz))

# 输出 aqu-sz 的变化情况
print("aqu-sz values:")
avg = 0.0
for index, value in enumerate(aqu_values):
    print(f"Entry {index + 1}: {value}")
    avg += value

avg /= len(aqu_values)
print(f"Avg {avg}")