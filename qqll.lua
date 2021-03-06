--[[ 1:  ──────────────────────────────
 2:                 【七窍玲珑任务介绍】（测试期）
 3:  ──────────────────────────────
 4:
 5:      当年华山论剑，全真派王重阳真人获得了“中神通”的称号。可
 6:  惜他年命不永，虽然身修上乘武学，却早逝于终南山中。王重阳临死
 7:  时，送给他的七名弟子一人一件遗物，另人惊讶的是，这些遗物，既
 8:  不是珠玉珍宝，也不是武功秘籍，尽是些奇怪的无用之物。武林中盛
 9:  传这些重阳遗物中蕴涵着极大的秘密。
10:
11:      其中，王重阳大弟子全真掌教马钰得到的是一块破烂的石头——
12:  七眼石。马钰多年来一直在寻觅能工巧匠帮他解开先师留下的这个迷
13:  团。
14:
15:  ──────────────────────────────
16:                          【任务要求】
17:  ──────────────────────────────
18:
19:      两人之组队任务。
20:      队长要求其经验比队员低4百万以下，1百万以上。
21:      队长要求其锻造术/织造术/农桑术/采矿术至少有一项在220段
22:  以上。
23:
== 还剩 41 行 == (ENTER 继续下一页，q 离开，b 前一页)

24:  ──────────────────────────────
25:                          【任务过程】
26:  ──────────────────────────────
27:
28:      在终南山金莲阁找到马钰，两人组队后，由队长（经验值低的一
29:  人）ask ma about 七眼石，ask ma about job 接任务。
30:      马钰会告诉你，有一位江湖奇人淳于蓝也许知道七眼石的秘密并
31:  给你七眼石请他鉴定。并说起某一位游戏中的玩家知道此人的位置。
32:  组队去寻找此人， ask player-id about 淳于蓝（有时候要ask好几
33:  次）就可知道淳于蓝的位置。然后，玩家互相follow后，由队长领路
34:  行走，一路上，会遇到来抢夺王重阳遗物的杀手若干组。杀手会对队
35:  长叫杀，两人联手将这些杀手击退后，来到淳于蓝出现的位置，找到
36:  淳于蓝（如果没有杀够足够的杀手，淳于蓝并不会出现），ask lan
37:  about 七眼石，并给淳于蓝七眼石让其鉴定。
38:
39:      此时会出现三种不同的情况：
40:      情况一是淳于蓝鉴定成功，告诉玩家七眼石只是西方一种略为名
41:  贵的七窍石，并不能称为宝物。玩家回到马钰处ask ma about 完成
42:  得到任务奖励。
43:      情况二是淳于蓝告诉玩家，他其实只是个走江湖的混混。玩家回
44:  到马钰处 ask ma about 完成，但得到很少的任务奖励。
45:
46:      情况三，淳于蓝会告诉玩家七眼石的真面目以及王真人留下此物
== 还剩 18 行 == (ENTER 继续下一页，q 离开，b 前一页)

47:  的真正含义。玩家回到马钰处 ask ma about 完成，得到任务奖励。
48:  并且马钰会把一块【七窍玲珑玉】给予队长。
49:
50:      任务过程中，玩家丢失了七眼石则算任务失败。玩家也可以自己
51:  去ask ma about 放弃来放弃任务。
52:
53:
54:  ──────────────────────────────
55:                          【经验介绍】
56:  ──────────────────────────────
57:
58:      这个任务难度大，首先是玩家组队有一定的限制，没有高超的打
59:  造系列技能无法接任务，还需要寻找合适的合作伙伴；虽然杀手不直
60:  接杀死玩家，但危险系数还是很高；而且要寻找淳于蓝的位置，必须
61:  找到合作的player。所以总体来说，并不是很适合作为玩家的首选任
62:  务。但唯一诱人的是，马钰所给的那块【七窍玲珑玉】，虽然还不清
63:  楚此物的具体用途，但似乎是修炼高级工匠技能的必需宝物。
64:  ]]
-- 走路 战斗 恢复
--require "wait8"
require "wait"
qqll={
  new=function()
     local ql={}
	 ql.uid=string.sub(CreateGUID(),25,30)
	 setmetatable(ql,{__index=qqll})
	 return ql
  end,
  co=nil,
  neili_upper=1.5,
  uid="",
  child_worldID="",
  master_worldID="",
  look_player=false,
  look_player_place="",
  playername="",
  playerid="",
  rooms={},
  wait_count=0,
  is_find=false,
  starttime=0,
  target={},
  stop=false,
  robbername="",
  master_ready=false,
  child_ready=false,
}

local heal_ok=false

local function child_Exe(cmd)
  local otherworld=GetWorldById(qqll.child_worldID)
   if otherworld ~= nil then
     otherworld:Execute(cmd)
   end
end

local function main_Exe(cmd)
  local mainworld=GetWorldById(qqll.master_worldID)
   if mainworld ~= nil then
     mainworld:Execute(cmd)
   end
end

function qqll:main_link()
   local leader_id=world.GetVariable("qqll_leader_id") or ""
   local partner_id=world.GetVariable("qqll_partner_id") or ""
   if partner_id=="" then
	  print("qqll_partner_id 变量没有设置")
	  return
   end
    if leader_id=="" then
	  print("qqll_leader_id 变量没有设置")
	  return
   end

   qqll.child_ready=false
   qqll.master_ready=false

    for k, v in pairs (GetWorldIdList ()) do
      local player_id=GetWorldById (v):GetVariable("player_id") or ""
	  if string.lower(player_id)==string.lower(leader_id) then
	    qqll.master_worldID=v
	    break
	  end
	end
   print(qqll.master_worldID," master_worldID")
   for k, v in pairs (GetWorldIdList ()) do
    local player_id=GetWorldById (v):GetVariable("player_id") or ""
	if string.lower(player_id)==string.lower(partner_id) then
	   print(player_id)
	  if v~=qqll.master_worldID then
	        qqll.partner1_id=string.lower(partner_id)
	        qqll.child_worldID= v
	   break
	  end
	end
  end
  print(qqll.child_worldID," child_worldID")
  --辅助id 参数设置
  local cmd="/qqll.master_worldID='"..qqll.master_worldID.."'"
  child_Exe(cmd)
  main_Exe(cmd)

  cmd="/qqll.child_worldID='"..qqll.child_worldID.."'"
  child_Exe(cmd)
  main_Exe(cmd)

  local leitai=world.GetVariable("qqll_leitai")
  cmd="/SetVariable('qqll_leitai',"..leitai..")"
  child_Exe(cmd)
  main_Exe(cmd)

  cmd="/qqll:Status_Check()"
  child_Exe(cmd)
  main_Exe(cmd)
end

function qqll:team()
   local player_id=world.GetVariable("player_id")
   local otherworld=GetWorldById(qqll.child_worldID)
   local parter_id=otherworld:GetVariable("player_id")
   print("子id",parter_id)
   print("主id",player_id)
   world.Send("team dismiss")
   child_Exe("team dismiss")
   world.Send("team with "..string.lower(parter_id))
   world.Send("follow "..string.lower(parter_id))
   local f=function()
     child_Exe("team with "..string.lower(player_id))
     child_Exe("follow "..string.lower(player_id))
	 qqll:ask_job()
   end
   f_wait(f,2)
   --
end

function qqll:main_pfm()
  local otherworld=GetWorldById(qqll.child_worldID)
  local mainworld=GetWorldById(qqll.master_worldID)
  local pfm1=mainworld:GetVariable("qqll_pfm") or ""
  local pfm2=otherworld:GetVariable("qqll_pfm") or ""

  local _pfm1=mainworld:GetVariable(pfm1)
  local _pfm2=otherworld:GetVariable(pfm2)

  main_Exe("/Send('alias pfm ".._pfm1.."')")
  child_Exe("/Send('alias pfm ".._pfm2.."')")
end

