
--[[2:                       �����¸���������ܡ�
 3: ������������������������������������������������������������
 4:
 5: �������¸���λ���������ϵǷ��ؾ��ڣ��������е���������̫�ҡ�����
 6: ��ɽ��ɽ��ͦ�Σ����͵��֣��кܶ���ʤ�ż����������ɹ��ɽ�����
 7: �����������ɣ�������ɽ�ɣ���ɽ�ɣ����¸����ɣ���ɽ�ɼ�̩ɽ�ɡ�
 8: ���¸����ɱ����������¸���֮�ۣ�������֮�Ӵ���Ȼ���������䵱������
 9: ̩����ͥ��������������������һ��������Ŀ����ǽ������¸���һ��
10: �Ľ�����λ��ͳ�Σ�ǧ���ټ����ɽ�����ʿΪ��Ч����
11:
12: ������������������������������������������������������������
13:                         ������Ҫ��
14: ������������������������������������������������������������
15:
16: ����ֵ����50k��������
17:
18: ������������������������������������������������������������
19:                         ��������̡�
20: ������������������������������������������������������������
21:
22:     �����¸��˷���̨����������������ask zuo about job������Ե�
23: ������Ҫ��ȥɱ������һ���ˣ��ȵ�����npc���ڵأ�
== ��ʣ 19 �� == (ENTER ������һҳ��q �뿪��b ǰһҳ)24:     ���ˣ�qing xxx����npc��˵һЩ������˼��Ҫ������У�Ȼ��
25: ���Զ����У������� fight����������ˣ��������������һ���ж�
26: ��Ȼ��������ص������������ɣ��������һ������
27:     ɱ�ˣ��ҵ�NPCȻ�� kill xxx�����ˣ�ɱ��֮�� get corpse
28: (or qie corpse;get head)�ص��������� give zuo corpse(head)
29: ���������һ������
30:     ���������ɣ���Ҫ��������ask zuo about ��������������
31: �µ�����
32:
33: ������������������������������������������������������������
34:                         ������̸֮��
35: ������������������������������������������������������������
36:
37:     һ����˵�����˱�ɱ��Ҫ����һЩ����Ϊ�ķѱȽϴ�ľ�����ʱ
38: �䣬�������˵�ʱ���мǲ�Ҫ�ö������򶾴�������߶�����������
39: �кù��Ӹ���ĳԵġ���Ȼ�����˵Ľ�����ʱ��Ҳ��ɱ��Ҫ��Ӧ��һ
40: Щ��]]
ryfx={
  new=function()
     local fx={}
	 setmetatable(fx,ryfx)
	 return fx
   end,
   ss_co=nil,
   npc="",
   id="",
   target_roomno="",
   get_reward_count=0,
   neili_upper=1.8,
   fight=false,
   qing_count=0,
   jobtype="",
   g_blacklist="",
   try_count=0,
}
ryfx.__index=ryfx


function ryfx:xxdf()
    local player_name=world.GetVariable("player_name") or ""
	--^(> |)����Ⱥ.*˵������"..player_name.."����˵ħ�̽��������ں����������ף���ȥ����ɱ�ˣ��Ҿ��������������ɡ���$
	--^(> )*������˵������'.. score.name ..'����˵����÷ׯ��λׯ��ϲ�������黭��������Ͷ��������ȥ�����������һ����Ե��
    wait.make(function()
	   local l,w=wait.regexp("^(> |)������˵������"..player_name.."����˵����÷ׯ��λׯ��ϲ�������黭��������Ͷ��������ȥ�����������һ����Ե����$|^(> |)���������˵������"..player_name.."����˵����÷ׯ��λׯ��ϲ�������黭��������Ͷ��������ȥ�����������һ����Ե��.*",10)
	   if l==nil then

	      return
	   end
	   if string.find(l,"����÷ׯ��λׯ��") then
	      world.Send("nick ���Ǵ�")
		  -- print (utils.msgbox ("��ʼ�⻯���󷨣�������", "Warning!", "ok", "!", 1)) --> ok
	      return
	   end
	end)
end

function ryfx:prepare()

end

function ryfx:catch_place()
--����������Ķ�������˵�������ˣ���̳������������ҽ��鲻����������������ȳ��ν���֮�¼�ֱ���練�ơ�
--������˵��������ʹ�����ȥ�置�ӻ�������������
--������˵���������ϴε����¸�������û�аɡ���
--���������������йء�job������Ϣ��
--����������Ķ�������˵���������ţ��е��ӻر��׻��������Դ������������ڶ������ܣ���ô����
--������˵�������ٺ٣����ڴ����ǳ�����һ������ȥ����ɱ�˴�������ʬ��ϻ�������
     wait.make(function()

	 local l,w=wait.regexp("^(> |)����������Ķ�������˵�������ˣ�.*(����|����|����|����|����|����|����)(.*)���ҽ��鲻����������������ȳ��ν���֮�¼�ֱ���練�ơ�$|^(> |)����������Ķ�������˵���������ţ��е��ӻر�.*(����|����|����|����|����|����|����)(.*)�������ڶ������ܣ���ô����$|^(> |)�趨����������action \\= \\\"ask\\\"|^(> |)������˵�������ţ�����������˼�����˴�ƣ������š���$|^(> |)������˵�������ţ�������æ�������š���$|^(> |)������˵��������������ȥ(.*)��(.*)������ô���������$|^(> |)������˵��������������ȥ(.*)ɱ(.*)������ô���������|^(> |)������˵��������հ���ң�������Ϣһ�°ɡ���$|^(> |)������˵���������ϴε����¸�������û����ɰɡ���$|^(> |)������˵����������æ���أ�����$",5)
	 if l==nil then
	   print("��ʱ")
	   self:ask_job()
	   return
	 end

	 if string.find(l,"�ȳ��ν���֮�¼�ֱ���練��") then
	    self.jobtype="����"
		  --print("fight")
		 self.fight=true
	    --print("����1",w[3])
		print("�����Ѷ�",w[2])
		local exps=tonumber(world.GetVariable("exps"))
	    if self:blacklist(w[3],exps)==true then
	      self:giveup()
	      return
	    end
        self:qing(w[3])
	   return
	 end

	 if string.find(l,"���ڶ�������") then
	  self.jobtype="��ɱ"
	  --print("�����Ѷ�",w[5])
	  --local exps=tonumber(world.GetVariable("exps"))
	  --if w[5]=="����" then
	  --    self:giveup()
	  --    return
	  --end
		self:shashou(w[6])
	   return
	 end
	 if string.find(l,"��") then
	    local place= w[11]
		 id=w[12]
		local ts={
	           task_name="���¸���",
	           task_stepname="����",
	           task_step=3,
	           task_maxsteps=4,
	           task_location=w[11],
	           task_description="����"..id,
	}
	   local st=status_win.new()
	   st:init(nil,nil,ts)
	   st:task_draw_win()
	   self.qing_count=0
	  print("qing:",id)
	    CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."���¸�������:λ��"..place.." ����:"..id, "yellow", "black") -- yellow on white
	  if self:is_invite(id)==false then
		 self:giveup()
         return
	  end
	  self.job_select=self.qing_NPC
	  self:appear(id,place)
	    return
	 end

	 if string.find(l,"ɱ") then
	  self.jobtype="��ɱ"
	    local place=w[14]
		id=w[15]
		local ts={
	           task_name="���¸���",
	           task_stepname="ɱ��",
	           task_step=3,
	           task_maxsteps=4,
	           task_location=place,
	           task_description="��ɱ"..id,
	}
	   local st=status_win.new()
	   st:init(nil,nil,ts)
	   st:task_draw_win()
        CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."���¸�������:λ��"..place.." ��ɱ:"..id, "yellow", "black") -- yellow on white

	    print("shashou:",id)
		self:prepare()
		--self.job_select=self.kill_NPC
		self.job_select=self.hit
		self:appear(id,place)
		return

	 end
	 if string.find(l,"�趨����������action") then
	   wait.time(2)
	   self:ask_job()
	   return
	 end
	  if string.find(l,"�ţ�����������˼�����¸��˴��") or string.find(l,"��հ����") then
        self.fail(101)
	   return
	 end
	 if string.find(l,"�ţ�������æ��������") then
	    self.fail(102)
	    return
	 end
	 if string.find(l,"��ô��������") or string.find(l,"���ϴε����¸�������û����ɰ�") or string.find(l,"����æ����") then
	    self:giveup()
	    return
	 end
	end)
