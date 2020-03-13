SELECT * FROM yongyou.ods_yongyou_ufdata_072_2019_code limit 10;
-- add jar hdfs://mycluster:8020/user/root/hive-contrib-1.2.1000.2.5.3.0-37.jar;
SELECT count(1) FROM yongyou.ods_yongyou_ufdata_072_2019_code ;
SELECT count(1) FROM yongyou.ods_yongyou_ufdata_072_2019_customer ;
SELECT count(1) FROM yongyou.ods_yongyou_ufdata_072_2019_department ;
select count(1) from test.business;
select count(1) from test.test_1;

-- (ods_eas_new_eas75_t_bd_accountview)fnumber = 1002.10   ==> yifei le001
select fnumber from eas.ods_eas_new_eas75_t_bd_accountview ;
-- (ods_eas_new_eas75_t_bd_currency) fnumber = BB01 , fname_l2 = 人民币
select  * from   eas.ods_eas_new_eas75_t_bd_currency ;
-- faccountid = 1D6jbpbXQ5iqntNR56RBSJ2pmCY=     ==> fnumber
-- fperiodid = /OQAAAAzppOCOIxM          
-- fcurrencyid = 11111111-1111-1111-1111-111111111111DEB58FDC   ==> 
select faccountid,fperiodid,fcurrencyid,forgunitid,day from eas.ods_eas_new_eas75_t_gl_accountbalance;
-- eas 缺失表 t_bd_period

-- 易飞  科目= le001 =  1002.09      ==> eas fnumber
-- le003 = 06  
select le001,le003 from yifei.ods_yifei80_djndyt3_actle;

-- 易飞和eas关联
-- eas count(fnumber)= 1305
select count(distinct(fnumber)) from eas.ods_eas_new_eas75_t_bd_accountview ;
-- yifei count(le001)= 523
select count(distinct(le001)) from yifei.ods_yifei80_djndyt3_actle yifei ;
-- common = 303
select count(distinct(fnumber)) from eas.ods_eas_new_eas75_t_bd_accountview eas join yifei.ods_yifei80_djndyt3_actle yifei

-- 易飞  客户= le006=D00105
select distinct(le006) from yifei.ods_yifei80_djndyt3_actle yifei ;
-- 易飞  供应商= le007=D0091
select distinct(le007) from yifei.ods_yifei80_djndyt3_actle yifei ;
-- 易飞  部门 = le008=1803
select distinct(le008) from yifei.ods_yifei80_djndyt3_actle yifei ;
-- 易飞  币别 = le004=RMB / USD
select distinct(le004) from yifei.ods_yifei80_djndyt3_actle yifei ;
-- 易飞  币别 = le004=RMB / USD
select distinct(le005) from yifei.ods_yifei80_djndyt3_actle yifei ;
-- 易飞  本期借方发生额 = le014 = -6836.03
select distinct(le014) from yifei.ods_yifei80_djndyt3_actle yifei ;
-- 易飞  本期贷方发生额 = le017 = -201206.89
select distinct(le017) from yifei.ods_yifei80_djndyt3_actle yifei ;

--  eas 和yifei  关联 的客户 le006 =  C00009， C00016 ，C00033
select distinct(le006) from eas.ods_eas_new_eas75_t_bd_accountview eas join yifei.ods_yifei80_djndyt3_actle yifei
 on eas.fnumber = yifei.le001; 

select distinct(le006) from yifei.ods_yifei80_djndyt3_actle;
 
-- iperiod = 6
-- 		2	1122001	0212	""	21.5	借	0	0	21.5	借
select iperiod ,ccode ,ccus_id ,csup_id ,mb ,cbegind_c, mc ,md ,me,cendd_c  from  yongyou.ods_yongyou_ufdata_072_2019_gl_accass ;
-- 用友 本期借方发生额= mc = 0.0000    本期贷方发生额   = md = 0.0000
select distinct(md)   from  yongyou.ods_yongyou_ufdata_072_2019_gl_accass ;