--full
function qqll:full()
    local liao_percent=world.GetVariable("liao_percent") or 80
	liao_percent=tonumber(liao_percent)
	local qi_percent=world.GetVariable("qi_percent") or 100
	qi_percent=assert(tonumber(qi_percent),"qi_percent变量必须输入数字！") or 100
	local vip=world.GetVariable("vip") or "普通玩家"
    local h
	h=hp.new()
	h.checkover=function()
	   -- print(h.food,h.drink)
	   --print(h.qi_percent,"气血百分百 ",h.qi,"气血 ",heal_ok," heal_ok")
	    if (h.food<50 or h.drink<50) and vip~="贵宾玩家" then
		    print("eat")
		   local w
		   w=walk.new()
		   w.walkover=function()
			   local b
			   b=busy.new()
			   b.interval=0.3
			   b.Next=function()
			      world.Execute("sit chair;knock table;get mi tao;get cha;drink cha;drink cha;drink cha;eat mi tao;eat mi tao;eat mi tao;drop mi tao;drop tea")
				 local b2
				 b2=busy.new()
				 b2.interval=0.3
				 b2.Next=function()
				    qqll:Status_Check()
				 end
				 b2:check()
			  end
			  b:check()
		   end
		   w:go(1960) --299 ask xiao tong about 食物 ask xiao tong about 茶
		elseif h.jingxue_percent<=80 or (h.qi_percent<=liao_percent and heal_ok==false) then
		    print("疗伤")
            local rc=heal.new()
			--rc.teach_skill=teach_skill --config 全局变量
			rc.saferoom=505
			rc.heal_ok=function()
			   --heal_ok=true
			   qqll:full()
			end
			rc:liaoshang()
        elseif h.jingxue_percent<100 then
		    print("打通经脉")
            local rc=heal.new()
			--world.Send("set heal jing")
			rc.saferoom=505
			--rc.teach_skill=teach_skill --config 全局变量
			rc.heal_ok=function()
			    --world.Send("unset heal")
			   --heal_ok=true
			   qqll:full()
			end
			rc:heal(false,true)
		elseif h.qi_percent<qi_percent and heal_ok==false  then
			print("打通经脉")
            local rc=heal.new()
			rc.saferoom=505
			--rc.teach_skill=teach_skill --config 全局变量
			rc.heal_ok=function()
			   heal_ok=true
			   qqll:full()
			end
			rc:heal(true,false)

		elseif h.neili<math.floor(h.max_neili*qqll.neili_upper) then
		    heal_ok=false --复位
		    local x
			x=xiulian.new()
			x.min_amount=10
			x.safe_qi=h.max_qi*0.5
			x.limit=true
			x.danger=function()
			   world.Send("yun qi")
			   world.Send("yun jingli")
			   local w=walk.new()
			   w.walkover=function()
			      x:dazuo()
			   end
			   w:go(53)
			end
			x.fail=function(id)
             --print(id)
				if id==201 or id==1 then
				  world.Send("yun recover")
				  world.Send("yun jing")
	              local f
		          f=function() x:dazuo() end  --外壳
				  f_wait(f,0.5)
			    end
				if id==777 then
				   f=function()
				     heal_ok=false
   				     qqll:full()
				   end  --外壳
				   f_wait(f,0.5)
				end
	           if id==202 then
	             local w
		         w=walk.new()
		         w.walkover=function()
			       x:dazuo()
		         end
		         w:go(643)
		 	   end
			end
			x.success=function(h)
               --print(h.qi,h.max_qi*0.9)
			   --print(h.neili,h.max_neili*2-200)
			   if h.neili>=math.floor(h.max_neili*qqll.neili_upper) then
			     qqll:start()
			   else
	             print("继续修炼")
				 world.Send("yun recover")
		         x:dazuo()
			   end
			end
			x:dazuo()
		else
			--print(h.neili,h.max_neili*2-200)
			local b
			b=busy.new()
			b.Next=function()
			  heal_ok=false
			  qqll:start()
			end
			b:check()
		end
	end
	local b=busy.new()
	b.Next=function()
	  h:check()
	end
	b:check()
end

local list=""
local tb_who={}
function qqll:wholist(info)
   if string.find(info,"━━━━━━━━") then
   elseif string.find(info,"位玩家连线中") then
       world.EnableTrigger("wholist",false)
	   world.DoAfterSpecial(0.1,"DeleteTrigger('wholist')",12)
		--print(list)
		local who={}
		who=Split(list," ")
		local party=""
		local playername=""
		local playerid=""
		local status=""
		 tb_who={}
		for _,w in ipairs(who) do
		   if Trim(w)~="" then
		      --print(w)
			  if string.find(w,"：") then
			     party=w
			  else
			     local s,e=string.find(w,"%(")
				 playername=string.sub(w,1,s-1)
				 playerid=string.sub(w,e+1,string.len(w)-1)
				 playerid=string.lower(playerid)
				 if string.find(playername,"%*") then
				     status="断线"
				 elseif string.find(playername,"%+") then
				     status="发呆"
				 else
				    status=""
				 end
				 --print(playername," ",playerid," ",party," ",status)
				 tb_who[playerid]={}
				 tb_who[playerid].name=playername
				 tb_who[playerid].party=party
				 tb_who[playerid].status=status
			  end
		   end
		end
		qqll:wanted()
   else
        --print(info)
       list=list..info
   end
end

local function is_contain(r,rooms)
    if rooms==nil then
	  return false
	end
	for _,v in ipairs(rooms) do
	    --print("当前房间:",v)
	    if v==r then
		   --print("相同")
		   return true
		end
	end
	--print("不同")
	return false
end

local function get_dir(dx)
   if dx=="up" then
      return "down"
	elseif dx=="down" then
	   return "up"
   elseif dx=="east" then
      return "west"
	elseif dx=="west" then
	  return "east"
	elseif dx=="north" then
	  return "south"
	elseif dx=="south" then
	  return "north"
	elseif dx=="northwest" then
	  return "southeast"
	elseif dx=="northeast" then
	  return "southwest"
	elseif dx=="southwest" then
	   return "northeast"
	elseif dx=="southeast" then
	   return "northwest"
	elseif dx=="enter" then
	  return "out"
	elseif dx=="out" then
	  return "enter"
	elseif dx=="southdown" then
	  return "northup"
	elseif dx=="northup" then
	  return "southdown"
	elseif dx=="eastup" then
	  return "westdown"
	elseif dx=="westdown" then
	   return "eastup"
	elseif dx=="northdown" then
	   return "southup"
	elseif dx=="southup" then
	   return "northdown"
	elseif dx=="eastdown" then
	    return "westup"
	elseif dx=="westup" then
	    return "eastdown"
   end
end

function qqll:recover_check()
   if qqll.master_ready==true and qqll.child_ready==true then
      qqll.master_ready=false
	  qqll.child_ready=false
	   qqll:back() --2个id 都回到擂台
	   child_Exe("/qqll:back()")
   end
end

function qqll:recover_status()
	 local worldID=GetWorldID()
	  if qqll.master_worldID==worldID then
	     print("主id就绪!")
		 qqll.master_ready=true
		 qqll:recover_check()
	  else
	     print("子id就绪!")
		 local cmd="/qqll.child_ready=true"
		 main_Exe(cmd)
		 local cmd="/qqll:recover_check()"
		 main_Exe(cmd)
	  end
end

function qqll:recover()
     world.Send("follow none")
	local ts={
	           task_name="七窍玲珑玉",
	           task_stepname="恢复",
	           task_step=5,
	           task_maxsteps=7,
	           task_location=qqll.lan_place,
	           task_description="",
	}
	local st=status_win.new()
	st:init(nil,nil,ts)
	st:task_draw_win()
	local liao_percent=world.GetVariable("liao_percent") or 80
	liao_percent=tonumber(liao_percent)
	local qi_percent=world.GetVariable("qi_percent") or 100
	qi_percent=assert(tonumber(qi_percent),"qi_percent变量必须输入数字！") or 100

	local cd=cond.new()
	heal_ok=false
	cd.over=function()
		print("检查状态")
		if table.getn(cd.lists)>0 then
		      local sec=0
		       for _,i in ipairs(cd.lists) do
				local s,e=string.find(i[1],"毒")
				 if s~=nil then
                    s=s%2
				 else
				    s=0
				 end
			     if i[1]=="星宿掌毒" or s==1 then
				   print("中毒了")
			       sec=i[2]
				    local rc=heal.new()
			        rc.saferoom=505
			        rc.heal_ok=function()
			          qqll:recover()
			        end
			        rc:qudu(sec,i[1],false)
				    return
			     end
				 if i[1]=="内伤" or i[1]=="七伤拳内伤" then
				    print("内伤")
				    sec=i[2]
				    local rc=heal.new()
			        rc.saferoom=505
			        rc.heal_ok=function()
					  local f=function()
			            qqll:recover()
					  end
					  f_wait(f,5)
			        end
			        rc:heal(true,true)
				    return
				 end
			   end
		end
		local b2=busy.new()
	    b2.Next=function()
  	      world.Send("yun qi")
	      world.Send("yun jingli")
	      local h
	      h=hp.new()
	      h.checkover=function()
	       if h.jingxue_percent<=80 or (h.qi_percent<=liao_percent and heal_ok==false) then
		    print("疗伤")
            local rc=heal.new()
			--rc.teach_skill=teach_skill --config 全局变量
			rc.saferoom=505
			 rc.heal_ok=function()
			   --heal_ok=true
			   qqll:recover()
			 end
		 	rc:liaoshang()
		   elseif h.jingxue_percent<100 then
			print("打通经脉")
            local rc=heal.new()
			rc.saferoom=505
			rc.heal_ok=function()
			    qqll:recover()
			end
			rc:heal(false,true)
		  elseif h.qi_percent<100 then
			print("打通经脉")
            local rc=heal.new()
			rc.saferoom=505
			rc.heal_ok=function()
			    qqll:recover()
			end
			rc:heal(true,false)
		  elseif h.neili<math.floor(h.max_neili*qqll.neili_upper)  then
		    local x
			x=xiulian.new()
			x.min_amount=100
			x.safe_qi=h.max_qi*0.5
			x.limit=true
			x.danger=function()
			   world.Send("yun qi")
			   world.Send("yun jingli")
			   local w=walk.new()
			   w.walkover=function()
			      x:dazuo()
			   end
			   w:go(53)
			end
			x.fail=function(id)
             --print(id)
				if id==201 or id==1 then
				  if h.jingxue_percent<=60 then
				     qqll:recover()
				     return
				  end
	              local f
		          f=function() x:dazuo() end  --外壳
				  f_wait(f,10)
			    end
				if id==777 then
				   qqll:recover()
				end
	           if id==202 then
			     local roomno=153
                 local leitai=world.GetVariable("qqll_leitai")
		         roomno=tonumber(leitai)
	             local w
		         w=walk.new()
		         w.walkover=function()
			       x:dazuo()
		         end
		         w:go(roomno)
			   end
			end
			x.success=function(h)
               print(h.qi,h.max_qi*0.9)
			   print(h.neili,h.max_neili*2-200)
			   world.Send("yun recover")
			   if h.neili>h.max_neili*2-200 then
				  heal_ok=false
			      qqll:recover_status()
			   else
	             print("继续修炼")
		         x:dazuo()
			   end
			end
			x:dazuo()
		else
			--print(h.neili,h.max_neili*2-200)
			local b
			b=busy.new()
			b.Next=function()
			   heal_ok=false
			   qqll:recover_status()
			end
			b:check()
		end
	  end
	  h:check()
	  end
	    b2:check()
	end
	cd:start()
end