end

function ryfx:auto_pfm(flag)
end

function ryfx:ask_job()
   local w
   w=walk.new()
   w.walkover=function()
     world.Send("ask xiang wentian about job")
	 world.Send("set action ask")
	 wait.make(function()

	 local l,w=wait.regexp("^(> |)��������������йء�job������Ϣ��",5)
	 if l==nil then
	   print("��ʱ")
	   self:ask_job()
	   return
	 end

	 if string.find(l,"��������������й�") then
	   self:catch_place()
	   --BigData:catchData(311,"����̨")
	   return
	 end

   end)
  end
  w:go(1413)
end

function ryfx:is_invite(id)
   if id=="������" or id=="������" or id=="������" or id=="ѦĽ��"  or id=="����" then
      return false
   end
   return true
end

function ryfx:qing(id)
   print(id)
   ----������˵��������ʹ�����ȥ�置�ӻ�������������
   wait.make(function()
    local l,w=wait.regexp("^(> |)������˵��������ʹ�����ȥ(.*)����������$",3)
	if string.find(l,"��ʹ�����ȥ") then
	   	local ts={
	           task_name="���¸���",
	           task_stepname="����",
	           task_step=3,
	           task_maxsteps=4,
	           task_location=w[2],
	           task_description="����"..id,
	}
	   local st=status_win.new()
	   st:init(nil,nil,ts)
	   st:task_draw_win()
	   self.qing_count=0
	  print("qing:",w[2])
	  if self:is_invite(id)==false then
		 self:giveup()
         return
	  end
	    CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."���¸�������:λ��"..w[2].." ����:"..id, "yellow", "black") -- yellow on white
	  self.job_select=self.qing_NPC
	  self:prepare()
	  self:appear(id,w[2])
	  return
	end
	 wait.time(3)
   end)

end

function ryfx:combat_end()

end

function ryfx:combat()

end
--

function ryfx:dazuo()

   world.Send("set ����")
	local h
	h=hp.new()
	h.checkover=function()
	  if h.neili<math.floor(h.max_neili*self.neili_upper) then
		   --print(h.neili,h.max_neili*self.neili_upper," +++ ",self.neili_upper)
		    local x
			x=xiulian.new()
			x.halt=false
			x.min_amount=100
			x.safe_qi=h.max_qi*0.5
			x.limit=true
			x.fail=function(id)
             --print(id)
				if id==201 or id==1 then
				  world.Send("yun qi")
				  world.Send("yun jing")
	              local f
		          f=function() x:dazuo() end  --���
				  f_wait(f,10)
			    end
				if id==777 then
				   self:Status_Check()
				end
	           if id==202 then
	             local w
		         w=walk.new()
		         w.walkover=function()
			       x:dazuo()
		         end
		         w:go(1412)
			   end
			end
			x.success=function(h)
               --print(h.qi,h.max_qi*0.9)
			   --print(h.neili,h.max_neili*2-200)
			   if h.neili>=math.floor(h.max_neili*self.neili_upper) then
			      self:qing_again()
			   else
	             print("��������")
				 world.Send("yun qi")
		         x:dazuo()
			   end
			end
			x:dazuo()
		else
			--print(h.neili,h.max_neili*2-200)
			local b
			b=busy.new()
			b.Next=function()
			   self:qing_again()
			end
			b:check()
		end
	end
	h:check()
end

function ryfx:yun_neigong_again()
   wait.make(function()
	  world.Send("yun refresh")
	  world.Send("yun regenerate")
      local l,w=wait.regexp("^(> |)�������������$|^(> |)�����ھ������档$|^(> |)�㳤��������һ������$",5)
	   if l==nil then
	      self:yun_neigong_again()
	      return
	   end
       if string.find(l,"�����������") then
	     print("��������!")
	     --self:giveup()
		 self:dazuo()
	     return
	  end
      if string.find(l,"�����ھ�������")  or string.find(l,"�㳤��������һ����") then
		 local f=function()
		   self:qing_again()
		 end
		 f_wait(f,0.8)
		return
      end
	  wait.time(5)
	end)
end

function ryfx:qing_again()
   print("qing_again")
   print("npc:",self.npc," id:",self.id)
   world.Send("yun liaodu "..self.id)

   wait.make(function()
      world.Send("qing "..self.id)
	  local l,w=wait.regexp("^(> |)�㾫��������Ϣһ�°ɣ�$|^(> |)̫��ϧ�ˣ���Ҫ��������Ѿ����ˡ�|^(> |)"..self.npc.."����������һ���ж���$|^(> |)����û�������Ү��$|^(> |)"..self.npc.."�Ѿ����������룬�㲻���ٷѾ�����$|^(> |)"..self.npc.."��ɫ�԰ף�ֻ������һ�ۡ����������岻�ʡ�$|^(> |)��Ҫ�ȵ����ѹ�����˵��$|^(> |)��Ҫ�ȵ����ѹ�����˵��$",5)
      if l==nil then
         self:qing_again()
		 return
	  end
	  if string.find(l,"�㾫��������Ϣһ�°�") then
	     self:yun_neigong_again()
		 return
	  end
	  if string.find(l,"̫��ϧ�ˣ���Ҫ��������Ѿ�����") or string.find(l,"����û�������Ү") then
	     self:giveup()
		 return
	  end
	  if string.find(l,"ֻ������һ�ۡ����������岻��") then
	     self.qing_count=self.qing_count+1
		 print(self.qing_count," ����")
		 if self.qing_count>10 then
		    self:giveup()
		 else
		     self:qing_again()
		 end
	     return
	  end
	  if string.find(l,"��Ҫ�ȵ����ѹ�����˵") then
	     local party=world.GetVariable("party") or ""
		 if party=="������" then
	      world.Send("yun guiyuan "..self.id)
		 end
		  wait.time(2)
		  self:qing_again()
	      return
	  end
	  if string.find(l,"����������һ���ж�") or string.find(l,"�㲻���ٷѾ���") then
	     print("success!!")
		 local b
		 b=busy.new()
		 b.interval=0.3
		 b.Next=function()
		   local sp=special_item.new()
   	       sp.cooldown=function()
             self:reward()
           end
           sp:unwield_all()
		 end
		 b:check()
		 return
	  end
	 wait.time(5)
   end)

