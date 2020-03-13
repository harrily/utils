
select empno ,ename,job,
if (empno < 7800 and mgr = 8002 ,SUM(sal),'') as a1 ,  
if (empno < 7800 and mgr != 8002 ,SUM(sal),'') as  a2 ,
if (empno >=7800 ,SUM(sal),'') as B  
from test.emp group by empno,ename,job,mgr;

select  empno ,ename,job,  a1 ,  a2  from
(select empno ,ename,job,
if (empno < 7800 and mgr = 8002 ,SUM(sal) over (partition by empno,ename,job ,mgr) ,'') as a1 ,  
if (empno < 7800 and mgr != 8002 ,SUM(sal) over (partition by empno,ename,job,mgr  ) ,'') as  a2 
from test.emp) vv where vv.a1!= "" or vv.a2 != "";

select empno ,ename,job, if (empno < 7800 and collect_set(mgr)[0] = 8002 ,SUM(sal) over (partition by empno,ename,job ,mgr),'') as a1 ,   
if (empno < 7800 and collect_set(mgr)[0] != 8002 ,SUM(sal) over (partition by empno,ename,job ,mgr),'') as  a2 
from test.emp ;

select a.empno ,a.ename,a.job,a.a1,b.a2 from 
(select empno ,ename,job,if (empno < 7800 ,SUM(sal),'') as a1
from test.emp where mgr = 8002 group by empno,ename,job) a
-- inner join
full JOIN 
(select empno ,ename,job,if (empno < 7800 ,SUM(sal),'') as a2 
from test.emp where mgr = 7902 group by empno,ename,job) b
on a.empno = b.empno;


-- ,if (gjahr,monat, < 7800 ,SUM(sal),'') as a1
select bukrs,lifnr,kunnr,anln1,kostl,h_waers  from  sap.ods_sap_zffi_007  
where shkzg = 'S' group by bukrs,lifnr,kunnr,anln1,kostl,hkont,h_waers limit 10  ;

select distinct(shkzg) from sap.ods_sap_zffi_007  ;

select
	case (cast (monat as int) )  
		when 1 then 31
		when 4 then 30
	else 28  end as endDate
from sap.ods_sap_zffi_007 limit 10 ;

-- BSEG02_BEGIN
--  期初 
select bukrs,lifnr,kunnr,anln1,kostl,h_waers,sum(wrbtr) as start_origin_jie_yue ,sum(dmbtr) as start_benwei_jie_yue  from  sap.ods_sap_zffi_007  
where shkzg = 'S' and  cast(regexp_replace(budat,"-","") as int) < cast(concat(gjahr,monat,"01") as int) 
group by bukrs,lifnr,kunnr,anln1,kostl,hkont,h_waers  ;

select bukrs,lifnr,kunnr,anln1,kostl,h_waers,sum(wrbtr) as start_origin_dai_yue ,sum(dmbtr) as start_benwei_dai_yue  from  sap.ods_sap_zffi_007  
where shkzg = 'H' and  cast(regexp_replace(budat,"-","") as int) < cast(concat(gjahr,monat,"01") as int) 
group by bukrs,lifnr,kunnr,anln1,kostl,hkont,h_waers  ;

-- BSEG02_END
-- 期末   
		-- S = 9712  H = 10576   all = 18617
select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(anln1) as anln1,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_jie_yue ,sum(dmbtr) as end_benwei_jie_yue from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(anln1),trim(kostl),trim(hkont),trim(h_waers) ;

select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(anln1) as anln1,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_dai_yue ,sum(dmbtr) as end_benwei_dai_yue from  sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(anln1),trim(kostl),trim(hkont),trim(h_waers) ;


select endall.bukrs,endall.lifnr,endall.kunnr,endall.anln1,endall.kostl,
endall.hkont,endall.h_waers,orig.h_hwaer 
,endall.end_origin_jie_yue,endall.end_benwei_jie_yue,endall.end_origin_dai_yue,endall.end_benwei_dai_yue
from(
select if(end1.bukrs is not null,end1.bukrs,end2.bukrs) as bukrs,
if(end1.lifnr is not null,end1.lifnr,end2.lifnr) as lifnr,
if(end1.kunnr is not null,end1.kunnr,end2.kunnr) as kunnr,
if(end1.anln1 is not null,end1.anln1,end2.anln1) as anln1,
if(end1.kostl is not null,end1.kostl,end2.kostl) as kostl,
if(end1.hkont is not null,end1.hkont,end2.hkont) as hkont,
if(end1.h_waers is not null,end1.h_waers,end2.h_waers) as h_waers,
end1.end_origin_jie_yue,end1.end_benwei_jie_yue,end2.end_origin_dai_yue,end2.end_benwei_dai_yue from
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(anln1) as anln1,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_jie_yue ,sum(dmbtr) as end_benwei_jie_yue from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(anln1),trim(kostl),trim(hkont),trim(h_waers) ) end1
full join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(anln1) as anln1,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_dai_yue ,sum(dmbtr) as end_benwei_dai_yue from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(anln1),trim(kostl),trim(hkont),trim(h_waers) ) end2 
on end1.bukrs = end2.bukrs and end1.lifnr = end2.lifnr  and end1.kunnr = end2.kunnr 
and end1.anln1 = end2.anln1 and end1.kostl = end2.kostl and end1.hkont = end2.hkont and end1.h_waers = end2.h_waers ) endall
left join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(anln1) as anln1,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers , trim(h_hwaer) as h_hwaer
from(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(anln1) as anln1,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers , trim(h_hwaer) as h_hwaer
,ROW_NUMBER() OVER (PARTITION by trim(bukrs),trim(lifnr),trim(kunnr),trim(anln1),trim(kostl),trim(hkont),trim(h_waers) ) rn
from sap.ods_sap_zffi_007) tmp where tmp.rn =1) orig
on endall.bukrs = orig.bukrs and endall.lifnr = orig.lifnr  and endall.kunnr = orig.kunnr 
and endall.anln1 = orig.anln1 and endall.kostl = orig.kostl and endall.hkont = orig.hkont and endall.h_waers = orig.h_waers