--[[
虚孟有气无力地说道：「好汉饶命，这些黄金请笑纳。 ...」
虚孟丢下一些黄金。
虚孟转身几个起落就不见了。]]



local function short_dir(dir)
   local d=dir
   d=string.gsub(d,"eastdown","ed")
   d=string.gsub(d,"westdown","wd")
   d=string.gsub(d,"northdown","nd")
   d=string.gsub(d,"southdown","sd")
   d=string.gsub(d,"eastup","eu")
   d=string.gsub(d,"westup","wu")
   d=string.gsub(d,"northup","nu")
   d=string.gsub(d,"southup","su")
   d=string.gsub(d,"northwest","nw")
   d=string.gsub(d,"northeast","ne")
   d=string.gsub(d,"southwest","sw")
   d=string.gsub(d,"southeast","se")
   d=string.gsub(d,"east","e")
   d=string.gsub(d,"west","w")
   d=string.gsub(d,"south","s")
   d=string.gsub(d,"north","n")
   d=string.gsub(d,"up","u")
   d=string.gsub(d,"down","d")
   return d
end

function qqll:back_status()
  if qqll.child_ready==true and qqll.master_ready==true then
	local player_id=world.GetVariable("player_id")
    local otherworld=GetWorldById(qqll.child_worldID)
    local parter_id=otherworld:GetVariable("player_id")
	main_Exe("follow "..string.lower(parter_id))
	child_Exe("follow "..string.lower(player_id))
	qqll:shield()
	child_Exe("/qqll:shield()")
	qqll:robber()
	qqll.stop=false
	local dir=qqll.g_dir
	qqll:go(dir)
	qqll.child_ready=false
	qqll.master_ready=false
   end
end

function qqll:back() --回到出发点

   local roomno=153
   local leitai=world.GetVariable("qqll_leitai")
   roomno=tonumber(leitai)
   local w=walk.new()
   local worldID=GetWorldID()
   w.walkover=function()
	  if qqll.master_worldID==worldID then
		qqll.master_ready=true
        qqll:back_status()
	  else
	    main_Exe("/qqll.child_ready=true") --通知主id
		main_Exe("/qqll:back_status()")
	  end
   end
   w:go(roomno)
end

--淳于蓝给你一块七眼石。
function qqll:givelanshi()
    wait.make(function()
	  local l,w=wait.regexp("^(> |)淳于蓝给你一块七眼石。$",5)
	  if l==nil then
	     world.Send("give lan qiyan shi")
         qqll:givelanshi()
	     return
	  end
	  if string.find(l,"七眼石") then
	    qqll:reward()
	     return
	  end
	end)
end

function qqll:checkLan(callback)

   local _R=Room.new()
    local _R
	_R=Room.new()
	_R.CatchEnd=function()
	    print(_R.roomname,"房间名称")
        print(_R.exits)
		local dx=Split(_R.exits,";")
		local _dir=""
		for _,d in ipairs(dx) do
		   if d~="enter" and d~="out" then
		      _dir=d
			  break
		   end
		end
		if _dir=="" then
		    _dir=string.gsub(_R.exits,";","")
		end
		print(_dir)
		local rev_dir=get_dir(_dir)
		local path=_dir..";"..rev_dir
		path=short_dir(path)
		print(path)
		if _R.roomname=="黄土坪" then
		   path="w;e"
		elseif _R.roomname=="山间小路" then  --寒潭有busy
		   path="wu;ed"
		end
		world.Execute(path)
		world.Send("ask lan about 七眼石")
        wait.make(function()
         local l,w=wait.regexp("^(> |)这里没有这个人。$|^(> |)你向淳于蓝打听有关『七眼石』的消息。$",5)
	     if l==nil then
	       qqll:checkLan(callback)
	       return
	     end
	     if string.find(l,"这里没有这个人") then
	       callback()
	       return
	      end
		 if string.find(l,"你向淳于蓝打听有关") then
	      world.DoAfter(2,"give lan qiyan shi")
		  wait.time(2)
		  qqll:givelanshi()
	      return
	     end
        end)
	end
	_R:CatchStart()
end

function qqll:checkLan_status()
  if qqll.master_ready==true and qqll.child_ready==true then
     local playerid=world.GetVariable("player_id")
     child_Exe("follow "..playerid)
     local f=function()
		coroutine.resume(qqll.co)
	 end
	 qqll:checkLan(f)
   end
end

function qqll:go_room(roomno)
    local worldID=GetWorldID()
    local w=walk.new()
	w.noway=function()
	    print("noway")
	end
	w.walkover=function()

		if qqll.master_worldID==worldID then
	        print("主id就绪!")
		    qqll.master_ready=true
            qqll:checkLan_status()
		  else
	        print("子id就绪!")
		    main_Exe("/qqll.child_ready=true")
	    	main_Exe("/qqll:checkLan_status()")
		  end
	end
	w:go(roomno)
end

local giveshi_test=0
function qqll:give_shi()
   local ts={
	           task_name="七窍玲珑玉",
	           task_stepname="寻找淳于蓝",
	           task_step=6,
	           task_maxsteps=7,
	           task_location=qqll.lan_place,
	           task_description="寻找"..qqll.lan_place.."的淳于蓝",
	}
	local st=status_win.new()
	st:init(nil,nil,ts)
	st:task_draw_win()
	--CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."七窍玲珑任务:寻找淳于蓝 "..qqll.lan_place, "blue", "black") -- yellow on white
    local place=qqll.lan_place
    local n,e=Where(place)
	if n==0 then
	  if string.find(place,"大理城") or string.find(place,"大理城南") then

	     --place=string.gsub(place,"大理城","大理城南")
	     local place2=string.gsub(place,"大理城南","大理城")
		 --print(place2," place2")
		 n,e=Where(place2)
		 if n==0 then
		     place2=string.gsub(place,"无量山","大理城")
			 n,e=Where(place2)
		 end
		 if n==0 then
		     place2=string.gsub(place,"大理皇宫","大理城")
			 n,e=Where(place2)
		 end
		 if n==0 then
			 place2=string.gsub(place,"大理王府","大理城")
			 n,e=Where(place2)
		 end
		 if n==0 then
			 place2=string.gsub(place,"玉虚观","大理城")
			 n,e=Where(place2)
		 end
	  end
	  if string.find(place,"蝴蝶谷") then
	     place=string.gsub(place,"蝴蝶谷","明教")
		 n,e=Where(place)
	  end
	  if string.find(place,"姑苏慕容") then
	     place=string.gsub(place,"姑苏慕容","燕子坞")
		 n,e=Where(place)
		  if n==0 then
		     place=string.gsub(place,"姑苏慕容","曼佗罗山庄")
			 n,e=Where(place)
		 end
	  end
	  if string.find(place,"襄阳城") then
		 place=string.gsub(place,"襄阳城","柳宗镇")
		 n,e=Where(place)
	  end
	  if string.find(place,"中原神州") then
	     place=string.gsub(place,"中原神州","")
		 n,e=Where(place)
	  end
	  if string.find(place,"平定州") then
	     place=string.gsub(place,"平定州","星宿海")
		 n,e=Where(place)
	  end
	  if string.find(place,"成都郊外") then
		 place=string.gsub(place,"成都郊外","成都城")
		 n,e=Where(place)
	  end
	  if string.find(place,"大草原") then
		 place=string.gsub(place,"大草原","大雪山")
		 n,e=Where(place)
	  end
	   if string.find(place,"伊犁城") then
		 place=string.gsub(place,"伊犁城","星宿海")
		 n,e=Where(place)
	  end
	  if string.find(place,"星宿海") then

	      place=string.gsub(place,"星宿海","伊犁城")
		  n,e=Where(place)
	  end
	end
	if n==0 then
	   --[[local worldID=GetWorldID()
	   if qqll.master_worldID==worldID then
	     print("主id 继续问")
	     qqll:wanted()
	   end]]
	   qqll:wanted()
	   return
	end
	qqll.target=e
   	qqll.co=coroutine.create(function()
      for _,roomno in ipairs(e) do
	    local w=walk.new()
		local al=alias.new()
		al.maze_done=function()
			print("迷宫check npc")
			local f2=function() al.maze_step() end
			qqll:checkLan(f2)
		end
		al.songlin_check=function()
			print("迷宫check npc")
			local f2=function() al:NextPoint() end
			qqll:checkLan(f2)
		end
		al.noway=function()
		   print("alias noway")
		   qqll:wanted()
		end
		w.user_alias=al
		w.noway=function()
		   print("walk noway")
		   qqll:wanted()
		end
	    w.walkover=function()
		   qqll.master_ready=true
		   qqll:checkLan_status()
	    end
		world.Send("follow none")
		child_Exe("follow none")
	    w:go(roomno)
		qqll.master_ready=false
		qqll.child_ready=false
		child_Exe("/qqll:go_room("..roomno..")")
        coroutine.yield()
	  end
	  print("走到底没找到")
	  if giveshi_test>1 then
	     giveshi_test=0
	     qqll:giveup()
	  else
	     giveshi_test=9
		 local b=busy.new()
		 b.Next=function()
	       qqll:give_shi()
		 end
		 b:check()
	  end
	end)
	coroutine.resume(qqll.co)
end

function qqll:shield()

end

local steps=0
function qqll:go(dir)
   if qqll.stop==false then
	 qqll.g_dir=dir
	 world.Execute(dir)
	 local f=function()
	    steps=steps+1
		print("次数:",steps)
		if qqll.robber_count>=5 then
		  print("已结出现了5个强盗")
		  qqll:give_shi()
		elseif steps>30 then
		   CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."七窍玲珑任务:共击败"..qqll.robber_count.."位强盗", "yellow", "black") -- yellow on white
		   qqll:give_shi()

		else
		  qqll:go(dir)
		end
	 end
	 f_wait(f,0.5)
   end
