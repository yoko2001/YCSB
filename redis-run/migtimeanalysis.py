import json

# 从文件中读取数据
# with open('migtimeresult.txt', 'r') as file:
#     data = json.load(file)

# 遍历数据并获取每个时间点
total1 = 0
total2 = 0
num = 0
with open('migtimeresult.txt', 'r') as file:
    for line in file:
        entry = eval(line)  # 将字符串转换为字典
        start_time = entry['start']
        iosend_time = entry['iosend']
        finish_time = entry['finish']
        time1 = float(iosend_time) - float(start_time)
        time2 = float(finish_time) - float(iosend_time)

        print(f"Start Time - Io Send Time: {time1}")
        print(f"Io Send Time - Finish Time: {time2}")
        num += 1
        total1 += time1
        total2 += time2


print(f"avg Start Time - Io Send Time: {total1 / num}")
print(f"avg Io Send Time - Finish Time: {total2 / num}")
