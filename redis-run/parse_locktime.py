import re
fastlat = 0
fastcount = 0
slowlat = 0
slowcount = 0
totallat = 0
totalcount = 0
# 打开文件并逐行读取
with open('trace_record_p.txt', 'r') as file:
    # 正则表达式
    pattern = r'entry=\[([0-9a-f]+)\]\s+cpu=(\d+)\s+wait_time_ns=(\d+)'
    
    # 逐行处理
    for line in file:
        match = re.search(pattern, line)
        if match:
            entry, cpu, wait_time_ns = match.groups()
            wait_time_ns = int(wait_time_ns)
            totalcount += 1
            totallat += wait_time_ns
            if entry.startswith('40000000'):
                fastlat += wait_time_ns
                fastcount += 1
                #print(f'Entry: {entry}, CPU: {cpu}, Wait Time (ns): {wait_time_ns}')
            else:
                slowlat += wait_time_ns
                slowcount += 1
                #print(f'Entry: {entry}, CPU: {cpu}, Wait Time (ns): {wait_time_ns}')

    avglat = totallat / totalcount
    fastavglat = fastlat / fastcount
    slowavglat = slowlat / slowcount

    print(f'avg: {avglat}, fast: {fastavglat}, slow: {slowavglat}')
    