end

function ryfx:fight_end(callback)

end

function ryfx:win_lose(npc,id)
   wait.make(function()--�������һ�ݣ�˵�����������չ�Ȼ�������ⳡ�����������ˣ� ��˫��һ����Ц��˵�������ã�
   --�ؾ�������˼�����˵�����ⳡ�����������ˣ�����������
   --�������Ц��˵���������ˣ�


      local l,w=wait.regexp("^(> |)"..npc.."������Ц��˵���������ˣ�$|^(> |)"..npc.."˫��һ����Ц��˵�������ã�$|^(> |)��������˼�����˵�����ⳡ�����������ˣ�����������|^(> |)�����һ�ݣ�˵�����������չ�Ȼ�������ⳡ�����������ˣ�$|^(> |)�����һ�ݣ�������Ҿ˵�����������ղ�������Ȼ������|^(> |)����ɫ΢�䣬˵��������������$|^(> |)����־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��$|^(> |)"..npc.."ʤ�����У����Ծ�����ߣ�Ц�������ã�$|^(> |)�������Ц��˵���������ˣ�$|^(> |)��˫��һ����Ц��˵�������ã�$|^(> |)"..npc.."������˼�����˵�����ⳡ�����������ˣ�����������|^(> |)"..npc.."���һ�ݣ�˵�����������չ�Ȼ�������ⳡ�����������ˣ�$|^(> |)"..npc.."���һ�ݣ�������Ҿ˵�����������ղ�������Ȼ������|^(> |)"..npc.."��ɫ΢�䣬˵��������������$|^(> |)"..npc.."��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��$|^(> |)��ʤ�����У����Ծ�����ߣ�Ц�������ã�$|^(> |)"..npc.."��ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�$|^(> |)��ֻ����ͷ�����ͣ���ǰһ�ڣ�����ʲôҲ��֪���ˡ���$",5)

	  if l==nil then
	    self:win_lose(npc,id)
	    return
	  end
	  if string.find(l,"�������Ц��˵����������") or string.find(l,npc.."������˼�����˵�����ⳡ�����������ˣ���������") or string.find(l,"��˫��һ����Ц��˵��������") or string.find(l,npc.."���һ�ݣ�˵�����������չ�Ȼ�������ⳡ������������") or string.find(l,npc.."���һ�ݣ�������Ҿ˵�����������ղ�������Ȼ����") or string.find(l,npc.."��ɫ΢�䣬˵������������") or string.find(l,npc.."��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ") or string.find(l,"��ʤ�����У����Ծ�����ߣ�Ц��������") then
		print("Ӯ��!!")
		print("ս������")
		shutdown()
		--world.Send("unset wimpy")
		self.qing_count=0
		local f=function()
		  --self:qing_again()
		   self:qing_NPC(npc,id)
		end
		self.fight_end(f)
	    return
	  end
	  if string.find(l,"�����ų鶯�˼��¾�����") then
	     shutdown()
		 world.Send("unset wimpy")
		 local f=function()
		    self:giveup()
		 end
		 self.fight_end(f)
	     return
	  end
	  if string.find(l,"��ֻ����ͷ������") or string.find(l,npc.."������Ц��˵����������") or string.find(l,"��������˼�����˵�����ⳡ�����������ˣ���������") or string.find(l,npc.."˫��һ����Ц��˵��������") or string.find(l,"�����һ�ݣ�˵�����������չ�Ȼ�������ⳡ������������") or string.find(l,"�����һ�ݣ�������Ҿ˵�����������ղ�������Ȼ����") or string.find(l,"����ɫ΢�䣬˵������������") or string.find(l,"����־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ") or string.find(l,npc.."ʤ�����У����Ծ�����ߣ�Ц��������") then
	    print("����!!")
		world.Send("yun recover")
		print("ս������")
		shutdown()
		world.Send("unset wimpy")
		local h
	    h=hp.new()
	    h.checkover=function()
		  local f=nil
          if h.qi_percent<=80 or h.neili<=h.max_neili then
		      f=function()
		        self:giveup()
			  end
		  else
			 self.qing_count=0
			 f=function()
		        self:qing_NPC(npc,id)
			 end
		   end
		  self.fight_end(f)
	    end
	    h:check()
	    return
	  end
	  wait.time(5)
   end)
end

function ryfx:flee(i)
  world.Send("go away")
  local _R
   _R=Room.new()
   _R.CatchEnd=function()
    print("Ѱ�ҳ���")
     local dx=_R:get_all_exits(_R)
	 for _,d in ipairs(dx) do
	   print("exit:",d)
	 end
	 if i==nil then
	    --����������
	     local n=table.getn(dx)
	     i=math.random(n)
	 elseif i>table.getn(dx) then
	     i=1
	 end
	 print("���:",i)
	 local run_dx=dx[i]
	 print(run_dx, " ����")
	 local halt
	 if _R.roomname=="ϴ��ر�" then
	    world.Send("alias pfm "..run_dx..";set action ����")
	 else
	    world.Send("alias pfm halt;"..run_dx..";set action ����")
	 end
	 world.Send("set wimpy 100")
	 world.Send("set wimpycmd pfm\\hp")
	 self:run(run_dx,i)
   end
   _R:CatchStart()
end

function ryfx:yun_neigong(npc,id)
   wait.make(function()
	  world.Send("yun refresh")
	  world.Send("yun regenerate")
      local l,w=wait.regexp("^(> |)�������������$|^(> |)�����ھ������档$|^(> |)�㳤��������һ������$",5)
	   if l==nil then
	      self:yun_neigong(npc,id)
	      return
	   end
       if string.find(l,"�����������") then
	     print("��������!")
	     self:giveup()
	     return
	  end
      if string.find(l,"�����ھ�������")  or string.find(l,"�㳤��������һ����") then
		 local f=function()
		   self:qing_NPC(npc,id)
		 end
		 f_wait(f,0.8)
		return
      end
	end)