-- 去除重复的行 利用rownumber
select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(anln1) as anln1,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers , trim(h_hwaer) as h_hwaer
from(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(anln1) as anln1,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers , trim(h_hwaer) as h_hwaer
,ROW_NUMBER() OVER (PARTITION by trim(bukrs),trim(lifnr),trim(kunnr),trim(anln1),trim(kostl),trim(hkont),trim(h_waers) ) rn
from sap.ods_sap_zffi_007) tmp where tmp.rn =1 ;


/**  --  借贷标记，放至group by ， 结果是同一条记录，上下各两条
select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(anln1) as anln1,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
, if(shkzg = 'S' , sum(wrbtr)  ,'') as end_origin_jie_yue  ,if(shkzg = 'S' , sum(dmbtr) ,'') as end_benwei_jie_yue 
,if(shkzg = 'H' , sum(wrbtr)  ,'') as end_origin_dai_yue  ,if(shkzg = 'H' , sum(dmbtr) ,'') as end_benwei_dai_yue 
from  sap.ods_sap_zffi_007  
where  cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(anln1),trim(kostl),trim(hkont),trim(h_waers) ,shkzg;

/**
/*   -- 计数
select count(1) from (select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(anln1) as anln1,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_jie_yue ,sum(dmbtr) as end_benwei_jie_yue from  sap.ods_sap_zffi_007  
where  cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(anln1),trim(kostl),trim(hkont),trim(h_waers)) a ;
*/

-- BSEG02_OCCUR
select bukrs,lifnr,kunnr,anln1,kostl,hkont,h_waers  from  sap.ods_sap_zffi_007  
where shkzg = 'S' and  cast(regexp_replace(budat,"-","") as int) >=  cast(concat(gjahr,monat,"01") as int) 
and cast(regexp_replace(budat,"-","") as int)  <=  cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by bukrs,lifnr,kunnr,anln1,kostl,hkont,h_waers  ;

select distinct(lifnr) from sap.ods_sap_zffi_007; --供应商  ★
select distinct(kunnr) from sap.ods_sap_zffi_007;  -- 客户     ★
select distinct(anln1) from sap.ods_sap_zffi_007;  --资产    ★
select distinct(kostl) from sap.ods_sap_zffi_007; -- 成本中心  ★ 
select distinct(hkont) from sap.ods_sap_zffi_007;  --   总帐科目  ★
   --  h_waers  原币       ★ 
    -- H_HWAER 本位币    ★ 
    --  BUKRS  公司代码 

select distinct(shkzg) from sap.ods_sap_zffi_007;  

-- 转化过账日期 budat 为 int 便于计算
select cast(regexp_replace(budat,"-","") as int) from  sap.ods_sap_zffi_007  ;

-- 根据会计年度 期间 转化为月底日期（int）
select cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int) from sap.ods_sap_zffi_007 ;  
--  根据会计年度 期间   转化为月初日期（int）
select cast(concat(gjahr,monat,"01") as int)  from sap.ods_sap_zffi_007 ;  

select date_sub(concat(gjahr,"-",monat,"-","01"),dayofmonth(concat(gjahr,"-",monat,"-","01"))-1) from  sap.ods_sap_zffi_007 ;

select current_date from  sap.ods_sap_zffi_007 ;
-- 月底日期
select last_day("2004-02-08") from sap.ods_sap_zffi_007 ;  
-- 月初日期
select date_sub("2019-01-08",dayofmonth("2019-01-08")-1) from  sap.ods_sap_zffi_007 ;



---------------------------------- 2019全年 科目余额   表----------------------------------------------------------\

