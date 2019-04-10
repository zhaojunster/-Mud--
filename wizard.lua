
function wizard_end()
end

local function wizard_start()
  local _exps=world.GetVariable("exps")
  _exps=tonumber(_exps)

----------------战斗-------------------

  local pfm
  pfm=world.GetVariable("pfm")
  if pfm==nil then
     print("需要设置pfm变量:战斗时自动施放 例 wield jian;jiali max;perform sword.haichao;jiali 1;yun xinjing")
     world.SetVariable("pfm","")
  end
  local cmd --block npc perform
  cmd=world.GetVariable("cmd")
  if cmd==nil then
    print("需要设置cmd变量: kill 挡路npc 时候使用 例 perform xxxx")
    world.SetVariable("cmd","")
  end
  local unarmed_pfm
  unarmed_pfm=world.GetVariable("unarmed_pfm")
  if unarmed_pfm==nil then
    print("需要设置unarmed_pfm变量: 武器丢失被夺时候的技能 例 get jian;wield jian;perform haichao 或 切换空手技能 类pfm变量设置")
	world.SetVariable("unarmed_pfm","")
  end
-----------------技能--------------------

  local wuxing
  wuxing=world.GetVariable("wuxing")
  if wuxing==nil then
     print("需要设置wuxing 变量：如果学习领悟需要 提前yun 内功  可以写入，例 yun qimen 或 yun xinjing  ")
     world.SetVariable("wuxing","")
  end
  local shield
  shield=world.GetVariable("shield")
  if shield==nil then
    print("需要设置shield 变量：如果战斗前需要 yun 内功 或装备武器  可以写入，例 wield sword;yun longxiang 或 yun shield  ")
    world.SetVariable("shield","")
  end
   local afk_cmd=world.GetVariable("afk_cmd")
   local afk_sec=world.GetVariable("afk_sec")
   if afk_cmd==nil then
      world.SetVariable("afk_cmd","")
   end
   if afk_sec==nil then
      world.SetVariable("afk_sec","60")
   end

    local sp_exert
	sp_exert=world.GetVariable("sp_exert")
  if sp_exert==nil then
    print("需要设置sp_exert 变量：如果战斗前需要 yun 内功 或装备武器  可以写入，例 '全部':'wield sword;yun longxiang'  ")
    world.SetVariable("sp_exert","")
  end
  local liao_percent
  liao_percent=world.GetVariable("liao_percent")
  if liao_percent==nil then
    print("需要设置liao_percent 变量：找薛疗伤气血比例")
    world.SetVariable("liao_percent","80")
  end
  local pot
  pot=world.GetVariable("pot")
  if pot==nil then
    print("需要设置pot 变量： 每次学习的pot 设置值 1~50 ")
    world.SetVariable("pot","1")
  end
  local pot_overflow
  pot_overflow=world.GetVariable("pot_overflow")
  if pot_overflow==nil then
     print("需要设置pot_overflow 变量： pot=maxpot-pot_overflow 时就去学习领悟,负值就会一直job  ")
     world.SetVariable("pot_overflow",20)
  end
  local up
  up=world.GetVariable("up")
  if up==nil then
     print("需要设置up 变量: 消耗pot 方式 up 值=learn,lingwu,duanzao,zhizhao,chenggao,literate 会自动消耗银行存款学习,cun 存潜能银行")

	 if _exps>1000000 then
	    world.SetVariable("up","lingwu")
	 else
	    world.SetVariable("up","learn")
	 end
  end
  local bei_up
  bei_up=world.GetVariable("bei_up")
  if bei_up==nil then
     print("需要设置bei_up 变量: 消耗pot 方式 bei_up 值=learn,lingwu 银行gold 不够时自动切换")
	  if _exps>1000000 then
	    world.SetVariable("bei_up","lingwu")
	 else
	    world.SetVariable("bei_up","learn")
	 end
  end
  local skills
  skills=world.GetVariable("skills")
  if skills==nil then
     print("需要设置skills 变量: 学习skills 或 领悟的 skills  例 longxiang-boruo|dashou-yin|hand|dodge|yuxue-dunxing|parry|poison|huanxi-chan|force")
     world.SetVariable("skills","")
  end
  local lian_skills
  lian_skills=world.GetVariable("lian_skills")
  if lian_skills==nil then
	 print("需要设置lian_skills 变量: 练习skills  例 龙象般若功&force|大手印&hand|摘星功&dodge")
     world.SetVariable("lian_skills","")
  end
  local lingwu_end
  lingwu_end=world.GetVariable("lingwu_end")
  if lingwu_end==nil then

     world.SetVariable("lingwu_end","false")
  end
  local sleeproomno
  sleeproomno=world.GetVariable("sleeproomno")
  if sleeproomno==nil then
     print("需要设置sleeproomno 变量: 学习时候到指定房间休息恢复。只在up=learn 有效。sz区域房间名称 查找对应房间号 例 sz少林睡房")
     world.SetVariable("sleeproomno","")
  end
  local master_place
  master_place=world.GetVariable("master_place")
  if master_place==nil then
	print("需要设置master_place 变量: 学习时候到指定房间学习师傅。只在up=learn 有效。sz区域房间名称 查找对应房间号 例 sz少林睡房")
	world.SetVariable("master_place","")
  end
  local masterid
  masterid=world.GetVariable("masterid")
  if masterid==nil then
     print("需要设置masterid 变量: 师傅的id。只在up=learn 有效。例 huang")
	world.SetVariable("masterid","")
  end


  local neili_upper
  neili_upper=world.GetVariable("neili_upper")
  if neili_upper==nil then
    print("需要设置neili_upper 变量: 开始job 前打坐的倍数1-1.99 之间值")
	world.SetVariable("neili_upper","1.9")
  end
  local i_equip
  i_equip=world.GetVariable("i_equip")
  if i_equip==nil then
     print("需要设置i_equip 变量:自动检查获取装备")
     world.SetVariable("i_equip","<保存>黄金&5|<保存>白银&200|<保存>铜钱&200|<保存>银票&10")
  end
  local xiulian
  xiulian=world.GetVariable("xiulian")
  if xiulian==nil then
     print("需要设置xiulian 变量:job busy 修炼内力或精力 填写 xiulian_jingli 或 xiulian_neili")
	 world.SetVariable("xiulian","xiulian_neili")
  end
------------------hb job 需要使用
  local hb_auto=world.GetVariable("hb_auto")
  if hb_auto==nil then
      print("护镖自动切换jobslist")
     world.SetVariable("hb_auto","true")
  end
  local hb_jobslist=world.GetVariable("hb_jobslist")
  if hb_jobslist==nil then
     world.SetVariable("hb_jobslist","")
  end
  local hb_pfm=world.GetVariable("hb_pfm")
  if hb_pfm==nil then
     world.SetVariable("hb_pfm","")
  end
  local hb_cmd=world.GetVariable("hb_cmd")
  if hb_cmd==nil then

      print("护镖主id 命令子id 执行指令,用于子id 切换jobslist")
     world.SetVariable("hb_cmd","")
  end

------------------xs job 需要使用
  local xs_blacklist
  xs_blacklist=world.GetVariable("xs_blacklist")
  if xs_blacklist==nil then
     print("需要设置xs_blacklist 变量: 雪山job 需要放弃的 guard  可以设置门派和武器的组合 例 桃花岛|渤泥岛&长剑|少林&布衣")
     world.SetVariable("xs_blacklist","")
  end
  local xs_pfm
  xs_pfm=world.GetVariable("xs_pfm")
  if xs_pfm==nil then
     world.SetVariable("xs_pfm","")
  end
  local sx_pfm
  sx_pfm=world.GetVariable("sx_pfm")
  local sx2_pfm
  sx2_pfm=world.GetVariable("sx2_pfm")
  if sx_pfm==nil then
     world.SetVariable("sx_pfm","")
  end
  if sx2_pfm==nil then
     world.SetVariable("sx2_pfm","")
  end
    local cl_pfm
  cl_pfm=world.GetVariable("cl_pfm")
  if cl_pfm==nil then
     world.SetVariable("cl_pfm","")
  end
    local wd_pfm
  wd_pfm=world.GetVariable("wd_pfm")
  if wd_pfm==nil then
     world.SetVariable("wd_pfm","")
  end
    local hs_pfm
  hs_pfm=world.GetVariable("hs_pfm")
  if hs_pfm==nil then
     world.SetVariable("hs_pfm","")
  end
    local hs2_pfm
  hs2_pfm=world.GetVariable("hs2_pfm")
  if hs2_pfm==nil then
     world.SetVariable("hs2_pfm","")
  end
    local gb_pfm
  gb_pfm=world.GetVariable("gb_pfm")
  if gb_pfm==nil then
     world.SetVariable("gb_pfm","")
  end
    local tdh_pfm
  tdh_pfm=world.GetVariable("tdh_pfm")
  if tdh_pfm==nil then
     world.SetVariable("tdh_pfm","")
  end
  local zs_pfm
  zs_pfm=world.GetVariable("zs_pfm")
  if zs_pfm==nil then
     world.SetVariable("zs_pfm","")
  end
  local ss_kill_pfm
  ss_kill_pfm=world.GetVariable("ss_kill_pfm")
  if ss_kill_pfm==nil then
     world.SetVariable("ss_kill_pfm","")
  end
  local ss_fight_pfm
  ss_fight_pfm=world.GetVariable("ss_fight_pfm")
  if ss_fight_pfm==nil then
     world.SetVariable("ss_fight_pfm","")
  end
  local ss_fight_pfm_list
  ss_fight_pfm_list=world.GetVariable("ss_fight_pfm_list")
  if ss_fight_pfm_list==nil then
     world.SetVariable("ss_fight_pfm_list","")
  end
  local ss_kill_pfm_list
  ss_kill_pfm_list=world.GetVariable("ss_kill_pfm_list")
  if ss_kill_pfm_list==nil then
     world.SetVariable("ss_kill_pfm_list","")
  end
 local tm_pfm
  tm_pfm=world.GetVariable("tm_pfm")
  if tm_pfm==nil then
     world.SetVariable("tm_pfm","")
  end

  local sm_pfm
  sm_pfm=world.GetVariable("sm_pfm")
  if sm_pfm==nil then
     world.SetVariable("sm_pfm","")
  end

  local xl_pfm
  xl_pfm=world.GetVariable("xl_pfm")
  if xl_pfm==nil then
     world.SetVariable("xl_pfm","")
  end

  local jy_pfm
  jy_pfm=world.GetVariable("jy_pfm")
  if jy_pfm==nil then
     world.SetVariable("jy_pfm","")
  end
------------------sx job 需要使用
  local sx_blacklist
  sx_blacklist=world.GetVariable("sx_blacklist")
  if sx_blacklist==nil then
     print("需要设置sx_blacklist 变量: 送信job 需要放弃的 sx2 npc 武器技能列表 可以设置门派和武器的组合 例 少林派&韦陀杵|星宿派&天山杖法|华山派&独孤九剑")
     world.SetVariable("sx_blacklist","")
  end
  local cl_blacklist
  cl_blacklist=world.GetVariable("cl_blacklist")
  if cl_blacklist==nil then
	 print("需要设置cl_blacklist 变量: 长乐帮job 放弃的门派 例 星宿|桃花")
     world.SetVariable("cl_blacklist","")
  end
  local wd_blacklist
  wd_blacklist=world.GetVariable("wd_blacklist")
  if cl_blacklist==nil then
	 print("需要设置wd_blacklist 变量: 武当job 放弃的门派或技能 例 星宿派|独孤九剑|腾龙匕首")
     world.SetVariable("wd_blacklist","")
  end
  local difficulty
  difficulty=world.GetVariable("difficulty")
  if difficulty==nil then
     print("需要设置difficulty 变量: 武当job 难度等级1~4 级 1 不足为虑 2 颇为了得 3 极其厉害 4 已如化境")
     world.SetVariable("difficulty","1")
  end
  local immediate_sx1
  immediate_sx1=world.GetVariable("immediate_sx1")
  if immediate_sx1==nil then
     print("需要设置immediate_sx1 变量:sx1 立即送信不等待杀手")
     world.SetVariable("immediate_sx1","")
  end
  local blockNPC
  blockNPC=world.GetVariable("blockNPC")
  if blockNPC==nil then
     print("需要设置blockNPC:挡路NPC pfm使用设置")
	 world.SetVariable("blockNPC","")
  end
  local sx_giveup_pos
   sx_giveup_pos=world.GetVariable("sx_giveup_pos")
  if sx_giveup_pos==nil then
     print("需要设置sx_giveup_pos:送信放弃地点")
	 world.SetVariable("sx_giveup_pos","绝情谷|神龙岛|姑苏慕容|燕子坞|曼佗罗山庄|天山|武当山院门|武当山后山小院|沙滩|小岛")
  end

    local ss_blacklist
  ss_blacklist=world.GetVariable("ss_blacklist")
  if ss_blacklist==nil then
	 print("需要设置ss_blacklist 变量: 嵩山job 放弃的门派或技能 例 星宿派|独孤九剑|腾龙匕首")
     world.SetVariable("ss_blacklist","")
  end