select * from   eas.ods_eas_new_eas75_t_org_company where fnumber = '01.05.05';

select int(float(p.fperiodnumber)),int(float(p.fperiodquarter)),int(float(fperiodyear)) from eas.ods_eas_new_eas75_t_bd_period p join  eas.ods_eas_new_eas75_t_gl_accountbalance a on  p.fid = a.fperiodid;

-- ******************   科目余额表  数据来源/建表语句  ******************************
select '',fperiodid , faccountid,'','','',fcurrencyid,cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),'',forgunitid,'eas.ods_eas_new_eas75_t_gl_accountbalance','','' from  eas.ods_eas_new_eas75_t_gl_accountbalance
union all 
select LE002,LE003,LE001,LE006,LE007,LE008,LE004,cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),LE014,LE017,cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),'','','yifei.ods_yifei80_djndyt3_actle','','' from yifei.ods_yifei80_djndyt3_actle
union ALL
select '',cast(iperiod as string),ccode,ccus_id,csup_id,cdept_id,'',mb,mc,md,mc,cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),me,me,'','','yongyou.ods_yongyou_ufdata_072_2019_gl_accass','','' from yongyou.ods_yongyou_ufdata_072_2019_gl_accass;

insert overwrite tablename (day='2017') base.dwb_base_t_balance
select '',string(ej.num) , ej.faccountid,'','','',ej.fcurrencyid,cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),'',ej.forgunitid,'eas.ods_eas_new_eas75_t_gl_accountbalance','','' from 
(select '',int(float(p.fperiodnumber)) as num , faccountid,'','','',fcurrencyid,cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),'',forgunitid,'eas.ods_eas_new_eas75_t_gl_accountbalance','','' from  eas.ods_eas_new_eas75_t_gl_accountbalance a
LEFT join eas.ods_eas_new_eas75_t_bd_period  p on  a.fperiodid = p.fid) ej
union all 
select LE002,LE003,LE001,LE006,LE007,LE008,LE004,cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),LE014,LE017,cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),'','','yifei.ods_yifei80_djndyt3_actle','','' from yifei.ods_yifei80_djndyt3_actle
union ALL
select '',cast(iperiod as string),ccode,ccus_id,csup_id,cdept_id,'',mb ,mc as mc1,md,mc as mc2,cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),me as me1,me as me2,'','','yongyou.ods_yongyou_ufdata_072_2019_gl_accass','','' from yongyou.ods_yongyou_ufdata_072_2019_gl_accass;



-- 9448103 9421678
select count(1) from base.dwb_base_t_balance where day='2019-09-19';  -- 4766849
select count(1) from eas.ods_eas_new_eas75_t_bd_period; -- 299 
select count(1) from eas.ods_eas_new_eas75_t_gl_accountbalance where day='2019-09-12'; -- 941 5654

select count(1) from 
(select '',int(float(p.fperiodnumber)) as num , faccountid,'','','',fcurrencyid,cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),cast (null  as decimal(19,4)),'',forgunitid,'eas.ods_eas_new_eas75_t_gl_accountbalance','','' from ( select fperiodid,faccountid,fcurrencyid,forgunitid from  eas.ods_eas_new_eas75_t_gl_accountbalance where   day = '2019-09-12') a
	LEFT join   eas.ods_eas_new_eas75_t_bd_period  as   p on  a.fperiodid = p.fid ) ej ;

select count(1) from  yifei.ods_yifei80_djndyt3_actle; -- 3 2449
select count(1) from  yongyou.ods_yongyou_ufdata_072_2019_gl_accass; --

