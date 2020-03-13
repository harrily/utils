select distinct(currency_name) from dwbase.dwb_price_policy_pu where day='2020-02-14';

select entries_effectivedate,effectivedate from dwbase.dwb_price_policy_pu where day='2020-02-14';

select distinct(saleorgunit_name) from dwbase.dwb_price_policy_pu where day='2020-02-14';

select distinct(customer_name) from dwbase.dwb_price_policy_pu where day='2020-02-14';

-- 15494
select count(1) from dwbase.dwb_price_policy_pu where day='2020-02-14';


select status,count(1) from dwbase.dwb_allbill where day='2020-02-14' group by status;
select distinct(tranName) from dwbase.dwb_allbill where day='2020-02-14';
select warename from dwbase.dwb_allbill where day='2020-02-14' and warename like '%���ϲ�%' ;
select distinct(warename) from dwbase.dwb_allbill where day='2020-02-14';


select distinct(status) from dwbase.dwb_production_close where day='2020-02-14';

select distinct(status) from dwbase.dwb_production_make where day='2020-02-14';


-- 	���ݳ�ѹ����

select
case substring(billfnumber,2,1) 
when 'G' then '�ƽ�һ��'
when 'A' then '�ƽ�����'
when 'L' then '�ƽ�����'
when 'C' then '��ƽ��'
when 'R' then '��ƽ��'
else 'unknown'
end as industry_factory ,
case substring(billfnumber,2,2) 
when 'GM' then 'ģ��'
when 'GC' then '��ѹ'
when 'GJ' then '��װ'
when 'AC' then '��ѹ'
when 'AJ' then '��װ'
when 'LC' then '��ѹ'
when 'LJ' then '��װ'
when 'CM' then 'ģ��'
when 'CC' then '��ѹ'
when 'CJ' then '��װ'
when 'RC' then '�ȹ�'
when '' then ''
else 'unknown'
end as craft_dimension ,
SUBSTRING(split(materialnumber,'-')[1],0,3) as inner_projiect
from dwbase.dwb_allbill where day='2020-02-14' 
and substring(materialnumber,0,3) in('880','883') or substring(materialnumber,0,2) = '68'
and (substring(billfnumber,0,1) not in('B','Z') and (warename not like '%���ϲ�%' or warename not like '%MRB%') )
and tranName != '����Ʒ���';

select A.material_number,collect_set(entries_price)[0] from (
select material_number, entries_price,entries_effectivedate from dwbase.dwb_price_policy_pu where day='2020-02-14'
and saleorgunit_name in ('LY INVESTMENT (HK) LIMITED','TLG INVESTMENT (HK) LIMITED','������ԣ���ӿƼ����޹�˾')
and customer_name not like ('%��%')
order by entries_effectivedate desc, entries_price asc)A
group by A.material_number




select entry1qty,entry1baseqty, tranName,warename  from dwbase.dwb_allbill where day='2020-02-14' and 
materialNumber='882-LBG894-A0-0'
 

select materialnumber, SUBSTRING(split(materialnumber,'-')[1],0,3),
billfnumber,coreTypeFid,coreNumber,srcnumber
from  dwbase.dwb_allbill where day='2020-02-14' ;


SELECT bill.*,'�����ֵ' as isoutputValue FROM dwbase.dwb_allbill bill 
WHERE bill.storageName='������ԣ���ӿƼ����޹�˾'
and bill.DEPNAME LIKE '%CNC%' 
AND bill.TRANNAME = '�깤�ϸ����'
AND bill.CORENUMBER  not like '%___R%'
AND bill.WARENAME IN ('SuZ_LYu_CNC��Ʒ��','SuZ_LYu_CNC�ͻ����ϲ�%')
and bill.AUDITTIME >'2020-01-01 00:00:00' AND bill.AUDITTIME <= '2020-01-07 23:59:59'


select AUDITTIME, substring(AUDITTIME,0,10) FROM dwbase.dwb_allbill where day='2020-02-14'
and  substring(AUDITTIME,0,10) between '2020/01/01' and '2020/01/07';

select AUDITTIME,substring(AUDITTIME,0,10) FROM dwbase.dwb_allbill where day='2020-02-14'
and  AUDITTIME between '2020/01/01 00:00:00' and '2020/01/07 00:00:00';

-- ʱ�亯��
select weekofyear(to_date(from_unixtime(unix_timestamp(substr('20200101',1,8),'yyyymmdd'),'yyyy-mm-dd')));
select to_date(from_unixtime(unix_timestamp(substr('20201201',1,8),'yyyymmdd'),'yyyy-mm-dd'));
select weekofyear('2018-12-31');


-- ��ȡ��ǰ����Ϊ�ܼ�, +4 ����Ϊ1920-01-01��������4������һ����������������4�졣��+4
select pmod(datediff('2020-01-01','1920-01-01')+4,7);  --2

-- ��ȡ��ǰ�µ����һ��
select last_day(DATE_SUB('2020-01-05', 2)) ;
select last_day('2020-02-01') ;


-- +1 ����Ϊ,datediff�����ʱ����1����ԭ����ǰʱ��-�³�ʱ�䣬�õ��ڼ��ܡ���

-- ���ȷ������Ϊ�Ǹ��ܱ��ܱ����Ե�ǰ��Ȼ��Ϊһ���������ڣ��̶���ʼ������Ϊ�ܱ����䣬���㵱ǰ����Ϊ����ȵڼ��ܣ���
-- ��ǰ��  ����ʼ���䣺���� -> �ܶ�Ϊ������Ҫ��Ҫȷ�ϵ�ǰ��Ȼ����ʼ������һ�졣

-- 2019���ܱ����
---������ ${week_begin}=2018-12-26 --��Ϊ2019-01-01����2����������2018-12-26��Ϊ${week_begin}��
select if(pmod(datediff(regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-'),'${week_begin}')+1,7) = 0 ,
int((datediff(regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-'),'${week_begin}')+1)/7), 
int(((datediff(regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-'),'${week_begin}')+1)/7)) + 1 )  as week_type
,regexp_replace(SUBSTRING(AUDITTIME,0,10),'/','-')
FROM dwbase.dwb_allbill where day='2020-02-14'
and AUDITTIME between '2019/01/01 00:00:00' and '2019/12/31 23:59:59';

-- 2020���ܱ����
--������ ${week_begin}=2020-01-01 --��Ϊ2020-01-01�պ�����3�����������ƣ�ֱ�Ӱ�2020-01-01��Ϊ${week_begin}
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