end

function ryfx:fight_reset()
end

function ryfx:compare(npc,id)
    world.Send("compare "..id)
	wait.make(function()
	   local l,w=wait.regexp("^(> |)С�ĵ㣬.*������ʤһ��, ���ʤ�㲻��$",5)
	   if l==nil then
	      return
	   end
	   if string.find(l,"���ʤ�㲻��") then
		  self:fight_reset()
	      return
	   end

	end)
end

function ryfx:qing_NPC(npc,id) --����ʵ��
   --���id
   --print("qing")
   --print("npc:",npc," id:",id)
   --������׹���һЦ����׳ʿ�Ĺ����Ȼ��������������ʹ����������ȥ�������͵�����
   wait.make(function()--,5)
      world.Send("qing "..string.lower(id))
	  local l,w=wait.regexp("^(> |)����û�������Ү��$|^(> |)̫��ϧ�ˣ���Ҫ��������Ѿ����ˡ�|^(> |)�㾫��������Ϣһ�°ɣ�$|^(> |)"..npc.."ɨ����һ�۵�����.*��Ȼ������������м������ʵѧ������.*������������ɣ���|^(> |)"..npc.."����������һ���ж���$|^(> |)����û�������Ү��$|^(> |)"..npc.."�Ѿ����������룬�㲻���ٷѾ�����$|^(> |)"..npc.."��ɫ�԰ף�ֻ������һ�ۡ����������岻�ʡ�$|^(> |)"..npc.."����һЦ����.*�Ĺ����Ȼ��������������ʹ����������ȥ�������͵�����$|^(> |)��Ҫ�ȵ����ѹ�����˵��$",5)
      if l==nil then
         self:qing_NPC(npc,id)
		 return
	  end

	  if string.find(l,"�㾫��������Ϣһ�°�") then
		 self:yun_neigong(npc,id)
		 return
	  end
	  if string.find(l,"̫��ϧ�ˣ���Ҫ��������Ѿ�����") or string.find(l,"����û�������Ү") then
	     self:giveup()
	     return
	  end
      if string.find(l,"���������岻��") then
	     self.qing_count=self.qing_count+1
		 print(self.qing_count," ����")
		 if self.qing_count>10 then
		    self:giveup()
		 else
		     self:qing_NPC(npc,id)
		 end
		 return
	  end
	  if string.find(l,"��Ҫ�ȵ����ѹ�����˵") then
		 local party=world.GetVariable("party") or ""
		 if party=="������" then
	      world.Send("yun guiyuan "..self.id)
		 end
		  wait.time(2)
		   self:qing_NPC(npc,id)
	     return
	  end

	  --éʮ��ɨ����һ�۵�����С���˵�����Ȼ������������м������ʵѧ�����ô�ү��������������ɣ���
	  if string.find(l,"�������������") then
	     --print("fight")
		 --self.fight=true
         self:compare(npc,id)
		 world.Send("follow "..id)
		 self:combat()
		 self:win_lose(npc,id)
		 return
	  end
	 if string.find(l,"����������һ���ж�") or string.find(l,"�㲻���ٷѾ���") or string.find(l,"�����͵�") then
	     print("success!!")
		 local b
		 b=busy.new()
		 b.interval=0.3
		 b.Next=function()
		   self:reward()
		 end
		 b:check()
		 return
	  end
   end)
   --�㾫��������Ϣһ�°ɣ�
   --�˵�����ɨ����һ�۵��������������ּ�Ȼ������������м������ʵѧ�����ô�ү��������������ɣ���
   --�˵��������һ�ݣ�������Ҿ˵�����������ղ�������Ȼ������
   --�˵����Ӿ���������һ���ж���
   --�嶾��Ů����ɨ����һ�۵��������������ּ�Ȼ������������м������ʵѧ�����ñ�����������������ɣ���
end

function ryfx:fail(id)
end

function ryfx:give_head()
  	local ts={
	           task_name="���¸���",
	           task_stepname="����",
	           task_step=4,
	           task_maxsteps=4,
	           task_location="",
	           task_description="",
	}
	local st=status_win.new()
	st:init(nil,nil,ts)
	st:task_draw_win()
  ryfx.ss_co=nil
  local w
  w=walk.new()
  w.walkover=function()
     world.Send("give head to xiang wentian")
	 world.Send("give corpse to xiang wentian")
	 wait.make(function()
	   local l,w=wait.regexp("^(> |)��������㽲��һЩ��ѧ�ϵ����ѣ���������˼�ص���ͷ��$|^(> |)������û������������$",5)
	   if l==nil then
	     self:give_head()
		 return
	   end
	   if string.find(l,"��������˼�ص���ͷ") or string.find(l,"������û����������") then
	     self:xxdf()
	      local rc=reward.new()
		  rc.finish=function()
		     CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."���¸�������:����! ����:"..rc.exps_num.." Ǳ��:"..rc.pots_num, "red", "black") -- yellow on white
 		  end
		  rc:get_reward()
       local b=busy.new()
	   b.Next=function()
         self:jobDone()
	   end
	   b:check()
	     return
	   end
	 end)
  end
  w:go(1413)
end

function ryfx:qie_corpse(index)
	print("ս������")
	shutdown()
    world.Send("wield jian")
   if index==nil then
      --world.Send("get all from corpse")
	  --world.Send("get ling from corpse")
	  world.Send("get silver from corpse")
	  world.Send("get gold from corpse")
      world.Send("qie corpse")
	else
      world.Send("get silver from corpse "..index)
	  --world.Send("get ling from corpse "..index)
	  world.Send("get gold from corpse "..index)

	  world.Send("qie corpse ".. index)
   end

	--ֻ�����ǡ���һ�����㽫���������׼�ն���������������С�> ���б���ɱ���˸��ﰡ��
    wait.make(function()
	  local l,w=wait.regexp("^(> |)ֻ�����ǡ���һ�����㽫"..self.npc.."���׼�ն���������������С�$|^(> |)���б���ɱ���˸��ﰡ��$|^(> |)�Ǿ�ʬ���Ѿ�û���׼��ˡ�$|^(> |)���Ҳ��� corpse ����������$|^(> |)�Ҳ������������$|(> |)��������������޷����У������������ʬ���ͷ����$|^(> |)����ü����������߲���������ʬ���ͷ����$|^(> |)����ɣ���Զ����ʬ��Ҳ����Ȥ��$",5)
	  if l==nil then
	    self:qie_corpse(index)
		return
	  end
	  if string.find(l,"���б���ɱ���˸��ﰡ") or string.find(l,"�Ǿ�ʬ���Ѿ�û���׼���") or string.find(l,"����ɣ���Զ����ʬ��Ҳ����Ȥ") then
       if index==nil then
	     index=2
	   else
	     index=index+1
	   end
       self:qie_corpse(index)
       return
      end
	 if string.find(l,"�Ҳ���") then
       local sp=special_item.new()
	   sp.cooldown=function()
         self:giveup()
	   end
	   sp:unwield_all()
       return
     end
	  if string.find(l,"�׼�ն����������������") then
	    print("�ر�")
		shutdown()
		local b
		b=busy.new()
		b.interval=0.5
		b.Next=function()
		  world.Send("unwield jian")
		  local sp=special_item.new()
   	       sp.cooldown=function()
             self:give_head()
           end
           sp:unwield_all()
		end
		b:check()
	    return
	  end
	   if string.find(l,"��������������޷����У������������ʬ���ͷ��") or string.find(l,"����ü����������߲���������ʬ���ͷ��") then
        local sp=special_item.new()
   	    sp.cooldown=function()
	     local f=function()
           self:qie_corpse(index)
		 end
		 local error_deal=function()
		     world.Send("get corpse") --ֱ�ӻ�ȡʬ��
			 self:give_head()
		 end
		 local do_again=function()
		   world.Send("i")
	  	   self:auto_wield_weapon(f,error_deal)
		   world.Send("set look 1")
		 end
		  f_wait(do_again,0.5)
        end
        sp:unwield_all()
      return
   end
	end)