select whole.bukrs,whole.lifnr,whole.kunnr,whole.kostl,
whole.hkont,whole.h_waers,whole.h_hwaer,
whole.begin_origin_jie_yue,whole.begin_benwei_jie_yue,
whole.begin_origin_dai_yue,whole.begin_benwei_dai_yue,
whole.period_origin_jie_fasehng,whole.period_benwei_jie_fasheng,
whole.period_origin_dai_fasheng,whole.period_benwei_dai_fasheng,
whole.end_origin_jie_yue,whole.end_benwei_jie_yue,
whole.end_origin_dai_yue,whole.end_benwei_dai_yue
from
(select entire.bukrs,entire.lifnr,entire.kunnr,entire.kostl,
entire.hkont,entire.h_waers,orig.h_hwaer,
round(entire.begin_origin_jie_yue,2) as begin_origin_jie_yue ,round(entire.begin_benwei_jie_yue,2) as begin_benwei_jie_yue,
round(entire.begin_origin_dai_yue,2) as begin_origin_dai_yue ,round(entire.begin_benwei_dai_yue,2) as begin_benwei_dai_yue,
round(entire.period_origin_jie_fasehng,2) as period_origin_jie_fasehng,
round(entire.period_benwei_jie_fasheng,2) as period_benwei_jie_fasheng,
round(entire.period_origin_dai_fasheng,2) as period_origin_dai_fasheng,
round(entire.period_benwei_dai_fasheng,2) as period_benwei_dai_fasheng,
round(entire.end_origin_jie_yue,2) as end_origin_jie_yue,round(entire.end_benwei_jie_yue,2) as end_benwei_jie_yue,
round(entire.end_origin_dai_yue,2) as end_origin_dai_yue,round(entire.end_benwei_dai_yue,2) as end_benwei_dai_yue
from(
select if(endall.bukrs is not null,endall.bukrs,periodall.bukrs) as bukrs,
if(endall.lifnr is not null,endall.lifnr,periodall.lifnr) as lifnr,
if(endall.kunnr is not null,endall.kunnr,periodall.kunnr) as kunnr,
if(endall.kostl is not null,endall.kostl,periodall.kostl) as kostl,
if(endall.hkont is not null,endall.hkont,periodall.hkont) as hkont,
if(endall.h_waers is not null,endall.h_waers,periodall.h_waers) as h_waers,
beginall.begin_origin_jie_yue,beginall.begin_benwei_jie_yue,beginall.begin_origin_dai_yue,beginall.begin_benwei_dai_yue,
periodall.period_origin_jie_fasehng,periodall.period_benwei_jie_fasheng,periodall.period_origin_dai_fasheng,periodall.period_benwei_dai_fasheng,
endall.end_origin_jie_yue,endall.end_benwei_jie_yue,endall.end_origin_dai_yue,endall.end_benwei_dai_yue
from
(select if(end1.bukrs is not null,end1.bukrs,end2.bukrs) as bukrs,
if(end1.lifnr is not null,end1.lifnr,end2.lifnr) as lifnr,
if(end1.kunnr is not null,end1.kunnr,end2.kunnr) as kunnr,
if(end1.kostl is not null,end1.kostl,end2.kostl) as kostl,
if(end1.hkont is not null,end1.hkont,end2.hkont) as hkont,
if(end1.h_waers is not null,end1.h_waers,end2.h_waers) as h_waers,
end1.end_origin_jie_yue,end1.end_benwei_jie_yue,end2.end_origin_dai_yue,end2.end_benwei_dai_yue from
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_jie_yue ,sum(dmbtr) as end_benwei_jie_yue from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) end1
full join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_dai_yue ,sum(dmbtr) as end_benwei_dai_yue from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) end2 
on end1.bukrs = end2.bukrs and end1.lifnr = end2.lifnr  and end1.kunnr = end2.kunnr 
and end1.kostl = end2.kostl and end1.hkont = end2.hkont and end1.h_waers = end2.h_waers 
) endall
full join 
(select if(begin1.bukrs is not null,begin1.bukrs,begin2.bukrs) as bukrs,
if(begin1.lifnr is not null,begin1.lifnr,begin2.lifnr) as lifnr,
if(begin1.kunnr is not null,begin1.kunnr,begin2.kunnr) as kunnr,
if(begin1.kostl is not null,begin1.kostl,begin2.kostl) as kostl,
if(begin1.hkont is not null,begin1.hkont,begin2.hkont) as hkont,
if(begin1.h_waers is not null,begin1.h_waers,begin2.h_waers) as h_waers,
begin1.begin_origin_jie_yue,begin1.begin_benwei_jie_yue,begin2.begin_origin_dai_yue,begin2.begin_benwei_dai_yue from
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as begin_origin_jie_yue ,sum(dmbtr) as begin_benwei_jie_yue from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) < cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) begin1
full join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as begin_origin_dai_yue ,sum(dmbtr) as begin_benwei_dai_yue from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) < cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) begin2 
on begin1.bukrs = begin2.bukrs and begin1.lifnr = begin2.lifnr  and begin1.kunnr = begin2.kunnr 
and begin1.kostl = begin2.kostl and begin1.hkont = begin2.hkont and begin1.h_waers = begin2.h_waers
) beginall 
on  endall.bukrs = beginall.bukrs and endall.lifnr = beginall.lifnr  and endall.kunnr = beginall.kunnr 
and endall.kostl = beginall.kostl and endall.hkont = beginall.hkont and endall.h_waers = beginall.h_waers
full join 
(select if(period1.bukrs is not null,period1.bukrs,period2.bukrs) as bukrs,
if(period1.lifnr is not null,period1.lifnr,period2.lifnr) as lifnr,
if(period1.kunnr is not null,period1.kunnr,period2.kunnr) as kunnr,
if(period1.kostl is not null,period1.kostl,period2.kostl) as kostl,
if(period1.hkont is not null,period1.hkont,period2.hkont) as hkont,
if(period1.h_waers is not null,period1.h_waers,period2.h_waers) as h_waers,
period1.period_origin_jie_fasehng,period1.period_benwei_jie_fasheng,period2.period_origin_dai_fasheng,period2.period_benwei_dai_fasheng from
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as period_origin_jie_fasehng ,sum(dmbtr) as period_benwei_jie_fasheng from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int) and cast(regexp_replace(budat,"-","") as int) >= cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) period1
full join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as period_origin_dai_fasheng ,sum(dmbtr) as period_benwei_dai_fasheng from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int) and cast(regexp_replace(budat,"-","") as int) >= cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) period2 
on period1.bukrs = period2.bukrs and period1.lifnr = period2.lifnr  and period1.kunnr = period2.kunnr 
and period1.kostl = period2.kostl and period1.hkont = period2.hkont and period1.h_waers = period2.h_waers 
) periodall
on endall.bukrs = periodall.bukrs and endall.lifnr = periodall.lifnr  and endall.kunnr = periodall.kunnr 
and endall.kostl = periodall.kostl and endall.hkont = periodall.hkont and endall.h_waers = periodall.h_waers
) entire 
left join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers , trim(h_hwaer) as h_hwaer
from(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers , trim(h_hwaer) as h_hwaer
,ROW_NUMBER() OVER (PARTITION by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) rn
from sap.ods_sap_zffi_007) tmp where tmp.rn =1) orig
on entire.bukrs = orig.bukrs and entire.lifnr = orig.lifnr  and entire.kunnr = orig.kunnr 
and entire.kostl = orig.kostl and entire.hkont = orig.hkont and entire.h_waers = orig.h_waers
 )whole
