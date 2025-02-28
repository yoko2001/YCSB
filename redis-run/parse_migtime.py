import re
matchlist = {}
time_1 = 0
time_2 = 0
time_3 = 0
num1 = 0
num2 = 0 
num3 = 0
def parse_log_line(log_line):
    global time_1, time_2, time_3, num1, num2, num3 
    # 匹配字符串中的日期、时间、主机名、日志类型和条目值
    # pattern = r'(\w{3} \d{1,2} \d{2}:\d{2}:\d{2}) (\w+) kernel: \[\s*(\d+\.\d+)\]\[\s*T(\d+)\] (start dealing with|after io send|end migrating) entry\[(\w+)\]'
    # pattern = r"\[(\s*\d+\.\d+)\]\[\s*T(\d+)\] \[ckpt\] (\w+) (io send|start dealing with) entry\[(\w+)\]"
    #pattern = r'^(?P<date>\w{3} \d{1,2} \d{2}:\d{2}:\d{2}) (?P<host>\S+) (?P<component>\S+): \[\s*(?P<timestamp>\d+\.\d+)\]\[\s*(?P<thread_id>T\d+)\] \[(?P<identifier>\w+)\] (?P<message>.+)\[(?P<entry_id>\w+)\]$'
    pattern = r'^(?P<date>\w{3} \d{1,2} \d{2}:\d{2}:\d{2}) (?P<host>\S+) (?P<component>\S+): \[\s*(?P<system_time>\d+\.\d+)\]\[\s*(?P<thread_id>T\d+)\] \[(?P<identifier>\w+)\] entry\[(?P<entry_id>[^\]]+)\]$'
    match = re.match(pattern, log_line)

    if match:
        log_info = match.groupdict()
        identifier = log_info['identifier']
        timestamp  = log_info['system_time']
        entry_value = log_info['entry_id']
        # date_time = match.group(1)
        # host = match.group(2)
        # timestamp = match.group(3)
        # thread_id = match.group(4)
        # log_type = match.group(5)
        # entry_value = match.group(6)
        # timestamp = match.group(1)
        # event_type = match.group(3)
        # entry_value = match.group(4)
        # log_type = identifier
        if entry_value not in matchlist.keys():
            matchlist[entry_value] = {}
        if identifier == 'ckpt3':
            matchlist[entry_value]['start'] = timestamp
        if identifier == 'ckpt4':
            matchlist[entry_value]['iosend'] = timestamp
        if identifier == 'ckpt5':
            matchlist[entry_value]['enabled'] = timestamp
            time_1 += float(matchlist[entry_value]['iosend']) - float(matchlist[entry_value]['start'])
            time_2 += float(matchlist[entry_value]['enabled']) - float(matchlist[entry_value]['iosend'])
            num1 += 1
            num2 += 1
            return matchlist[entry_value]
        if identifier == 'ckpt1':
            matchlist[entry_value]['swapin_start'] = timestamp
        if identifier == 'ckpt2':
            matchlist[entry_value]['swapin_end'] = timestamp
            time_3 += float(matchlist[entry_value]['swapin_end']) - float(matchlist[entry_value]['swapin_start'])
            num3 +=1
            return matchlist[entry_value]

        # print(identifier, matchlist[entry_value])
        # if log_type == "start dealing with":
        #     log_type = "start dealing with"
        #     matchlist[entry_value] = {"start" : timestamp}
        # elif log_type == "after io send":
        #     log_type = "after io send"
        #     if entry_value in matchlist.keys():
        #         matchlist[entry_value]["iosend"] = timestamp
        # elif log_type == "end migrating":
        #     log_type = "end migrating"
        #     if entry_value in matchlist.keys():
        #         matchlist[entry_value]["finish"] = timestamp
        #         print(matchlist[entry_value])
        # return f"日志类型: {log_type}, 条目值: {entry_value}, 时间戳: {timestamp}"
    # else:
    #     return f"未能解析日志字符串"

# 打开syslog文件进行逐行处理
with open('syslog.txt', 'r') as file:
    for line in file:
        result = parse_log_line(line)
        if result:
            print(result)
# print(matchlist)
# for key in matchlist.keys():
#     print(matchlist[key])
print("time_1", time_1 / num1)
print("time_2", time_2 / num2)
print("time_3", time_3 / num3)