CREATE EXTERNAL TABLE IF NOT EXISTS `base.dwb_base_t_balance`(
  `year` string COMMENT '会计年度',
  `period` string COMMENT '会计期间',
  `account` string COMMENT '科目',
  `customer` string COMMENT '客户',
  `supplier` string COMMENT '供应商 ',
  `department` string COMMENT '部门',
  `currency` string COMMENT '币别',
  `BegDebit` decimal(19,4) COMMENT '期初借方余额',
  `BegCredit` decimal(19,4) COMMENT '期初贷方余额',
  `debit` decimal(19,4) COMMENT '本期借方发生额',
  `credit` decimal(19,4) COMMENT '本期贷方发生额',
  `accumdebit` decimal(19,4) COMMENT '本年借方累计发生额',
  `accumcredit` decimal(19,4) COMMENT '本年贷方累计发生额',
  `enddebit` decimal(19,4) COMMENT '期末借方余额',
  `endcredit` decimal(19,4) COMMENT '期末贷方余额',
  `fundsprop` string COMMENT '款项性质',
  `finaorg` string COMMENT '财务组织',
  `origin` string COMMENT '数据来源',
  `reserved1` string COMMENT '预留字段1',
  `reserved2` string COMMENT '预留字段2')
PARTITIONED BY (
  `day` string)
ROW FORMAT DELIMITED  FIELDS TERMINATED BY '^#'
 STORED AS orc
 LOCATION 'hdfs://mycluster/warehouse/base/dwb/DWB_base_t_balance'
 tblproperties('orc.compression' = 'snappy');


select distinct(day) from eas.ods_eas_new_eas75_t_bd_accountview;
select distinct(day) from eas.ods_eas_new_eas75_t_bd_cashflowitem;
-- ******************   凭证     数据来源/建表语句  ******************************
insert overwrite tablename (day='') base.dwb_base_t_voucher
select '','',fperiodid,fbookeddate,fbizdate,fvouchertypeid,fnumber,'','','','','','','','',cast (null  as decimal(19,4)),float(null),cast (null  as decimal(19,4)),'','','','','','','','','eas.ods_eas_new_eas75_t_gl_voucher','','' from eas.ods_eas_new_eas75_t_gl_voucher where day = '@'
union ALL
select '','','','','','','','','','','','','',faccountid,fcurrencyid,cast(float(foriginalamount) as decimal(19,4)),float(null),cast (null  as decimal(19,4)),'','','','','','','','','eas.ods_eas_new_eas75_t_gl_voucherentry','','' from eas.ods_eas_new_eas75_t_gl_voucherentry where day = ''
union ALL
select '','','',ta003,'',ta001,ta002,'','',ta015,ta023,ta020,ta015,'','',cast (null  as decimal(19,4)),float(null),cast (null  as decimal(19,4)),'','','','','',ta032,'','','yifei.ods_yifei80_djndyt3_actta','','' from  yifei.ods_yifei80_djndyt3_actta  where day = ''
union ALL
select '','','','','','','','','','','','',''  ,tb005,tb013,cast(tb015 as decimal(19,4)), float(tb014),cast( tb007 as decimal(19,4)),cast(tb004 as string),tb032,'',tb031,'','','','','yifei.ods_yifei80_djndyt3_acttb','','' from   yifei.ods_yifei80_djndyt3_acttb where day = ''
union all
select '','',cast(iperiod as string),dbill_date,dbill_date,csign,cast(ino_id as string),'',cbill,ccheck,ccashier,cbook,cast(iflag as string),ccode,cexch_name, if(md=0.0000,mc,md) as m1,nfrat, if(md=0.0000,mc,md) as m2,'',csup_id,'',ccus_id,'','','','','yongyou.ods_yongyou_ufdata_072_2019_gl_accvouch','','' from  yongyou.ods_yongyou_ufdata_072_2019_gl_accvouch  where day = '';
-- UNION ALL
-- select  '','','','','','','',inid,'','','','', null,'','',0,null,null,'','','','','','','','','yongyou.ods_yongyou_ufdata_072_2019_gl_accattachs','','' from yongyou.ods_yongyou_ufdata_072_2019_gl_accattachs;