where !((whole.begin_origin_jie_yue is null or whole.begin_origin_jie_yue = 0.00)
and (whole.begin_benwei_jie_yue is null or whole.begin_benwei_jie_yue = 0.00) 
and (whole.begin_origin_dai_yue is null or whole.begin_origin_dai_yue = 0.00) 
and (whole.begin_benwei_dai_yue is null or whole.begin_benwei_dai_yue = 0.00) 
and (whole.period_origin_jie_fasehng is null or whole.period_origin_jie_fasehng = 0.00) 
and (whole.period_benwei_jie_fasheng is null or whole.period_benwei_jie_fasheng = 0.00) 
and (whole.period_origin_dai_fasheng is null or whole.period_origin_dai_fasheng = 0.00) 
and (whole.period_benwei_dai_fasheng is null or whole.period_benwei_dai_fasheng = 0.00) 
and (whole.end_origin_jie_yue is null or whole.end_origin_jie_yue = 0.00) 
and (whole.end_benwei_jie_yue is null or whole.end_benwei_jie_yue = 0.00) 
and (whole.end_origin_dai_yue is null or whole.end_origin_dai_yue = 0.00) 
and (whole.end_benwei_dai_yue is null or whole.end_benwei_dai_yue = 0.00))



---------------------------------- 全部字段求sum值 ------------------------------------------------------------------------------------
select 
sum(f1.period_origin_jie_fasehng) as sum_period_origin_jie_fasehng,sum(f1.period_benwei_jie_fasheng) as sum_period_benwei_jie_fasheng,
sum(f1.period_origin_dai_fasheng) as sum_period_origin_dai_fasheng,sum(f1.period_benwei_dai_fasheng) as sum_period_benwei_dai_fasheng
from
(select whole.bukrs,whole.lifnr,whole.kunnr,whole.kostl,
whole.hkont,whole.h_waers,whole.h_hwaer,
whole.begin_origin_jie_yue,whole.begin_benwei_jie_yue,
whole.begin_origin_dai_yue,whole.begin_benwei_dai_yue,
whole.period_origin_jie_fasehng,whole.period_benwei_jie_fasheng,
whole.period_origin_dai_fasheng,whole.period_benwei_dai_fasheng,
whole.end_origin_jie_yue,whole.end_benwei_jie_yue,
whole.end_origin_dai_yue,whole.end_benwei_dai_yue
from
(select entire.bukrs,entire.lifnr,entire.kunnr,entire.kostl,
entire.hkont,entire.h_waers,orig.h_hwaer,
round(entire.begin_origin_jie_yue,2) as begin_origin_jie_yue ,round(entire.begin_benwei_jie_yue,2) as begin_benwei_jie_yue,
round(entire.begin_origin_dai_yue,2) as begin_origin_dai_yue ,round(entire.begin_benwei_dai_yue,2) as begin_benwei_dai_yue,
round(entire.period_origin_jie_fasehng,2) as period_origin_jie_fasehng,
round(entire.period_benwei_jie_fasheng,2) as period_benwei_jie_fasheng,
round(entire.period_origin_dai_fasheng,2) as period_origin_dai_fasheng,
round(entire.period_benwei_dai_fasheng,2) as period_benwei_dai_fasheng,
round(entire.end_origin_jie_yue,2) as end_origin_jie_yue,round(entire.end_benwei_jie_yue,2) as end_benwei_jie_yue,
round(entire.end_origin_dai_yue,2) as end_origin_dai_yue,round(entire.end_benwei_dai_yue,2) as end_benwei_dai_yue
from(
select if(endall.bukrs is not null,endall.bukrs,periodall.bukrs) as bukrs,
if(endall.lifnr is not null,endall.lifnr,periodall.lifnr) as lifnr,
if(endall.kunnr is not null,endall.kunnr,periodall.kunnr) as kunnr,
if(endall.kostl is not null,endall.kostl,periodall.kostl) as kostl,
if(endall.hkont is not null,endall.hkont,periodall.hkont) as hkont,
if(endall.h_waers is not null,endall.h_waers,periodall.h_waers) as h_waers,
beginall.begin_origin_jie_yue,beginall.begin_benwei_jie_yue,beginall.begin_origin_dai_yue,beginall.begin_benwei_dai_yue,
periodall.period_origin_jie_fasehng,periodall.period_benwei_jie_fasheng,periodall.period_origin_dai_fasheng,periodall.period_benwei_dai_fasheng,
endall.end_origin_jie_yue,endall.end_benwei_jie_yue,endall.end_origin_dai_yue,endall.end_benwei_dai_yue
from
(select if(end1.bukrs is not null,end1.bukrs,end2.bukrs) as bukrs,
if(end1.lifnr is not null,end1.lifnr,end2.lifnr) as lifnr,
if(end1.kunnr is not null,end1.kunnr,end2.kunnr) as kunnr,
if(end1.kostl is not null,end1.kostl,end2.kostl) as kostl,
if(end1.hkont is not null,end1.hkont,end2.hkont) as hkont,
if(end1.h_waers is not null,end1.h_waers,end2.h_waers) as h_waers,
end1.end_origin_jie_yue,end1.end_benwei_jie_yue,end2.end_origin_dai_yue,end2.end_benwei_dai_yue from
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_jie_yue ,sum(dmbtr) as end_benwei_jie_yue from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) end1
full join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_dai_yue ,sum(dmbtr) as end_benwei_dai_yue from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) end2 
on end1.bukrs = end2.bukrs and end1.lifnr = end2.lifnr  and end1.kunnr = end2.kunnr 
and end1.kostl = end2.kostl and end1.hkont = end2.hkont and end1.h_waers = end2.h_waers 
) endall
full join 
(select if(begin1.bukrs is not null,begin1.bukrs,begin2.bukrs) as bukrs,
if(begin1.lifnr is not null,begin1.lifnr,begin2.lifnr) as lifnr,
if(begin1.kunnr is not null,begin1.kunnr,begin2.kunnr) as kunnr,
if(begin1.kostl is not null,begin1.kostl,begin2.kostl) as kostl,
if(begin1.hkont is not null,begin1.hkont,begin2.hkont) as hkont,
if(begin1.h_waers is not null,begin1.h_waers,begin2.h_waers) as h_waers,
begin1.begin_origin_jie_yue,begin1.begin_benwei_jie_yue,begin2.begin_origin_dai_yue,begin2.begin_benwei_dai_yue from
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as begin_origin_jie_yue ,sum(dmbtr) as begin_benwei_jie_yue from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) < cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) begin1
full join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as begin_origin_dai_yue ,sum(dmbtr) as begin_benwei_dai_yue from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) < cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) begin2 
on begin1.bukrs = begin2.bukrs and begin1.lifnr = begin2.lifnr  and begin1.kunnr = begin2.kunnr 
and begin1.kostl = begin2.kostl and begin1.hkont = begin2.hkont and begin1.h_waers = begin2.h_waers
) beginall 
on  endall.bukrs = beginall.bukrs and endall.lifnr = beginall.lifnr  and endall.kunnr = beginall.kunnr 
and endall.kostl = beginall.kostl and endall.hkont = beginall.hkont and endall.h_waers = beginall.h_waers
full join 
(select if(period1.bukrs is not null,period1.bukrs,period2.bukrs) as bukrs,
if(period1.lifnr is not null,period1.lifnr,period2.lifnr) as lifnr,
if(period1.kunnr is not null,period1.kunnr,period2.kunnr) as kunnr,
if(period1.kostl is not null,period1.kostl,period2.kostl) as kostl,
if(period1.hkont is not null,period1.hkont,period2.hkont) as hkont,
if(period1.h_waers is not null,period1.h_waers,period2.h_waers) as h_waers,
period1.period_origin_jie_fasehng,period1.period_benwei_jie_fasheng,period2.period_origin_dai_fasheng,period2.period_benwei_dai_fasheng from
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as period_origin_jie_fasehng ,sum(dmbtr) as period_benwei_jie_fasheng from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int) and cast(regexp_replace(budat,"-","") as int) >= cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) period1
full join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers
,sum(wrbtr) as period_origin_dai_fasheng ,sum(dmbtr) as period_benwei_dai_fasheng from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int) and cast(regexp_replace(budat,"-","") as int) >= cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) period2 
on period1.bukrs = period2.bukrs and period1.lifnr = period2.lifnr  and period1.kunnr = period2.kunnr 
and period1.kostl = period2.kostl and period1.hkont = period2.hkont and period1.h_waers = period2.h_waers 
) periodall
on endall.bukrs = periodall.bukrs and endall.lifnr = periodall.lifnr  and endall.kunnr = periodall.kunnr 
and endall.kostl = periodall.kostl and endall.hkont = periodall.hkont and endall.h_waers = periodall.h_waers
) entire 
left join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers , trim(h_hwaer) as h_hwaer
from(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(hkont) as hkont,trim(h_waers) as h_waers , trim(h_hwaer) as h_hwaer
,ROW_NUMBER() OVER (PARTITION by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(hkont),trim(h_waers) ) rn
from sap.ods_sap_zffi_007) tmp where tmp.rn =1) orig
on entire.bukrs = orig.bukrs and entire.lifnr = orig.lifnr  and entire.kunnr = orig.kunnr 
and entire.kostl = orig.kostl and entire.hkont = orig.hkont and entire.h_waers = orig.h_waers
 )whole