end

function ryfx:look_corpse(npc)
   print("look "..npc.." ʬ��")
   wait.make(function()
      world.Send("look")
	  world.Send("set look 1")
     local l,w=wait.regexp("^(> |).*"..npc.."��ʬ��\\(Corpse\\)$|^(> |)�趨����������look \\= 1$",5)
	 if l==nil then
	    self:look_corpse()
	    return
	 end
	 if string.find(l,"��ʬ��") then
	    print(npc,"��ʬ��")
	    self:qie_corpse()
		return
	 end
	 if string.find(l,"�趨����������look") then
	    shutdown()
		self:giveup()
	    return
	 end
   end)
end

function ryfx:npc_idle(npc,id)
  print("�ε�",npc,id)
  npc=Trim(npc)
  wait.make(function()
  local l,w=wait.regexp("^(> |)"..npc.."��ž����һ�����ڵ��ϣ������ų鶯�˼��¾�����.*|^(> |)�������Ц��˵���������ˣ�$|^(> |)��˫��һ����Ц��˵�������ã�$|^(> |)"..npc.."������˼�����˵�����ⳡ�����������ˣ�����������|^(> |)"..npc.."���һ�ݣ�˵�����������չ�Ȼ�������ⳡ�����������ˣ�$|^(> |)"..npc.."���һ�ݣ�������Ҿ˵�����������ղ�������Ȼ������|^(> |)"..npc.."��ɫ΢�䣬˵��������������$|^(> |)"..npc.."��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��$|^(> |)��ʤ�����У����Ծ�����ߣ�Ц�������ã�$|^(> |)"..npc.."��(.*)��.*��Ķ����ˡ�$",5)

    --���ĵ���־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��
	   if l==nil then
	      self:npc_idle(npc,id)
		  return
	   end
	   if string.find(l,"�������Ц��˵����������") or string.find(l,"������˼�����˵�����ⳡ�����������ˣ���������") or string.find(l,"��˫��һ����Ц��˵��������") or string.find(l,"���һ�ݣ�˵�����������չ�Ȼ�������ⳡ������������") or string.find(l,"���һ�ݣ�������Ҿ˵�����������ղ�������Ȼ����") or string.find(l,"��ɫ΢�䣬˵������������") or string.find(l,"��ʤ�����У����Ծ�����ߣ�Ц��������") then
	    print("�ٴ�fight!")
  	    self:kill_NPC(npc,id)
	    return
	   end
	   if string.find(l,"��Ķ���") then
	       local dx=w[11]
		   print(dx,"��Ķ���!")
		   local escape=""
		   if dx=="����" then
		       escape="east"
		   elseif dx=="����" then
		      escape="west"
		   elseif dx=="����" then
		      escape="north"
		   elseif dx=="����" then
		      escape="south"
		   end
		   shutdown()
		   print(escape,"׷��")
		   local b=busy.new()
		   b.Next=function()
		      world.Send(escape)
		      print("�ٴ�fight!")
  	          self:kill_NPC(npc,id)
		   end
		   b:check()
	      return
	   end
	   if string.find(l,"�����ų鶯�˼��¾�����") then
	     print("ֱ�ӹҵ�")
	     self:qie_corpse()
	     return
	   end
	   if string.find(l,"��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ") then
	     print("�ε�")
	     self:hit(npc,id)
		 return
	   end
	end)
end

function ryfx:npc_die(npc,id)
    print("npc die",npc)
    wait.make(function()
	  local l,w=wait.regexp("^(> |)"..npc.."��ž����һ�����ڵ��ϣ������ų鶯�˼��¾�����.*$|^(> |)"..npc.."��(.*)��.*��Ķ����ˡ�$",10)
	   if l==nil then
	      self:npc_die(npc,id)
		  return
	   end
	  if string.find(l,"��Ķ���") then
	       local dx=w[11]
		   print(dx,"��Ķ���!")
		   local escape=""
		   if dx=="����" then
		       escape="east"
		   elseif dx=="����" then
		      escape="west"
		   elseif dx=="����" then
		      escape="north"
		   elseif dx=="����" then
		      escape="south"
		   end
		   print(escape,"׷��")
		   shutdown()
		   local b=busy.new()
		   b.Next=function()
		      world.Send(escape)
		      print("�ٴ�fight!")
  	          self:kill_NPC(npc,id)
		   end
		   b:check()
	      return
	   end
	   if string.find(l,"�����ų鶯�˼��¾�����") then
	     shutdown()
	     self:qie_corpse()
	     return
	   end
	end)
end

function ryfx:hit(npc,id)
  local b=busy.new()
  b.Next=function()
   wait.make(function()
       world.Send("follow "..id)
       world.Send("kill "..id)
	   --self:auto_pfm()
	   self:combat()
	   self:npc_die(npc,id)
	   local l,w=wait.regexp("^(> |)����û������ˡ�$",10)
	   if l==nil then
         self:hit(npc,id)
	     return
	   end
	   --if string.find(l,"������"..npc.."��ɱ����") or string.find(l,"���ͣ����ͣ�") then
	   --self:npc_die(npc,id)
	   --   return
	   --end
	   if string.find(l,"����û�������") then
	     shutdown()
	     self:look_corpse(npc) --1 �Ѿ�����
	     return
	   end
   end)
  end
  b:jifa()
end

function ryfx:kill_NPC(npc,id) --����ʵ��

--[[
��������ĵºٺ�һЦ�������������ô�ү����������׳ʿ�ĸ��аɣ�
Ǯ�ཡ˵��������Ȼ׳ʿ�ͽ̣�����ֻ�÷��㣬���ǵ㵽Ϊֹ����
���ĵ�˵��������Ȼ׳ʿ�ͽ̣�����ֻ�÷��㣬���ǵ㵽Ϊֹ����
> �㻺�����ƶ��ţ���Ҫ�ҳ����ĵµ�������
���ĵ�ע��������ж�����ͼѰ�һ�����֡�

��������ʤ�ٺ�һЦ�������������ô�ү����������׳ʿ�ĸ��аɣ�
�ױ��ӳ���ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�
�ױ��ӳ�˵��������Ȼ����ͽ̣�����ֻ�÷��㣬���ǵ㵽Ϊֹ����
���ʤ˵������������ô������׳ʿ�Ķ��֣����ͱ���Ц�ˣ���
]]
   print("ս��")
   print("npc:",npc," id:",id)
   wait.make(function()
       world.Send("follow "..id)
       world.Send("fight "..id)
	   --self:auto_pfm()

	   local l,w=wait.regexp("^(> |)������"..npc.."��������������$|^(> |)"..npc.."˵��������Ȼ.*�ͽ̣�.*ֻ�÷��㣬���ǵ㵽Ϊֹ����$|^(> |)���ͣ����ͣ����ͣ�$|^(> |)"..npc.."�Ѿ��޷�ս���ˡ�$|^.*����û�� "..id.."��$|^(> |)�����ֹս����$",5)
	   if l==nil then
         self:kill_NPC(npc,id)
	     return
	   end
	   if string.find(l,"������������") or string.find(l,"�Ѿ��޷�ս����") then
	      self:hit(npc,id)
	      return
	   end
	   if string.find(l,"���ǵ㵽Ϊֹ")  or string.find(l,"���ͣ����ͣ�����") then
	     --print("kill npc fight hit")
		 self:npc_idle(npc,id)
	     self:combat()

	     return
	   end
	   if string.find(l,"�����ֹս��") then
	      self:giveup()
	      return
	   end
	   if string.find(l,"����û��") then
	      self:look_corpse(npc)
	      return
	   end

   end)
end

function ryfx:job_select(npc,id) --�ص�����
end

function ryfx:run(i)
--[[> ��� "pfm" �趨Ϊ "halt;east;set action ����" �ɹ���ɡ�
> �趨����������wimpy = 100
> �趨����������wimpycmd = "pfm\hp"
> ������ʹ�á��ļ�ɢ��������ʱ�޷�ֹͣս����
��ת����Ҫ��������ҷ�һ����ס��
������ʧ�ܡ�
�趨����������action = "����"]]
--���ֲ���ս������ʲô�ܣ�

   wait.make(function()
	   local l,w=wait.regexp("^(> |)��Ķ�����û����ɣ������ƶ���$|^(> |)������ʧ�ܡ�$|^(> |)������ʹ��.*��ʱ�޷�ֹͣս����$|^(> |)�����Ϊ������$|^(> |)�趨����������action \\= \\\"����\\\"$|^(> |)���ֲ���ս������ʲô�ܣ�$",1.5)
	   if l==nil then
	      world.Send("go away")
	      self:run(i)
	      return
	   end
	   if string.find(l,"�����Ϊ����") then
	     i=i+1
		 self:flee(i)
	     return
	   end
	   if string.find(l,"��Ķ�����û����ɣ������ƶ�") or string.find(l,"������ʧ��") or string.find(l,"��ʱ�޷�ֹͣս��") then
		  self:run(i)
	      return
	   end
	   if string.find(l,"���ֲ���ս������ʲô��") then
	      self:giveup()
	      return
	   end
	   if string.find(l,"�趨����������action") then
		 world.DoAfter(1.5,"set action ����")
		 wait.make(function()
		    local l,w=wait.regexp("^(> |)�趨����������action \\= \\\"����\\\"$|^(> |)�趨����������action \\= \\\"����\\\"$",5)
			if l==nil then
			   self:run(i)
			  return
			end
			if string.find(l,"����") then
			    i=i+1
		        self:flee(i)
			   return
			end
			if string.find(l,"����") then
			   shutdown()
			   world.Send("unset wimpy")
			   self:giveup()
			   return
			end
			wait.time(5)
		 end)
	     return
	   end


  end)
end

function ryfx:flee(i)
  world.Send("go away")
  local _R
   _R=Room.new()
   _R.CatchEnd=function()
    print("Ѱ�ҳ���")
     local dx=_R:get_all_exits(_R)
	 for _,d in ipairs(dx) do
	   print("exit:",d)
	 end
	 if i==nil or i>table.getn(dx) then
	    --����������
	     local n=table.getn(dx)
	     i=math.random(n)
		 print("���:",i)
	 end
	 local run_dx=dx[i]
	 print(run_dx, " ����")
	 local halt
	 if _R.roomname=="ϴ��ر�" then
	    world.Send("alias pfm "..run_dx..";set action ����")
	 else
	    world.Send("alias pfm halt;"..run_dx..";set action ����")
	 end
	 world.Send("set wimpy 100")
	 world.Send("set wimpycmd pfm\\hp")
	 self:run(i)
   end
   _R:CatchStart()
end

function ryfx:check_menpai(id,npc)
  local exps=world.GetVariable("exps") or 0
  if tonumber(exps)>2000000 then
     world.Send("look "..id)
  end
   world.Send("set action ���ɼ��")
   wait.make(function()
      local l,w=wait.regexp("^(> |)���˿���ȥʦ��(.*)���ó�ʹ��(.*)�˵У�$|^(> |)�趨����������action = \"���ɼ��\"$",5)
   if string.find(l,"���˿���ȥʦ��") then
       if self.jobtype=="��ɱ" then

        local party=w[2]
	    local skill=w[3]
	    if self.g_blacklist~="" then
	      local blacklist=Split(self.g_blacklist,"|")
	       for _,b in ipairs(blacklist) do
	        --print("b",b)
		   if skill==b or party==b then
		     print("����")
		      self:flee()
		     return
		    end
	     end
	    end
	  end
	  self:auto_pfm()
	  self:job_select(npc,id)
      return
   end
   if string.find(l,"�趨����������action") then
       self:auto_pfm()
       self:job_select(npc,id)
       return
   end
   end)
end

function ryfx:get_id(npc)
	wait.make(function()
		 world.Send("look")
	    local l,w=wait.regexp("^(> |).*"..npc.."\\\((.*)\\\).*$",5)
		if l==nil then
		   self:get_id(npc)
		   return
		end
		if string.find(l,npc) then
		   --���������� ���� xx ��
		   self.npc=npc
		   local id=string.lower(w[2])
		   self.id=id
		   self:check_menpai(id,npc)
		   return
		end
		wait.time(5)
	end)