end

function qqll:qiyanshi_exist()
    world.EnableTimer("qiyanshi_exist",false)
	world.DeleteTimer("qiyanshi_exist")
    local sp=special_item.new()
	sp.cooldown=function()
        print("cooldown")
		for _,i in ipairs(sp.equipment_items) do
		   print(i.name,i.id,i.num)
		   if string.find(i.name,"七眼石") then
			  local b=busy.new()
		      b.Next=function()
		       world.Send("get gold")
			   qqll.child_ready=false
			   qqll.master_ready=false
			   qqll:recover()
			   child_Exe("/qqll:recover()")
		      end
		      b:check()
		      return
		   end
		end
		world.Send("follow none")
		child_Exe("/shutdown()")
		child_Exe("follow none")
		qqll:main_link()
	end
	local equip={}
	equip=Split("<使用>七眼石","|")
	sp:check_items(equip)
end
--你「啪」的一声倒在地上，挣扎着抽动了几下就死了。
function qqll:robber_fight()
  wait.make(function()
       local l,w=wait.regexp("^(> |).*有气无力地说道：「.*饶命，这些黄金请笑纳。 ...」$|^(> |)你只觉得头昏脑胀，眼前一黑，接着什么也不知道了……$|^(> |)"..qqll.robbername.."急急忙忙地离开了。$",5)
	   if l==nil then
	      qqll:robber_fight()
	      return
	   end
	   if string.find(l,"眼前一黑") or string.find(l,"急急忙忙地离开了") then
	      world.AddTimer("qiyanshi",0,0,8,"qqll:qiyanshi_exist()", timer_flag.Enabled + timer_flag.OneShot , "")
          world.SetTimerOption ("qiyanshi", "send_to", 12)
	      return
	   end
       if string.find(l,"这些黄金请笑纳") then
	      shutdown()
	      local b=busy.new()
		  b.Next=function()
		      world.Send("get gold")
			  qqll.child_ready=false
			  qqll.master_ready=false
			  qqll:recover()
			  child_Exe("/qqll:recover()")
		  end
		  b:check()
		  return
       end
  end)
end

--|^(> |)淳于蓝急急走了过来。$
--卜唐时余决定跟随你一起行动。
function qqll:robber_follow()
    wait.make(function()
       local l,w=wait.regexp("^(> |)(.*)决定跟随你一起行动。$",5)
	   if l==nil then
	      qqll:robber_follow()
	      return
	   end
       if string.find(l,"决定跟随你一起行动") then
	      qqll.robbername=w[2]
		  return
       end
  end)
end

function qqll:robber()
  --你觉得行囊中的顽石越来越沉，令你举步维艰……。
  wait.make(function()
       local l,w=wait.regexp("^(> |)你觉得行囊中的顽石越来越沉，令你举步维艰……。$",5)
	   if l==nil then
	      qqll:robber()
	      return
	   end
       if string.find(l,"你觉得行囊中的顽石越来越沉") then
	      qqll.robber_count=qqll.robber_count+1
		  steps=0
		  qqll:robber_follow()
	      qqll:robber_fight()
          qqll.stop=true
		   print("战斗模块")
	      local cb=fight.new()
		  local pfm=world.GetVariable("pfm")
		   cb.combat_alias=pfm
	      local unarmed_pfm=world.GetVariable("unarmed_pfm")
	      cb.unarmed_alias=unarmed_pfm
	      cb.no_pfm=function()
		    local sp=special_item.new()
			sp.cooldown=function()
		      print("卸载武器")
		  	  cb:run()
		    end
		    sp:unwield_all()
	      end
	      cb.finish=function()
            print("战斗结束")
		    world.Send("unset wimpy")
		    shutdown()
		    qqll:qiyanshi_exist()
	      end
	      cb:start()
		  return
       end
  end)
end

function qqll:Dragon()
   steps=0
   world.Send("say 决战擂台")
   qqll:robber()
   qqll:go("e;w")
end
  --[[
function qqll:go_round()
   print("巡逻")
   print("采用固定地点巡逻")
 local points={}
   for i,r in ipairs(qqll.target) do
      local p={}
	  p.startroomno=r
	  if i+1>table.getn(qqll.target) then
	     p.endroomno=qqll.target[1]
	  else
	     p.endroomno=qqll.target[i+1]
	  end
	  print(p.startroomno,p.endroomno)
	  table.insert(points,p)
   end
   local dir=""
   for i,r in ipairs(points) do
      local path,room_type,rooms=Search(r.startroomno,r.endroomno)
      dir=dir..path
   end
   dir=string.sub(dir,1,-2)
   --print(dir)
   if string.find(dir,"noway") then
      qqll:get_way()
   else
      qqll:go(dir)
   end

   --计算巡逻路径

   --你觉得行囊中的顽石越来越沉，令你举步维艰……。
end

function qqll:prepare_status()
	 if qqll.master_ready==false then
	    child_Exe("say 等等大师")
		world.DoAfterSpecial(1,"qqll:prepare_status()",12)
	 elseif qqll.child_ready==false then
		main_Exe("say 等等助手")
		world.DoAfterSpecial(1,"qqll:prepare_status()",12)
	 end
end]]

function qqll:prepare_check()
     if qqll.child_ready==true and qqll.master_ready==true then
		qqll:Dragon()
		qqll.child_ready=false
		qqll.master_ready=false
	 elseif qqll.master_ready==false then
	    child_Exe("say 等等大师")
		--world.DoAfterSpecial(1,"qqll:prepare_status()",12)
	 elseif qqll.child_ready==false then
		main_Exe("say 等等助手")
		--world.DoAfterSpecial(1,"qqll:prepare_status()",12)
	 end
end

function qqll:check_place(roomno,place)
   local worldID=GetWorldID()
   local f=function(r)
     if is_contain(roomno,r)==true then
         print("正确房间")
		 --CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."七窍玲珑任务:到达擂台,准备战斗", "white", "black") -- yellow on white
		 if qqll.master_worldID==worldID then
	        print("主id就绪!")
		    qqll.master_ready=true
            qqll:prepare_check()
		  else
	        print("子id就绪!")
		   local cmd="/qqll.child_ready=true"
		    main_Exe(cmd)
			local cmd="/qqll:prepare_check()"
		    main_Exe(cmd)
		  end
	  else
         qqll:dragonGate(place)
	  end
   end
   print("确定位置")
   CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."七窍玲珑任务:是否到达擂台", "blue", "black") -- yellow on white
   WhereAmI(f,10000) --排除出口变化
end

function qqll:dragonGate(place)
   local ts={
	           task_name="七窍玲珑玉",
	           task_stepname="杀光强盗",
	           task_step=5,
	           task_maxsteps=7,
	           task_location="擂台",
	           task_description=place,
	}
	local st=status_win.new()
	st:init(nil,nil,ts)
	st:task_draw_win()
	CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."七窍玲珑任务:前往擂台,后续"..place, "blue", "black") -- yellow on white
	qqll.lan_place=place
	qqll.robber_count=0 --强盗数量

	world.Send("follow none")
	local roomno=153
	local leitai=world.GetVariable("qqll_leitai")
	roomno=tonumber(leitai)
	local w=walk.new()
	w.walkover=function()
		local masterworld=GetWorldById(qqll.master_worldID)
	    local master_id=masterworld:GetVariable("player_id")
        local otherworld=GetWorldById(qqll.child_worldID)
        local parter_id=otherworld:GetVariable("player_id")
		main_Exe("follow "..string.lower(parter_id))
		child_Exe("follow "..string.lower(master_id))
		main_Exe("emote 持剑站立,天地变色")
		child_Exe("emote 持刀站立,风起云涌")

		qqll:check_place(roomno,place)
	end
	w:go(roomno)
end

function qqll:ketou(roomno,uid)
   wait.make(function()
--小兵在你的耳边悄声说道：不过他现在已经去祭坛了。
      local l,w=wait.regexp("^(> |)"..qqll.playername.."在你的耳边悄声说道：不过他现在已经去(.*)了。|^(> |)这里没有这个人。$|^(> |)设定环境变量：action \\= \\\""..uid.."\\\"$|^(> |)你的搭档去哪里了.*$",3)
	  if l==nil then
	     qqll:ask_lan(roomno)
		 return
	  end
	  if string.find(l,"在你的耳边悄声说道") then
	     world.Send("follow none")
		 child_Exe("follow none")
		 qqll.is_find=true
	     --main_Exe("follow "..qqll.playerid)
	     --child_Exe("follow "..qqll.playerid)
	     local place=w[2]
		 place=qqll.location..place
		 if place=="神龙岛蛇窟" or place=="襄阳城正厅" or place=="绝情谷谷底" or place=="绝情谷练功房" or place=="回疆大草原" or place=="明教天字门" or place=="明教雷字门" or place=="明教风字门" or place=="明教地字门" or place=="华山祭坛" or place=="华山夹山壁" or place=="华山密道" or place=="华山石洞" or place=="绝情谷鳄鱼潭" or place=="绝情谷大厅" or place=="绝情谷小室" or place=="嵩山少林武僧堂" or place=="嵩山少林松树林" or place=="嵩山少林里屋" then
		    qqll:wanted()
		    return
		 end
		 qqll.stop=false
		 world.ColourNote ("red", "yellow", place)
		 qqll:set_guard()

		 qqll:dragonGate(place)
		 qqll.master_ready=false
	     qqll.child_ready=false
		 child_Exe("say 战斗准备")
		 child_Exe("/qqll:dragonGate('"..place.."')")
	     return
	  end
	  if string.find(l,"这里没有这个人") then
	     qqll.is_find=false
	     local f=function()
		    qqll:ask_lan(roomno)
		 end
		 f_wait(f,1)
	     return
	  end
	  if string.find(l,"设定环境变量：action") then
	     world.Execute("ask "..qqll.playerid.." about 淳于蓝")

		 local uid=string.sub(CreateGUID(),25,30)
		  world.DoAfter(0.3,"set action "..uid)
		 qqll:ketou(roomno,uid)
	     return
	  end
		if string.find(l,"你的搭档去哪里了") then
	       print("重置")
	       qqll:wanted()
	       return
	   end
   end)
   -- 上官剑南在你的耳边悄声说道：不过他现在已经去磨针井了。