where !((whole.begin_origin_jie_yue is null or whole.begin_origin_jie_yue = 0.00) 
and (whole.begin_benwei_jie_yue is null or whole.begin_benwei_jie_yue = 0.00) 
and (whole.begin_origin_dai_yue is null or whole.begin_origin_dai_yue = 0.00) 
and (whole.begin_benwei_dai_yue is null or whole.begin_benwei_dai_yue = 0.00) 
and (whole.period_origin_jie_fasehng is null or whole.period_origin_jie_fasehng = 0.00) 
and (whole.period_benwei_jie_fasheng is null or whole.period_benwei_jie_fasheng = 0.00) 
and (whole.period_origin_dai_fasheng is null or whole.period_origin_dai_fasheng = 0.00) 
and (whole.period_benwei_dai_fasheng is null or whole.period_benwei_dai_fasheng = 0.00) 
and (whole.end_origin_jie_yue is null or whole.end_origin_jie_yue = 0.00) 
and (whole.end_benwei_jie_yue is null or whole.end_benwei_jie_yue = 0.00) 
and (whole.end_origin_dai_yue is null or whole.end_origin_dai_yue = 0.00) 
and (whole.end_benwei_dai_yue is null or whole.end_benwei_dai_yue = 0.00) )
) f1


-------- 去掉一个  过滤字段  求sum值 ，-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