end
--û��npcʱ�� ȷ�����Ƿ񵽴�׼ȷ�ص�
local function is_contain(r,rooms)
    if rooms==nil then
	  return false
	end
	for _,v in ipairs(rooms) do
	    if v==r then
		   return true
		end
	end
	return false
end

function ryfx:checkPlace(npc,roomno,here)
      if is_contain(roomno,here) then
  	     print("�ȴ�0.1s,��һ������")
		 self.try_count=0
		 local f=function()
		   local b
		   b=busy.new()
		   b.interval=0.5
		   b.Next=function()
		     self:NextPoint()
		   end
		   b:check()
		 end
		 f_wait(f,0.1)
	   else
	   --û���ߵ�ָ������
	    print("û���ߵ�ָ������")
		self.try_count=self.try_count+1
		if self.try_count<3 then

	      local w=walk.new()
		  local al
		  al=alias.new()
		  al.do_jobing=true
		  al.break_in_failure=function()
		      self:giveup()
		  end
		  w.user_alias=al
		  w.walkover=function()
		    self:checkNPC(npc,roomno)
		  end
		  w:go(roomno)
		else
		   self:NextPoint()
		end
	   end
end

--  ��̳���� �ֺ�(Yue hu) <ս����>
--> �ֺ������㷢��һ����Ц��˵������Ȼ��������������������ˣ���Ҳ��ֻ�����������ˣ�

--�ֺ�˵�������������������������İɣ���
--�������ֺ���ɱ���㣡
function ryfx:checkNPC(npc,roomno)
    --print("checkNPC",npc)
    wait.make(function()
      world.Execute("look;set look 1")
	  local l,w=wait.regexp("^(> |).*"..npc.."\\\((.*)\\\)(| <ս����>)$|^(> |)�趨����������look \\= 1$",15)
	  if l==nil then
	     self:checkNPC(npc,roomno)
		 return
	  end
	  if string.find(l,"�趨����������look") then
	      local f=function(r)
		     self:checkPlace(npc,roomno,r)
		  end
		  WhereAmI(f)
	     return
	  end
	  if string.find(l,npc) then
         --self:get_id(npc)
		  self.npc=npc
		   local id=string.lower(w[2])
		   self.id=id
		   self:check_menpai(id,npc)
	     return
	  end
	  wait.time(15)
   end)
end

function ryfx:NextPoint()
   print("���ָ̻�")
   coroutine.resume(ryfx.ss_co)
end

function ryfx:appear(npc,location)
   if zone_entry(location)==true then
      --world.AppendToNotepad (WorldName().."_���¸�������:",os.date()..": �޷�����"..location.."ֱ�ӷ���\r\n")
      self:giveup()
      return
   end

  local n,rooms=Where(location)
   if n>0 then
	 local b
	 b=busy.new()
	 b.interval=0.5
	 b.Next=function()
	   world.Send("yun recover")
	   self:shield()
	   print("ץȡ")
	   ryfx.ss_co=coroutine.create(function()
	    for index,r in ipairs(rooms) do
          local w
		  w=walk.new()
		  local al
		  al=alias.new()
		  al.do_jobing=true
		  al.break_in_failure=function()
		      self:giveup()
		  end
          al.maze_done=function()
		      self:checkNPC(npc,r)
		  end
		  w.user_alias=al

		  w.walkover=function()

		    self:checkNPC(npc,r)
		  end
		  al.noway=function()
		     self:giveup()
		  end
		  w.noway=function()
		    self:giveup()
		  end
		  self.target_roomno=r
		 if index==1 then
		    w.current_roomno=1413
		  end
		  w:go(r)
		  coroutine.yield()
	    end
		self:giveup()
	   end)
	   self:NextPoint()
	 end
	 b:check()
	else
	  print("û��Ŀ��")
	  self:giveup()
	end
end

function ryfx:blacklist(name,exps)
 -- ������|����|���ĵ�|��Ȼ��|ժ����|�ֲ�
 --ʷ��ͷ|������|����|������|���ĵ�|�����|������|ժ����|ƮȻ��|������|����Ƽ
  if string.find(name,"��Ժ����") or string.find(name,"������") or string.find(name,"ѦĽ��") or string.find(name,"���ĵ�") or string.find(name,"�����") or string.find(name,"����") or string.find(name,"������") or string.find(name,"ժ����") or string.find(name,"ƮȻ��") or string.find(name,"�����") or string.find(name,"�ɹ��") or string.find(name,"������") then

     return true
  end
  if (string.find(name,"�ɹ���ʿ") or string.find(name,"����Ƽ")) and exps<990000 then

     return true
  end
  return false
end

--������˵�������ٺ٣����ڴ����ǳ�����һ������ȥ����ɱ�˴�������ʬ��ϻ�������

function ryfx:shashou(id)
   print(id)
   wait.make(function()
    local l,w=wait.regexp("^(> |)������˵�������ٺ٣�����(.*)һ������ȥ����ɱ�˴�������ʬ��ϻ�������$",3)
	 if string.find(l,"��ȥ����ɱ��") then
	   	local ts={
	           task_name="���¸���",
	           task_stepname="ɱ��",
	           task_step=3,
	           task_maxsteps=4,
	           task_location=w[2],
	           task_description="��ɱ"..id,
	}
	   local st=status_win.new()
	   st:init(nil,nil,ts)
	   st:task_draw_win()

       CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."���¸�������:λ��"..w[2].." ��ɱ:"..id, "yellow", "black") -- yellow on white
	    print("shashou:",w[2])
		self.job_select=self.kill_NPC
		self:auto_pfm()
		self:appear(id,w[2])
		return
	 end
    wait.time(3)
   end)
end

function ryfx:giveup()
   ryfx.ss_co=nil
   local w
   w=walk.new()
   w.walkover=function()
     wait.make(function()
	 world.Send("ask xiang wentian about ����")
	 local l,w=wait.regexp("^(> |)������˵������������͵��ˣ������ʱ���ܾȳ��ν�����������$|������˵��������Ȼ��ɲ���Ҳû��ϵ����ȥ�̿������ɣ��Ժ�����Ϊ���ǵĲ��ɴ�Ƴ�������$|^(> |)������˵��������û�������񣬺�������ʲô����",5)
	 if l==nil then
	   print("��ʱ")
	   self:giveup()
	   return
	 end
	 if string.find(l,"��Ȼ��ɲ���Ҳû��ϵ����ȥ�̿�������") or string.find(l,"��ʱ���ܾȳ��ν���") then
	    --BigData:catchData(311,"����̨")
       wait.time(2)
	   local f=function()
	     self:Status_Check()
	   end
	   Weapon_Check(f)

	   return
	 end
	 if string.find(l,"��û�������񣬺�������ʲô") then
	    print("ɵɵ������")
		self.fail(101)
		--self:jobDone()
	    return
	 end

   end)
  end
  w:go(1413)