end

local is_reset=0
function qqll:lan(roomno)
--上官剑南在你的耳边悄声说道：不过他现在已经去磨针井了。
	--world.Send("follow "..qqll.playerid)
	--child_Exe("follow "..qqll.playerid)

   local player_id=world.GetVariable("player_id")
   local otherworld=GetWorldById(qqll.child_worldID)
   local parter_id=otherworld:GetVariable("player_id")
   --print("子id",parter_id)
   --print("主id",player_id)
	--world.Send("follow "..string.lower(qqll.playerid))
	--child_Exe("follow "..string.lower(qqll.player_id))
	world.Send("ask "..string.lower(qqll.playerid).." about 淳于蓝")

	wait.make(function()
	   local l,w=wait.regexp("^(> |)"..qqll.playername.."在你的耳边悄声说道：不过他现在已经去(.*)了。$|^(> |)这里没有 "..qqll.playerid.."。$|^(> |)你决定跟随"..qqll.playername.."一起行动。$|^(> |)这里没有这个人。$",2)
	   if l==nil then
	      qqll:lan(roomno)
	      return
	   end
	   --[[
	   if string.find(l,"一起行动") then
	       qqll.is_find=true
	       local uid=string.sub(CreateGUID(),25,30)
	       qqll:ketou(roomno,uid)
		   --world.Send("ask "..qqll.playerid.." about 淳于蓝")
		   world.DoAfter(0.3,"set action "..uid)
	       --world.EnableTimer("catch_id",false)
		   --world.DeleteTimer("catch_id")
	       world.Send("say 桃花过处,寸草不生,金钱落地,人头不保! "..qqll.playername.."看你往哪里跑，留下内裤！")
	       return
	   end]]
      if string.find(l,"在你的耳边悄声说道") then
	     world.Send("follow none")
		 child_Exe("follow none")
		 qqll.is_find=true
	     --main_Exe("follow "..qqll.playerid)
	     --child_Exe("follow "..qqll.playerid)
	     local place=w[2]
		 place=qqll.location..place
		 if place=="武当山烈火丛林" or place=="武当山积雪丛林" or place=="武当山落叶丛林" or place=="武当山院门" or place=="神龙岛蛇窟" or place=="襄阳城正厅" or place=="绝情谷练功房" or place=="回疆大草原" or place=="明教天字门" or place=="明教雷字门" or place=="明教风字门" or place=="明教地字门" or place=="华山祭坛" or place=="华山夹山壁" or place=="华山密道" or place=="华山石洞" or place=="绝情谷鳄鱼潭" or place=="绝情谷大厅" or place=="绝情谷小室" or place=="绝情谷洞口" or place=="嵩山少林武僧堂" or place=="嵩山少林松树林" or place=="嵩山少林里屋" then
		    qqll:lan(roomno)
		    return
		 end
		 qqll.stop=false
		 world.ColourNote ("red", "yellow", place)
		 qqll:set_guard()

		 qqll:dragonGate(place)
		 qqll.master_ready=false
	     qqll.child_ready=false
		 child_Exe("say 战斗准备")
		 child_Exe("/qqll:dragonGate('"..place.."')")
	     return
	  end
	   if string.find(l,"这里没有") then
		  local sec=480-os.difftime(os.time(),qqll.starttime)
		  print(sec," 倒计时")
	     if is_reset>=10 then

		    local interval=os.difftime(os.time(),qqll.starttime)
		    print("重置")
			child_Exe("say")
			is_reset=0
			if interval>480 then
			  print("超过 480 ",interval)
			  qqll:giveup()
			else
	          qqll:wanted()
		    end
		 else
		    if is_reset==2 then
		     qqll:collectData() --收集数据
			end
	        local f=function()
			  is_reset=is_reset+1
		      qqll:lan(roomno)
            end
		    f_wait(f,0.5)
		 end
		  --world.EnableTimer("catch_id",true)
	      return
	   end
	end)
end


function qqll:ask_lan(roomno,is_omit)
   world.Send("follow none")
   local w=walk.new()
   w.walkover=function()
       	local f=function(r)
		    if is_contain(roomno,r) then
			   if is_omit==true then
			     world.Send("say 我和你到天涯海角")
			   else
				qqll:lan(roomno)
			   end

			else
				qqll:ask_lan(roomno)
			end
	    end
	    WhereAmI(f,10000) --排除出口变化
   end
   w:go(roomno)
end
--数据采集点

local database_path=""
function qqll:db_init()
  local db_name="sjcentury.db" --地图数据库
--数据采样
 local path=world.GetInfo (66) .. db_name
  database_path=path
end
qqll:db_init()

function qqll:ClearDB()
	world.DatabaseOpen ("db2", database_path, 6) --只读数据库

   local sql="delete from mud_bigdata"
   DatabaseExec ("db2",sql)
   DatabaseFinalize ("db2")
   DatabaseClose ("db2")
end

function qqll:DeleteHistory()
	world.DatabaseOpen ("db2", database_path, 6) --只读数据库
   local t=os.time()
   local now_date = os.date("*t",t)
   --[[
      print("before")
print("year:" .. now_date.year)
print("month:" .. now_date.month)
print("day:" .. now_date.day)
print("hour:" .. now_date.hour)]]
   now_date.hour=now_date.hour-2
  --[[
   print("after")
print("year:" .. now_date.year)
print("month:" .. now_date.month)
print("day:" .. now_date.day)
print("hour:" .. now_date.hour)
]]
 local sql="delete from mud_bigdata where import_time<'"..os.date("%y/%m/%d %H:%M:%S",os.time({day=now_date.day,month=now_date.month,year=now_date.year,hour=now_date.hour,min=now_date.min,sec=now_date.sec})).."'"
 --  print(sql)
   DatabaseExec ("db2",sql)
   DatabaseFinalize ("db2")
   DatabaseClose ("db2")

end

function qqll:GetHistoryCount()
     world.DatabaseOpen ("db2", database_path, 6) --只读数据库
    local sql="select count(*) from mud_bigdata"
	world.DatabasePrepare ("db2", sql)
	 local rows={}
	 local rc={}
  	  rc=world.DatabaseStep ("db2")
	  while rc == 100 do
	     ------print("row",i)
	     local values=  world.DatabaseColumnValues ("db2")

		 rows=values[1]
		 break
	  end
	  world.DatabaseFinalize ("db2")
	  DatabaseClose ("db2")
	  return rows
end

function qqll:insert(playername,playerid,roomno,roomname)
    local item={}
	item.playername=playername
	item.playerid=playerid
	item.roomno=roomno
	item.roomname=roomname
	if item.playerid~="qingtong" and item.playerid~="board" and item.playerid~="head" then
	   self:Record(playername,playerid,roomno,roomname)
	end
end

--

function qqll:collectData()

  local _R
  _R=Room.new()
  _R.CatchEnd=function()
  --根据当前位置 前往最近的钱庄
--1532 正气堂 1657 入幽口 1957 三清殿 506 驿站 1413 凉亭 1969 日月洞
      local count,roomno=Locate(_R)
	  local roomname=_R.roomname
	  print("当前房间号",roomno[1]," ",roomname)
	    world.Send("id here")
	    world.Send("set action 数据采集")
	    self:catch(roomno[1],roomname)
   end
  _R:CatchStart()
end

function qqll:start_collectData(count,interval)
   if interval==nil then
      interval=5
   end
   if count>0 then
     count=count-1
	   self:collectData()
	   --等待10s
       local f=function()
		   self:start_collectData(count)
       end
	   f_wait(f,interval)
   else
       coroutine.resume(qqll.co)

   end


end

function qqll:redo_collectData()

  local rooms={}
  local r=math.random(2)
  print("随机数:",r)
  if r==1 then
   table.insert(rooms,1532)
   table.insert(rooms,1657)
   table.insert(rooms,1957)
  table.insert(rooms,2540)
   table.insert(rooms,1413)
   table.insert(rooms,506)
   table.insert(rooms,1969)
  else
     table.insert(rooms,1413)
     table.insert(rooms,1969)
	  table.insert(rooms,506)
	   table.insert(rooms,2540)
	  table.insert(rooms,1957)
	  table.insert(rooms,1657)
     table.insert(rooms,1532)
  end
   qqll.co=coroutine.create(function()
	  for _,r in ipairs(rooms) do
	    print("下一步")
		 local w=walk.new()
         w.walkover=function()
            self:start_collectData(3,2)

         end
         w:go(r)

		coroutine.yield()
	  end
	   print("结束!!!")

   end)
   coroutine.resume(qqll.co)
end

function qqll:init()
   qqll:ClearDB()
   local rooms={}

   local worldID=GetWorldID()
	if qqll.master_worldID==worldID then
	     table.insert(rooms,1532)
         table.insert(rooms,1657)
         table.insert(rooms,2540)
         table.insert(rooms,1957)
         table.insert(rooms,506)
         table.insert(rooms,1413)
         table.insert(rooms,1969)
	else
	      table.insert(rooms,1413)
          table.insert(rooms,1969)
	      table.insert(rooms,506)
	       table.insert(rooms,2540)
	      table.insert(rooms,1957)
	       table.insert(rooms,1657)
          table.insert(rooms,1532)
	end
   qqll.co=coroutine.create(function()
	  for _,r in ipairs(rooms) do
	    print("下一步")
		 local w=walk.new()
         w.walkover=function()
            self:start_collectData(10)

         end
         w:go(r)

		coroutine.yield()
	  end
	   print("qqllyu 玩家数据获取结束!!!")
	   qqll:start()

   end)
   coroutine.resume(qqll.co)

