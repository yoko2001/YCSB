import re
matchlist = {}
def parse_log_line(log_line):
    # 匹配字符串中的日期、时间、主机名、日志类型和条目值
    pattern = r'(\w{3} \d{1,2} \d{2}:\d{2}:\d{2}) (\w+) kernel: \[\s*(\d+\.\d+)\]\[\s*T(\d+)\] (start dealing with|after io send|end migrating) entry\[(\w+)\]'
    
    match = re.match(pattern, log_line)

    if match:
        date_time = match.group(1)
        host = match.group(2)
        timestamp = match.group(3)
        thread_id = match.group(4)
        log_type = match.group(5)
        entry_value = match.group(6)
        
        if log_type == "start dealing with":
            log_type = "start dealing with"
            matchlist[entry_value] = {"start" : timestamp}
        elif log_type == "after io send":
            log_type = "after io send"
            if entry_value in matchlist.keys():
                matchlist[entry_value]["iosend"] = timestamp
        elif log_type == "end migrating":
            log_type = "end migrating"
            if entry_value in matchlist.keys():
                matchlist[entry_value]["finish"] = timestamp
                print(matchlist[entry_value])
        return f"日志类型: {log_type}, 条目值: {entry_value}, 时间戳: {timestamp}"
    else:
        return "未能解析日志字符串"

# 打开syslog文件进行逐行处理
with open('syslog.txt', 'r') as file:
    for line in file:
        result = parse_log_line(line)
        # print(result)