------------------wd job 需要使用


------------------模块切换---------------
  local jobslist
  jobslist=world.GetVariable("jobslist")
  if jobslist==nil then
     print("需要设置without_fight 变量: 雪山job 需要放弃的 guard  可以设置门派和武器的组合 例 桃花岛|渤泥岛&长剑|少林&布衣")
     world.SetVariable("jobslist","")
  end
  local shashou_level
  shashou_level=world.GetVariable("shashou_level")
  if shashou_level==nil then
     print("需要设置shashou_level 变量: 送信job 杀手难度等级 -1 放弃 sx2 job 0 微不足道 1 马马虎虎 2 小有所成 3 融会贯通 5 颇为了得 9 极其厉害 10 已入化境")
     world.SetVariable("shashou_level","-1")
  end
------------------区域进出开关
   local wdj_entry=world.GetVariable("wdj_entry")
   if wdj_entry==nil then
       world.SetVariable("wdj_entry","false")
   end
   local putian_entry=world.GetVariable("putian_entry")
   if putian_entry==nil then
     if _exps>=170000 then
	    world.SetVariable("putian_entry","true")
	 else
	    world.SetVariable("putian_entry","false")
	 end
   end
	local shaolin_entry=world.GetVariable("shaolin_entry")
	if shaolin_entry==nil then
     if _exps>=170000 then
	    world.SetVariable("shaolin_entry","true")
	 else
	    world.SetVariable("shaolin_entry","false")
	 end
    end
	local heimuya_entry=world.GetVariable("heimuya_entry")
	if heimuya_entry==nil then
	  if _exps>=1500000 then
	    world.SetVariable("heimuya_entry","true")
	 else
	    world.SetVariable("heimuya_entry","false")
	 end
	end
	local wudanghoushan_entry=world.GetVariable("wudanghoushan_entry")
	if wudanghoushan_entry==nil then
	   world.SetVariable("wudanghoushan_entry","false")
	end
    local tianshan_entry=world.GetVariable("tianshan_entry")
	if tianshan_entry==nil then
	   if _exps>=200000 then
	    world.SetVariable("tianshan_entry","true")
	   else
	    world.SetVariable("tianshan_entry","false")
	   end
	end
	local jueqinggu_entry=world.GetVariable("jueqinggu_entry")
    if jueqinggu_entry==nil then
	    if _exps>=200000 then
	      world.SetVariable("jueqinggu_entry","true")
	   else
	      world.SetVariable("jueqinggu_entry","false")
	   end
	end
    local taoyuan_entry=world.GetVariable("taoyuan_entry")
	if taoyuan_entry==nil then
	   world.SetVariable("taoyuan_entry","false")
	end
	local hudiegu_entry=world.GetVariable("hudiegu_entry")
	if hudiegu_entry==nil then
	   world.SetVariable("hudiegu_entry","false")
	end
	local sld_entry=world.GetVariable("sld_entry")
	if sld_entry==nil then
	    world.SetVariable("sld_entry","true")
	end
	local taohuadao_entry=world.GetVariable("taohuadao_entry")
	if taohuadao_entry==nil then
	   world.SetVariable("taohuadao_entry","false")
	end
	local mr_entry=world.GetVariable("mr_entry")
	if mr_entry==nil then
	   world.SetVariable("mr_entry","false")
	end
	local mty_entry=world.GetVariable("mty_entry")
	if mty_entry==nil then
	   world.SetVariable("mty_entry","false")
	end
	--
	local pfm1
	local pfm2
	local pfm3
	local pfm4
	local pfm5
	pfm1=world.GetVariable("pfm1")
	pfm2=world.GetVariable("pfm2")
	pfm3=world.GetVariable("pfm3")
	pfm4=world.GetVariable("pfm4")
	pfm5=world.GetVariable("pfm5")
	if pfm1==nil then
	  world.SetVariable("pfm1","")
	end
   if pfm2==nil then
	  world.SetVariable("pfm2","")
	end
	if pfm3==nil then
	  world.SetVariable("pfm3","")
	end
	if pfm4==nil then
	  world.SetVariable("pfm4","")
	end
	if pfm5==nil then
	  world.SetVariable("pfm5","")
	end
	--特殊heal 变量
	local special_heal=world.GetVariable("special_heal")
	if special_heal==nil then
	   world.SetVariable("special_heal","false")
	end
	--wizard end
	local liandu=world.GetVariable("liandu")
	if liandu==nil then
	   world.SetVariable("liandu","")
	end
	--
	local is_canwu=world.GetVariable("is_canwu")
	if is_canwu==nil then
	   world.SetVariable("is_canwu","true")
	end
	wizard_end()
end

local _skills_id
function get_all_skills_id()
    wait.make(function()
	  local l,w=wait.regexp("^.*\\((.*)\\).*$|^(> |)设定环境变量：look \\= \"YES\"$",5)
	  if l==nil then
	     get_all_skills_id()
	     return
	  end
	  if string.find(l,")") then
	     _skills_id=_skills_id..w[1].."|"
	     get_all_skills_id()
	     return
	  end
	  if string.find(l,"设定环境变量：look") then
	     if string.len(_skills_id)>0 then
		    world.SetVariable("teach_skills",string.sub(_skills_id,1,-2))
		 end
	     return
	  end
	  wait.time(5)
	end)
end

function get_skill()
 -- local teach_skills
 --teach_skills=world.GetVariable("teach_skills")
 --if teach_skills==nil then
    --print("需要设置teach_skills变量: 教薛慕华的skill名称 例 dashou-yin|yuxue-dunxing|longxiang-boruo|huanxi-chan")
	world.Send("cha")
	world.Send("set look")
	--world.SetVariable("teach_skills","")
	_skills_id=""
	get_all_skills_id()
 --end
end

function ch_over()
   print("检查结束")
end
--┃经验额外获取：〖百分之二十〗    参悟天赋：无          未分配天赋：无      ┃
function get_score()
	  wait.make(function()
	    local l,w=wait.regexp("^┃姓    名：(.*)\\((.*)\\).*┃$|^┃性    别：(.*)┃$|^┃.*师    承：【(.*)】【(.*)】.*|^┃注册：(.*)┃$|^┃称    谓：【(.*)】.*|^┃经验额外获取：(.*)参悟天赋：(.*)未分配天赋：(.*)┃|^┃.*师    承：【普通百姓】.*|.*师    承：【古墓派】.*",5)
		if l==nil then
		   auto_variable()
		   return
		end
		if string.find(l,"姓    名") then
		   world.SetVariable("player_name",Trim(w[1]))
		   world.SetVariable("player_id",w[2])
		   get_score()
		   return
		end
		if string.find(l,"性    别") then
		  if string.find(w[3],"男性") then
		     world.SetVariable("gender","男性")
		  elseif string.find(w[3],"女性") then
             world.SetVariable("gender","女性")
          else
		      world.SetVariable("gender","东方不败")
          end
		   get_score()
		   return
		end
		if string.find(l,"普通百姓") then
		   world.SetVariable("party","无")
		   world.SetVariable("mastername","无")
		   get_score()
		   return
		end
		if string.find(l,"古墓派") and Trim(w[5])=="" then
		   --print(w[5],"  w5")
		    world.SetVariable("party","古墓派")
		   world.SetVariable("mastername","无")
		   get_score()
           return
		end
		if string.find(l,"师    承") then
		   world.SetVariable("party",w[4])
		   world.SetVariable("mastername",w[5])
		   get_score()
		   return
		end
		if string.find(l,"注册") then
		   if string.find( w[6],"普通玩家") then
		      world.SetVariable("vip","普通玩家")
		   elseif string.find(w[6],"荣誉终身贵宾") then
		      world.SetVariable("vip","荣誉终身贵宾")
		   else
		      world.SetVariable("vip","贵宾玩家")
		   end
		   wizard_start()
		   ch_over()
		   return
		end
		if string.find(l,"称    谓") then
			world.SetVariable("title",w[7])
		    get_score()
		   return
		end
		if string.find(l,"参悟天赋") then
		   local exert_reward=Trim(w[8])
		   exert_reward=string.gsub(exert_reward,"〗","")
		   exert_reward=string.gsub(exert_reward,"〖","")
		   if exert_reward=="无" then
		      world.SetVariable("exert_reward","0")
		   else
		      exert_reward=string.gsub(exert_reward,"百分之","")
			  exert_reward=ChineseNum(exert_reward)
			  world.SetVariable("exert_reward",exert_reward)
		   end

		   local exert_gift=Trim(w[9])
		   if exert_gift=="无" then
		      world.SetVariable("exert_gift","0")
		   else
		      exert_gift=ChineseNum(exert_gift)
			  world.SetVariable("exert_gift",exert_gift)
		   end
		   local exert_unset_gift=Trim(w[10])
		   if exert_unset_gift=="无" then
		      world.SetVariable("exert_unset_gift","0")
		   else
		      exert_unset_gift=ChineseNum(exert_unset_gift)
		      world.SetVariable("exert_unset_gift",exert_unset_gift)
		   end
		   get_score()
		   return
		end
		wait.time(5)
	  end)
end

function auto_variable()
  --player_id 门派 exps vip 进出开关 变量存在检查
---------------自动获得---------------
  --world.SetVariable("get_exp","0")
  local h=hp.new()
  h.checkover=function()
      get_skill()
      world.Send("score")
	  get_score()
  end
  h:check()
end