end

function qqll:catch(roomno,roomname)

   wait.make(function()
      local l,w=wait.regexp("^(> |)在这个房间中\\, 生物及物品的\\(英文\\)名称如下：$|^(> |)设定环境变量：action \\= \\\"数据采集\\\"",2)
	  if l==nil then
		 world.Send("set action 数据采集")
	     self:catch(roomno,roomname)
	     return
	  end
	  if string.find(l,"设定环境变量：action") then
	     --print("结束")
		 world.EnableTrigger("idhere",false)
		 world.DoAfterSpecial(0.1,"DeleteTrigger('idhere')",12)
	     return
	  end
	  if string.find(l,"生物及物品的") then
	     world.AddTriggerEx ("idhere", "^(> |)(\\W*) \\= (\\w*)$", "qqll:insert('%2','%3',"..roomno..",'"..roomname.."')", trigger_flag.RegularExpression +trigger_flag.Enabled + trigger_flag.Replace, custom_colour.NoChange, 0, "", "", 12, 999)
		 self:catch(roomno,roomname)
	     return
	  end
   end)
end

function qqll:Record(playername,playerid,roomno,roomname)

	world.DatabaseOpen ("db2", database_path, 6) --只读数据库
   local editwho=world.GetVariable("player_id") or "sys"
   if editwho~=playerid then
     local sql="insert into mud_bigdata (roomno,roomname,import_time,editwho,playername,playerid) values("..roomno..",'"..roomname.."','"..os.date("%y/%m/%d %H:%M:%S").."','"..editwho.."','"..playername.."','"..playerid.."')"
     print(sql)
     DatabaseExec ("db2",sql)
     DatabaseFinalize ("db2")
     DatabaseClose ("db2")
   end
end

function qqll:loadDataCount(id)
     world.DatabaseOpen ("db2", database_path, 6) --只读数据库
    local sql="select roomno,count(*) b from mud_bigdata where playerid='"..id.."' group by roomno order by b desc"
	world.DatabasePrepare ("db2", sql)
	 local rc ={}

	 local returnvalue={}
  	  rc=world.DatabaseStep ("db2")
	  while rc == 100 do
	     ------print("row",i)
	     local values=  world.DatabaseColumnValues ("db2")
         local r={}
		 r.roomno=values[1]
		 r.count=values[2]
		 table.insert(returnvalue,r)
		 rc = world.DatabaseStep ("db2")

	  end
	  world.DatabaseFinalize ("db2")
	  DatabaseClose ("db2")
	  return returnvalue
end

function qqll:loadData(id)
   qqll:DeleteHistory()

   world.DatabaseOpen ("db2", database_path, 6) --只读数据库

	local sql="select roomno,roomname,import_time,editwho,playername,playerid from mud_bigdata where playerid='"..id.."' order by import_time desc limit 1"
	print(sql)
	world.DatabasePrepare ("db2", sql)
	 local rc ={}
	 local r={}
	 local returnvalue={}
  	  rc=world.DatabaseStep ("db2")
	  while rc == 100 do
	     ------print("row",i)
	     local values=  world.DatabaseColumnValues ("db2")

		 r.roomno=values[1]
		 r.roomname=values[2]
		 r.import_time=values[3]
		 r.editwho=values[4]
		 r.playername=values[5]
		 r.playerid=values[6]
		 table.insert(returnvalue,r)
		 rc = world.DatabaseStep ("db2")

	  end
	  world.DatabaseFinalize ("db2")
	  DatabaseClose ("db2")
	  return returnvalue
end


local last_roomno=0
function qqll:wanted()
    local party=""
	local status=""
	local name=""
	local id=qqll.playerid
    qqll.is_find=false
	local result=qqll:loadData(id)
	local count=qqll:loadDataCount(id)
	--通过 神游功来获得玩家位置

	if result==nil then
	   print("获取数据失败")
	   local f=function()
	     qqll:wanted()
	   end
	   f_wait(f,2)
	   return
	end
    print("最近此玩家出现的地点")
	local r=result[1]
	if r==nil then
	   print("没有轨迹!!")
	   qqll:giveup()
	   return
	end
	print(r.import_time,":",r.playername," ",r.playerid," ",r.roomname,"(",r.roomno,") ",r.editwho)
	for _,v in ipairs(count) do
	   print("房间号:",v.roomno," 次数 ",v.count)

	end
	r.roomno=tonumber(r.roomno)

	--03/15/16 19:58:18:147
	--[[
	r.import_time=string.sub(r.import_time,1,17)
    local tab={}
	tab.year="20"..string.sub(r.import_time,7,8)
	tab.month=string.sub(r.import_time,1,2)
	tab.day=string.sub(r.import_time,4,5)
    tab.hour=string.sub(r.import_time,10,11)
	tab.min=string.sub(r.import_time,13,14)
	tab.sec=string.sub(r.import_time,16,17)
	local t = os.time(tab)  --获得上传时间
	--print(t)
	local interval=os.difftime(os.time(),t)
	if interval>=900 then
	    print("时间间隔超过6分钟")
		qqll:giveup()
	   return
	end]]
	-- BigData:catchData(2542,"回廊")
	----1532 正气堂 1657 入幽口 1957 三清殿 506 驿站 1413 凉亭 1969 日月洞
    if r.roomno==1532 then
	    last_roomno=1532
	    qqll:ask_lan(1532)
		child_Exe("/qqll:ask_lan(1532,true)")
	elseif r.roomno==2542 or r.roomname=="回廊" then
	    last_roomno=2542
	    qqll:ask_lan(2542)
		child_Exe("/qqll:ask_lan(2542,true)")
	elseif r.roomno==2540 then
	    last_roomno=2540
	    qqll:ask_lan(2540)
		child_Exe("/qqll:ask_lan(2540,true)")
	elseif r.roomno==506 then
	    last_roomno=506
	    qqll:ask_lan(506)
		child_Exe("/qqll:ask_lan(506,true)")
	elseif r.roomno==1969 then
	    last_roomno=1969
		qqll:ask_lan(1969)
		child_Exe("/qqll:ask_lan(1969,true)")
	elseif r.roomno==1413 then
	    last_roomno=1413
		qqll:ask_lan(1413)
		child_Exe("/qqll:ask_lan(1413,true)")
	elseif r.roomno==1657 then
         last_roomno=1657
		 qqll:ask_lan(1657)
         child_Exe("/qqll:ask_lan(1657,true)")
	elseif r.roomno==1957 or string.find(r.roomname,"汉水西岸") then
	    last_roomno=1957
	    qqll:ask_lan(1957)
		child_Exe("/qqll:ask_lan(1957,true)")
    elseif r.roomno==50 then
	    last_roomno=50
	    qqll:ask_lan(50)
		child_Exe("/qqll:ask_lan(50,true)")
	elseif r.roomno==84 then
	    last_roomno=84
	    qqll:ask_lan(84)
		child_Exe("/qqll:ask_lan(84,true)")
	elseif r.roomno==135 then
	    last_roomno=135
	    qqll:ask_lan(135)
		child_Exe("/qqll:ask_lan(135,true)")
	elseif r.roomno==2540 then
	    last_roomno=2540
	    qqll:ask_lan(2540)
		child_Exe("/qqll:ask_lan(2540,true)")
	elseif r.roomno==1345 then
	    last_roomno=1345
	    qqll:ask_lan(1345)
		child_Exe("/qqll:ask_lan(1345,true)")
	elseif r.roomno==311 then
	    last_roomno=311
	    qqll:ask_lan(311)
		child_Exe("/qqll:ask_lan(311,true)")
	elseif r.roomno==2553 then
	    last_roomno=2553
	    qqll:ask_lan(2553)
		child_Exe("/qqll:ask_lan(2553,true)")
	elseif string.find(r.roomname,"长江渡船") or string.find(r.roomname,"长江北岸") or string.find(r.roomname,"长江南岸") or string.find(r.roomname,"渡船") then
		last_roomno=148
		qqll:ask_lan(148)
		child_Exe("/qqll:ask_lan(148,true)")
	elseif string.find(r.roomname,"大渡口") then
	    last_roomno=1573
	     qqll:ask_lan(1573)
		child_Exe("/qqll:ask_lan(1573,true)")
	elseif string.find(r.roomname,"陕晋渡口") then
	    last_roomno=1351
	     qqll:ask_lan(1351)
		child_Exe("/qqll:ask_lan(1351,true)")
	elseif string.find(r.roomname,"澜沧江边") then
	    last_roomno=525
	      qqll:ask_lan(525)
		child_Exe("/qqll:ask_lan(525,true)")
	elseif string.find(r.roomname,"西夏渡口") then
	    last_roomno=1596
	    qqll:ask_lan(1596)
		child_Exe("/qqll:ask_lan(1596,true)")
	else
	     print("没找到对应数据")
		 if last_roomno==0 then
		    last_roomno=50
		 end
		qqll:ask_lan(last_roomno)
	  	child_Exe("/qqll:ask_lan("..last_roomno..",true)")
	end

--上官剑南在你的耳边悄声说道：不过他现在已经去磨针井了。
    --1532
	--一个毒人给岳不群一块令牌。
	--1957
	--宋远桥对着杨继忠点了点头。
	--506
	--311
	--左冷禅给真爱永恒讲解一些武学上的疑难，真爱永恒若有所思地点着头。
	--2540 --lingwu  2542

	--clb 135 贝海石在上官零五耳边小声地说了些话。
	--褚万里对着桃花风点了点头。
  --1345 吴长老对着鲅鱼饺子竖起了右手大拇指，好样的。
  --【谣言】某人：渡灭护送大师顺利到达恒山了！