end


function ryfx:reward()
  	local ts={
	           task_name="���¸���",
	           task_stepname="����",
	           task_step=4,
	           task_maxsteps=4,
	           task_location="",
	           task_description="",
	}
	local st=status_win.new()
	st:init(nil,nil,ts)
	st:task_draw_win()
	ryfx.ss_co=nil

  local w
  w=walk.new()
  w.walkover=function()
     world.Send("ask xiang wentian about ���")
     wait.make(function()
	   local l,w=wait.regexp("^(> |)��ϲ�㣡��ɹ�����������¸��������㱻�����ˣ�$|^(> |)"..self.npc.."��ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�$|^(> |)��������л�Ȼ����.*$|^(> |)������˵��������û��������Ҫ���ʲô����$",8)
	   if l==nil then
	       if self.get_reward_count>=5 then
		      self:jobDone()
		   else
		      self.get_reward_count=self.get_reward_count+1
	          self:reward()
		   end
	       return
	   end
	   if string.find(l,"�����ų鶯�˼��¾�����") then
	      print("��������ʱ�䣡")
	      self:giveup()
	      return
	   end
	   if string.find(l,"��ϲ��") or string.find(l,"��������л�Ȼ����") or string.find(l,"Ҫ���ʲô") then
          self:xxdf()
		 local rc=reward.new()
		  rc.finish=function()
		     CallPlugin ("88f53dbf74b5a0ac2fefbf95", "MsgNote", os.date().."���¸�������:����! ����:"..rc.exps_num.." Ǳ��:"..rc.pots_num, "red", "black") -- yellow on white
 		  end
		  rc:exps()
         local b=busy.new()
		 b.Next=function()
		  -- BigData:catchData(311,"����̨")
	      print("job ����")
	      self:jobDone()
		 end
		 b:check()
		  return
	   end
	   --wait.time(8)
	 end)
  end
  --self:get_reward()
  w:go(1413)
end

-- ��������
function ryfx:Status_Check()
	local ts={
	           task_name="���¸���",
	           task_stepname="����",
	           task_step=1,
	           task_maxsteps=4,
	           task_location="",
	           task_description="",
	}
	local st=status_win.new()
	st:init(nil,nil,ts)
	st:task_draw_win()
	 local liao_percent=world.GetVariable("liao_percent") or 80
	 liao_percent=tonumber(liao_percent)
     --��ʼ��
	 self.fight=false
	 local vip=world.GetVariable("vip") or "��ͨ���"
	local h
	h=hp.new()
	h.checkover=function()
	    print(h.food,h.drink)
	    if h.food<50 or h.drink<50 and vip~="�����������" then
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
				    self:Status_Check()
				 end
				 b2:check()
			  end
			  b:check()
		   end
		   w:go(1960) --299 ask xiao tong about ʳ�� ask xiao tong about ��

		elseif h.qi_percent<=liao_percent or h.jingxue_percent<=80  then
			local rc=heal.new()
			--rc.teach_skill=teach_skill --config ȫ�ֱ���
			rc.saferoom=1412
			rc.heal_ok=function()
			   self:Status_Check()
			end
			rc:liaoshang()
		elseif h.qi_percent<100 and h.qi_percent>=80 then
			print("��ͨ����")
            local rc=heal.new()
			--rc.teach_skill=teach_skill --config ȫ�ֱ���
			rc.liaoshang_fail=self.liaoshang_fail
			rc.saferoom=1412
			rc.heal_ok=function()
			   self:Status_Check()
			end
			rc:heal()
		elseif h.neili<h.max_neili*0.5 then
		    local r=rest.new()
			r.wash_over=function()
                self:Status_Check()
            end
			r:wash()

		elseif h.neili<math.floor(h.max_neili*self.neili_upper) then
		   --print(h.neili,h.max_neili*self.neili_upper," +++ ",self.neili_upper)
		     if h.neili<=h.max_neili then
			  world.Send("fu chuanbei wan")
			end
		    local x
			x=xiulian.new()
			x.halt=false
			x.min_amount=100
			x.safe_qi=h.max_qi*0.5
			x.limit=true
			x.fail=function(id)
             --print(id)
				if id==201 or id==1 then
				  world.Send("yun qi")
				  world.Send("yun jing")
	              local f
		          f=function() x:dazuo() end  --���
				  f_wait(f,10)
			    end
				if id==777 then
				   self:Status_Check()
				end
	           if id==202 then
	             local w
		         w=walk.new()
		         w.walkover=function()
			       x:dazuo()
		         end
		         w:go(1413)
			   end
			end
			x.success=function(h)
               --print(h.qi,h.max_qi*0.9)
			   --print(h.neili,h.max_neili*2-200)
			   if h.neili>=math.floor(h.max_neili*self.neili_upper) then
			     self:ask_job()
			   else
	             print("��������")
				 world.Send("yun qi")
		         x:dazuo()
			   end
			end
			x:dazuo()
		else
			--print(h.neili,h.max_neili*2-200)
			local b
			b=busy.new()
			b.Next=function()
			  self:ask_job()
			end
			b:check()
		end
	end
	h:check()

end

function ryfx:auto_wield_weapon(f,error_deal)
--�㽫�����������������С��㡸ৡ���һ�����һ�������������С�

   wait.make(function()
	 local l,w=wait.regexp("(.*)\\((.*)\\)$|^(> |)�趨����������look \\= 1$",5)
    if l==nil then
	   self:auto_wield_weapon(f,error_deal)
	   return
	end
	if string.find(l,")") then
	   print(w[1],w[2])
	   local item_name=w[1]
	   local item_id=string.lower(w[2])
      if (string.find(item_id,"sword") or string.find(item_id,"jian")) and string.find(item_name,"��") then
         world.Send("wield "..item_id)
		  self.weapon_exist=true
      elseif (string.find(item_id,"axe") or string.find(item_id,"fu")) and string.find(item_name,"��") then
         world.Send("wield "..item_id)
		 self.weapon_exist=true
      elseif (string.find(item_id,"blade") or string.find(item_id,"dao")) and string.find(item_name,"��") or string.find(item_id,"xue sui") then
         world.Send("wield "..item_id)
		 self.weapon_exist=true
      elseif (string.find(item_id,"dagger") or string.find(item_id,"bishou")) and string.find(item_name,"ذ��") then
         world.Send("wield "..item_id)
		 self.weapon_exist=true
	  end
	  self:auto_wield_weapon(f,error_deal)
	  return
	end
    if string.find(l,"�趨����������look") then
	   print(self.weapon_exits,"ֵ")
	   if self.weapon_exist==true then
	      f()
	   else
	     print("û�к�������!!�����鹺������!")
         error_deal()
	   end
	   return
	end
	wait.time(5)
   end)
end

function ryfx:shield()
end
function ryfx:jobDone()  --�ص�����
end