wizard={
  jobslist={},
  jobs_auto_setting=false,
}
--1
function wizard:jobs_select()
    self.jobslist={}
    local yesno=utils.msgbox ("是否使用常用任务组合？", "任务选择", "yesno", "?")
	if yesno=="yes" then
	   local jobslist={
	     combo1="华山1+丐帮",
	     combo2="华山2+送信",
		 combo3="长乐帮+嵩山",
		 combo4="武当+华山1+送信",
		 combo5="雪山+嵩山+长乐帮",
		 combo6="华山1+送信",
		 combo7="送信+长乐帮",
		 combo8="丐帮+长乐帮",
	   }

	     local select_job=utils.listbox ("选择你要做任务", "任务选择", jobslist)
         if select_job=="combo1" then
		    table.insert(self.jobslist,"hs")
			table.insert(self.jobslist,"gb")
			world.SetVariable("jobslist","hs|gb")
		 elseif select_job=="combo2" then
		     table.insert(self.jobslist,"hs2")
			table.insert(self.jobslist,"sx")
			world.SetVariable("jobslist","hs2|sx")
		 elseif select_job=="combo3" then
		    table.insert(self.jobslist,"ss")
			table.insert(self.jobslist,"cl")
			world.SetVariable("jobslist","cl|ss")
		 elseif select_job=="combo4" then
		    table.insert(self.jobslist,"wd")
			table.insert(self.jobslist,"sx")
			table.insert(self.jobslist,"hs")
			world.SetVariable("jobslist","wd|(hs|sx)")
		 elseif select_job=="combo5" then
		     table.insert(self.jobslist,"xs")
			table.insert(self.jobslist,"ss")
			table.insert(self.jobslist,"cl")
			world.SetVariable("jobslist","xs|(ss|cl)")
		 elseif select_job=="combo6" then
		    table.insert(self.jobslist,"hs")
			table.insert(self.jobslist,"sx")
			world.SetVariable("jobslist","hs|sx")
		 elseif select_job=="combo7" then
		    table.insert(self.jobslist,"sx")
			table.insert(self.jobslist,"cl")
			world.SetVariable("jobslist","sx|cl")
		 elseif select_job=="combo8" then
		    table.insert(self.jobslist,"gb")
			table.insert(self.jobslist,"cl")
			world.SetVariable("jobslist","gb|cl")
		 end
		 self.jobs_auto_setting=true
	     self:jobs_setting()
	    return

	end

  local jobs={
    xc="1.1 大理巡城",
	tdh="2.1 天地会",
	zc="2.2 洪七公做菜",
	wd="3.1 武当",
	hs="3.2 华山1",
	hs2="3.3 华山2",
	sx="3.4 大理送信",
	xs="4.1 雪山",
	cl="4.2 长乐帮",
	tx="5.1 慕容偷学",
	suoming="5.2 神龙岛索命",
	sm="5.3 桃花岛守墓",
	ss="5.4 左冷禅任务",
	gb="5.5 丐帮",
	zs="5.6 抓蛇",
	jh="5.7 浇花",
	tm="5.8 少林教武僧",
	ck="5.9 采矿",
	xl="6.0 明教巡逻任务",
	jy="6.1 少林救援任务",
	xxbug="6.2 星宿抓虫",
	qqll="6.3 七窍玲珑玉任务"

  }
  local select_job=utils.multilistbox ("选择你要做任务", "任务选择", jobs)
  if select_job then
     local str_jobs=""
	 for n,j in pairs(select_job) do
	   --if j==select_job then
	      --local name=n
		  --print(name)
	      table.insert(self.jobslist,n)
		  str_jobs=str_jobs..n.."|"
	   --end
	 end
	 if str_jobs~="" then
	   str_jobs=string.sub(str_jobs,1,-2)
	 end
     --for _,i in pairs(self.jobslist) do print(i) end
   local _jobs=utils.inputbox ("设置任务变量", "任务选择", str_jobs, "宋体", 9)
   if _jobs then
       world.SetVariable("jobslist",_jobs)
   end
	self:jobs_setting()

  else
     self.jobslist={}
  end
end


function wizard:jobs_setting()
   for _,job in ipairs(self.jobslist) do
       print(job)
       if job=="wd" then
	     self:wudang_setting()
	   elseif job=="sx" then
	     self:songxin_setting()
	   elseif job=="hs" then
	     self:huashan_setting()
	   elseif job=="hs2" then
	     self:huashan2_setting()
	   elseif job=="xs" then
	     self:xueshan_setting()
	   elseif job=="cl" then
	     self:changle_setting()
	   elseif job=="gb" then
	     self:gaibang_setting()
	   elseif job=="tdh" then
	     self:tiandihui_setting()
	   elseif job=="xc" then
	     self:xuncheng_setting()
	    elseif job=="zc" then
		 self:zuocai_setting()
	   elseif job=="ss" then
		 self:songshan_setting()
	   elseif job=="suoming" then
	     self:suoming_setting()
	   elseif job=="zs" then
	      self:zhuashe_setting()
	   elseif job=="tm" then
	      self:teachmonk_setting()
	   elseif job=="tx" then
	      self:touxue_setting()
	   elseif job=="ck" then
	      self:caikuang_setting()
	   elseif job=="sm" then
		  self:shoumu_setting()
		elseif job=="xl" then
		  self:xunluo_setting()
		elseif job=="jy" then
		  self:jiuyuan_setting()
		elseif job=="qj" then
		  self:qiangjie_setting()
	  end
   end
end

function wizard:touxue_setting()
     --[[
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="tx" then
		     table.insert(jb1,j)
		  end
	   end

	   local _jb1=utils.listbox ("设置偷学任务后续的job1:", "偷学任务", jb1)
	   if _jb1 then
	     result="tx|"..jb1[_jb1]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end]]
end

function wizard:xuncheng_setting()
   local drug={
     neixiwan="1 内息丸",
	 xujingdan="2 续精丹",
   }
   local _drug=utils.listbox ("设置巡城任务吃药:", "巡城任务", drug)
   if _drug then
       world.SetVariable("xc_type",_drug)
   else
       return
   end

end

function wizard:caikuang_setting()
--[[
    if self.jobs_auto_setting==false then
	  local jb1={}
	   for _,j in ipairs(self.jobslist) do
		  table.insert(jb1,j)
	   end
       local _jb1=utils.listbox ("设置采矿任务后续的job:", "采矿任务", jb1)
	   if _jb1 then
	   else
          return
	   end
	   local jb2={}
	    for _,j in ipairs(self.jobslist) do
	      if j~="ck" and j~=self.jobslist[_jb1] then
		     table.insert(jb2,j)
		  end
	   end
	   local _jb2=utils.listbox ("设置采矿任务后续的job2:", "采矿任务", jb2)
	   if _jb2 then
	     result="ck|("..jb1[_jb1].."|"..jb2[_jb2]..")"
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
    end]]
	local ck_playId=utils.inputbox ("矿石需要送给的玩家的ID不填写表示自己交给铁匠", "采矿任务", "", "宋体", 9)
   if ck_playId then
     world.SetVariable("ck_playId",ck_playId)
   else
     return
   end
end