select 
sum(f1.period_origin_jie_fasehng) as sum_period_origin_jie_fasehng,sum(f1.period_benwei_jie_fasheng) as sum_period_benwei_jie_fasheng,
sum(f1.period_origin_dai_fasheng) as sum_period_origin_dai_fasheng,sum(f1.period_benwei_dai_fasheng) as sum_period_benwei_dai_fasheng
from
(select whole.bukrs,whole.lifnr,whole.kunnr,whole.kostl,
whole.h_waers,whole.h_hwaer,
whole.begin_origin_jie_yue,whole.begin_benwei_jie_yue,
whole.begin_origin_dai_yue,whole.begin_benwei_dai_yue,
whole.period_origin_jie_fasehng,whole.period_benwei_jie_fasheng,
whole.period_origin_dai_fasheng,whole.period_benwei_dai_fasheng,
whole.end_origin_jie_yue,whole.end_benwei_jie_yue,
whole.end_origin_dai_yue,whole.end_benwei_dai_yue
from
(select entire.bukrs,entire.lifnr,entire.kunnr,entire.kostl,
entire.h_waers,orig.h_hwaer,
round(entire.begin_origin_jie_yue,2) as begin_origin_jie_yue ,round(entire.begin_benwei_jie_yue,2) as begin_benwei_jie_yue,
round(entire.begin_origin_dai_yue,2) as begin_origin_dai_yue ,round(entire.begin_benwei_dai_yue,2) as begin_benwei_dai_yue,
round(entire.period_origin_jie_fasehng,2) as period_origin_jie_fasehng,
round(entire.period_benwei_jie_fasheng,2) as period_benwei_jie_fasheng,
round(entire.period_origin_dai_fasheng,2) as period_origin_dai_fasheng,
round(entire.period_benwei_dai_fasheng,2) as period_benwei_dai_fasheng,
round(entire.end_origin_jie_yue,2) as end_origin_jie_yue,round(entire.end_benwei_jie_yue,2) as end_benwei_jie_yue,
round(entire.end_origin_dai_yue,2) as end_origin_dai_yue,round(entire.end_benwei_dai_yue,2) as end_benwei_dai_yue
from(
select if(endall.bukrs is not null,endall.bukrs,periodall.bukrs) as bukrs,
if(endall.lifnr is not null,endall.lifnr,periodall.lifnr) as lifnr,
if(endall.kunnr is not null,endall.kunnr,periodall.kunnr) as kunnr,
if(endall.kostl is not null,endall.kostl,periodall.kostl) as kostl,
if(endall.h_waers is not null,endall.h_waers,periodall.h_waers) as h_waers,
beginall.begin_origin_jie_yue,beginall.begin_benwei_jie_yue,beginall.begin_origin_dai_yue,beginall.begin_benwei_dai_yue,
periodall.period_origin_jie_fasehng,periodall.period_benwei_jie_fasheng,periodall.period_origin_dai_fasheng,periodall.period_benwei_dai_fasheng,
endall.end_origin_jie_yue,endall.end_benwei_jie_yue,endall.end_origin_dai_yue,endall.end_benwei_dai_yue
from
(select if(end1.bukrs is not null,end1.bukrs,end2.bukrs) as bukrs,
if(end1.lifnr is not null,end1.lifnr,end2.lifnr) as lifnr,
if(end1.kunnr is not null,end1.kunnr,end2.kunnr) as kunnr,
if(end1.kostl is not null,end1.kostl,end2.kostl) as kostl,
if(end1.h_waers is not null,end1.h_waers,end2.h_waers) as h_waers,
end1.end_origin_jie_yue,end1.end_benwei_jie_yue,end2.end_origin_dai_yue,end2.end_benwei_dai_yue from
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_jie_yue ,sum(dmbtr) as end_benwei_jie_yue from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(h_waers) ) end1
full join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(h_waers) as h_waers
,sum(wrbtr) as end_origin_dai_yue ,sum(dmbtr) as end_benwei_dai_yue from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(h_waers) ) end2 
on end1.bukrs = end2.bukrs and end1.lifnr = end2.lifnr  and end1.kunnr = end2.kunnr 
and end1.kostl = end2.kostl and end1.h_waers = end2.h_waers 
) endall
full join 
(select if(begin1.bukrs is not null,begin1.bukrs,begin2.bukrs) as bukrs,
if(begin1.lifnr is not null,begin1.lifnr,begin2.lifnr) as lifnr,
if(begin1.kunnr is not null,begin1.kunnr,begin2.kunnr) as kunnr,
if(begin1.kostl is not null,begin1.kostl,begin2.kostl) as kostl,
if(begin1.h_waers is not null,begin1.h_waers,begin2.h_waers) as h_waers,
begin1.begin_origin_jie_yue,begin1.begin_benwei_jie_yue,begin2.begin_origin_dai_yue,begin2.begin_benwei_dai_yue from
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(h_waers) as h_waers
,sum(wrbtr) as begin_origin_jie_yue ,sum(dmbtr) as begin_benwei_jie_yue from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) < cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(h_waers) ) begin1
full join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(h_waers) as h_waers
,sum(wrbtr) as begin_origin_dai_yue ,sum(dmbtr) as begin_benwei_dai_yue from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) < cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(h_waers) ) begin2 
on begin1.bukrs = begin2.bukrs and begin1.lifnr = begin2.lifnr  and begin1.kunnr = begin2.kunnr 
and begin1.kostl = begin2.kostl  and begin1.h_waers = begin2.h_waers
) beginall 
on  endall.bukrs = beginall.bukrs and endall.lifnr = beginall.lifnr  and endall.kunnr = beginall.kunnr 
and endall.kostl = beginall.kostl  and endall.h_waers = beginall.h_waers
full join 
(select if(period1.bukrs is not null,period1.bukrs,period2.bukrs) as bukrs,
if(period1.lifnr is not null,period1.lifnr,period2.lifnr) as lifnr,
if(period1.kunnr is not null,period1.kunnr,period2.kunnr) as kunnr,
if(period1.kostl is not null,period1.kostl,period2.kostl) as kostl,
if(period1.h_waers is not null,period1.h_waers,period2.h_waers) as h_waers,
period1.period_origin_jie_fasehng,period1.period_benwei_jie_fasheng,period2.period_origin_dai_fasheng,period2.period_benwei_dai_fasheng from
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(h_waers) as h_waers
,sum(wrbtr) as period_origin_jie_fasehng ,sum(dmbtr) as period_benwei_jie_fasheng from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int) and cast(regexp_replace(budat,"-","") as int) >= cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(h_waers) ) period1
full join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(h_waers) as h_waers
,sum(wrbtr) as period_origin_dai_fasheng ,sum(dmbtr) as period_benwei_dai_fasheng from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int) and cast(regexp_replace(budat,"-","") as int) >= cast(concat(gjahr,monat,"01") as int) 
group by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(h_waers) ) period2 
on period1.bukrs = period2.bukrs and period1.lifnr = period2.lifnr  and period1.kunnr = period2.kunnr 
and period1.kostl = period2.kostl and period1.h_waers = period2.h_waers 
) periodall
on endall.bukrs = periodall.bukrs and endall.lifnr = periodall.lifnr  and endall.kunnr = periodall.kunnr 
and endall.kostl = periodall.kostl  and endall.h_waers = periodall.h_waers
) entire 
left join 
(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(h_waers) as h_waers , trim(h_hwaer) as h_hwaer
from(select trim(bukrs) as bukrs ,trim(lifnr) as lifnr,trim(kunnr) as kunnr,trim(kostl) as kostl,trim(h_waers) as h_waers , trim(h_hwaer) as h_hwaer
,ROW_NUMBER() OVER (PARTITION by trim(bukrs),trim(lifnr),trim(kunnr),trim(kostl),trim(h_waers) ) rn
from sap.ods_sap_zffi_007) tmp where tmp.rn =1) orig
on entire.bukrs = orig.bukrs and entire.lifnr = orig.lifnr  and entire.kunnr = orig.kunnr 
and entire.kostl = orig.kostl and entire.h_waers = orig.h_waers
 )whole