end

function qqll:get_who()
   wait.make(function()
      local l,w=wait.regexp("^.*◎ 「書劍」紫檀站在线玩家：$|^(> |)设定环境变量：action \\= \\\"在线列表\\\"",2)
	  if l==nil then
		 world.Send("set action 在线列表")
	     qqll:get_who()
	     return
	  end
	  if string.find(l,"设定环境变量：action") then
	     print("结束")
	     return
	  end
	  if string.find(l,"紫檀站在线玩家") then
	      print("启动触发器")
         list=""
		 world.AddTriggerEx ("wholist", "^(> |)\\s*\\d*:(.*)$", "qqll:wholist('%2')", trigger_flag.RegularExpression +trigger_flag.Enabled + trigger_flag.Replace, custom_colour.NoChange, 0, "", "", 12, 999);
         qqll:get_who()
	     return
	  end
   end)
end

function qqll:get_wholist()
  world.Send("who -i")
  --world.DoAfter(1,"\\n")
  qqll:get_who()
end

--[[
你向上官剑南打听有关『淳于蓝』的消息。
上官剑南说道：「哦，上次确实有这么一个人来过。」
上官剑南在你的耳边悄声说道：不过他现在已经去思过崖了。
一个蒙面杀手从路边跳了出来。大声喝道：「把王重阳的宝物留下，不然取你的性命。」
淳于蓝急急走了过来。
了五决定跟随桃花风一起行动。]]
function qqll:getid(guard_name)
    wait.make(function()
     local l,w=wait.regexp("^(> |)(.*)决定跟随"..guard_name.."一起行动。$",5)
	 if l==nil then
	    qqll:getid(guard_name)
	    return
	 end
	 if string.find(l,"决定跟随") then
        local npc=w[2]
		print(npc," id")
		qqll:killNPC(npc,guard_name)
	    return
	 end
   end)
end

function qqll:killNPC(npc,guard_name)

      --thread_monitor("huashan:checkNPC",f,{npc,roomno})
    wait.make(function()
      world.Execute("look;set action 核对身份")
      local l,w=wait.regexp("^(> |).*"..npc.."\\\((.*)\\\).*$|^(> |)设定环境变量：action \\= \\\"核对身份\\\"",10)
	  if l==nil then
		qqll:killNPC(npc,guard_name)
		return
	  end
	  if string.find(l,"设定环境变量：action") then
	      qqll:guard(guard_name)
		  return
	  end

	  if string.find(l,npc) then
	     --找到
		  local id=string.lower(Trim(w[2]))
		  --print(id)
		  world.Send("kill "..id)
		  main_Exe("kill "..id)
		  qqll:main_pfm()
		  main_Exe("/qqll:set_guard()")
		  return
	  end
	  wait.time(6)
   end)
end

function qqll:guard(guard_name)

   print("等待",guard_name)
   world.Send("die2")
   main_Exe("say 人在江湖飘哪能不挨刀!")
   wait.make(function()
     local l,w=wait.regexp("^(> |)一个蒙面杀手从路边跳了出来。大声喝道：「把王重阳的宝物留下，不然取你的性命。」$|^(> |)"..guard_name.."「啪」的一声倒在地上，挣扎着抽动了几下就死了。$",8)
	 if l==nil then
	    qqll:guard(guard_name)
	    return
	 end
	 if string.find(l,"挣扎着抽动了几下就死了") then
	    world.Send("say 我来给你收尸")
		world.Send("get gold")
		world.Send("get all from corpse")
		main_Exe("/qqll:qiyanshi_exist()")
	    return
	 end
	 if string.find(l,"一个蒙面杀手从路边跳了出来") then
        qqll:getid(guard_name)
	    return
	 end
   end)

end

function qqll:set_guard()
   qqll:main_pfm()
   print("设置pfm")
  local player_name=world.GetVariable("player_name")
   child_Exe("/qqll:guard('"..player_name.."')")
end

function qqll:xunwen_place(name,id,location)
  	local ts={
	           task_name="七窍玲珑玉",
	           task_stepname="询问玩家",
	           task_step=4,
	           task_maxsteps=7,
	           task_location=location,
	           task_description="寻找玩家"..name.."("..id..")",
	}
	local st=status_win.new()
	st:init(nil,nil,ts)
	st:task_draw_win()

	 CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."七窍玲珑任务:寻找玩家"..name.."("..id..")", "blue", "black") -- yellow on white
	 print("询问玩家")
  --qqll:player_exist()
   qqll.playername=name
   qqll.playerid=id
   qqll.location=location
   --qqll:get_wholist() --get who list
   qqll.starttime=os.time()
   qqll:wanted()--
end

function qqll:Status_Check()
	local ts={
	           task_name="七窍玲珑玉",
	           task_stepname="打坐",
	           task_step=1,
	           task_maxsteps=7,
	           task_location="",
	           task_description="",
	}
	local st=status_win.new()
	st:init(nil,nil,ts)
	st:task_draw_win()
	local cd=cond.new()
	heal_ok=false
	cd.over=function()
	          print("检查状态")
		     if table.getn(cd.lists)>0 then

		      local sec=0
		       for _,i in ipairs(cd.lists) do
				local s,e=string.find(i[1],"毒")
				 if s~=nil then
                    s=s%2
				 else
				    s=0
				 end
			     if i[1]=="星宿掌毒" or s==1 then
				   print("中毒了")
			       sec=i[2]
				    local rc=heal.new()
			        rc.saferoom=505
			        rc.heal_ok=function()
			          qqll:Status_Check()
			        end
			        rc:qudu(sec,i[1],false)
				    return
			     end
				 if i[1]=="内伤" or i[1]=="七伤拳内伤" then
				    print("内伤")
				    sec=i[2]
				    local rc=heal.new()
			        rc.saferoom=505
			        rc.heal_ok=function()
					  local f=function()
			            qqll:Status_Check()
					  end
					  f_wait(f,5)
			        end
			        rc:heal(true,true)
				    return
				 end
			   end
		     end
            qqll:full()
	end
	cd:start()
end

function qqll:ready_status()
    if qqll.master_ready==false then
	   child_Exe("say 等等大师")
	   world.DoAfterSpecial(1,"qqll:ready_status()",12)
	elseif qqll.child_ready==false then
	   main_Exe("say 等等助手")
	   world.DoAfterSpecial(1,"qqll:ready_status()",12)
	end
end

function qqll:ready_check()
     if qqll.child_ready==true and qqll.master_ready==true then
		qqll:team() --开始组队
	 elseif qqll.master_ready==false then
	    child_Exe("say 等等大师")
		world.DoAfterSpecial(1,"qqll:ready_status()",12)
	 elseif qqll.child_ready==false then
		main_Exe("say 等等助手")
		world.DoAfterSpecial(1,"qqll:ready_status()",12)
	 end
end

--走到位置
function qqll:start()
  qqll:DeleteHistory()
   local rows=qqll:GetHistoryCount()
   if rows==0 then
	  qqll:init()
      return
   end
  local w=walk.new()
  w.walkover=function()
	 local worldID=GetWorldID()
	  if qqll.master_worldID==worldID then
	     print("主id就绪!")
		 qqll.master_ready=true
		  local cmd="/qqll.master_ready=true"
		 child_Exe(cmd)

		 qqll:ready_check()
	  else
	     print("子id就绪!")
		 qqll.child_ready=true
		 local cmd="/qqll.child_ready=true"
		 main_Exe(cmd)
		 local cmd="/qqll:ready_check()"
		 main_Exe(cmd)
	  end
  end
  w:go(644)
end

function qqll:wait_moment(flag)

	print("内功修炼")
	world.Send("unset 积蓄")
	if flag==1 then
	  local f=function()
		 local q=function() qqll:main_link() end
		 switch(q)
	   end
	   f_wait(f,60)
	else
	  local f=function()
		 local q=function() world.Send("say 休息结束") end
		 switch(q)
	   end
	   f_wait(f,60)
	end
	local b=busy.new()
	b.interval=0.5
	b.Next=function()
		local xiulian=world.GetVariable("xiulian")
		if xiulian=="xiulian_jingli" then
			process.neigong2()
		elseif xiulian=="xiulian_neili" then
			process.neigong3()
		elseif xiulian=="xiulian_dubook" then
		   local cmd=world.GetVariable("dubook_cmd") or "du book"
			process.readbook(cmd)
		elseif xiulian=="xiulian_skills" then
			qqll:redo_collectData()
		else
			process.neigong3()
		end
	end
	b:check()

