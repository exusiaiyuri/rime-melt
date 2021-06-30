function get_date(input, seg, env)
  if ( input == "date") then
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), " -"))
  elseif ( input == "time"  or  input == "date---") then
    yield(Candidate("time", seg.start, seg._end, os.date("%H:%M"), " -"))
    yield(Candidate("time", seg.start, seg._end, os.date("%H:%M:%S"), " -"))
    yield(Candidate("time", seg.start, seg._end, os.date("%H%M%S"), " -"))
  elseif ( string.sub(input,-1)  == "-") then
    if ( input == "date-"  or  input == "time--") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%B %d"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), ""))
    elseif ( input == "time-" or  input == "date--") then
      yield(Candidate("date", seg.start, seg._end, os.date("%m/%d %H:%M"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y/%m/%d %H:%M"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y.%m.%d %H:%M"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y%m%d%H%M%S"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%B %d %H:%M"), ""))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日 %H:%M"), ""))
    elseif ( input == "re-" ) then
--      env.engine.context:PushInput('x')
      yield(Candidate("date", seg.start, seg._end, "x", "上屏"))
    else
      inpu = string.gsub(input,"[-]+$","")
      if (string.len(inpu) > 1 and string.sub(input,1,1) ~= "-") then
        if ( string.sub(input,-2)  == "--") then
--          file = io.open("C:\\Users\\Yazii\\AppData\\Roaming\\Rime\\pinyin_simp_pin.txt", "a")
--          user_path = (rime_api ~= nil and rime_api.get_user_data_dir ~= nil and {rime_api:get_user_data_dir()} or {'%appdata%\\Rime'})[1]
          ppath = getCurrentDir() .. "melt_eng_custom.dict.yaml"
--          yield(Candidate("pin", seg.start, seg._end, ppath , ""))
          file = io.open(ppath,"a")
          file:write("\n" .. inpu .. "\t" .. inpu .. "\t100")
          file:close()
          yield(Candidate("pin", seg.start, seg._end, inpu , " 已保存"))
        else
          yield(Candidate("pin", seg.start, seg._end, inpu , " -保存"))
        end
	  end
    end
  end
end

function getCurrentDir()
  function sum(a, b)
    return a + b
  end
  info = debug.getinfo(sum)
  path = info.source
  path = string.sub(path, 2, -1) -- 去掉开头的"@"
  path = string.match(path, "^(.*[\\/])") -- 捕获目录路径
  spacer = string.match(path,"[\\/]")
  path=string.gsub(path,'[\\/]',spacer)
  return path
end

function jpcharset_filter(input, env)
  sw =  env.engine.context:get_option("jpcharset_filter")
  if( env.engine.context:get_option("jpcharset_c")) then
    for cand in input:iter() do
      text = cand.text
      for i in utf8.codes(text) do
         local c = utf8.codepoint(text, i)
         if (c< 0x3041 or c> 0x30FF) then
            yield(cand)
--            yield(Candidate("pin", seg.start, seg._end, text , string.format("%x %c",c,c)))
            break
         end
      end
    end
  elseif( env.engine.context:get_option("jpcharset_j")) then
    for cand in input:iter() do
      text = cand.text
      for i in utf8.codes(text) do
         local c = utf8.codepoint(text, i)
         if (c>= 0x3041 and c<= 0x30FF) then
            yield(cand)
            break
         end
      end
    end
  else
    for cand in input:iter() do
      yield(cand)
    end
  end
end

function autocap_filter(input, env)
  if true then
--  if( env.engine.context:get_option("autocap_filter")) then
    for cand in input:iter() do
      text = cand.text
      commit = env.engine.context:get_commit_text()
      if (string.find(text, "^%l%l.*") and string.find(commit, "^%u%u.*")) then
        if(string.len(text) == 2) then
          yield(Candidate("cap", 0, 2, commit , "+" ))
        else
          yield(Candidate("cap", 0, string.len(commit), string.upper(text) , "+" .. string.sub(cand.comment, 2)))
        end
        --[[ 修改候选的注释 `cand.comment`
            因复杂类型候选项的注释不能被直接修改，
            因此使用 `get_genuine()` 得到其对应真实的候选项
            cand:get_genuine().comment = cand.comment .. " " .. s
        --]]
      elseif (string.find(text, "^%l+$") and string.find(commit, "^%u+")) then
        suffix = string.sub(text,string.len(commit)+1)
        yield(Candidate("cap", 0, string.len(commit), commit .. suffix , "+" .. suffix))
      else
        yield(cand)
      end
    end
  else
    for cand in input:iter() do
      yield(cand)
    end
  end
end