where !((whole.begin_origin_jie_yue is null or whole.begin_origin_jie_yue = 0.00) 
and (whole.begin_benwei_jie_yue is null or whole.begin_benwei_jie_yue = 0.00) 
and (whole.begin_origin_dai_yue is null or whole.begin_origin_dai_yue = 0.00) 
and (whole.begin_benwei_dai_yue is null or whole.begin_benwei_dai_yue = 0.00) 
and (whole.period_origin_jie_fasehng is null or whole.period_origin_jie_fasehng = 0.00) 
and (whole.period_benwei_jie_fasheng is null or whole.period_benwei_jie_fasheng = 0.00) 
and (whole.period_origin_dai_fasheng is null or whole.period_origin_dai_fasheng = 0.00) 
and (whole.period_benwei_dai_fasheng is null or whole.period_benwei_dai_fasheng = 0.00) 
and (whole.end_origin_jie_yue is null or whole.end_origin_jie_yue = 0.00) 
and (whole.end_benwei_jie_yue is null or whole.end_benwei_jie_yue = 0.00) 
and (whole.end_origin_dai_yue is null or whole.end_origin_dai_yue = 0.00) 
and (whole.end_benwei_dai_yue is null or whole.end_benwei_dai_yue = 0.00) )
) f1





/****  按月，按年 ，期初，期末，本期 所有的数据 **/



