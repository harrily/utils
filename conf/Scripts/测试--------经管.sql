select distinct(currency_name) from dwbase.dwb_price_policy_pu where day='2020-02-14';

select entries_effectivedate,effectivedate from dwbase.dwb_price_policy_pu where day='2020-02-14';

select distinct(saleorgunit_name) from dwbase.dwb_price_policy_pu where day='2020-02-14';

select distinct(customer_name) from dwbase.dwb_price_policy_pu where day='2020-02-14';

-- 15494
select count(1) from dwbase.dwb_price_policy_pu where day='2020-02-14';


select status,count(1) from dwbase.dwb_allbill where day='2020-02-14' group by status;
select distinct(tranName) from dwbase.dwb_allbill where day='2020-02-14';
select warename from dwbase.dwb_allbill where day='2020-02-14' and warename like '%报废仓%' ;
select distinct(warename) from dwbase.dwb_allbill where day='2020-02-14';


select distinct(status) from dwbase.dwb_production_close where day='2020-02-14';

select distinct(status) from dwbase.dwb_production_make where day='2020-02-14';


-- 	苏州冲压数据

select
case substring(billfnumber,2,1) 
when 'G' then '黄江一厂'
when 'A' then '黄江二厂'
when 'L' then '黄江二厂'
when 'C' then '常平厂'
when 'R' then '常平厂'
else 'unknown'
end as industry_factory ,
case substring(billfnumber,2,2) 
when 'GM' then '模切'
when 'GC' then '冲压'
when 'GJ' then '组装'
when 'AC' then '冲压'
when 'AJ' then '组装'
when 'LC' then '冲压'
when 'LJ' then '组装'
when 'CM' then '模切'
when 'CC' then '冲压'
when 'CJ' then '组装'
when 'RC' then '热管'
when '' then ''
else 'unknown'
end as craft_dimension ,
SUBSTRING(split(materialnumber,'-')[1],0,3) as inner_projiect
from dwbase.dwb_allbill where day='2020-02-14' 
and substring(materialnumber,0,3) in('880','883') or substring(materialnumber,0,2) = '68'
and (substring(billfnumber,0,1) not in('B','Z') and (warename not like '%报废仓%' or warename not like '%MRB%') )
and tranName != '不良品入库';

select A.material_number,collect_set(entries_price)[0] from (
select material_number, entries_price,entries_effectivedate from dwbase.dwb_price_policy_pu where day='2020-02-14'
and saleorgunit_name in ('LY INVESTMENT (HK) LIMITED','TLG INVESTMENT (HK) LIMITED','苏州领裕电子科技有限公司')
and customer_name not like ('%领%')
order by entries_effectivedate desc, entries_price asc)A
group by A.material_number




select entry1qty,entry1baseqty, tranName,warename  from dwbase.dwb_allbill where day='2020-02-14' and 
materialNumber='882-LBG894-A0-0'
 

select materialnumber, SUBSTRING(split(materialnumber,'-')[1],0,3),
billfnumber,coreTypeFid,coreNumber,srcnumber
from  dwbase.dwb_allbill where day='2020-02-14' ;


SELECT bill.*,'计入产值' as isoutputValue FROM dwbase.dwb_allbill bill 
WHERE bill.storageName='苏州领裕电子科技有限公司'
and bill.DEPNAME LIKE '%CNC%' 
AND bill.TRANNAME = '完工合格入库'
AND bill.CORENUMBER  not like '%___R%'
AND bill.WARENAME IN ('SuZ_LYu_CNC成品仓','SuZ_LYu_CNC客户退料仓%')
and bill.AUDITTIME >'2020-01-01 00:00:00' AND bill.AUDITTIME <= '2020-01-07 23:59:59'


select AUDITTIME, substring(AUDITTIME,0,10) FROM dwbase.dwb_allbill where day='2020-02-14'
and  substring(AUDITTIME,0,10) between '2020/01/01' and '2020/01/07';

select AUDITTIME,substring(AUDITTIME,0,10) FROM dwbase.dwb_allbill where day='2020-02-14'
and  AUDITTIME between '2020/01/01 00:00:00' and '2020/01/07 00:00:00';

-- 时间函数
select weekofyear(to_date(from_unixtime(unix_timestamp(substr('20200101',1,8),'yyyymmdd'),'yyyy-mm-dd')));
select to_date(from_unixtime(unix_timestamp(substr('20201201',1,8),'yyyymmdd'),'yyyy-mm-dd'));
select weekofyear('2018-12-31');


-- 获取当前日期为周几, +4 是因为1920-01-01，是星期4，对于一个完整的周是少了4天。故+4
select pmod(datediff('2020-01-01','1920-01-01')+4,7);  --2

-- 获取当前月的最后一天
select last_day(DATE_SUB('2020-01-05', 2)) ;
select last_day('2020-02-01') ;


-- +1 是因为,datediff相减的时候少1。【原理，当前时间-月初时间，得到第几周。】

-- 如何确定日期为那个周别（周别是以当前自然年为一个完整周期，固定起始周周作为周别区间，计算当前日期为本年度第几周），
-- 当前以  周起始区间：周三 -> 周二为例：主要是要确认当前自然年起始周是那一天。

-- 2019年周别计算
---参数： ${week_begin}=2018-12-26 --因为2019-01-01是周2，故上推至2018-12-26作为${week_begin}。
select if(pmod(datediff(regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-'),'${week_begin}')+1,7) = 0 ,
int((datediff(regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-'),'${week_begin}')+1)/7), 
int(((datediff(regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-'),'${week_begin}')+1)/7)) + 1 )  as week_type
,regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-')
FROM dwbase.dwb_allbill where day='2020-02-14'
and AUDITTIME between '2019/01/01 00:00:00' and '2019/12/31 23:59:59';

-- 2020年周别计算
--参数： ${week_begin}=2020-01-01 --因为2020-01-01刚好是周3，故无须上推，直接吧2020-01-01作为${week_begin}
select if(pmod(datediff(regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-'),'${week_begin}')+1,7) = 0 ,
int((datediff(regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-'),'${week_begin}')+1)/7), 
int(((datediff(regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-'),'${week_begin}')+1)/7)) + 1 )  as week_type
,regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-')
FROM dwbase.dwb_allbill where day='2020-02-14'
and AUDITTIME between '2020/01/01 00:00:00' and '2020/12/31 00:00:00';


select distinct(day) from eas.ods_eas_new_eas75_t_im_purinwarehsbill;
select distinct(day) from eas.ods_eas_new_eas75_t_bd_material;
select distinct(DEPNAME)  FROM dwbase.dwb_allbill where day='2020-02-14';
select distinct(costcenterName)  FROM dwbase.dwb_allbill where day='2020-02-14';

select pmod(datediff('2020-02-17','2020-01-01'),7)

select datediff(regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-'),'2020-01-01')+1,
regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-')
from  dwbase.dwb_allbill where day='2020-02-14'

select max(AUDITTIME) from  dwbase.dwb_allbill where day='2020-02-14';
select min(AUDITTIME) from  dwbase.dwb_allbill where day='2020-02-14';