CREATE EXTERNAL TABLE IF NOT EXISTS `base.dwb_base_t_voucher`(
  `finaorg` string COMMENT '财务组织',
  `year` string COMMENT '会计年度',
  `period` string COMMENT '会计期间',
  `perioddate` string COMMENT '记账日期',
  `date` string COMMENT '业务日期',
  `vchtype` string COMMENT '凭证类型 ',
  `vchnumber` string COMMENT '凭证编号',
  `annex` string COMMENT '附件号',
  `maker` string COMMENT '制单',
  `approved` string COMMENT '审核 ',
  `casher` string COMMENT '出纳',
  `posted` string COMMENT '过账',
  `cancel` string COMMENT '作废',
  `account` string COMMENT '科目',
  `currency` string COMMENT '币别',
  `orgamount` decimal(19,4) COMMENT '原币金额',
  `currencyrate` float COMMENT '汇率',
  `amount` decimal(19,4) COMMENT '金额',
  `due` string COMMENT '借贷方向',
  `supplier` string COMMENT '供应商代码',
  `suppname` string COMMENT '供应商名称',
  `customer` string COMMENT '客户代码',
  `custname` string COMMENT '客户描述',
  `gainloss` string COMMENT '是否结转损益',
  `scope` string COMMENT '功能范围（SAP)',
  `cashflowprop` string COMMENT '现流性质',
  `origin` string COMMENT '数据来源',
  `reserved1` string COMMENT '预留字段1',
  `reserved2` string COMMENT '预留字段2')
PARTITIONED BY (
  `day` string)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '^#'
 STORED AS orc 
 LOCATION 'hdfs://mycluster/warehouse/base/dwb/DWB_base_t_voucher'
 tblproperties('orc.compression' = 'snappy');



-- String  000000000000613.2100 转换为 decimal之后，丢失数据
select cast(foriginalamount as decimal(16,2)) as a,foriginalamount  from eas.ods_eas_new_eas75_t_gl_voucherentry;
-- 1.string先转化为float，2再转化为decimal之后，精度保留，解决。
select cast(float(foriginalamount) as decimal(19,4)) as a,foriginalamount  from eas.ods_eas_new_eas75_t_gl_voucherentry;
-- decimal  默认也为null ，因为存在decimal的值为  负数的情况，
select cast (null  as decimal(19,4))  as a  from eas.ods_eas_new_eas75_t_gl_voucherentry;
-- decimal 转化为int
select cast(tb015 as decimal(19,4)) as a, tb015,int(FLOOR(tb014)) as b, tb014,int(FLOOR(tb007)) as c,tb007 from   yifei.ods_yifei80_djndyt3_acttb;
select distinct(float(tb014)), tb014 from yifei.ods_yifei80_djndyt3_acttb;
select md,mc from  yongyou.ods_yongyou_ufdata_072_2019_gl_accvouch limit 100;
select distinct(iflag) from  yongyou.ods_yongyou_ufdata_072_2019_gl_accvouch;
select distinct(nfrat) from  yongyou.ods_yongyou_ufdata_072_2019_gl_accvouch;
select null from  yongyou.ods_yongyou_ufdata_072_2019_gl_accvouch;
-- select ta020,int(ta015) from  yifei.ods_yifei80_djndyt3_actta
-- select if(md=0.0000,mc,md),md,mc from yongyou.ods_yongyou_ufdata_072_2019_gl_accvouch;

select distinct(day) from yifei.ods_yifei80_djndyt3_acttb;


--  eas.ods_eas_new_eas75_t_gl_accountbalance  与eas.ods_eas_new_eas75_t_gl_voucherentry  关联

select * from eas.ods_eas_new_eas75_t_gl_accountbalance b  join  eas.ods_eas_new_eas75_t_gl_voucherentry v 
on  b.faccountid = v.faccountid limit 10;