select 
if(b_e_entire.GJAHR is not null,b_e_entire.GJAHR,periodall.GJAHR) as GJAHR,
if(b_e_entire.MONAT is not null,b_e_entire.MONAT,periodall.MONAT) as MONAT,
b_e_entire.end_origin_jie_yue,b_e_entire.end_benwei_jie_yue,
b_e_entire.end_origin_dai_yue,b_e_entire.end_benwei_dai_yue,
b_e_entire.begin_origin_jie_yue,b_e_entire.begin_benwei_jie_yue,
b_e_entire.begin_origin_dai_yue,b_e_entire.begin_benwei_dai_yue,
periodall.period_origin_jie_fasehng,periodall.period_benwei_jie_fasheng,
periodall.period_origin_dai_fasheng,periodall.period_benwei_dai_fasheng
from 
(select 
if(endall.GJAHR is not null,endall.GJAHR,beginall.GJAHR) as GJAHR,
if(endall.MONAT is not null,endall.MONAT,beginall.MONAT) as MONAT,
endall.end_origin_jie_yue,endall.end_benwei_jie_yue,
endall.end_origin_dai_yue,endall.end_benwei_dai_yue,
beginall.begin_origin_jie_yue,beginall.begin_benwei_jie_yue,
beginall.begin_origin_dai_yue,beginall.begin_benwei_dai_yue
from 
(select if(end1.GJAHR is not null,end1.GJAHR,end2.GJAHR) as GJAHR,
if(end1.MONAT is not null,end1.MONAT,end2.MONAT) as MONAT,
end1.end_origin_jie_yue,end1.end_benwei_jie_yue,
end2.end_origin_dai_yue,end2.end_benwei_dai_yue 
from 
(select GJAHR,MONAT,round(sum(wrbtr),2) as end_origin_jie_yue ,round(sum(dmbtr),2) as end_benwei_jie_yue from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by GJAHR,MONAT) end1
full  join
(select GJAHR,MONAT,round(sum(wrbtr),2) as end_origin_dai_yue ,round(sum(dmbtr),2) as end_benwei_dai_yue from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int)
group by GJAHR,MONAT) end2 
on end1.GJAHR = end2.GJAHR and end1.MONAT = end2.MONAT) endall
full  join
(select if(begin1.GJAHR is not null,begin1.GJAHR,begin2.GJAHR) as GJAHR,
if(begin1.MONAT is not null,begin1.MONAT,begin2.MONAT) as MONAT,
begin1.begin_origin_jie_yue,begin1.begin_benwei_jie_yue,
begin2.begin_origin_dai_yue,begin2.begin_benwei_dai_yue
from 
(select GJAHR,MONAT,round(sum(wrbtr),2) as begin_origin_jie_yue ,round(sum(dmbtr),2) as begin_benwei_jie_yue from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) < cast(concat(gjahr,monat,"01") as int) 
group by GJAHR,MONAT) begin1 
full  join
(select GJAHR,MONAT,round(sum(wrbtr),2) as begin_origin_dai_yue ,round(sum(dmbtr),2) as begin_benwei_dai_yue from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) < cast(concat(gjahr,monat,"01") as int) 
group by GJAHR,MONAT) begin2
on begin1.GJAHR = begin2.GJAHR and begin1.MONAT = begin2.MONAT) beginall
on  endall.GJAHR = beginall.GJAHR and endall.MONAT = beginall.MONAT) b_e_entire 
full join
(select if(period1.GJAHR is not null,period1.GJAHR,period2.GJAHR) as GJAHR,
if(period1.MONAT is not null,period1.MONAT,period2.MONAT) as MONAT,
period1.period_origin_jie_fasehng,period1.period_benwei_jie_fasheng,
period2.period_origin_dai_fasheng,period2.period_benwei_dai_fasheng
from 
(select GJAHR,MONAT,round(sum(wrbtr),2) as period_origin_jie_fasehng , round(sum(dmbtr),2) as period_benwei_jie_fasheng from  sap.ods_sap_zffi_007  
where shkzg = 'S' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int) and cast(regexp_replace(budat,"-","") as int) >= cast(concat(gjahr,monat,"01") as int) 
group by GJAHR,MONAT) period1
full join 
(select GJAHR,MONAT,round(sum(wrbtr),2) as period_origin_dai_fasheng ,round(sum(dmbtr),2) as period_benwei_dai_fasheng from sap.ods_sap_zffi_007  
where shkzg = 'H' and cast(regexp_replace(budat,"-","") as int) <= cast(regexp_replace(last_day(concat(gjahr,"-",monat,"-","01")) ,"-","") as int) and cast(regexp_replace(budat,"-","") as int) >= cast(concat(gjahr,monat,"01") as int) 
group by GJAHR,MONAT) period2
on period1.GJAHR = period2.GJAHR and period1.MONAT = period2.MONAT)  periodall
on b_e_entire.GJAHR = periodall.GJAHR and b_e_entire.MONAT = periodall.MONAT


select * from sap.ods_sap_zffi_007 where day='2019-10-29';