function wizard:tiandihui_setting()
   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5",
	    }
	   local _pfm=utils.listbox ("设置天地会任务使用的pfm:", "天地会任务", pfm)
	   if _pfm then
	      world.SetVariable("tdh_pfm",_pfm)
	   else
	      return
	   end
	   --[[
    if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="tdh" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置天地会任务后续的job1:", "天地会任务", jb1)
	   if _jb1 then
	     result="tdh|"..jb1[_jb1]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:wudang_setting()

     local t={"1.不足为虑","2.颇为了得","3.极其厉害","4.已入化境",}
	 local diff=utils.listbox ("设置武当任务难度等级:", "武当任务", t)
	 if diff~=nil then
	   world.SetVariable("difficulty",diff)
	 else
	   return
	 end

   local blacklist={}

    blacklist={
	    ["武当派"]="1.1 武当派",
		["少林派"]="1.2 少林派",
		["星宿派"]="1.3 星宿派",
		["华山派"]="1.4 华山派",
		["峨嵋派"]="1.5 峨嵋派",
		["雪山派"]="1.6 雪山派",
		["姑苏慕容"]="1.7 姑苏慕容",
		["古墓派"]="1.8 古墓派",
		["嵩山派"]="1.9 嵩山派",
		["昆仑派"]="2.0 昆仑派",
		["神龙岛"]="2.1 神龙岛",
		["铁掌帮"]="2.2 铁掌帮",
		["丐帮"]="2.3 丐帮",
		["桃花岛"]="2.4 桃花岛",
		["天龙寺"]="2.5 天龙寺",
		["大理"]="2.6 大理",
		["韦陀杵"]="3.1 韦陀杵",
		["独孤九剑"]="3.2 独孤九剑",
		["玄阴剑法"]="3.3 玄阴剑法",
		["打狗棒法"]="3.4 打狗棒法",
		["腾龙匕法"]="3.5 腾龙匕法",
		["辟邪剑法"]="3.6 辟邪剑法",
		["降龙十八掌"]="3.7 降龙十八掌",
		["弹指神通"]="3.8 弹指神通",
		["天山杖法"]="3.9 天山杖法",
	  }

  local _blacklist=utils.multilistbox ("设置武当任务黑名单", "武当任务", blacklist)
  if _blacklist then
       --print(_menpai)
	  local result=""
      for n,i in pairs(_blacklist) do
		 result=result..n.."|"
	  end
	  if result~="" then
		result=string.sub(result,1,-2)
	  end
      world.SetVariable("wd_blacklist",result)
  else
      world.SetVariable("wd_blacklist","")
  end

	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置武当任务使用的pfm:", "武当任务", pfm)
	   if _pfm then
	      world.SetVariable("wd_pfm",_pfm)
	   else
	      return
	   end
	   local pfm_list={
	     pfm1_list="1 pfm1_list",
		 pfm2_list="2 pfm2_list",
		 pfm3_list="3 pfm3_list",
		 pfm4_list="4 pfm4_list",
		 pfm5_list="5 pfm5_list"
	   }
--^.*只觉得.*已被你的指风点中，身形不由的缓慢下来！$#身形不由的缓慢下来#wield xiao;jifa parry yuxiao-jian;jiali max;perform sword.feiying;yun qi;yun jingli&^.*你飞影使完，手一晃将.*拿回手中。$#你飞影使完#unwield xiao;jiali 1;jifa parry tanzhi-shentong;perform finger.tan
	   local _pfm_list=utils.listbox("设置武当任务使用的pfm_list 设置基本格式触发器的通配符1#匹配语句1#执行的命令1&触发器的通配符2#匹配语句2#执行的命令2\n例: ^.*只觉得.*已被你的指风点中，身形不由的缓慢下来！$#身形不由的缓慢下来#wield xiao;jifa parry yuxiao-jian;jiali max;perform sword.feiying&^.*你飞影使完，手一晃将.*拿回手中。$#你飞影使完#unwield xiao;jifa parry tanzhi-shentong;perform finger.tan","武当任务",pfm_list)
	   if _pfm_list then
	       world.SetVariable("wd_pfm_list",_pfm_list)
	   else
	       return
	   end

	  local all_skills_list=utils.inputbox ("拆解敌人技能所使用的pfm pfm_list 设置基本格式:技能名称1#pfm1#pfm1_list|技能名称2#pfm2#pfm2_list\n例:独孤九剑#pfm1#pfm1_list|弹指神通#pfm2#|打狗棒法#pfm2#pfm2_list", "武当任务", "", "宋体", 9)
	  if all_skills_list then
        world.SetVariable("all_skills_list",all_skills_list)
	  end
	--[[
    if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      --print(j)
	      if j~="wd" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置武当任务后续的job:", "武当任务", jb1)
	   if _jb1 then
	   else
          return
	   end
	   local jb2={}
	    for _,j in ipairs(self.jobslist) do
	      if j~="wd" and j~=self.jobslist[_jb1] then
		     table.insert(jb2,j)
		  end
	   end
	   local _jb2=utils.listbox ("设置武当任务后续的job2:", "武当任务", jb2)
	   if _jb2 then
	     result="wd->"..jb1[_jb1].."->"..jb2[_jb2]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end


function wizard:songxin_setting()

	local yesno=utils.msgbox ("第一次送信是否立即投递，不管杀手是否出现？", "送信任务", "yesno", "?")
	if yesno=="yes" then
	  world.SetVariable("immediate_sx1","true")
    else
      world.SetVariable("immediate_sx1","false")
	end

	 local t={"1.不做送信2", "2.微不足道", "3.马马虎虎", "4.小有所成", "5.融会贯通","6.颇为了得", "7.极其厉害","8.已入化境","9.全部做"}
	 local shashou_level=utils.listbox ("第二次送信杀手等级选择:", "送信任务", t)
	 if shashou_level~=nil then
	   world.SetVariable("shashou_level",shashou_level-1)
	 else
	   return
	 end

	local shashou_level=world.GetVariable("shashou_level")
    if tonumber(shashou_level)>=0 then
	 local blacklist={}

     blacklist={
	    ["武当派"]="1.1 武当派",
		["少林派"]="1.2 少林派",
		["星宿派"]="1.3 星宿派",
		["华山派"]="1.4 华山派",
		["峨嵋派"]="1.5 峨嵋派",
		["雪山派"]="1.6 雪山派",
		["姑苏慕容"]="1.7 姑苏慕容",
		["古墓派"]="1.8 古墓派",
		["嵩山派"]="1.9 嵩山派",
		["昆仑派"]="2.0 昆仑派",
		["神龙岛"]="2.1 神龙岛",
		["铁掌帮"]="2.2 铁掌帮",
		["丐帮"]="2.3 丐帮",
		["桃花岛"]="2.4 桃花岛",
		["天龙寺"]="2.5 天龙寺",
		["大理"]="2.6 大理",
		["韦陀杵"]="3.1 韦陀杵",
		["独孤九剑"]="3.2 独孤九剑",
		["玄阴剑法"]="3.3 玄阴剑法",
		["打狗棒法"]="3.4 打狗棒法",
		["腾龙匕法"]="3.5 腾龙匕法",
		["辟邪剑法"]="3.6 辟邪剑法",
		["降龙十八掌"]="3.7 降龙十八掌",
		["弹指神通"]="3.8 弹指神通",
		["天山杖法"]="3.9 天山杖法",
	  }

      local _blacklist=utils.multilistbox ("设置送信任务黑名单", "送信任务", blacklist)
      if _blacklist then
       --print(_menpai)
	    local result=""
        for n,i in pairs(_blacklist) do
		 result=result..n.."|"
	    end
	    if result~="" then
		 result=string.sub(result,1,-2)
	    end
        world.SetVariable("sx_blacklist",result)
      else
        world.SetVariable("sx_blacklist","")
      end
	end

	  local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }

	  local pfm_list={
	    pfm1_list="1 pfm1_list",
		pfm2_list="2 pfm2_list",
		pfm3_list="3 pfm3_list",
		pfm4_list="4 pfm4_list",
		pfm5_list="5 pfm5_list"
	  }
	   local _pfm=utils.listbox ("设置【送信1】任务使用的pfm:", "送信任务", pfm)
	   if _pfm then
	      world.SetVariable("sx_pfm",_pfm)
	   else
	      return
	   end
	   local _pfm_list=utils.listbox ("设置【送信1】任务使用的pfm_list:", "送信任务", pfm_list)
	   if _pfm_list then
	      world.SetVariable("sx1_pfm_list",_pfm_list)
	   else
	      return
	   end
	   local _pfm=utils.listbox ("设置【送信2】任务使用的pfm:", "送信任务", pfm)
	   if _pfm then
	      world.SetVariable("sx2_pfm",_pfm)
	   else
	      return
	   end
	   local _pfm_list=utils.listbox ("设置【送信2】任务使用的pfm_list:", "送信任务", pfm_list)
	   if _pfm_list then
	      world.SetVariable("sx2_pfm_list",_pfm_list)
	   else
	      return
	   end
	--[[
    if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="sx" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置送信任务后续的job1:", "送信任务", jb1)
	   if _jb1 then
	     result="sx->"..jb1[_jb1]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:huashan_setting()
    local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置华山任务使用的pfm:", "华山任务", pfm)
	   if _pfm then
	      world.SetVariable("hs_pfm",_pfm)
	   else
	      return
	   end

	    local yesno
		yesno =utils.msgbox ("是否自动调整工作次数解吸星大法？", "华山任务", "yesno", "?")
		if yesno=="yes" then
			world.SetVariable("quest_xxdf","true")
		else
			world.SetVariable("quest_xxdf","false")
		end
	--[[
	if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="hs" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置华山任务后续的job1:", "华山任务", jb1)
	   if _jb1 then
	     result="hs->"..jb1[_jb1]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:teachmonk_setting()
      local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置少林教武僧任务使用的pfm:", "少林教武僧任务", pfm)
	   if _pfm then
	      world.SetVariable("tm_pfm",_pfm)
	   else
	      return
	   end
	--[[
    if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      --print(j)
	      if j~="tm" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置少林教武僧任务后续的job:", "少林教武僧任务", jb1)
	   if _jb1 then
	   else
          return
	   end
	   local jb2={}
	    for _,j in ipairs(self.jobslist) do
	      if j~="tm" and j~=self.jobslist[_jb1] then
		     table.insert(jb2,j)
		  end
	   end
	   local _jb2=utils.listbox ("设置少林教武僧后续的job2:", "少林教武僧任务", jb2)
	   if _jb2 then
	     result="tm->"..jb1[_jb1].."->"..jb2[_jb2]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:huashan2_setting()
       local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置华山1 任务使用的pfm:", "华山2任务", pfm)
	   if _pfm then
	      world.SetVariable("hs_pfm",_pfm)
	   else
	      return
	   end

		local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置华山2 任务使用的pfm:", "华山2任务", pfm)
	   if _pfm then
	      world.SetVariable("hs2_pfm",_pfm)
	   else
	      return
	   end
	--[[
    if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="hs" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置华山2 任务后续的job1:", "华山2任务", jb1)
	   if _jb1 then
	     result="hs2->"..jb1[_jb1]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:xueshan_setting()
	  local blacklist={}
      blacklist={
	    ["桃花岛"]="1 桃花岛",
		["少林&铁棍"]="2 少林&铁棍",
		["大内高手"]="3 大内高手",
		["明教&布衣"]="4 明教&布衣",
	  }
      local _blacklist=utils.multilistbox ("设置雪山任务黑名单", "雪山任务", blacklist)
      if _blacklist then
       --print(_menpai)
	    local result=""
        for n,i in pairs(_blacklist) do
		 result=result..n.."|"
	    end
	    if result~="" then
		 result=string.sub(result,1,-2)
	    end
        world.SetVariable("xs_blacklist",result)
      else
        world.SetVariable("xs_blacklist","")
      end

	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置雪山任务使用的pfm:", "雪山任务", pfm)
	   if _pfm then
	      world.SetVariable("xs_pfm",_pfm)
	   else
	      return
	   end
	local yesno =utils.msgbox ("是否采用跑杀？", "雪山任务", "yesno", "?")
	if yesno=="yes" then
		world.SetVariable("xs_runkill","true")
	else
		world.SetVariable("xs_runkill","false")
	end
	--[[
	if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="xs" then
		     table.insert(jb1,j)
		  end
	   end

	    local _jb1=utils.listbox ("设置雪山任务后续的job:", "雪山任务", jb1)
	   if _jb1 then
	   else
          return
	   end
	   local jb2={}
	    for _,j in ipairs(self.jobslist) do
	      if j~="xs" and j~=self.jobslist[_jb1] then
		     table.insert(jb2,j)
		  end
	   end
	   local _jb2=utils.listbox ("设置雪山任务后续的job2:", "雪山任务", jb2)
	   if _jb2 then
	     result="xs->"..jb1[_jb1].."->"..jb2[_jb2]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:suoming_setting()
    local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置神龙岛索命任务使用的pfm:", "神龙岛索命任务", pfm)
	   if _pfm then
	      world.SetVariable("suoming_pfm",_pfm)
	   else
	      return
	   end
	   --[[
    if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      --print(j)
	      if j~="suoming" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置神龙岛索命任务后续的job:", "神龙岛索命任务", jb1)
	   if _jb1 then
	   else
          return
	   end
	   local jb2={}
	    for _,j in ipairs(self.jobslist) do
	      if j~="suoming" and j~=self.jobslist[_jb1] then
		     table.insert(jb2,j)
		  end
	   end
	   local _jb2=utils.listbox ("设置神龙岛索命后续的job2:", "神龙岛索命任务", jb2)
	   if _jb2 then
	     result="suoming->"..jb1[_jb1].."->"..jb2[_jb2]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:zhuashe_setting()
	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置抓蛇任务使用的pfm:", "丐帮抓蛇任务", pfm)
	   if _pfm then
	      world.SetVariable("zs_pfm",_pfm)
	   else
	      return
	   end
	   --[[
   if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="cl" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置抓蛇任务使用的pfm:", "丐帮抓蛇任务", jb1)
	   if _jb1 then
	     result="zs->"..jb1[_jb1]
		 print(result)
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:changle_setting()
	  local blacklist={}
      blacklist={
	    ["桃花岛"]="1 桃花岛",
		["星宿派"]="2 星宿派",
	  }
      local _blacklist=utils.multilistbox ("设置长乐帮任务黑名单", "长乐帮任务", blacklist)
      if _blacklist then
       --print(_menpai)
	    local result=""
        for n,i in pairs(_blacklist) do
		 result=result..n.."|"
	    end
	    if result~="" then
		 result=string.sub(result,1,-2)
	    end
        world.SetVariable("cl_blacklist",result)
      else
        world.SetVariable("cl_blacklist","")
      end

	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置长乐帮任务使用的pfm:", "长乐帮任务", pfm)
	   if _pfm then
	      world.SetVariable("cl_pfm",_pfm)
	   else
	      return
	   end
	--[[
    if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="cl" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置长乐帮任务后续的job1:", "长乐帮任务", jb1)
	   if _jb1 then
	     result="cl->"..jb1[_jb1]
		 print(result)
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:gaibang_setting()
  	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置丐帮任务使用的pfm:", "丐帮任务", pfm)
	   if _pfm then
	      world.SetVariable("gb_pfm",_pfm)
	   else
	      return
	   end
	   local gb_blacklist=world.GetVariable("gb_blacklist") or "干光豪|出尘子|五毒教女弟子|浪荡公子|富家公子|茅十八|洪哮天|岭南大盗|梁子翁|劳德诺|周孤桐|吴柏英|摘星子|狮吼子|黯然子|蒙古卫士|史镖头|王夫人|赵敏|吕文德|侯君集|忽必烈|达尔巴|龙卷风|马掌柜|张浩天|黄令天|薛慕华|贾布|天狼子"
	   gb_blacklist=utils.inputbox ("需要设置gb_blacklist 变量: 丐帮任务屏蔽的NPC 例 干光豪|出尘子|五毒教女弟子|浪荡公子|富家公子|茅十八|洪哮天|岭南大盗|梁子翁|劳德诺|周孤桐|吴柏英|摘星子|狮吼子|黯然子|蒙古卫士|史镖头|王夫人|赵敏|吕文德|侯君集|忽必烈|达尔巴|龙卷风|马掌柜|张浩天|黄令天|薛慕华|贾布|天狼子", "丐帮任务", gb_blacklist, "宋体", 9)
       if gb_blacklist~=nil then
          world.SetVariable("gb_blacklist",gb_blacklist)
       end
	--[[
    if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="cl" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置丐帮任务后续的job1:", "丐帮任务", jb1)
	   if _jb1 then
	     result="gb->"..jb1[_jb1]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:xunluo_setting()
  	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置明教巡逻任务使用的pfm:", "明教巡逻任务", pfm)
	   if _pfm then
	      world.SetVariable("xl_pfm",_pfm)
	   else
	      return
	   end


	  local yesno=utils.msgbox ("是否等待画印时候打坐(巡逻人多时候最好关闭)", "明教巡逻任务", "yesno", "?")
	   if yesno=="yes" then
	     world.SetVariable("xl_xiulian","true")
	   else
	     world.SetVariable("xl_xiulian","false")
	   end
--[[
    if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="xl" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置明教巡逻任务后续的job1:", "明教巡逻任务", jb1)
	   if _jb1 then
	     result="xl->"..jb1[_jb1]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:jiuyuan_setting()
  	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置少林救援任务使用的pfm:", "少林救援任务", pfm)
	   if _pfm then
	      world.SetVariable("jy_pfm",_pfm)
	   else
	      return
	   end
	 --[[
	if self.jobs_auto_setting==false then
		local jb1={}
		for _,j in ipairs(self.jobslist) do
	      if j~="sm" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置少林救援任务后续的job:", "少林救援任务", jb1)
	   if _jb1 then
	   else
          return
	   end
	   local jb2={}
	    for _,j in ipairs(self.jobslist) do
	      if j~="jy" and j~=self.jobslist[_jb1] then
		     table.insert(jb2,j)
		  end
	   end
	   local _jb2=utils.listbox ("设置少林救援任务后续的job2:", "少林救援任务", jb2)
	   if _jb2 then
	     result="sm->"..jb1[_jb1].."->"..jb2[_jb2]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:shoumu_setting()
  	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置守墓任务使用的pfm:", "守墓任务", pfm)
	   if _pfm then
	      world.SetVariable("sm_pfm",_pfm)
	   else
	      return
	   end
	--[[
	if self.jobs_auto_setting==false then
		local jb1={}
		for _,j in ipairs(self.jobslist) do
	      if j~="sm" then
		     table.insert(jb1,j)
		  end
	   end
	   local _jb1=utils.listbox ("设置守墓任务后续的job:", "守墓任务", jb1)
	   if _jb1 then
	   else
          return
	   end
	   local jb2={}
	    for _,j in ipairs(self.jobslist) do
	      if j~="sm" and j~=self.jobslist[_jb1] then
		     table.insert(jb2,j)
		  end
	   end
	   local _jb2=utils.listbox ("设置守墓后续的job2:", "守墓任务", jb2)
	   if _jb2 then
	     result="sm->"..jb1[_jb1].."->"..jb2[_jb2]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:qiangjie_setting()
  	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置星宿抢劫任务使用的pfm:", "星宿抢劫", pfm)
	   if _pfm then
	      world.SetVariable("qj_pfm",_pfm)
	   else
	      return
	   end
--[[
    if self.jobs_auto_setting==false then
	   local jb1={}
	   local _jb1=utils.listbox ("设置星宿抢劫后续的job1:", "星宿抢劫", jb1)
	   if _jb1 then
	     result="qj->"..jb1[_jb1]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:songshan_setting()
  	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置嵩山任务 请人所使用的pfm:", "嵩山任务", pfm)
	   if _pfm then
	      world.SetVariable("ss_fight_pfm",_pfm)
	   else
	      return
	   end


	   local pfm={
	     pfm1="1 pfm1",
		 pfm2="2 pfm2",
		 pfm3="3 pfm3",
		 pfm4="4 pfm4",
		 pfm5="5 pfm5"
	    }
	   local _pfm=utils.listbox ("设置嵩山任务 刺杀所使用的pfm:", "嵩山任务", pfm)
	   if _pfm then
	      world.SetVariable("ss_kill_pfm",_pfm)
	   else
	      return
	   end


	   local ss_blacklist=world.GetVariable("ss_blacklist")
	   ss_blacklist=utils.inputbox ("需要设置ss_blacklist 变量: 嵩山任务屏蔽的技能或门派 例 星宿派|降伏轮 ", "嵩山任务", ss_blacklist, "宋体", 9)
       if ss_blacklist~=nil then
          world.SetVariable("ss_blacklist",ss_blacklist)
       end
	if self.jobs_auto_setting==false then
	   local jb1={}
	   for _,j in ipairs(self.jobslist) do
	      if j~="ss" then
		     table.insert(jb1,j)
		  end
	   end
	   --[[
	   local _jb1=utils.listbox ("设置嵩山任务后续的job1:", "嵩山任务", jb1)
	   if _jb1 then
	     result="ss->"..jb1[_jb1]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end]]
	end
end

function wizard:zuocai_setting()

--[[	   local _jb1=utils.listbox ("设置洪七公做菜后续的job1:", "洪七公做菜任务", self.jobslist)
	if self.jobs_auto_setting==false then
	   if _jb1 then
	     local result="zc->"..self.jobslist[_jb1]
	     local jobslist=world.GetVariable("jobslist")
	     if jobslist==nil or jobslist=="" then
           world.SetVariable("jobslist",result)
	     else
           world.SetVariable("jobslist",jobslist.."|"..result)
	     end
	   end
	end]]
end

function wizard:skills_select()
	   local up={
	     learn="1 学师傅",
		 literate="2 学读书识字",
		 zhizhao="3 学织造",
		 duanzao="4 学锻造",
		 lingwu="5 达摩院领悟",
		 taojiao="6 明教讨教",
		 shenzhaojing="7 神照经",
		 chenggao="8 成高道长"
	    }
	   local _up=utils.listbox ("升级方式:", "升级设置", up)
	   if _up then
	      world.SetVariable("up",_up)
	   else
	      return
	   end

	local up=world.GetVariable("up")
	if up=="learn" then
	  local master_id=utils.inputbox ("你的师傅[id]?", "升级设置", "", "宋体", 9)
	  if master_id then
        world.SetVariable("masterid",master_id)
	  end
     local master_place=utils.inputbox ("师傅所在房间号?", "升级设置", "", "宋体", 9)
	 if master_place then
       world.SetVariable("master_place",master_place)
	 end
     local sleeproomno=utils.inputbox ("睡觉的房间号?", "升级设置", "", "宋体", 9)
	 if sleeproomno then
	  world.SetVariable("sleeproomno",sleeproomno)
	 end
      local pot=utils.inputbox ("每次学习消耗的pot量?", "升级设置", "1", "宋体", 9)
	 if pot then
       world.SetVariable("pot",pot)
	 end
	end

		local bei_up={
	     learn="1 学师傅",
		 lingwu="2 达摩院领悟",
	    }
	   local _bei_up=utils.listbox ("后备升级方式(gold 消耗完了自动切换):", "升级设置", bei_up)
	   if _bei_up then
	      world.SetVariable("bei_up",_bei_up)
	   else
	      return
	   end
	  --学习 领悟的 skills 选择
	if up=="learn" then

	  local teach_skills=world.GetVariable("teach_skills")
	  local _skills=Split(teach_skills,"|")
      local _list=utils.multilistbox ("设置学习技能(多项选择) 手动调整变量【skills】中技能学习的先后顺序,可以 zui-gun&tiegun|liuhe-dao&mu dao 支持装备自定义武器", "升级设置", _skills)
	   if _list then
       --print(_menpai)
	    local result=""
        for n,i in pairs(_list) do
		 result=result.._skills[n].."|"
		 print(result)
	    end
	    if result~="" then
		 result=string.sub(result,1,-2)
	    end
         world.SetVariable("skills",result)
      else
        return
      end
	end
	 -- 练 skills 技能选择
	if up=="lingwu" then
	 local baseskills={}
	 --1 基本技能
	 local teach_skills=world.GetVariable("teach_skills")
	 local _skills=Split(teach_skills,"|")
	 local _special_skills=Split(teach_skills,"|")
	 for i=table.getn(_skills),1,-1 do
	   if _skills[i]~="force" and _skills[i]~="parry" and _skills[i]~="dodge" and _skills[i]~="sword" and _skills[i]~="blade" and _skills[i]~="dagger" and _skills[i]~="whip" and _skills[i]~="staff" and _skills[i]~="hook" and _skills[i]~="club" and _skills[i]~="stick" and _skills[i]~="spear" and _skills[i]~="hammer" and _skills[i]~="strike" and _skills[i]~="cuff" and _skills[i]~="hand" and _skills[i]~="claw" and _skills[i]~="leg" and _skills[i]~="finger" and _skills[i]~="throwing" and _skills[i]~="axe" and _skills[i]~="brush" then
	     table.remove(_skills,i)
	   else
	     table.remove(_special_skills,i)
	   end
	 end
	 local _list=utils.multilistbox ("需要练的基本功设置(多项选择)", "升级设置", _skills)
	 if _list then
        for n,i in pairs(_list) do
		  --print(n,_skills[n])
		  table.insert(baseskills,_skills[n])
	    end
	 else
        return
	 end
	 --2 特殊技能
	 --print("lian skills 设置2 和基本功对应特殊武功设置。 例 bihao-chaosheng对应force,lanhua-shou对应hand")
	 local specialskills={}
	 for _,value in ipairs(baseskills) do
	   local special_skills={}
	   local _special_index=utils.listbox ("和"..value.."对应的特殊武功:", "升级设置", _special_skills)
	   if _special_index then
	       local result=_special_skills[_special_index].."&"..value
		   print(result)
		   table.insert(specialskills,result)
	   else
	      return
	   end
	 end
	 --领悟的技能
	 local result=""
	 for n,i in ipairs(baseskills) do
		result=result..i.."|"
	 end
	 if result~="" then
		result=string.sub(result,1,-2)
	 end
	 world.SetVariable("skills",result)
	 --特殊的技能
	 local result=""
	 for n,i in ipairs(specialskills) do
	    result=result..i.."|"
	 end
	 if result~="" then
		result=string.sub(result,1,-2)
	 end
	 world.SetVariable("lian_skills",result)
	end
	--3 ready 执行函数

	local lingwu_finish=utils.inputbox ("领悟完成以后执行的命令,比如jifa force bihai-chaoshen;jifa sword yuxiao-jian\n领悟以后重新bei jifa 技能使用。", "升级设置", "", "宋体", 9)
   if lingwu_finish then
     world.SetVariable("lingwu_finish",lingwu_finish)
   else
     return
   end
end

function wizard:equipments()

   local i_equip_sample="功能大全 <获取> <出售> <存在> <保存> <丢弃> <使用> <自动修理> <修理>\n"
  i_equip_sample=i_equip_sample .."1.<获取>物品名称&数量 比如<获取>木剑&2|<获取>白银&50\n"
  i_equip_sample=i_equip_sample .."2.<出售>甲&数量~{排除1,排除2} 会自动出售所有铁甲,皮甲。数量{可选项不填写默认是1}.\n排除~{软猬甲}不会出售软猬甲\n"
  i_equip_sample=i_equip_sample .."3.<存在>物品名称 不存在时候会自动退出\n"
  i_equip_sample=i_equip_sample .."4.<保存>玉~{疣玉}|<保存>白银&200 会自动保存玉 白银超过200 会自动保存\n"
  i_equip_sample=i_equip_sample .."5.<丢弃>布衣|<丢弃>长袍\n"
  i_equip_sample=i_equip_sample .."6.<使用>十三龙象袈裟|<使用>丹|<使用>丸 自动吃奖励的药丸和龙象袈裟\n"
  local i_equip= world.GetVariable("i_equip") or ""
  local i_equip=utils.inputbox(i_equip_sample, "物品设置", i_equip, "宋体", 9)
  if i_equip then
     world.SetVariable("i_equip",i_equip)
  else
     return
  end
end

function wizard:other()
   local neili_upper=utils.inputbox ("工作前内力打坐倍数 1~1.9的值", "其他设置", "1.5", "宋体", 9)
   if neili_upper then
       world.SetVariable("neili_upper",neili_upper)
   else
       return
   end
   local _xiulian={
		xiulian_neili="1 修炼内力",
		xiulian_jingli="2 修炼精力",
	}
	local xiulian=utils.listbox ("工作busy时候修炼内力或精力:", "其他设置", _xiulian,"xiulian_neili")
	if xiulian then
		world.SetVariable("xiulian",xiulian)
	else
		return
	end

   local pot_overflow=world.GetVariable("pot_overflow") or "20"
   pot_overflow=utils.inputbox("pot保留值 最大pot-当前pot<=保留值时会停止job 去学习领悟消耗pot，如果不想学习领悟，这个值设置成-1", "其他设置", pot_overflow, "宋体", 9)
   if pot_overflow then
       world.SetVariable("pot_overflow",pot_overflow)
   else
       return
   end
   local wuxing=utils.inputbox("学习前提前做的动作设置 比如yun maze;yun xinjing 装备 wield 龙泉剑", "其他设置", "", "宋体", 9)
   if wuxing then
       world.SetVariable("wuxing",wuxing)
   else
      -- return
   end
   local sp_exert=world.GetVariable("sp_exert")
   local shield=utils.inputbox("战斗前提前做的动作设置比如装备武器可以按任务进行设置json格式 例 \"华山1\":\"wield sword\",\"全部\":\"bei none;bei strike;unwield zhen;unwield jian;wield yinshe sword;wield jian;yun huti\"", "其他设置", sp_exert, "宋体", 9)
   if shield then
       world.SetVariable("sp_exert",shield)
	else
	   world.SetVariable("sp_exert","\"全部\":\"\"")
   end

	 local yesno=utils.msgbox ("是否自动参悟属性:", "其他设置", "yesno", "?")
	     if yesno=="no" then
            world.SetVariable("is_canwu","false")
         else
			world.SetVariable("is_canwu","true")
			local canwu_exps_limit=utils.inputbox("多少经验开始参悟额外经验?", "其他设置", "15000000", "宋体", 9)
            if canwu_exps_limit then
              world.SetVariable("canwu_exps_limit",canwu_exps_limit)
	        end
	        local canwu_gift_limit=utils.inputbox("多少经验开始参悟天赋？", "其他设置", "20000000", "宋体", 9)
            if canwu_gift_limit then
              world.SetVariable("canwu_gift_limit",canwu_gift_limit)
	        end
		 end


   local pfm1=world.GetVariable("pfm1")
   local pfm2=world.GetVariable("pfm2")
   local pfm3=world.GetVariable("pfm3")
   local pfm4=world.GetVariable("pfm4")
   local pfm5=world.GetVariable("pfm5")
   local _pfm1=utils.inputbox("pfm1 alias设置", "其他设置", pfm1, "宋体", 9)
   if _pfm1 then
      world.SetVariable("pfm1",_pfm1)
   else
   end

   local _pfm2=utils.inputbox("pfm2 alias设置", "其他设置", pfm2, "宋体", 9)
   if _pfm2 then
      world.SetVariable("pfm2",_pfm2)
   else
   end

   local _pfm3=utils.inputbox("pfm3 alias设置", "其他设置", pfm3, "宋体", 9)
   if _pfm3 then
      world.SetVariable("pfm3",_pfm3)
   else
   end

   local _pfm4=utils.inputbox("pfm4 alias设置", "其他设置", pfm4, "宋体", 9)
   if _pfm4 then
      world.SetVariable("pfm4",_pfm4)
   else
   end

   local _pfm5=utils.inputbox("pfm5 alias设置", "其他设置", pfm5, "宋体", 9)
   if _pfm5 then
      world.SetVariable("pfm5",_pfm5)
   else
   end

   local _blockNPC={
		["fan yiweng"]="1 樊一翁",
		["yin liting"]="2 殷梨亭",
		["huang lingtian"]="3 凌震天*",
		["ling zhentian"]="4 凌震天*",
		["chuchen zi"]="5 出尘子*",
		["xi huazi"]="6 西华子",
		["hong xiaotian"]="7 洪哮天",
		["xuansheng dashi"]="8 玄生大师*",
		["yang xiao"]="9 杨逍*",
		["fan yao"]="10 范遥",
		["he taichong"]="11 何太冲",
		["hufa shizhe"]="12 护法使者*",
		["wu seng"]="13 武僧",
		["zhang songxi"]="14 张松溪",
		["zhao liangdong"]="15 赵良栋",
		["ding mian"]="16 丁勉",
		["yu lianzhou"]="17 俞莲舟",
		["huizhen zunzhe"]="18 慧真尊者*",
		["dadian dashi"]="19 大癫大师*",
	    ["murong bo"]="20 慕容博", }

  local blockNPC=utils.multilistbox("挡路npc 使用pfm设置:", "其他设置", _blockNPC)
  local result=""
  for n,i in pairs(_blockNPC) do
	 result=result..n.."|"
  end
  if result~="" then
	 result=string.sub(result,1,-2)
  end
  world.SetVariable("blockNPC",result)

  local cmd=world.GetVariable("cmd")
  local _cmd=utils.inputbox("cmd 对挡路NPC使用pfm的alias设置", "其他设置", cmd, "宋体", 9)
   if _cmd then
      world.SetVariable("cmd",_cmd)
   else
   end
end

function wizard:special_heal()
   local liao_percent=world.GetVariable("liao_percent")
   local _liao_percent=utils.inputbox("找薛慕华疗伤气血百分比设置", "疗伤", liao_percent, "宋体", 9)
   if _liao_percent then
      world.SetVariable("liao_percent",_liao_percent)
   else
   end
  local party=world.GetVariable("party")
  if party=="明教" then
	 local yesno=utils.msgbox ("是否去蝴蝶谷找胡青牛疗伤？", "疗伤", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("special_heal","hudiegu")
	 end
  end
   local yesno=utils.msgbox ("是否使用龙象般若功的聚血疗伤？", "疗伤", "yesno", "?")
	if yesno=="yes" then
	   world.SetVariable("special_heal","juxue")
	end
	local yesno=utils.msgbox ("是否使用一阳指疗伤？", "疗伤", "yesno", "?")
	if yesno=="yes" then
	   world.SetVariable("special_heal","liao")
	end
end

function wizard:zone()

	 local yesno=utils.msgbox ("是否去莆田少林？", "区域", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("putian_entry","true")
	 else
	   world.SetVariable("putian_entry","false")
	 end

	  local yesno=utils.msgbox ("是否去嵩山少林？", "区域", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("shaolin_entry","true")
	 else
	   world.SetVariable("shaolin_entry","false")
	 end

	 local yesno=utils.msgbox ("是否去黑木崖？", "区域", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("heimuya_entry","true")
	 else
	   world.SetVariable("heimuya_entry","false")
	 end


	 local yesno=utils.msgbox ("是否去武当后山？", "区域", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("wudanghoushan_entry","true")
	 else
	   world.SetVariable("wudanghoushan_entry","false")
	 end

	 local yesno=utils.msgbox ("是否去天山？", "区域", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("tianshan_entry","true")
	 else
	   world.SetVariable("tianshan_entry","false")
	 end


	 local yesno=utils.msgbox ("是否去绝情谷？", "区域", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("jueqinggu_entry","true")
	 else
	   world.SetVariable("jueqinggu_entry","false")
	 end

	 local yesno=utils.msgbox ("是否去桃源？", "区域", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("taoyuan_entry","true")
	 else
	   world.SetVariable("taoyuan_entry","false")
	 end

	 local yesno=utils.msgbox ("是否去蝴蝶谷�", "区域", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("hudiegu_entry","true")
	 else
	   world.SetVariable("hudiegu_entry","false")
	 end

	 local yesno=utils.msgbox ("是否去神龙岛?", "区域", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("sld_entry","true")
	 else
	   world.SetVariable("sld_entry","false")
	 end

	 local yesno=utils.msgbox ("是否去五毒教?", "区域", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("wdj_entry","true")
	 else
	   world.SetVariable("wdj_entry","false")
	 end
end

function wizard:plugin()

   local afk_cmd=world.GetVariable("afk_cmd")
   local afk_sec=world.GetVariable("afk_sec")

   local _afk_cmd=utils.inputbox("发呆重新启动任务命令(比如你想发呆以后启动武当任务可以这样写Weapon_Check(process.wd)。\nWeapon_Check表示武器检查,process.wd是武当任务的进程,这种写法就表示武器检查以后启动武当任务)", "插件设置", afk_cmd, "宋体", 9)
   if _afk_cmd then
      world.SetVariable("afk_cmd",_afk_cmd)
   else
   end
   local _afk_sec=utils.inputbox("发呆时间间隔设置(秒),插件在设定时间内没有任何指令输入就认为发呆了，一般设置为60", "插件设置", afk_sec, "宋体", 9)
   if _afk_sec then
      world.SetVariable("afk_sec",_afk_sec)
      if GetPluginList()~=nil then
        for k, v in pairs (GetPluginList()) do
         if GetPluginInfo(v, 1)=="reconnect2" then
           local PluginID=GetPluginInfo(v, 7)
	       local afk_sec=tonumber(world.GetVariable("afk_sec")) or 60
	       CallPlugin(PluginID, "set_AFKTime", afk_sec)
		   CallPlugin(PluginID, "Enable_AFK")
          end
        end
      end
   else
   end
   	 local yesno=utils.msgbox ("是否显示小地图?", "插件", "yesno", "?")
	 if yesno=="yes" then
	   world.SetVariable("mini_map","true")
	 else
	   world.SetVariable("mini_map","false")
	 end
end

function loadnode (node)

  -- root node won't have a name
  local tag_type=""
  local tag_content=""
  local tag_name=""
  if node.name ~= "" then

    -- show node name followed by attributes (if any)
    --Tell ("<" .. node.name)
	tag_type=node.name
    if node.attributes then
      --print ""
      for k, v in pairs (node.attributes) do
        --print ("  " .. k .. '="' .. FixupHTML (v) .. '"')
		if k=="name" then
		  tag_name=v
		end
      end -- doing attributes
    end -- if

    if node.empty then
      --print ("/>")
      return  -- no closing tag
    else
      --Tell (">")
    end -- if

  end -- if have a node name

  -- print node contents
  --Tell (FixupHTML (node.content))
  tag_content=node.content

  -- do children
  if node.nodes then
    for k, v in ipairs (node.nodes) do
      loadnode (v)
    end -- for
  end -- of having children

  -- root node won't have a name
  if node.name ~= "" then

	-- closing tag
    --print ("</" .. node.name .. ">")
	if tag_type=="variable" then
	   print("导入变量:",tag_name," ",tag_content)
	   world.SetVariable(tag_name,tag_content)
	end

  end -- if have a node name

end -- writenode

function wizard:update_webconfig()
   local player_id=world.GetVariable("player_id") or ""
   local world_address=world.GetVariable("world_address") or ""
   local id=player_id.."@"..world_address
   local config_updated=utils.msgbox ("是否将当前配置上传服务器?", "设置精灵", "yesno", "?")
   if config_updated=="yes" then
		--当前所有变量
		local variables=""
		for k, v in pairs (GetVariableList()) do
           --Note (k, " = ", v)
		   if k~="world_address" then
		     config_txt=string.gsub(v,"<","lt;")
	         config_txt=string.gsub(config_txt,">","gt;")
		     config_txt=string.gsub(config_txt,"+","2b;")
		   --config_txt=string.gsub(config_txt,"&","&amp;")
		     variables=Trim(variables).."<variable name=\""..k.."\">"..config_txt.."</variable>"
		   end
        end
       local config_txt=utils.inputbox("请将配置信息复制到输入框中", "设置精灵", variables, "宋体", 9)

	   --config_txt=string.gsub(config_txt,"&amp;","&")
       --print(config_txt)
	   package.loaded["webServer"]=nil
	   require "webServer"
       webServer:Config_Save(id,config_txt)
	   package.loaded["webServer"]=nil
	   print("上传配置结束!")
   end

end

function wizard:select_settings(flag)
   --选择设置内容！
   local mastername=world.GetVariable("mastername") or ""
   local exps=world.GetVariable("exps") or "0"
   local player_name=world.GetVariable("player_name") or ""
   local player_id=world.GetVariable("player_id") or ""
   local world_address=world.GetVariable("world_address") or ""
   local party=world.GetVariable("party") or ""
   local gender=world.GetVariable("gender") or "男性"
   local exert_gift=world.GetVariable("exert_gift") or "0"
   local exert_reward=world.GetVariable("exert_reward") or "0"
   --[[
   local url="http://112.65.143.180:9001/SJMain.aspx?mastername="..mastername.."&exps="..exps.."&name="..player_name.."&id="..player_id.."&party="..party.."&gender="..gender.."&exert_gift="..exert_gift.."&exert_reward="..exert_reward
   --print(url)
   local xml=""
    local is_download=utils.msgbox ("是否从服务器下载配置文件?", "设置精灵", "yesno", "?")
	if is_download=="yes" then
	    local id=player_id.."@"..world_address
		package.loaded["webServer"]=nil
		require "webServer"
	    xml=webServer:Config_Get(id)
		package.loaded["webServer"]=nil
		print("_______________________配置文件下载完成_________________________________")
		xml=string.gsub(xml,"&lt;","<")
		xml=string.gsub(xml,"&gt;",">")
	else
	   local yesno =utils.msgbox ("是否需要前往在线帮助网站配置机器人?", "设置精灵", "yesno", "?")
	   if yesno=="yes" then
	      world.OpenBrowser(url)
	   end
	end

	local loadingVariable=false
	 loadingVariable=utils.msgbox("是否导入配置信息","设置精灵","yesno","?")
	 if loadingVariable=="yes" then
	       local xml_txt=utils.inputbox("请将配置信息复制到输入框中", "设置精灵", xml, "宋体", 9)
           if xml_txt then

			 xml_txt=string.gsub(xml_txt,"&","&amp;")
			 xml_txt=string.gsub(xml_txt,"lt;","&lt;")
			 xml_txt=string.gsub(xml_txt,"gt;","&gt;")
			  xml_txt=string.gsub(xml_txt,"2b;","+")


			 --print(xml_txt)
			 xml_txt="<variables>"..xml_txt.."</variables>"
             local value=world.ImportXML(xml_txt)
			 if value>0 then
			    utils.msgbox("导入变量成功,共"..value.."导入。","设置精灵","ok","?")
			 else
                utils.msgbox("格式错误导入失败!","设置精灵","ok","?")
			 end
           end
	 end]]

	  local loadingVariable=false
	  loadingVariable=utils.msgbox("是否导入配置文件","设置精灵","yesno","?")
	  if loadingVariable=="yes" then
	     local filter = { txt = "Text files", ["*"] = "All files" }
	     local filename = utils.filepicker ("配置文件", name, "txt", filter, false)
		 local f = assert (io.open (filename, "r"))  -- open it
		 local s = f:read ("*a")  -- read all of it
         --print (s)  -- print out
         f:close ()  -- close it
	     local a, b, c = utils.xmlread (s)
		--tprint (a)
         loadnode(a)
		 process.check()
	      return
	  end
     local yesno
     if flag==nil then
        yesno =utils.msgbox ("是否第一次设置?", "设置精灵", "yesno", "?")
	 end
	 if yesno=="yes" and flag==nil then
	      self:plugin()
	      self:jobs_select()
          self:skills_select()
	      self:equipments()
	      self:other()
	      self:special_heal()
	      self:zone()
	 else
	       local model=utils.listbox ("选择需要设置的模块", "选择模块", { "1.插件设置", "2.任务顺序设置", "3.技能选择设置", "4.装备设置","5.其他设置","6.特殊疗伤设置","7.区域进出设置" })
		   if model==1 then
		      self:plugin()
		   elseif model==2 then
		      self:jobs_select()
		   elseif model==3 then
		      self:skills_select()
		   elseif model==4 then
		      self:equipments()
		   elseif model==5 then
		      self:other()
		   elseif model==6 then
		      self:special_heal()
		   elseif model==7 then
		      self:zone()
		   end
		   --
		    local yesno=utils.msgbox ("是否完成设置?", "设置精灵", "yesno", "?")
			if yesno=="yes" then
			     print("---------------------------------------------------------")
				 register() --任务注册
				 world.ColourNote ("red", "yellow", "设置结束，输入任务开始的命令")
			else
			    self:select_settings(true)
			end

	 end

end

function mousedown()
  return function (flags, hotspot_id)
    --print(flags)

	if flags==16 then
      wizard:start()
	end
  end
end

function stopRobot()
  return function (flags, hotspot_id)
    --print(flags)
     print("停止机器人")
	if flags==16 then
      shutdown()
	end
  end
end

function mapHere()
   return function(flags,hotspot_id)
      if flags==16 then
	     Map_Here()
	  end
   end
end

local help_win = "help_window"
local help_win_width = 240
local help_win_height = 25
local FONT_NAME = "f1"
local FONT_SIZE = "9"
local left = 50
local top = 10
--[[
local stop_win= "stop_window"
local stop_win_width = 40
local stop_win_height = 25
local FONT_NAME = "f1"
local FONT_SIZE = "9"]]

function switchmode()
  return function(flags,hotspot_id)
      if flags==16 then
        for k, v in pairs (GetPluginList()) do
            if GetPluginInfo(v, 1)=="reconnect2" then

				local PluginID=GetPluginInfo(v, 7)
			    local value=GetPluginVariable(PluginID,"is_afk")
				if value=="true" then
				    print("手动模式")
				    CallPlugin(PluginID, "Disable_AFK")
				else
				    print("挂机模式")
			        CallPlugin(PluginID, "Enable_AFK")
			    end

            end
         end

	  end
  end
end

local function pots_bank(pots,callback)
   local w=walk.new()
   w.walkover=function()
       world.Send("qn_qu "..pots)
	   local b=busy.new()
	   b.Next=function()
	      callback()
	   end
	   b:check()
   end
   w:go(4067)
end

function startjob()
  return function(flags,hotspot_id)
	if flags==16 then

	     local jobs={
    xc="1.1 大理巡城",
	tdh="2.1 天地会",
	zc="2.2 洪七公做菜",
	wudang="3.1 武当",
	hs="3.2 华山1",
	hs2="3.3 华山2",
	sx="3.4 大理送信",
	xs="4.1 雪山",
	cl="4.2 长乐帮",
	tx="5.1 慕容偷学",
	suoming="5.2 神龙岛索命",
	sm="5.3 桃花岛守墓",
	ss="5.4 左冷禅任务",
	gb="5.5 丐帮",
	zs="5.6 抓蛇",
	jh="5.7 浇花",
	tm="5.8 少林教武僧",
	ck="5.9 采矿",
	xl="6.0 明教巡逻任务",
	jy="6.1 少林救援任务",
	xxbug="6.2 星宿抓虫",
	qqll="6.3 七窍玲珑玉任务"

  }
       local select_job=utils.listbox ("选择你要做任务", "设置精灵", jobs)
	   if select_job then
          world.Execute(select_job)
       else
         return
       end
   end
   end
end

function neili_canwu()
  local w=walk.new()
  w.walkover=function()
     world.Send("jump 牛心石")
     world.Send("canwu 100000 to neili")
  end
  w:go(669)
end

--自动设置 master的房间号 睡房 id
function master_setting(master_name)
    --武当  2790 男 3175 女
	--少林 877 878
	--峨眉 653
	--古墓  3016 绝情谷
	--华山 1524 男性  3174 女性
	--全真 4166
	--逍遥 4242
	--灵鹫宫  2339
	--星宿派 3110
	--大轮寺 2711 女性 2272 男性 大草原 哈萨克帐篷 2072 2075
	--桃花岛 2785 男性 3146 女性 归云庄  2815 桃花岛
	--日月神教 142
	--昆仑派  3023
	--明教 2248
	--神龙岛 1800
	--丐帮
	--慕容 877 慕容博  2003 慕容复 2186 王夫人
	--大理 484
	--天龙寺 3890 3892
	--嵩山 308  男性 3154 女性
	--铁掌 2418 男性 4989 女性
	local party=world.GetVariable("party") or ""
	local gender=world.GetVariable("gender") or ""
	if master_name==nil or master_name=="" then
	   master_name=world.GetVariable("mastername") or ""
	end
	print(master_name," mastername")
	local roomno=WhereIsNpc(master_name)
	 if roomno==nil or table.getn(roomno)==0 then
	   print("没有找到师父所在地!!请手动设置!")

	   return
	else
		local r=roomno[1]
	    print(r)
	   world.SetVariable("master_place",r)

	   local ids={}
	   ids=GetNpcID(master_name)
	   local id=ids[1]
	   local len=string.len(id.id1)
	   local short_id=id.id1
	   if len>string.len(id.id2) and string.len(id.id2)>0 then
		   len=string.len(id.id2)
		   short_id=id.id2
	   end
	    if len>string.len(id.id3) and string.len(id.id3)>0 then
		   len=string.len(id.id3)
		   short_id=id.id3
	   end
	   if master_name=="殷天正" then
	    short_id="tianzheng"
	   end
	   print("师父id:",short_id)
	   world.SetVariable("masterid",short_id)
	   local sleeproomno=0
	   if string.find(party,"武当") then
	      if gender=="男性" then
		    sleeproomno=2790
		  else
		    sleeproomno=3175
		  end
	   elseif string.find(party,"少林") then
	      sleeproomno=877
	   elseif string.find(party,"华山") then
		  if gender=="男性" then
		    sleeproomno=1524
		  else
		    sleeproomno=3174
		  end
		elseif string.find(party,"峨嵋") then
		   sleeproomno=653
		elseif string.find(party,"全真") then
		   sleeproomno=4166
		elseif string.find(party,"逍遥") then
		   sleeproomno=4242
		elseif string.find(party,"古墓") then
		   sleeproomno=3016
		elseif string.find(party,"灵鹫宫") then
		   sleeproomno=2339
		elseif string.find(party,"星宿派") then
		   sleeproomno=3110
		 elseif string.find(party,"日月神教") then
		   sleeproomno=142
		 elseif string.find(party,"昆仑派") then
		   sleeproomno=3023
	    elseif string.find(party,"明教") then
		   sleeproomno=2248
		 elseif string.find(party,"神龙岛") then
		   sleeproomno=1800
		 elseif string.find(party,"大理") then
		   sleeproomno=484
		 elseif string.find(party,"天龙寺") then
		   local title=world.GetVariable("title") or ""
		   if string.find(title,"神  僧") then
		      sleeproomno=3890
		   else
		      sleeproomno=484
		   end
	    elseif string.find(party,"铁掌") then
		  if gender=="男性" then
		    sleeproomno=2418
		  else
		    sleeproomno=4989
		  end
		elseif string.find(party,"嵩山") then
		  if gender=="男性" then
		    sleeproomno=308
		  else
		    sleeproomno=3154
		  end
		elseif string.find(party,"慕容") then
		  if master_name=="慕容博" then
		    sleeproomno=877
		  elseif master_name=="莫容复" then
		   sleeproomno=2003
		  elseif master_name=="王夫人" then
		    sleeproomno=2186
		  end
		elseif string.find(party,"桃花岛") then
		  if master_name=="黄药师" then
		    sleeproomno=2815
		  elseif gender=="男性" then
		   sleeproomno=2785
		  else
		    sleeproomno=3146
		  end
		elseif string.find(party,"大轮寺") then
		  if master_name=="金轮法王" then
		    sleeproomno=2072
		  elseif gender=="男性" then
		   sleeproomno=2273
		  else
		    sleeproomno=2712
		  end
		--大轮寺 2711 女性 2272 男性 大草原 哈萨克帐篷 2072 2075
       elseif string.find(party,"丐帮") then
	      sleeproomno=r
	   end
	   print("sleeproomno:",sleeproomno)
	    world.SetVariable("sleeproomno",sleeproomno)
	end
end

function gongneng()
  return function(flags,hotspot_id)
      if flags==16 then
            local selectItem={
			 master_setting="0 学习自动设置(师父睡房)",
	         fish="1 钓鱼",
		     readbook="2 读书籍",
		    xiulian1="3 修炼内力",
		    xiulian2="4 修炼精力",
			 fullskills="5 full技能",
			 quest="6 解谜",
			 canwu="7 牛心石参悟内力(要求100m)",
			 gumu="8 古墓一键full",
			  haichao="9 古墓瀑布练海潮剑法",
			  dzxy="10 参悟斗转星移 51~201",
			  gancao="11 堆干草练基本技能(自己wield 武器)",
	      }
	      local _select=utils.listbox ("辅助功能:", "设置精灵", selectItem)
		    if _select=="fish" then
			  package.loaded["fish"]=nil
			  require "fish"
			   fish:go()
			elseif _select=="readbook" then
			   	 local cmd=utils.inputbox("读书执行的命令例如read medicine book", "设置精灵", "read medicine book", "宋体", 9) or "read medicine book"
	            local f=function(r)
		             local readroomno=r[1]
					 print(readroomno)
					 local sleeproomno=world.GetVariable("sleeproomno") or 126
					 sleeproomno=tonumber(sleeproomno)
					 process.readbook(cmd,nil,readroomno,sleeproomno)
				end
	            WhereAmI(f,10000) --排除出口变化
			elseif _select=="xiulian1" then
			   world.Send("unset 积蓄")
			   process.neigong3()
			elseif _select=="xiulian2" then
			   process.neigong2()
			elseif _select=="quest" then
			   require "quest"
			   quest:quest_ask()
			elseif _select=="canwu" then
               neili_canwu()
		    elseif _select=="gumu" then
			    package.loaded["gumu"]=nil
			    require "gumu"
			    gumu:lingwu_skills()
		    elseif _select=="haichao" then
			    process.xuantie()
			elseif _select=="master_setting" then
				local master_name=world.GetVariable("mastername") or ""
			    local master_name=utils.inputbox("师父的中文名字", "设置精灵", master_name, "宋体", 9) or master_name
			     master_setting(master_name)
			elseif _select=="dzxy" then
			      package.loaded["lingwu"]=nil
			      require "lingwu"
                  local lw=lingwu.new()
				  lw.exps=tonumber(world.GetVariable("exps")) or 0
				  lw.get_skills_end=function()
				    local special=lw:get_skill("douzhuan-xingyi")
				    if special>=171 and special<201 then
				      lw:douzhuan_xingyi2()
				    elseif special>=51 and special<171 then
				      lw:douzhuan_xingyi()
			        end
				  end
                  lw:get_exps()
			elseif _select=="gancao" then
			       package.loaded["duicao"]=nil
                  require "duicao"
			      duicao:start()
			elseif _select=="fullskills" then
			   local select_up={
			     learn="学习师父",
				 lingwu="领悟",
				 literate="读书写字",
				 chenggao="成高",
				 jyzj="读九阴下人皮",
			   }

	          local pots=utils.inputbox("需要潜能银行取多少pots", "设置精灵", "10000", "宋体", 9) or "10000"
			  local  _select_up=utils.listbox ("方式选择:", "设置精灵", select_up)
		      if _select_up=="learn" then
		        local f=function()
			 	   world.Send("unset skilllimit")
				   local f=function()
				      world.Send("学习结束")
					   print (utils.msgbox ("学习结束", "Warning!", "ok", "!", 1)) --> ok
				   end
		           Go_learn(f)
				end
				pots_bank(pots,f)
		      elseif _select_up=="lingwu" then
		        local f=function()
				    world.Send("unset skilllimit")
					local f2=function()
					   world.Send("领悟结束")
					   print (utils.msgbox ("领悟接收", "Warning!", "ok", "!", 1)) --> ok
					end
			       process.lingwu(f2,false)
			     end
			     pots_bank(pots,f)
		      elseif _select_up=="literate" then
		         local f=function()
					local f2=function()
				      world.Send("学习结束")
					   print (utils.msgbox ("学习结束", "Warning!", "ok", "!", 1)) --> ok
				    end
			       learn_literate(f2)
			     end
			     pots_bank(pots,f)
		      elseif _select_up=="chenggao" then
		         local f=function()
				    local f2=function()
				      world.Send("学习结束")
					   print (utils.msgbox ("学习结束", "Warning!", "ok", "!", 1)) --> ok
				   end
			       chenggao_learn(f2)
			     end
			     pots_bank(pots,f)
		      elseif _select_up=="jyzj" then
			     local f=function()
				    local f2=function()
				      world.Send("学习结束")
					   print (utils.msgbox ("学习结束", "Warning!", "ok", "!", 1)) --> ok
				   end
			       du_zhenjing(f2)
			     end
			     pots_bank(pots,f)
		      end
	      end
	  end  --end flag
	end
end

function wizard:draw_win()
    WindowCreate (help_win, 0, 0,  help_win_width, help_win_height, miniwin.pos_bottom_left, 0, 0x000010)
	local help_win_info = movewindow.install(help_win, miniwin.pos_bottom_left, miniwin.create_absolute_location, true)
	WindowCreate(help_win, help_win_info.window_left, help_win_info.window_top, help_win_width, help_win_height, help_win_info.window_mode, help_win_info.window_flags, 0x000010)
	movewindow.add_drag_handler (help_win, 0, 0, help_win_width, 30)
	WindowFont (help_win, FONT_NAME, "Arial", FONT_SIZE)
	WindowResize (help_win, help_win_width, help_win_height, 0x000010)
    WindowCircleOp (help_win, miniwin.circle_round_rectangle, 0, 2, 38, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 40, 2, 78, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 80, 2, 118, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 120, 2, 158, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 160, 2, 198, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	WindowCircleOp (help_win, miniwin.circle_round_rectangle, 200, 2, help_win_width, help_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	--help_win_width
	left = 5
	top = 5

	WindowText (help_win, FONT_NAME, "设置",
					7, top, 0, 0,
					ColourNameToRGB ("yellow"), false)

	WindowText (help_win, FONT_NAME, "停止",
					47, top, 0, 0,
					ColourNameToRGB ("yellow"), false)
	WindowText (help_win, FONT_NAME, "定位",
				    87, top, 0, 0,
					ColourNameToRGB ("yellow"), false)
	WindowText (help_win, FONT_NAME, "模式",
				    127, top, 0, 0,
					ColourNameToRGB ("yellow"), false)

    WindowText (help_win, FONT_NAME, "启动",
				    167, top, 0, 0,
					ColourNameToRGB ("yellow"), false)

	WindowText (help_win, FONT_NAME, "功能",
				    207, top, 0, 0,
					ColourNameToRGB ("yellow"), false)

	top = top + 15
	WindowShow (help_win, true)
	movewindow.save_state(help_win)
   local _mousedown=mousedown()
   _G["at_mousedown"]=_mousedown
   local _stopRobot=stopRobot()
   _G["at_mousedown1"]=_stopRobot
   local _mapHere=mapHere()
   _G["at_mousedown2"]=_mapHere
   local _switchmode=switchmode()
      _G["at_mousedown3"]=_switchmode
   local _startjob=startjob()
	_G["at_mousedown4"]=_startjob
	  local _gongneng=gongneng()
	_G["at_mousedown5"]=_gongneng

   WindowAddHotspot(help_win, "setting_hotspot",
                    10,  0, 35, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "设置",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags

   WindowAddHotspot(help_win, "stop_hotspot",
                    50,  0, 75, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown1",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "停止机器人",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
    WindowAddHotspot(help_win, "mapHere_hotspot",
                    90,  0, 115, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown2",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "当前房间号",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
	 WindowAddHotspot(help_win, "hand_hotspot",
                    130,  0, 155, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown3",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "模式切换",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
	WindowAddHotspot(help_win, "startjob_hotspot",
                    170,  0, 195, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown4",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "启动JOB",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags
	WindowAddHotspot(help_win, "gongneng_hotspot",
                    210,  0, 235, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown5",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "辅助功能",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags

--[[
    WindowCreate (stop_win, 0, 0,  stop_win_width, stop_win_height, miniwin.pos_top_center, 0, 0x000010)
	local stop_win_info = movewindow.install(stop_win, miniwin.pos_top_center, miniwin.create_absolute_location, true)
	--WindowCreate(stop_win, stop_win_info.window_left, stop_win_info.window_top, stop_win_width, stop_win_height, stop_win_info.window_mode, stop_win_info.window_flags, 0x000010)
	movewindow.add_drag_handler (stop_win, 0, 0, stop_win_width, 30)
	WindowFont (stop_win, FONT_NAME, "Arial", FONT_SIZE)
	WindowResize (stop_win, stop_win_width, stop_win_height, 0x000010)
    WindowCircleOp (stop_win, miniwin.circle_round_rectangle, 0, 2, stop_win_width - 2, stop_win_height, 0xc0c0c0, 0, 1,0, 0, 9, 9)
	left = 5
	top = 5

	WindowText (stop_win, FONT_NAME, "停止",
					left+2, top, 0, 0,
					ColourNameToRGB ("yellow"), false)

	top = top + 15
	WindowShow (stop_win, true)
	movewindow.save_state(stop_win)
   local _stopRobot=stopRobot()
   _G["at_mousedown1"]=_stopRobot
   WindowAddHotspot(stop_win, "stop_hotspot",
                    10,  0, 25, 25,   -- rectangle
                   "",   -- MouseOver
                   "",   -- CancelMouseOver
                   "at_mousedown1",  -- MouseDown
                   "",   -- CancelMouseDown
                   "",   -- MouseUp
                   "停止机器人",  -- tooltip text
                   cursor or 1, -- cursor
                   0)  -- flags]]
end

--require('LuaXml')
function wizard:test()
local xml = require("xmlSimple").newParser()

--[[

local testXml = '<testOne param="param1value">'
testXml = testXml .. '<testTwo paramTwo="param2value">'
testXml = testXml .. '<testThree>'
testXml = testXml .. 'testThreeValue'
testXml = testXml .. '</testThree>'
testXml = testXml .. '<testThree duplicate="one" duplicate="two">'
testXml = testXml .. 'testThreeValueTwo'
testXml = testXml .. '</testThree>'
testXml = testXml .. '<test_Four something="else">'
testXml = testXml .. 'testFourValue'
testXml = testXml .. '</test_Four>'
testXml = testXml .. '<testFive>'
testXml = testXml .. '<testFiveDeep>'
testXml = testXml .. '<testFiveEvenDeeper>'
testXml = testXml .. '<testSix someParam="someValue"/>'
testXml = testXml .. '</testFiveEvenDeeper>'
testXml = testXml .. '</testFiveDeep>'
testXml = testXml .. '</testFive>'
testXml = testXml .. 'testTwoValue'
testXml = testXml .. '</testTwo>'
testXml = testXml .. '</testOne>'


local parsedXml = xml:ParseXmlText(testXml)


if parsedXml.testOne == nil then error("Node not created") end
if parsedXml.testOne:name() ~= "testOne" then error("Node name not set") end
if parsedXml.testOne.testTwo == nil then error("Child node not created") end
if parsedXml.testOne.testTwo:name() ~= "testTwo" then error("Child node name not set") end
if parsedXml.testOne.testTwo:value() ~= "testTwoValue" then error("Node value not set") end
if parsedXml.testOne.testTwo.test_Four:value() ~= "testFourValue" then error("Second child node value not set") end
if parsedXml.testOne["@param"] ~= "param1value" then error("Parameter not set") end
if parsedXml.testOne.testTwo["@paramTwo"] ~= "param2value" then error("Second child node parameter not set") end
if parsedXml.testOne.testTwo.test_Four["@something"] ~= "else" then error("Deepest node parameter not set") end

-- duplicate names tests
if parsedXml.testOne.testTwo.testThree[1]:value() ~= "testThreeValue" then error("First of duplicate nodes value not set") end
if parsedXml.testOne.testTwo.testThree[2]:value() ~= "testThreeValueTwo" then error("Second of duplicate nodes value not set") end
if parsedXml.testOne.testTwo.testThree[2]["@duplicate"][1] ~= "one" then error("First of duplicate parameters not set") end
if parsedXml.testOne.testTwo.testThree[2]["@duplicate"][2] ~= "two" then error("Second of duplicate parameters not set") end

-- deep element test

if parsedXml.testOne.testTwo.testFive.testFiveDeep.testFiveEvenDeeper.testSix['@someParam'] ~= "someValue" then error("Deep test error") end

-- node functions test
local node = require("xmlSimple").newNode("testName")

if node:name() ~= "testName" then error("Node creation failed") end

node:setName("nameTest")
if node:name() ~= "nameTest" then error("Name function test failed") end

node:setValue("valueTest")
if node:value() ~= "valueTest" then error("Value function test failed") end

local childNode = require("xmlSimple").newNode("parent")

node:addChild(childNode)

if type(node:children()) ~= "table" then error("children function test failed") end
if #node:children() ~= 1 then error("AddChild function test failed") end
if node:numChildren() ~= 1 then error("numChildren function test failed") end


node:addProperty("name", "value")

if type(node:properties()) ~= "table" then error("properties function test failed") end
if #node:properties() ~= 1 then error("Add property function test failed") end
if node:numProperties() ~= 1 then error("Num properties function test failed") end

print("Tests passed")
]]



end

function wizard:start()
  --第一步 jobs
  --学习 领悟 练 技能列表 师傅 休息房间
  --战斗 pfm unarmed_pfm
  --装备 i_equip 设置
  --self:support_job()
  --print("※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※※")

   wizard_end=function()

	teach_skill={}
    local teach_skills=world.GetVariable("teach_skills")
    if teach_skills==nil or teach_skills=="" then
      print("teach_skills变量没有设置!!")
    else
     local _skills=Split(teach_skills,"|")
     for _,ts in ipairs(_skills) do
       table.insert(teach_skill,ts)
     end
    end
    run_vip=world.GetVariable("VIP")
    if run_vip=="贵宾玩家" then
     run_vip=true
    else
     run_vip=false
    end
	 --
	 --print("配置内容检查")

	 --jobslist 格式检验
	 --get_jobslist
	 --sp_exert 格式检验

	 --i_equip
	 --filename = utils.filepicker (title, name, extension, filter, save)
	 --编辑默认模板
	 --选择设置内容！
     --self:select_settings()
   end
   auto_variable()
end

----2016-11-23更新 新增 xml配置文件导入导出功能
-- show all variables and their values
function wizard:import_xml()
for k, v in pairs (GetVariableList()) do
  Note (k, " = ", v)
end
Note (ExportXML (4, "gb_pfm"))
end