end
--[[
你向马钰打听有关『job』的消息。
马钰说道：「既然如此，就麻烦姑娘将此物交付 江南神匠 淳于蓝。」
马钰在你的耳边悄声说道：此人神龙见首不见尾，上次撸大风(luda)曾在神龙岛见过他的踪迹。你可以去打听打听。
马钰给你一块七眼石�

虚孟有气无力地说道：「好汉饶命，这些黄金请笑纳。 ...」
虚孟丢下一些黄金。
虚孟转身几个起落就不见了。
你内力不济，身法慢了下来。
]]
function qqll:ask_job()
  local w=walk.new()
  w.walkover=function()
    world.Send("ask ma about 七眼石")
	local b=busy.new()
	b.interval=0.5
	b.Next=function()
	  world.Send("ask ma about job")
	  wait.make(function()
	   local l,w=wait.regexp("^(> |)马钰在你的耳边悄声说道：此人神龙见首不见尾，上次(.*)\\((.*)\\)曾在(.*)见过他的踪迹。你可以去打听打听。$|^(> |)马钰说道：「你们现在这么忙，不用麻烦你们了。」$|^(> |)马钰说道：「现在没有事情需要麻烦你们。」$|^(> |)马钰说道：「你还没领任务呢，怎么完成？」$|^(> |)马钰说道：「前路茫茫，.*竟欲一人前往，壮志可嘉，但贫道却不能放心啊。」$",5)
	   if l==nil then
		  qqll:start()
	      return
	   end
	   if string.find(l,"此人神龙见首不见尾") then
	      qqll.wait_count=0
	      local playername=w[2]
		  local playerid=w[3]
		  local location=w[4]
		  local b=busy.new()
		  b.Next=function()
		    qqll:xunwen_place(playername,playerid,location)
		  end
		  b:check()
	      return
	   end
	   --马钰说道：「现在没有事情需要麻烦你们。」
	   if string.find(l,"你还没领任务呢，怎么完成") or string.find(l,"现在没有事情需要麻烦你们") then
	       main_Exe("follow none")
		   child_Exe("follow none")
		    main_Exe("/qqll.child_ready=false")
		    main_Exe("/qqll.master_ready=false")
	      qqll:jobDone()
		   child_Exe("/qqll.child_ready=false")
		    child_Exe("/qqll.master_ready=false")
		  child_Exe("/qqll:jobDone()")

	      return
	   end
	   if string.find(l,"不用麻烦你们了") then
		   main_Exe("follow none")
		   child_Exe("follow none")
		    main_Exe("/qqll.child_ready=false")
		    main_Exe("/qqll.master_ready=false")
		    child_Exe("/qqll.child_ready=false")
		    child_Exe("/qqll.master_ready=false")
	       --CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."七窍玲珑任务:没有合适工作！", "red", "black") -- yellow on white
           qqll:wait_moment(1)
		   child_Exe("/qqll:wait_moment()")
	       return
	   end
	   if string.find(l,"前路茫茫") then
	      child_Exe("/qqll:start()")
		  qqll:start()
	      return
	   end
	  end)
	end
	b:check()

  end
  w:go(644)
end

function qqll:jobDone()

end

function qqll:reward()
     child_Exe("follow none") --辅助id
   main_Exe("follow none") --辅助id
   child_Exe("/qqll:go_reward()") --辅助id
   main_Exe("/qqll:go_reward()") --辅助id
end

--[[
  五岳盟主亲传弟子「吸星大法」杨宗保(Questa)
  全真教掌教 先天功传人 洪八(Hongji)
  钱庄老板「千金万银进自来」钱缝(Qian feng)
  打手(Da shou)]]

function qqll:go_reward()
   local ts={
	           task_name="七窍玲珑玉",
	           task_stepname="奖励",
	           task_step=7,
	           task_maxsteps=7,
	           task_location="",
	           task_description="",
	}
	local st=status_win.new()
	st:init(nil,nil,ts)
	st:task_draw_win()
	CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."七窍玲珑任务:奖励", "yellow", "black") -- yellow on white
   shutdown()
   local w=walk.new()
	w.walkover=function()

		local worldID=GetWorldID()
		if qqll.master_worldID==worldID then
		main_Exe("ask ma about 完成")
		wait.make(function()
		  local l,w=wait.regexp("^(> |)任务完成，你被奖励了：$|^(> |)马钰说道：「你还没领任务呢，怎么完成？」$|^(> |)马钰说道：「你还没领任务呢，怎么完成？」$",10)
		  if l==nil then
		     qqll:reward()
		    return
		  end
		  if string.find(l,"你被奖励了") or string.find(l,"你还没领任务呢") then
		      print("奖励")
			  child_Exe("/qqll.master_ready=false")
	          main_Exe("/qqll.master_ready=false")
	          child_Exe("/qqll.child_ready=false")
	            main_Exe("/qqll.child_ready=false")
			  local b=busy.new()
		      b.Next=function()
		       qqll:jobDone()
			   child_Exe("/qqll:jobDone()")
		     end
		     b:check()
		     return
		  end
		end)
		end
	end
	w:go(644)
end

function qqll:giveup()
   child_Exe("follow none") --辅助id
   main_Exe("follow none") --辅助id
   child_Exe("/qqll:go_giveup()") --辅助id
   main_Exe("/qqll:go_giveup()") --辅助id
end

function qqll:go_giveup()
   local ts={
	           task_name="七窍玲珑玉",
	           task_stepname="放弃",
	           task_step=7,
	           task_maxsteps=7,
	           task_location="",
	           task_description="",
	}
	local st=status_win.new()
	st:init(nil,nil,ts)
	st:task_draw_win()
    local w=walk.new()
	w.walkover=function()

		local worldID=GetWorldID()
	    if qqll.master_worldID==worldID then
		   main_Exe("ask ma about fangqi")
	        wait.make(function()
			  local l,w=wait.regexp("^(> |)马钰从你那里拿回七眼石。$|^(> |)马钰说道：「放弃？没领任务你放弃什么？」$|^(> |)马钰说道：「放弃？没领任务你放弃什么？」$",5)
			  if l==nil then
			     qqll:giveup()
				 return
			  end
			  if string.find(l,"七眼石") or string.find(l,"没领任务") then
			     local b=busy.new()
				 b.Next=function()
				    qqll:main_link()
				 end
				 b:check()
			     return
			  end
			end)
	    end
	end
	w:go(644)
end

function qqll:lineup()
   world.Send("lineup form wuxing-zhen")
   world.Send("lineup with "..string.lower(qqll.partner1_id))
   child_Exe("lineup with "..string.lower(world.GetVariable("player_id")))
end

function qqll:continue()
  local cmd="/qqll:resume()"
   main_Exe(cmd)
end

function qqll:resume()
   coroutine.resume(qqll.co)
end

function qqll:stop_ok()
   if qqll.master_ready==true and qqll.child_ready==true then
       qqll.master_ready=false
	   qqll.child_ready=false
       qqll.main_link()
   end
end

function qqll:wait_stop()
   shutdown()
   world.DeleteVariable("qqll_player_status")
   local b=busy.new()
	b.interval=0.5
	b.Next=function()
	   local worldID=GetWorldID()
	   if qqll.master_worldID==worldID then
	     print("主id就绪!")
		 qqll.master_ready=true
		 qqll:stop_ok()
		 --qqll:recover_check()
	   else
	     print("子id就绪!")
		 local cmd="/qqll.child_ready=true"
		 main_Exe(cmd)

		 local cmd="/qqll:stop_ok()"
		 main_Exe(cmd)
	  end
	end
	b:check()
end

function qqll:wait_another_player()
	print("内功修炼")
	world.Send("unset 积蓄")
	local b=busy.new()
	b.interval=0.5
	b.Next=function()
		local xiulian=world.GetVariable("xiulian")
		if xiulian=="xiulian_jingli" then
			process.neigong2()
		elseif xiulian=="xiulian_neili" then
			process.neigong3()
		elseif xiulian=="xiulian_dubook" then
		   local cmd=world.GetVariable("dubook_cmd") or "du book"
			process.readbook(cmd)
		elseif xiulian=="xiulian_skills" then
			process.lian()
		else
			process.neigong3()
		end
	end
	b:check()
end

function qqll:player_Status_recheck()
  --获得变量值
  print(qqll.child_ready," child_ready")
  print(qqll.master_ready," master_ready")
    if qqll.child_ready==true and qqll.master_ready==true then
      child_Exe("/qqll:wait_stop()")
	  main_Exe("/qqll:wait_stop()")
	  child_Exe("/qqll.master_ready=false")
	  main_Exe("/qqll.master_ready=false")
	  child_Exe("/qqll.child_ready=false")
	  main_Exe("/qqll.child_ready=false")
   else
      local f=function()
	     print("qqll 重新启动")
	     shutdown()
	     qqll:Player_Status_Check()
	  end
	  f_wait(f,30)
	  qqll:wait_another_player()
   end
end

function qqll:Player_Status_Check()
	--world.SetVariable("qqll_player_status","ok")

   --是否子id
   --主id 代码
   local partner_id=world.GetVariable("qqll_partner_id") or ""
   local leader_id=world.GetVariable("qqll_leader_id") or ""

   if partner_id=="" then
	  print("qqll_partner_id 变量没有设置")
	  print("辅助id 不需要设置，请设置为空")
	  qqll:wait_another_player()
	  return
   end

   --qqll.child_ready=false
   --qqll.master_ready=false
    for k, v in pairs (GetWorldIdList ()) do
      local player_id=GetWorldById (v):GetVariable("player_id") or ""
	  if string.lower(player_id)==string.lower(leader_id) then
	    qqll.master_worldID=v
	    break
	  end
	end
   print(qqll.master_worldID," master_worldID")
   for k, v in pairs (GetWorldIdList ()) do
    local player_id=GetWorldById (v):GetVariable("player_id") or ""
	if string.lower(player_id)==string.lower(partner_id) then
	   print(player_id)
	  if v~=qqll.master_worldID then
	        qqll.partner1_id=string.lower(partner_id)
	        qqll.child_worldID= v
	   break
	  end
	end
  end
  print(qqll.child_worldID," child_worldID")
  --辅助id 参数设置
  local cmd="/qqll.master_worldID='"..qqll.master_worldID.."'"
  child_Exe(cmd)
  main_Exe(cmd)
  cmd="/qqll.child_worldID='"..qqll.child_worldID.."'"
  child_Exe(cmd)
  main_Exe(cmd)

   if qqll.master_worldID==GetWorldID() then

      child_Exe("/qqll.master_ready=true")
	  main_Exe("/qqll.master_ready=true")
   else

      child_Exe("/qqll.child_ready=true")
	  main_Exe("/qqll.child_ready=true")
   end
  --qqll:wait_another_player()
   --cmd="/qqll:player_Status_recheck(true)'"
   --child_Exe(cmd)
  --main_Exe(cmd)
  qqll:player_Status_recheck()
end
