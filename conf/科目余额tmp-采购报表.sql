insert overwrite table dwservice.dws_balance_by_year partition(day='2019-11-01',dim='com_sup_cus_cos_gla')

select * from dwservice.dws_balance_by_year_month ye_mo inner join dwservice.dws_balance_by_year ye on ye_mo.company_code = ye.company_code limit 10 ;

SELECT deptno, dname, location FROM test.dept;

show create table  dwservice.dws_balance_by_year;

alter table  dwservice.dws_balance_by_year drop partition(day='2019-11-01');
alter table  dwservice.dws_balance_by_year_month drop partition(day='2019-11-01');

drop table dwservice.dws_balance_by_year;
alter table  dwservice.dws_balance_by_year drop partition(day='2019-10-31');
alter table  dwservice.dws_balance_by_year_month drop partition(day='2019-10-31');

ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_sup_cus_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cos_cus_gla_sup');
ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='sup_cus_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='cos_cus_gla_sup');

ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_cus_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cus_gla_sup');

ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_sup_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cos_gla_sup');

ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_sup_cus_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cos_cus_sup');

ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_sup_cus_cos')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cos_cus_gla');

ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_sup_cus')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cos_cus');

ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_sup_cos')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cos_gla');



ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_sup_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cos_sup');


ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_cus_cos')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cus_gla');


ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_cus_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cus_sup');


ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='com_gla_sup');


ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='sup_cus_cos')
RENAME TO PARTITION  (day='2019-10-31',dim='cos_cus_gla');



ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='sup_cus_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='cos_cus_sup');


ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='sup_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='cos_gla_sup');


ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='cus_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='cus_gla_sup');


select distinct(cost_center) from dwservice.dws_balance_by_year;
select distinct(customer_code) from dwservice.dws_balance_by_year;
select distinct(suppler_code) from dwservice.dws_balance_by_year;


ALTER TABLE  eas.ods_eas_new_eas75_t_im_purinwarehsentry drop PARTITION (day='2019-11-14')
ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_sup')
RENAME TO PARTITION  (day='2019-10-31',dim='com_cos');
ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_cos')
RENAME TO PARTITION  (day='2019-10-31',dim='com_gla');
ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='com_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='com_sup_1');

ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='cus_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='cus_gla_sup');
ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='cus_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='cus_gla_sup');
ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='cus_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='cus_gla_sup');
ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='cus_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='cus_gla_sup');
ALTER TABLE dwservice.dws_balance_by_year PARTITION (day='2019-10-31',dim='cus_cos_gla')
RENAME TO PARTITION  (day='2019-10-31',dim='cus_gla_sup');





select count(1) from  dwservice.dws_balance_by_year where day='2019-10-31' and dim='com_cos_cus_gla_sup';

drop table dwservice.dws_balance_by_year_cccg;
drop table dwservice.dws_balance_by_year_cscc

drop table dwservice.dws_balance_by_year_csccg;
drop table dwservice.dws_balance_by_year_cscg;
drop table dwservice.dws_balance_by_year_cscg1
drop table dwservice.dws_balance_by_year_sccg
drop table dwservice.dws_balance_by_year_month_cccg
drop table dwservice.dws_balance_by_year_month_cscc
drop table dwservice.dws_balance_by_year_month_csccg
drop table dwservice.dws_balance_by_year_month_cscg
drop table dwservice.dws_balance_by_year_month_cscg1
drop table dwservice.dws_balance_by_year_month_sccg


select distinct(dim) From dwservice.dws_balance_by_year order by dim;

select count(1) from  dwservice.dws_balance_by_year where day='2019-10-31' and dim='com_sup_cus_cos_gla';
select count(1) from  dwservice.dws_balance_by_year where day='2019-10-31';

select count(dim) from  dwservice.dws_balance_by_year_month where day='2019-10-31'  and dim='com_sup_cus_cos_gla';


select * from  dwservice.dws_balance_by_year where  day='2019-11-01' and dim='sup_cus_cos_gla'  limit 10 ;

select count(1) from  dwservice.dws_balance_by_year_sccg where day='2019-10-31';
select count(1) from  dwservice.dws_balance_by_year_sccg where day='2019-11-01';

 -- select count(1) from dwservice.dws_balance_by_year_cscg  where day='2019-10-31';

select count(1) from dwservice.dws_balance_by_year_csccg;


drop table dwmiddle.t_balance_sum_month_tmp;
drop  table dwmiddle.t_balance_sum_year_tmp

insert overwrite table dwservice.dws_balance_sum_by_year partition(day='2019-10-31')
SELECT begin_origin_jie_yue, begin_benwei_jie_yue, begin_origin_dai_yue, begin_benwei_dai_yue, period_origin_jie_fasehng, period_benwei_jie_fasheng, period_origin_dai_fasheng, period_benwei_dai_fasheng, end_origin_jie_yue, end_benwei_jie_yue, end_origin_dai_yue, end_benwei_dai_yue, `year`
FROM dwmiddle.t_balance_sum_year_tmp
 where day='2019-10-29';

CREATE EXTERNAL TABLE `dwservice.dws_balance_sum_by_year`(
  `begin_origin_jie_yue` decimal(19,2) COMMENT '期初原币借方余额',
  `begin_benwei_jie_yue` decimal(19,2) COMMENT '期初本位币借方余额',
  `begin_origin_dai_yue` decimal(19,2) COMMENT '期初原币贷方余额',
  `begin_benwei_dai_yue` decimal(19,2) COMMENT '期初本位币贷方余额',
  `period_origin_jie_fasheng` decimal(19,2) COMMENT '本期原币借方发生额 ',
  `period_benwei_jie_fasheng` decimal(19,2) COMMENT '本期本位币借方发生额',
  `period_origin_dai_fasheng` decimal(19,2) COMMENT '本期原币贷方发生额',
  `period_benwei_dai_fasheng` decimal(19,2) COMMENT '本期本位币贷方发生额',
  `end_origin_jie_yue` decimal(19,2) COMMENT '期末原币借方余额',
  `end_benwei_jie_yue` decimal(19,2) COMMENT '期末本位币借方余额',
  `end_origin_dai_yue` decimal(19,2) COMMENT '期末原币贷方余额',
  `end_benwei_dai_yue` decimal(19,2) COMMENT '期末本位币贷方余额',
  `year` string COMMENT '统计年份')
   COMMENT '科目余额以年为维度，计算sum数据'
PARTITIONED BY (
  `day` string)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '^#'
  stored AS orc tblproperties('orc.compression' = 'snappy');


 insert overwrite table dwservice.dws_balance_sum_by_year_month partition(day='2019-10-31')
SELECT begin_origin_jie_yue, begin_benwei_jie_yue, begin_origin_dai_yue, begin_benwei_dai_yue, period_origin_jie_fasehng, period_benwei_jie_fasheng, period_origin_dai_fasheng, period_benwei_dai_fasheng, end_origin_jie_yue, end_benwei_jie_yue, end_origin_dai_yue, end_benwei_dai_yue, `year`, `month`
FROM dwmiddle.t_balance_sum_month_tmp
 where day='2019-10-29';

CREATE EXTERNAL TABLE `dwservice.dws_balance_sum_by_year_month`(
  `begin_origin_jie_yue` decimal(19,2) COMMENT '期初原币借方余额',
  `begin_benwei_jie_yue` decimal(19,2) COMMENT '期初本位币借方余额',
  `begin_origin_dai_yue` decimal(19,2) COMMENT '期初原币贷方余额',
  `begin_benwei_dai_yue` decimal(19,2) COMMENT '期初本位币贷方余额',
  `period_origin_jie_fasheng` decimal(19,2) COMMENT '本期原币借方发生额 ',
  `period_benwei_jie_fasheng` decimal(19,2) COMMENT '本期本位币借方发生额',
  `period_origin_dai_fasheng` decimal(19,2) COMMENT '本期原币贷方发生额',
  `period_benwei_dai_fasheng` decimal(19,2) COMMENT '本期本位币贷方发生额',
  `end_origin_jie_yue` decimal(19,2) COMMENT '期末原币借方余额',
  `end_benwei_jie_yue` decimal(19,2) COMMENT '期末本位币借方余额',
  `end_origin_dai_yue` decimal(19,2) COMMENT '期末原币贷方余额',
  `end_benwei_dai_yue` decimal(19,2) COMMENT '期末本位币贷方余额',
  `year` string COMMENT '统计年份',
  `month` string COMMENT '统计月份')
    COMMENT '科目余额以年+月为维度，计算sum数据'
PARTITIONED BY (
  `day` string)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '^#'
  stored AS orc tblproperties('orc.compression' = 'snappy');
 
 
 
select count(1) from eas.ods_eas_new_eas75_ct_ls_match where day = '2019-11-14';
	alter table  eas.ods_eas_new_eas75_ct_ls_match  drop partition(day='2019-11-14') ;

select count(1) from  eas.ods_eas_new_eas75_t_bd_Material  where day = '2019-11-14';
	select * from   eas.ods_eas_new_eas75_t_bd_Material where fid='/OQAAAABKMxECefw' and day = '2019-11-14';
	alter table  eas.ods_eas_new_eas75_t_bd_Material  drop partition(day='2019-11-14') ;

select count(1) from eas.ods_eas_new_eas75_t_bd_supplier where day = '2019-09-24';
	select * from eas.ods_eas_new_eas75_t_bd_supplier  where day = '2019-11-14' limit 100;
	alter table  eas.ods_eas_new_eas75_t_bd_supplier  drop partition(day='2019-09-24') ;

select count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsbill where day = '2019-11-14';
	select * from eas.ods_eas_new_eas75_t_im_purinwarehsbill where day = '2019-11-14' limit 100;
	alter table  eas.ods_eas_new_eas75_t_im_purinwarehsbill  drop partition(day='2019-11-14') ;

select count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day = '2019-11-14';
	select * from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day = '2019-11-14' limit 100;
	alter table  eas.ods_eas_new_eas75_t_im_purinwarehsentry  drop partition(day='2019-11-14') ;
	
select count(1) from eas.ods_eas_new_eas75_t_org_storage where day = '2019-11-14';
	select * from eas.ods_eas	_new_eas75_t_org_storage where day = '2019-11-14' limit 100;
	alter table  eas.ods_eas_new_eas75_t_org_storage  drop partition(day='2019-11-14') ;

select count(1) from eas.ods_eas_new_eas75_t_sm_purorder where day = '2019-11-14';
	select * from eas.ods_eas_new_eas75_t_sm_purorder where day = '2019-11-14' limit 100;
	alter table  eas.ods_eas_new_eas75_t_sm_purorder  drop partition(day='2019-11-14') ;


SELECT supplier_code, supplier_name, warehouse_name, warehousing_time, check_return_code, product_materiel_code, 
purchase_code, prodect_materiel_name, standards, check_number, check_return_num, return_num, valuation_return_num,
unit_price, unit, currency, cur_tax_bef_amount, cur_tax, cur_amount, first_level, secondary_level, bcnottax_unit_price, 
bctax_unit_price, ori_cur_beftax_amount, ori_cur_tax_rate, ori_cur_amount, exchange_rate, delivery_warehouse, damage_num, 
scrapped_num, location_code, sales_unit, inventory_unit, us_dollar_unit_price, bu_factory_area, natural_month, 
supplier_full_name,third_level, tax_unit_price, nottax_unit_price, bcnottax_amount, cd_amount, tax_rate,whether_designation,
ori_factory_proxy, days_of_account, buyer, remarks, data_sources, `day` FROM dwbase.dwb_yifei_display_module limit 100;


select bill.FNumber,entry.FMaterialID,bill.FSupplierID,bill.FCurrencyID,billFYear,bill.fperiod,
FCurrencyIDentry.FPurchasePersonID ,entry.FPrice,
entry.FAmount,entry.FBizDate,entry.FTaxPrice,entry.FQty,entry.FMfg,entry.FExp
from  eas.ods_eas_new_eas75_t_im_purinwarehsentry as entry
inner join eas.ods_eas_new_eas75_t_im_purinwarehsbill as bill
on entry.FParentID = bill.fid ;


select distinct(fmaterialtype) from eas.ods_eas_new_eas75_ct_ls_match;
select FClassify,count(1) from eas.ods_eas_new_eas75_ct_ls_match group by FClassify;

select distinct(FMaterialGroupID) from eas.ods_eas_new_eas75_t_bd_material; --  物料基本分类 T_BD_MaterialGroup

select FPurchaseOrgUnitID from eas.ods_eas_new_eas75_t_sm_purorder limit 10;
select FPurchasePersonID from eas.ods_eas_new_eas75_t_sm_purorder limit 10;  -- FPurchasePersonID(t_bd_person.fid 取fnumber)
select DISTINCT(FHROrgUnitID)  from eas.ods_eas_new_eas75_t_bd_person ;
select DISTINCT(FEmployeeClassifyID)  from eas.ods_eas_new_eas75_t_bd_person ;

-- 查看订单--总金额（famount）
--  FMaterialID = /OQAAAAKtARECefw
-- fsupplierid = /OQAAAABCXE3xn38
select FPurOrderNumber,ftax,FTaxRate,FOrderPrice,FTaxPrice,FActualPrice,FPurchasePersonID,FTaxAmount,FPrice,FAmount,FQty,
FMaterialID,FUnitID,FBaseUnitID
from eas.ods_eas_new_eas75_t_im_purinwarehsentry limit 100;

select * from eas.ods_eas_new_eas75_t_bd_material where fid= '/OQAAAAKtARECefw';
-- fnumber = LSHKCR131200041
select FSupplierID,FNumber,FTotalQty,FTotalAmount,FYear,FPeriod,FTotalAmount,FDay,FAuditTime,FBizDate,
FCurrencyID,FReceiptAmount,FExchangeRate,FPurchaseType,FIsInTax,FDescription
from eas.ods_eas_new_eas75_t_im_purinwarehsbill limit 100;
-- A.FNumber 不等于  B.fpurordernumber 
select A.FNumber,B.fpurordernumber from eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B on A.fid = B.fparentid limit 10;


select * from eas.ods_eas_new_eas75_t_im_purinwarehsbill A 
inner join eas.ods_eas_new_eas75_t_sm_purorder B
on A.fnumber = B.fnumber;
select * from  eas.ods_eas_new_eas75_t_im_purinwarehsbill where fnumber = 'LYSuZPO191015021';
select * from  eas.ods_eas_new_eas75_t_sm_purorder where fnumber = 'LYSuZPO191015021';
select * from  eas.ods_eas_new_eas75_t_sm_purorder where fnumber = 'LYDGPO181220022';


select A.fnumber,A.fyear,A.fperiod,A.fmonth,A.fsupplierid,A.FExchangeRate,A.FCurrencyID,A.FTotalQty,A.FTotalAmount,A.FDescription,
B.FTaxRate,B.FTax,B.FLocalTax,B.FTaxPrice,B.FActualPrice,B.FPurchasePersonID,
B.FPurchaseFee,B.FTaxAmount,B.FActualTaxPrice,B.FPrice,B.FAmount,B.FQty,
C.fnumber,C.fname_l2,C.fdescription_l2,C.fmodel
from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid
inner join eas.ods_eas_new_eas75_t_bd_material C on B.fmaterialid = C.fid
-- where A.fnumber = 'LSCHKCR19082700029'
limit 100;

/**
-- unkowm fnumber=120-9212030B-1372  BLX628-A
--select D.material_code,if(D.dim='unkonwn',,''),
--D.`year` ,D.`month`,D.`date`,
--D.FTaxPrice,D.fprice,D.famountD.fqty,D.FTaxRate,D.FTax,D.FTaxAmount,D.FActualTaxPrice(
select C.fnumber as material_code,
case SUBSTRING(TRIM(C.fnumber),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else G.companyname
end as dim,
A.fyear as `year` ,A.fperiod as `month`,A.fmonth as `date`,
B.FTaxPrice,B.fprice,B.famount,B.fqty,B.FTaxRate,B.FTax,B.FTaxAmount,B.FActualTaxPrice
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid
inner join eas.ods_eas_new_eas75_t_sm_purorderentry E on E.fmaterialid = C.fid
inner join eas.ods_eas_new_eas75_t_sm_purorder H on H.fid = E.fparentid
inner join eas.ods_eas_new_eas75_t_bd_person F  on  B.FPurchasePersonID = F.fid 
inner join (select * from jituanhr.ods_jituanhr_report_t_sys_hr_user  where day = '2019-11-18') G  on G.workno = H.fnumber 
-- )D ;
**/
select * from (
select total.material_code,total.`year`,total.`month`,total.`date`,total.dim,
total.famount,
total.flocalamount,
 (total.standardPrice  - total.standardAmount) as CD
from  (
select C.fnumber as material_code,
case SUBSTRING(TRIM(C.fnumber),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim,
A.fyear as `year` ,A.fperiod as `month`,A.fmonth as `date`,
B.FTaxPrice,B.fprice,B.flocalamount,B.flocalamount  as standardAmount,B.famount,B.fqty,B.FTaxRate,B.FTax,B.FTaxAmount,B.FActualTaxPrice,
D.FBenchmarkPrice  * B.fbaseqty  as standardPrice
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid 
left join eas.ods_eas_new_eas75_ct_ls_match D on D.CFMaterielNumID = C.fid
) total ) al order by al.CD desc;
-- group by  total.material_code,total.`year`,total.`month`,total.`date`,total.dim




select total.material_code,total.`year`,total.`month`,total.`date`,total.dim,
total.famount,
 as CD
from  (
select C.fnumber as material_code,
case SUBSTRING(TRIM(C.fnumber),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim,
A.fyear as `year` ,A.fperiod as `month`,A.fmonth as `date`,
B.FTaxPrice,B.fprice, D.inPrice,B.famount,B.fqty,B.FTaxRate,B.FTax,B.FTaxAmount,B.FActualTaxPrice
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid 
LEFT join (
select C.fnumber as material,B.fprice as inPrice,A.fyear as innerYear,A.fperiod as innerPeriod
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid 
) D on C.fnumber = D.material and A.fyear = D.innerYear-1 and A.innerPeriod = 12

) total 


 
select distinct(FBenchmarkPrice) from eas.ods_eas_new_eas75_ct_ls_match;


select * from eas.ods_eas_new_eas75_t_im_purinwarehsbill where  fid = '/OQAAAAF6hV4MGHj=';

select B.fprice
from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid
where A.fnumber = 'LSCHKCR19082700029'

select * from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A where A.fnumber = 'LSCHKCR19082700029'

alter table eas.ods_eas_new_eas75_t_im_purinwarehsentry drop PARTITION(day='2019-11-14');
DROP table  eas.ods_eas_new_eas75_t_im_purinwarehsentry;

-- -- 根据订单“采购员”，查找对应的BG
select A.FPurchasePersonID,B.fnumber,B.fname_l1,c.companyname from eas.ods_eas_new_eas75_t_sm_purorder A
-- select DISTINCT(c.companyname) from eas.ods_eas_new_eas75_t_sm_purorder A
RIGHT join eas.ods_eas_new_eas75_t_bd_person B  on  A.FPurchasePersonID = B.fid 
INNER join (select * from jituanhr.ods_jituanhr_report_t_sys_hr_user  where day = '2019-11-18') C  on c.workno = b.fnumber 
where c.companyname = '冲压BG';

SELECT count(DISTINCT(simname)) FROM jituanhr.ods_jituanhr_report_t_sys_hr_department where day = '2019-11-18';
SELECT DISTINCT(simname) FROM jituanhr.ods_jituanhr_report_t_sys_hr_department where day = '2019-11-18';

select DISTINCT(companyname) from jituanhr.ods_jituanhr_report_t_sys_hr_user where day = '2019-11-18';
select companyname,count(1) from jituanhr.ods_jituanhr_report_t_sys_hr_user where day = '2019-11-18' group by companyname;




select C.fnumber as material_code,
case SUBSTRING(TRIM(C.fnumber),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim,
A.fyear as `year` ,A.fperiod as `month`,A.fmonth as `date`,
A.Fnumber as po_number,A.FSupplierID as supplier_id,A.FCurrencyID ,
B.FTaxPrice,B.fprice, if(D.inPrice is not null , D.inPrice,0),B.famount,B.fqty,B.FTaxRate,B.FTax,B.FTaxAmount,B.FActualTaxPrice
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid 
LEFT join (
select C.fnumber as material,B.fprice as inPrice,A.fyear as innerYear,A.fperiod as innerPeriod
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid 
) D on C.fnumber = D.material and A.fyear -1  = D.innerYear and D.innerPeriod = 12



-- right join eas.ods_eas_new_eas75_t_bd_material E  on E.fnumber = C.fnumber




select * from eas.ods_eas_new_eas75_t_bd_material where fnumber = 'ALB810-A';

select * from eas.ods_eas_new_eas75_t_im_purinwarehsentry where fmaterialid = '/OQAAAABXCZECefw';

select fid,fmaterialid from eas.ods_eas_new_eas75_t_im_purinwarehsbill where fnumber =  'LSHKCR14010003108';

select fparentid,FMaterialID from eas.ods_eas_new_eas75_t_im_purinwarehsentry where fparentid =  'JW0wLpIURj6YiXOjTkABG3gwYeM=';



/**
2019-11-25
 1、unkonw未关联person
 2、为什么materialId对应多列?
**/
insert overwrite table dwmiddle.dwm_eas_material_cd_by_month partition(day='2019-11-25')
select C.fnumber as material_code,
case SUBSTRING(TRIM(C.fnumber),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim,
A.fyear as `year` ,A.fperiod as `month`,A.fmonth as `date`,
A.FSupplierID as supplier_id,
B.fprice, if(D.inPrice is not null , D.inPrice,0),B.famount,B.fqty
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid 
LEFT join (
select C.fnumber as material,B.fprice as inPrice,A.fyear as innerYear,A.fperiod as innerPeriod
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid 
) D on C.fnumber = D.material and A.fyear -1  = D.innerYear and D.innerPeriod = 12;


-- --  生成    dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month  ,根据（dwmiddle.dwm_eas_material_distinct_cd_by_month）
insert overwrite table dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month partition(day='2019-11-26')
select A.material_code,A.dim,A.`year`,A.`month`,A.`date`,A.price,A.standard_price,A.amount,A.quantity,A.supplier_code,A.supplier_name,C.fstartdeferdays as account_day  from 
dwmiddle.dwm_eas_material_distinct_cd_by_month A LEFT JOIN eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo B 
on A.supplier_code = B.fsupplierid inner join eas.ods_eas_new_eas75_t_bd_payconditionentry C
on C.fparentid = B.fpayconditionid ;

-- 存在  账期天数，多个,同一个供应商的账期天数逗号分隔.
select * from dwmiddle.dwm_eas_material_distinct_cd_by_month where material_code = '110-1318Y083-1219';

insert overwrite table dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month partition(day='2019-11-25') 

insert overwrite table dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month partition(day='2019-11-26')
select  material_code,dim,`year`,`month`,`date`,
sum(price)/count(1) as price,
sum(standard_price)/count(1) as standard_price ,
sum(amount)/count(1) as amount,
sum(quantity)/count(1) as quantity,
supplier_code,
supplier_name,
concat_ws(',', collect_set(account_day))
from dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month
group by material_code,dim,`year`,`month`,`date`,supplier_code,supplier_name;


-- ====================================================================================================== --
-- ====================================================================================================== --
-- ====================================================================================================== --
-- ====================================================================================================== --
-- ====================================================================================================== --
-- ====================================================================================================== --
-- ====================================================================================================== --
-- 生成no_standardPrice 表，
insert overwrite table dwmiddle.dwm_eas_material_no_standard_by_cd partition(day='2019-11-25')
select C.fnumber as material_code,
case SUBSTRING(TRIM(C.fnumber),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim,
A.fyear as `year` ,A.fperiod as `month`,A.fmonth as `date`,
A.FSupplierID as supplier_id,
B.fprice,B.famount,B.fqty
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid 

CREATE EXTERNAL TABLE `dwmiddle.dwm_eas_material_cd_by_month`(
  `material_code` string COMMENT '物料编码', 
  `dim` string COMMENT '维度', 
  `year` string COMMENT '年份', 
  `month` string COMMENT '月份', 
  `date` string COMMENT '日期（年月）', 
  `supplier_code` string COMMENT '供应商id', 
  `price`  DECIMAL(28,16) COMMENT '单价（未税）', 
  `standard_price` DECIMAL(28,16)COMMENT '标准价', 
  `amount` DECIMAL(28,16)COMMENT '金额', 
  `quantity` string COMMENT '数量'
  )
COMMENT 'eas物料编码cd-by月基础表'
PARTITIONED BY ( 
  `day` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '^#' 
STORED AS orc  tblproperties('orc.compression' = 'snappy');

CREATE EXTERNAL TABLE `dwmiddle.dwm_eas_material_no_standard_by_cd`(
  `material_code` string COMMENT '物料编码', 
  `dim` string COMMENT '维度', 
  `year` string COMMENT '年份', 
  `month` string COMMENT '月份', 
  `date` string COMMENT '日期（年月）', 
  `supplier_code` string COMMENT '供应商id', 
  `price`  DECIMAL(28,16) COMMENT '单价（未税）', 
  `amount` DECIMAL(28,16)COMMENT '金额', 
  `quantity` string COMMENT '数量'
  )
COMMENT 'eas物料编码cd-by月基础表'
PARTITIONED BY ( 
  `day` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '^#' 
STORED AS orc  tblproperties('orc.compression' = 'snappy');


CREATE EXTERNAL TABLE `dwmiddle.dwm_eas_material_distinct_cd_by_month`(
  `material_code` string COMMENT '物料编码', 
  `dim` string COMMENT '维度', 
  `year` string COMMENT '年份', 
  `month` string COMMENT '月份', 
  `date` string COMMENT '日期（年月）', 
  `price`  DECIMAL(28,16) COMMENT '单价（未税）', 
  `standard_price` DECIMAL(28,16)COMMENT '标准价', 
  `amount` DECIMAL(28,16)COMMENT '金额', 
  `quantity` string COMMENT '数量',
   `supplier_code` string COMMENT '供应商id', 
   `supplier_name` string COMMENT '供应商名称'
  )
COMMENT 'eas物料编码cd-by月基础表(去重复)'
PARTITIONED BY ( 
  `day` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '^#' 
STORED AS orc  tblproperties('orc.compression' = 'snappy');

CREATE EXTERNAL TABLE `dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month`(
  `material_code` string COMMENT '物料编码', 
  `dim` string COMMENT '维度', 
  `year` string COMMENT '年份', 
  `month` string COMMENT '月份', 
  `date` string COMMENT '日期（年月）', 
  `price`  DECIMAL(28,16) COMMENT '单价（未税）', 
  `standard_price` DECIMAL(28,16)COMMENT '标准价', 
  `amount` DECIMAL(28,16)COMMENT '金额', 
  `quantity` string COMMENT '数量',
   `supplier_code` string COMMENT '供应商id', 
   `supplier_name` string COMMENT '供应商名称',
   `account_day` string COMMENT '账期天数'
  )
COMMENT 'eas物料编码-账期天数-cd-by月基础表(去重复)'
PARTITIONED BY ( 
  `day` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '^#' 
STORED AS orc  tblproperties('orc.compression' = 'snappy');

	
select dim,count(dim) from  dwmiddle.dwm_eas_material_cd_by_month group by dim;

-- -- 以及添加supllier_name ,去除重复的material
insert overwrite table dwmiddle.dwm_eas_material_distinct_cd_by_month partition(day='2019-11-25') 
select A.*,COALESCE(B.fname_l2,B.fname_l1,B.fname_l3) as supplier_name  from (
select  material_code,dim,`year`,`month`,`date`,sum(price)/count(1) as price,
sum(standard_price)/count(1) as standard_price ,
sum(amount) as amount,sum(quantity) as quantity,supplier_code
from dwmiddle.dwm_eas_material_cd_by_month group by material_code,dim,`year`,`month`,`date`,supplier_code) A
left join eas.ods_eas_new_eas75_t_bd_supplier B on B.fid = A.supplier_code;

select count(1) from dwmiddle.dwm_eas_material_distinct_cd_by_month;
select dim ,count(dim)  from dwmiddle.dwm_eas_material_distinct_cd_by_month group by dim;
select fname_l1,fname_l2,fname_l3 from eas.ods_eas_new_eas75_t_bd_supplier  where fid = '/OQAAAiQC8I3xn38';

CREATE EXTERNAL TABLE IF NOT EXISTS DWSERVICE.DWS_CD_BY_AMOUNT_MONTH(
cd_amount  DECIMAL(28,16) COMMENT     'CD金额',   
cd_proportion  DECIMAL(28,16) COMMENT     'CD比例',    
total_amount  DECIMAL(28,16) COMMENT     '总金额',
dim  string COMMENT    '维度', 
`year`   string COMMENT     '年份',
`month`  string COMMENT     '月份',               
`date`   string COMMENT     '日期'           
) COMMENT 'CD月报，根据不同维度（总合计/cnc/模切/冲压...）'
PARTITIONED BY (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '^#'
STORED AS orc
LOCATION '/warehouse/dwbase/dwb_yifei_display_module'
tblproperties('orc.compression' = 'snappy');

-- eas CD  计算
-- select * from 
/**
insert overwrite table DWSERVICE.DWS_CD_BY_AMOUNT_MONTH partition(day='2019-11-25') 
select sum(B.cd_amount) as cd_amount,( sum(B.cd_amount)/sum(B.amount) ) as cd_proportion ,sum(B.amount) as amount,'10' as dim,`year`,`month`,`date`
from (select sum(A.cd_amount) as cd_amount,( sum(A.cd_amount)/sum(A.amount) ) as cd_proportion ,sum(A.amount) as amount,dim,`year`,`month`,`date`
from (select material_code,dim,amount,standard_price,price,quantity,(standard_price-price)*quantity as cd_amount
,`year`,`month`, if(length(`month`)=1 ,CONCAT_WS('-0', `year`, `month`),CONCAT_WS('-', `year`, `month`)  )as `date`  from dwmiddle.dwm_eas_material_distinct_cd_by_month )  A group by dim,`year`,`month`,`date`) B 
 group by B.`year`,B.`month`,B.`date` 
union all 
 select sum(A.cd_amount) as cd_amount,( sum(A.cd_amount)/sum(A.amount) ) as cd_proportion ,sum(A.amount) as amount,dim,`year`,`month`,`date`
from (select material_code,dim,amount,standard_price,price,quantity,(standard_price-price)*quantity as cd_amount
,`year`,`month`,if(length(`month`)=1 ,CONCAT_WS('-0', `year`, `month`),CONCAT_WS('-', `year`, `month`)  )as `date`  from dwmiddle.dwm_eas_material_distinct_cd_by_month )  A group by dim,`year`,`month`,`date` 
**/

-- 合并 eas，yifei
insert overwrite table dwservice.dws_cd_by_amount_month partition(day='2019-11-25') 
select sum(B.cd_amount) as cd_amount,( if(cast(sum(B.cd_amount)/sum(B.amount) as string) is null , 0,sum(B.cd_amount)/sum(B.amount))) as cd_proportion ,sum(B.amount) as amount,'10' as dim,`year`,`month`,`date`
from (select sum(A.cd_amount) as cd_amount,( if(cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount))) as cd_proportion ,sum(A.amount) as amount,dim,`year`,`month`,`date`
from (select material_code,dim,amount,standard_price,price,quantity,(standard_price-price)*quantity as cd_amount
,`year`,`month`,if(length(`month`)=1 ,CONCAT_WS('-0', `year`, `month`),CONCAT_WS('-', `year`, `month`)  )as `date`  from dwmiddle.dwm_eas_material_distinct_cd_by_month )  A group by dim,`year`,`month`,`date` 
union ALL
 select sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0,sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount,dim,`year`,`month`,`date`
from (select  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.dim,C.`year`,C.`month`,C.`date`
union ALL
select sum(D.cd_amount) as cd_amount,( if(cast(sum(D.cd_amount)/sum(D.amount) as string) is null ,0 , sum(D.cd_amount)/sum(D.amount))) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select cast(WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(ZPRCZ as DECIMAL(28,16)) as amount,if(WERKS = '8800','6','7') as dim ,GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show ) D group by D.dim,D.`year`,D.`month`,D.`date` )B 
 group by B.`year`,B.`month`,B.`date` 
 union all
 select sum(A.cd_amount) as cd_amount,( if( cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0 ,sum(A.cd_amount)/sum(A.amount)  )) as cd_proportion ,sum(A.amount) as amount,dim,`year`,`month`,`date`
from (select material_code,dim,amount,standard_price,price,quantity,(standard_price-price)*quantity as cd_amount
,`year`,`month`,if(length(`month`)=1 ,CONCAT_WS('-0', `year`, `month`),CONCAT_WS('-', `year`, `month`)  )as `date`  from dwmiddle.dwm_eas_material_distinct_cd_by_month )  A group by dim,`year`,`month`,`date` 
union ALL
 select sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount,dim,`year`,`month`,`date`
from (select  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.dim,C.`year`,C.`month`,C.`date`
union ALL
select sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select cast(WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(ZPRCZ as DECIMAL(28,16)) as amount,if(WERKS = '8800','6','7') as dim ,GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show ) D group by D.dim,D.`year`,D.`month`,D.`date`;


select  distinct(days_of_account) from dwbase.dwb_yifei_display_module ;
select account_day from  dwservice.dws_cd_by_supplier_month  where dim = '8';

-- 供应商 CD金额，sap ，eas，yifei
insert overwrite table dwservice.dws_cd_by_supplier_month partition(day='2019-11-25') 
select E.supplier_code,E.supplier_name,sum(E.cd_amount) as cd_amount,( if(cast(sum(E.cd_amount)/sum(E.amount) as string) is null , 0,sum(E.cd_amount)/sum(E.amount))) as cd_proportion ,sum(E.amount) as amount,concat_ws(',', collect_set(E.account_day)) as account_day,'10' as dim,E.`year`,E.`month`,E.`date`
from (select A.supplier_code,A.supplier_name, sum(A.cd_amount) as cd_amount,( if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount))) as cd_proportion ,sum(A.amount) as amount,concat_ws(',', collect_set(A.account_day)) as account_day,dim,`year`,`month`,`date`
from (select B.fnumber as supplier_code,COALESCE(B.fname_l2,B.fname_l1,B.fname_l3) as supplier_name,A.account_day as account_day,A.dim,A.amount,A.standard_price,A.price,A.quantity,(A.standard_price-A.price)*A.quantity as cd_amount
,A.`year`,A.`month`,if(length(A.`month`)=1 ,CONCAT_WS('-0', A.`year`, A.`month`),CONCAT_WS('-', A.`year`, A.`month`)  )as `date`  from dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month A
left join eas.ods_eas_new_eas75_t_bd_supplier B on B.fid = A.supplier_code
)  A group by supplier_code,supplier_name,dim,`year`,`month`,`date`  
union ALL
 select C.supplier_code,C.supplier_name, sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,concat_ws(',', collect_set(C.account_day)) as account_day,dim,`year`,`month`,`date`
from (select  supplier_code,supplier_name,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,case days_of_account
when '现结' then '0'
when '预付' then '60'
when '半月结' then '0'
when '月结30天' then '30'
when '月结60天' then '60'
when '月结90天' then '90'
else ''
end as account_day, 
SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.supplier_code,C.supplier_name, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.supplier_code,D.supplier_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,concat_ws(',', collect_set(D.account_day))  as account_day,dim,`year`,`month`,`date`
from (select B.lifnr as supplier_code,B.name1 as supplier_name, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,'' as account_day,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A left join saptest.ods_sap_zbigdata_md_lfa1 B on  A.LIFNR = B.lifnr
) D group by  D.supplier_code,D.supplier_name,D.dim,D.`year`,D.`month`,D.`date`
) E group by  E.supplier_code,E.supplier_name,E.`year`,E.`month`,E.`date`
union ALL
select A.supplier_code,A.supplier_name, sum(A.cd_amount) as cd_amount,( if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount))) as cd_proportion ,sum(A.amount) as amount,concat_ws(',', collect_set(A.account_day)) as account_day,dim,`year`,`month`,`date`
from (select B.fnumber as supplier_code,COALESCE(B.fname_l2,B.fname_l1,B.fname_l3) as supplier_name,A.account_day as account_day,A.dim,A.amount,A.standard_price,A.price,A.quantity,(A.standard_price-A.price)*A.quantity as cd_amount
,A.`year`,A.`month`,if(length(A.`month`)=1 ,CONCAT_WS('-0', A.`year`, A.`month`),CONCAT_WS('-', A.`year`, A.`month`)  )as `date`  from dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month A
left join eas.ods_eas_new_eas75_t_bd_supplier B on B.fid = A.supplier_code
)  A group by supplier_code,supplier_name,dim,`year`,`month`,`date`  
union ALL
 select C.supplier_code,C.supplier_name, sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,concat_ws(',', collect_set(C.account_day)) as account_day,dim,`year`,`month`,`date`
from (select  supplier_code,supplier_name,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim, case days_of_account
when '现结' then '0'
when '预付' then '60'
when '半月结' then '0'
when '月结30天' then '30'
when '月结60天' then '60'
when '月结90天' then '90'
else ''
end as account_day, 
SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.supplier_code,C.supplier_name, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.supplier_code,D.supplier_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,concat_ws(',', collect_set(D.account_day))  as account_day,dim,`year`,`month`,`date`
from (select B.lifnr as supplier_code,B.name1 as supplier_name, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,'' as account_day,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A left join saptest.ods_sap_zbigdata_md_lfa1 B on  A.LIFNR = B.lifnr
) D group by  D.supplier_code,D.supplier_name,D.dim,D.`year`,D.`month`,D.`date`;



-- 测试 冲压是否存在  cd金额为负数的情况。 (基础表+ 供应商需要重新 ，计算)
select A.* from 
(select material_code,dim,sum(amount) as amount,sum(price) as price ,sum(standard_price) as standard_pricet,
sum(quantity) as quantity,(sum(standard_price) -sum(price)) *sum(quantity) as cd_amount 
,((sum(standard_price) -sum(price)) *sum(quantity)) /sum(amount) as cd_proportion ,`year`,`month`,`date`
from  dwmiddle.dwm_eas_material_distinct_cd_by_month   where dim =2 group by material_code,dim, `year`,`month`,`date`
) A where A.cd_amount < 0;

-- 2019-11-26
-- 1、 新的逻辑  生成    dwmiddle.dwm_eas_material_distinct_cd_by_month2  表。【以前的表作废】
-- 2、等待业务提供更合适的算法
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
--select C.* from (
insert overwrite table dwmiddle.dwm_eas_material_cd_by_month2 partition(day='2019-11-25')
select A.material_code,A.dim,A.`year`,A.`month`,A.`date`,A.supplier_code,A.price,B.price as standard_price,
A.amount,A.quantity
from dwmiddle.dwm_eas_material_no_standard_by_cd A 
left join dwmiddle.dwm_eas_material_no_standard_by_cd B
on  A.material_code = B.material_code and A.`year` -1 = B.`year` and B.`month` = 12 
-- )Cwhere C.dim = '2' and C.material_code = '680-AEX773-A0-0-02';

-- -- 按年和月，合并重复的material，amount，price，等 ，且添加supplier——name
insert overwrite table dwmiddle.dwm_eas_material_distinct_cd_by_month2 partition(day='2019-11-25') 
select A.*,COALESCE(B.fname_l2,B.fname_l1,B.fname_l3) as supplier_name  from (
select  material_code,dim,`year`,`month`,`date`,sum(price)/count(1) as price,
sum(standard_price)/count(1) as standard_price ,
sum(amount) as amount,sum(quantity) as quantity,supplier_code
from dwmiddle.dwm_eas_material_cd_by_month2 group by material_code,dim,`year`,`month`,`date`,supplier_code) A
left join eas.ods_eas_new_eas75_t_bd_supplier B on B.fid = A.supplier_code;

-- 18405926
select count(1) from dwmiddle.dwm_eas_material_cd_by_month2 where standard_price = '' or standard_price is null ; 

select count(1) from dwmiddle.dwb_purchase_combine_mid2;  -- 165486418
select count(distinct(material_code)) from  dwmiddle.dwb_purchase_combine_mid2;  -- 169019
select count(1) from (select count(material_code) from dwmiddle.dwb_purchase_combine_mid2   -- 2380850
group by material_code,price,`date`,`year`,`month`,amount,quantity) A;
select count(1) from dwmiddle.dwb_purchase_combine_mid1;  -- 2969133

select * from dwmiddle.dwb_purchase_combine_mid2 where material_code = '180-XN330230-0180'; 

-- -- 物料分类  Cd金额，计算 == （ use 2）  === 以及合并sap && eas
insert overwrite table dwservice.dws_cd_by_material_type_month partition(day='2019-11-25') 
select P.material_type ,sum(P.cd_amount) as cd_amount,( if( cast(sum(P.cd_amount)/sum(P.amount) as string) is null ,0 ,sum(P.cd_amount)/sum(P.amount)  )) as cd_proportion ,sum(P.amount) as amount,'10' as dim,P.`year`,P.`month`,P.`date`
from (select A.material_type ,sum(A.cd_amount) as cd_amount,( if( cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0 ,sum(A.cd_amount)/sum(A.amount)  )) as cd_proportion ,sum(A.amount) as amount,dim,`year`,`month`,`date`
from 
(select N.material_code,V.fname_l2 as material_type,N.dim,N.amount,N.standard_price,N.price,N.quantity,(N.standard_price-N.price)*N.quantity as cd_amount
,N.`year`,N.`month`,if(length(N.`month`)=1 ,CONCAT_WS('-0', N.`year`, N.`month`),CONCAT_WS('-', N.`year`, N.`month`)  )as `date` 
from (select U.*,W.fparentid 
from dwmiddle.dwm_eas_material_distinct_cd_by_month2 U LEFT JOIN eas.ods_eas_new_eas75_t_bd_material M on M.fnumber = U.material_code
LEFT join eas.ods_eas_new_eas75_t_bd_materialgroup W on W.fid = M.fmaterialgroupid
) N left join  eas.ods_eas_new_eas75_t_bd_materialgroup V on V.fid = N.fparentid
)  A group by A.material_type,A.dim,A.`year`,A.`month`,A.`date` 
union ALL
 select C.material_type,sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount,dim,`year`,`month`,`date`
from (select first_level as material_type,  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.material_type,C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.material_type,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select mtbez as material_type,cast(WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(ZPRCZ as DECIMAL(28,16)) as amount,if(WERKS = '8800','6','7') as dim ,GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show ) D group by D.material_type,D.dim,D.`year`,D.`month`,D.`date`
) P group by P.material_type,P.`year`,P.`month`,P.`date`
union ALL
select A.material_type ,sum(A.cd_amount) as cd_amount,( if( cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0 ,sum(A.cd_amount)/sum(A.amount)  )) as cd_proportion ,sum(A.amount) as amount,dim,`year`,`month`,`date`
from 
(select N.material_code,V.fname_l2 as material_type,N.dim,N.amount,N.standard_price,N.price,N.quantity,(N.standard_price-N.price)*N.quantity as cd_amount
,N.`year`,N.`month`,if(length(N.`month`)=1 ,CONCAT_WS('-0', N.`year`, N.`month`),CONCAT_WS('-', N.`year`, N.`month`)  )as `date` 
from (select U.*,W.fparentid 
from dwmiddle.dwm_eas_material_distinct_cd_by_month2 U LEFT JOIN eas.ods_eas_new_eas75_t_bd_material M on M.fnumber = U.material_code
LEFT join eas.ods_eas_new_eas75_t_bd_materialgroup W on W.fid = M.fmaterialgroupid
) N left join  eas.ods_eas_new_eas75_t_bd_materialgroup V on V.fid = N.fparentid
)  A group by A.material_type,A.dim,A.`year`,A.`month`,A.`date` 
union ALL
 select C.material_type,sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount,dim,`year`,`month`,`date`
from (select first_level as material_type,  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.material_type,C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.material_type,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select mtbez as material_type,cast(WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(ZPRCZ as DECIMAL(28,16)) as amount,if(WERKS = '8800','6','7') as dim ,GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show ) D group by D.material_type,D.dim,D.`year`,D.`month`,D.`date`;


select distinct(dim) from dwservice.dws_cd_by_material_cut_price_month where material_name like '%2500%' ;
select * from eas.ods_eas_new_eas75_t_bd_material where  fname_l2 like '%2500%' ;
-- -- 物料 降价幅度
-- select * from (
insert overwrite table dwservice.dws_cd_by_material_cut_price_month partition(day='2019-11-25') 
select W.material_8code,W.material_name,W.price,'10' as dim ,W.`year`,W.`month`,W.`date`
from (select C.material_8code,concat_ws(',', collect_set(C.material_name)) as material_name,sum(C.price)/count(1) as price,C.dim,C.`year`,C.`month`,C.`date`
from(select if(SUBSTRING(A.material_code,instr(A.material_code,'-')+1,8) is null or SUBSTRING(A.material_code,instr(A.material_code,'-')+1,8) = '',A.material_code, SUBSTRING(A.material_code,instr(A.material_code,'-')+1,8) ) as material_8code ,
B.fname_l2 as material_name,A.price,A.dim,A.`year`,A.`month`,A.`date`
from dwmiddle.dwm_eas_material_distinct_cd_by_month2 A  left JOIN
eas.ods_eas_new_eas75_t_bd_material B on A.material_code = B.fnumber) C
group by C.material_8code,C.dim,C.`year`,C.`month`,C.`date` 
-- ) D where  D.material_8code = '000WH006';
-- 相同名称的物料，为不同的型号。
union ALL
select product_materiel_code as material_8code,concat_ws(',', collect_set(prodect_materiel_name)) as material_name,unit_price as price,
'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module group by product_materiel_code,unit_price,SUBSTRING(natural_month,0,4),SUBSTRING(natural_month,5,2),CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2))
union ALL
select MATNR AS  material_8code ,MAKTX as material_name ,if(NETPR is null or NETPR = '', (cast(HSDAJ as decimal(28,6)) / cast(MWSKZ1 as decimal(28,6))) , cast(NETPR as decimal(28,6))) as price,
if(WERKS = '8800','6','7') as dim ,GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show 
group by MATNR,MAKTX,if(NETPR is null or NETPR = '', (cast(HSDAJ as decimal(28,6)) / cast(MWSKZ1 as decimal(28,6))) , cast(NETPR as decimal(28,6))),if(WERKS = '8800','6','7'),GJAHR,SUBSTRING(LFDAT,6,2)  ,SUBSTRING(LFDAT,0,7) 
) W group by  W.material_8code,W.material_name,W.price,W.`year`,W.`month`,W.`date`
 union ALL
 select C.material_8code,concat_ws(',', collect_set(C.material_name)) as material_name,sum(C.price)/count(1) as price,C.dim,C.`year`,C.`month`,C.`date`
from(select if(SUBSTRING(A.material_code,instr(A.material_code,'-')+1,8) is null or SUBSTRING(A.material_code,instr(A.material_code,'-')+1,8) = '' ,A.material_code,SUBSTRING(A.material_code,instr(A.material_code,'-')+1,8))as material_8code ,
B.fname_l2 as material_name,A.price,A.dim,A.`year`,A.`month`,A.`date`
from dwmiddle.dwm_eas_material_distinct_cd_by_month2 A  left JOIN
eas.ods_eas_new_eas75_t_bd_material B on A.material_code = B.fnumber) C
group by C.material_8code,C.dim,C.`year`,C.`month`,C.`date` 
-- ) D where  D.material_8code = '000WH006';
-- 相同名称的物料，为不同的型号。
union ALL
select product_materiel_code as material_8code,concat_ws(',', collect_set(prodect_materiel_name)) as material_name,unit_price as price,
'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module group by product_materiel_code,unit_price,SUBSTRING(natural_month,0,4),SUBSTRING(natural_month,5,2),CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2))
union ALL
select MATNR AS  material_8code ,MAKTX as material_name ,if(NETPR is null or NETPR = '', (cast(HSDAJ as decimal(28,6)) / cast(MWSKZ1 as decimal(28,6))) , cast(NETPR as decimal(28,6))) as price,
if(WERKS = '8800','6','7') as dim ,GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show 
group by MATNR,MAKTX,if(NETPR is null or NETPR = '', (cast(HSDAJ as decimal(28,6)) / cast(MWSKZ1 as decimal(28,6))) , cast(NETPR as decimal(28,6))),if(WERKS = '8800','6','7'),GJAHR,SUBSTRING(LFDAT,6,2)  ,SUBSTRING(LFDAT,0,7) ;







-- --  厂区 Cd金额 计算 （易飞 没有公司的概念）
select W.area,W.industry_area,W.company_name, sum(W.cd_amount) as cd_amount,( if (cast(sum(W.cd_amount)/sum(W.amount) as string) is null ,0, sum(W.cd_amount)/sum(W.amount))) as cd_proportion ,sum(W.amount) as amount,concat_ws(',', collect_set(W.account_day)) as account_day,'10'as dim,W.`year`,W.`month`,W.`date`
from (select A.area,A.industry_area,A.company_name, sum(A.cd_amount) as cd_amount,( if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount))) as cd_proportion ,sum(A.amount) as amount,concat_ws(',', collect_set(A.account_day)) as account_day,dim,`year`,`month`,`date`
from (select E.area as area,'' as industry_area, D.fname_l2 as company_name,A.dim,A.amount,A.standard_price,A.price,A.quantity,(A.standard_price-A.price)*A.quantity as cd_amount
,A.`year`,A.`month`,if(length(A.`month`)=1 ,CONCAT_WS('-0', A.`year`, A.`month`),CONCAT_WS('-', A.`year`, A.`month`)  )as `date`  from dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month A
left join eas.ods_eas_new_eas75_t_bd_material C  on A.material_code = C.fnumber
left join eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on C.fid = B.fmaterialid 
left join eas.ods_eas_new_eas75_t_org_company D on D.fid = B.FCompanyOrgUnitID
left join eas.ods_eas_new_eas75_t_org_company_area_relation2 E on E.company_fid = D.fid
)  A group by area,industry_area,company_name,dim,`year`,`month`,`date`  
union ALL
select D.area,D.industry_area,D.company_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,concat_ws(',', collect_set(D.account_day))  as account_day,dim,`year`,`month`,`date`
from (select E.area as area ,B.name1 as industry_area,C.butxt as company_name, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,'' as account_day,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A 
left join saptest.ods_sap_zbigdata_md_t001w B on A.werks = B.werks
left join saptest.ods_sap_zbigdata_md_t001 C on A.bukrs = C.bukrs 
left join saptest.ods_sap_company_area_relation E on E.company_fid = A.bukrs
) D group by  D.area,D.industry_area,D.company_name,D.dim,D.`year`,D.`month`,D.`date`;
) W group by  W.area,W.industry_area,W.company_name,W.`year`,W.`month`,W.`date`;
UNION ALL
 select A.area,A.industry_area,A.company_name, sum(A.cd_amount) as cd_amount,( if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount))) as cd_proportion ,sum(A.amount) as amount,concat_ws(',', collect_set(A.account_day)) as account_day,dim,`year`,`month`,`date`
from (select E.area as area,'' as industry_area, D.fname_l2 as company_name,A.dim,A.amount,A.standard_price,A.price,A.quantity,(A.standard_price-A.price)*A.quantity as cd_amount
,A.`year`,A.`month`,if(length(A.`month`)=1 ,CONCAT_WS('-0', A.`year`, A.`month`),CONCAT_WS('-', A.`year`, A.`month`)  )as `date`  from dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month A
left join eas.ods_eas_new_eas75_t_bd_material C  on A.material_code = C.fnumber
left join eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on C.fid = B.fmaterialid 
left join eas.ods_eas_new_eas75_t_org_company D on D.fid = B.FCompanyOrgUnitID
left join eas.ods_eas_new_eas75_t_org_company_area_relation2 E on E.company_fid = D.fid
)  A group by area,industry_area,company_name,dim,`year`,`month`,`date`  
union ALL
select D.area,D.industry_area,D.company_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,concat_ws(',', collect_set(D.account_day))  as account_day,dim,`year`,`month`,`date`
from (select E.area as area ,B.name1 as industry_area,C.butxt as company_name, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,'' as account_day,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A 
left join saptest.ods_sap_zbigdata_md_t001w B on A.werks = B.werks
left join saptest.ods_sap_zbigdata_md_t001 C on A.bukrs = C.bukrs 
left join saptest.ods_sap_company_area_relation E on E.company_fid = A.bukrs
) D group by  D.area,D.industry_area,D.company_name,D.dim,D.`year`,D.`month`,D.`date`;





-- 采购员 CD金额报表
-- 生成masterial_purchaser_no_standardPrice 表，
insert overwrite table dwservice.DWS_CD_BY_PURCHASER_MONTH partition(day='2019-11-25') 
select W.person_name, sum(W.cd_amount) as cd_amount,( if (cast(sum(W.cd_amount)/sum(W.amount) as string) is null ,0, sum(W.cd_amount)/sum(W.amount))) as cd_proportion ,sum(W.amount) as amount,'10' as dim,`year`,`month`,`date`
from (select A.person_name, sum(A.cd_amount) as cd_amount,( if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount))) as cd_proportion ,sum(A.amount) as amount,dim,`year`,`month`,`date`
from (select N.person_name,N.dim,N.amount,N.standard_price,N.price,N.quantity,(N.standard_price-N.price)*N.quantity as cd_amount
,N.`year`,N.`month`,if(length(N.`month`)=1 ,CONCAT_WS('-0', N.`year`, N.`month`),CONCAT_WS('-', N.`year`, N.`month`)  )as `date` 
from dwmiddle.dwm_eas_material_purchaser_distinct_cd_by_month2 N ) A
group by  person_name,dim,`year`,`month`,`date`
union ALL
select C.buyer as person_name, sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select  buyer ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,
SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.buyer, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.UNSEZ as person_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select A.UNSEZ as UNSEZ, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A 
) D group by  D.UNSEZ,D.dim,D.`year`,D.`month`,D.`date`
) W group by  W.person_name,W.`year`,W.`month`,W.`date`
union all 
select A.person_name, sum(A.cd_amount) as cd_amount,( if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount))) as cd_proportion ,sum(A.amount) as amount,dim,`year`,`month`,`date`
from (select N.person_name,N.dim,N.amount,N.standard_price,N.price,N.quantity,(N.standard_price-N.price)*N.quantity as cd_amount
,N.`year`,N.`month`,if(length(N.`month`)=1 ,CONCAT_WS('-0', N.`year`, N.`month`),CONCAT_WS('-', N.`year`, N.`month`)  )as `date` 
from dwmiddle.dwm_eas_material_purchaser_distinct_cd_by_month2 N ) A
group by  person_name,dim,`year`,`month`,`date`
union ALL
select C.buyer as person_name, sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select  buyer ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,
SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.buyer, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.UNSEZ as person_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select A.UNSEZ as UNSEZ, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A 
) D group by  D.UNSEZ,D.dim,D.`year`,D.`month`,D.`date`



select cd_amount,total_amount from  dwservice.DWS_CD_BY_PURCHASER_MONTH order by casrtotal_amount desc ;

insert overwrite table dwmiddle.dwm_eas_material_purchaser_no_standard_by_cd partition(day='2019-11-25')
select C.fnumber as material_code,
case SUBSTRING(TRIM(C.fnumber),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim,
A.fyear as `year` ,A.fperiod as `month`,A.fmonth as `date`,
A.FSupplierID as supplier_id,
B.fprice,B.famount,B.fqty,D.fnumber as person_id, D.fname_l2 as person_name
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid left join 
eas.ods_eas_new_eas75_t_bd_person D  on  B.FPurchasePersonID = D.fid ;




select distinct(bu_factory_area) from dwbase.dwb_yifei_display_module;
select distinct(ori_factory_proxy) from dwbase.dwb_yifei_display_module;

--select DISTINCT(D.company_name) from ( 
select B.name1 as industry_area,C.butxt as company_name from saptest.ods_sap_zdmmr027_show A left JOIN
saptest.ods_sap_zbigdata_md_t001w B on A.werks = B.werks left JOIN
saptest.ods_sap_zbigdata_md_t001 C on A.bukrs = C.bukrs 
-- ) D

select distinct(A.fname_l2) from eas.ods_eas_new_eas75_t_org_company A right join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B on A.fid = B.fcompanyorgunitid




SELECT material_8code, material_name, price, dim, `month`, `year`, if(length(`month`)=1 ,CONCAT_WS('-0', `year`,`month`),CONCAT_WS('-', `year`,`month`)  )as `date`  FROM dwservice.dws_cd_by_material_cut_price_month;

select * from dwservice.dws_cd_by_material_cut_price_month where material_8code = '0001N-2' order by `date` desc;


select count(distinct(material_code)) from dwmiddle.dwm_eas_material_distinct_cd_by_month2  ; -- 169019

select count(distinct(material_code)) from dwmiddle.dwm_eas_material_no_standard_by_cd; -- 100W

select count(DISTINCT(fnumber)) from eas.ods_eas_new_eas75_t_bd_material;  

select fname_l2 from eas.ods_eas_new_eas75_t_bd_material where fnumber = '110-2104005C-1050';
select fname_l2 from eas.ods_eas_new_eas75_t_bd_material where fnumber = '110-2104005C-1050';

select A.*,B.fparentid from eas.ods_eas_new_eas75_t_bd_material A inner join eas.ods_eas_new_eas75_t_bd_materialgroup B 
on A.fmaterialgroupid = B.id;

select B.fname_l2 from eas.ods_eas_new_eas75_t_bd_materialgroup B where B.fid in (select A.fparentid from eas.ods_eas_new_eas75_t_bd_materialgroup A ) ;

inner join  eas.ods_eas_new_eas75_t_bd_materialgroup B 


alter  table  eas.ods_eas_new_eas75_t_bd_supplier  drop  if  exists  partition (day='2019-09-24')  ;


select  * from  dwmiddle.dwm_eas_material_no_standard_by_cd where material_code='680-ADD604-B0-00-A1';
select  * from  dwmiddle.dwm_eas_material_no_standard_by_cd where material_code='680-AEX773-A0-0-02';
select  * from  dwmiddle.dwm_eas_material_no_standard_by_cd where material_code='680-AEX996-A0-0-02';
select  * from  dwservice.dws_cd_by_amount_month where dim = '2' 

 
alter  table  eas.ODS_EAS_NEW_EAS75_T_BD_PAYCONDITION  drop  if  exists  partition (day='2019-11-25')  ;
alter  table  eas.ODS_EAS_NEW_EAS75_T_BD_PAYCONDITION  add  partition  (day='2019-11-25')  location  '/warehouse/eas/ods/ODS_EAS_NEW_EAS75_ODS_EAS_NEW_EAS75_T_BD_PAYCONDITION/day=2019-11-25'

alter  table  eas.ODS_EAS_NEW_EAS75_T_SM_PURREQUEST  drop  if  exists  partition (day='2019-11-25')  ;
alter  table  eas.ODS_EAS_NEW_EAS75_T_SM_PURREQUEST  add  partition  (day='2019-11-25')  location  '/warehouse/eas/ods/ODS_EAS_NEW_EAS75_ODS_EAS_NEW_EAS75_T_SM_PURREQUEST/day=2019-11-25'; 

select count(1) from eas.ods_eas_new_eas75_t_sm_purrequest where day='2019-11-25';
select count(1) from eas.ods_eas_new_eas75_t_bd_person



select distinct(cd_proportion) from dwservice.dws_cd_by_amount_month

select MATNR as material_code,GJAHR as `year`,  MJAHR as niandu ,LFDAT as jiao_date ,JSHJI as faxamount,MWSKZ1 as taxPro,
ZPRCZ as localamount, WSCY,WSCD as CD  from saptest.ods_sap_zdmmr027_show ;

select LIFNR from saptest.ods_sap_zdmmr027_show ;

drop table dwservice.dws_cd_by_amount_month;
-- 合并sap ，eas ，yifei
select  MATNR as material_code,'9' as dim, from  saptest.ods_sap_zmmr008_show

select * from (
select gjahr as `year` from saptest.ods_sap_zmmr008_show	
union all  
select gjahr as `year` from saptest.ods_sap_zmmr008_show); 

CREATE EXTERNAL TABLE `dwservice.dws_cd_by_material_type_month`(
  `material_type` string COMMENT '物料类型名称', 
  `cd_amount` decimal(28,16) COMMENT 'CD金额', 
  `cd_proportion`  decimal(28,16) COMMENT 'CD比例', 
  `total_amount`  decimal(28,16) COMMENT '总金额', 
  `dim` string COMMENT '维度', 
  `month` string COMMENT '月份', 
  `year` string COMMENT '年份', 
  `date` string COMMENT '日期')
COMMENT 'CD月报物料类型，根据不同维度（总合计/cnc/模切/冲压...）'
PARTITIONED BY ( 
  `day` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '^#' 
STORED AS orc
tblproperties('orc.compression' = 'snappy');

select *  from dwservice.dws_cd_by_material_cut_price_month where material_8code = '' or material_8code is null ;

select cfoutsupplierno from eas.ods_eas_new_eas75_t_im_purinwarehsentry ;

-- -- -- 合并eas ，sap，易飞源数据

select  * from dwbase.dwb_yifei_display_module where product_materiel_code = '11-521W7-09001-BO-S';

-- MBLNR ,
select ZEILE from saptest.ods_sap_zdmmr027_show

select * from eas.ods_eas_new_eas75_t_sm_purorder where fnumber  = 'LYDGPO181220022';
select * from eas.ods_eas_new_eas75_t_sm_purorder where fid = '/OQAAAngUW0xcb+t';
select * from eas.ods_eas_new_eas75_t_im_purinwarehsentry where fpurordernumber = 'LYDGPO181220022';



--生成 账期天数 文字描述。  == 
insert overwrite table dwservice.DWS_CD_BY_ACCOUNT_DAY_MONTH partition(day='2019-11-25')
select case split(account_day,',')[0]
when '0' then '现结/半月结'
when '1' then '现结/半月结'
when '10' then 'COD'
when '105' then '月结90天'
when '120' then '60天月结+60天承兑'
when '135' then '月结120天'
when '195' then '票结90天+90天承兑汇票'
when '30' then '月结30天'
when '45' then '月结30天'
when '60' then '月结60天'
when '75' then '月结60天'
when '90' then '月结90天'
ELSE '' end as account_day,cd_amount,cd_proportion,total_amount,
dim,`year`,`month`,`date`
from 
dwservice.dws_cd_by_supplier_month;

CREATE EXTERNAL TABLE `dwservice.DWS_CD_BY_ACCOUNT_DAY_MONTH`(
	  `account_day`  string COMMENT     '账期天数名称',
	  cd_amount  DECIMAL(28,16)  COMMENT     'cd金额',
	  cd_proportion   DECIMAL(28,16) COMMENT     'CD比例',    
	  total_amount   DECIMAL(28,16) COMMENT     '总金额',
	  `dim` string COMMENT '维度', 
	  `year` string COMMENT '年份', 
	  `month` string COMMENT '月份', 
	  `date` string COMMENT '日期（年月）')
	COMMENT '账期天数名称 cd-by月基础表(去重复)'
	PARTITIONED BY ( 
	  `day` string)
	ROW FORMAT DELIMITED 
	  FIELDS TERMINATED BY '\t' 
	STORED AS orc
	tblproperties('orc.compression' = 'snappy');



select distinct( split(account_day,',')[0]) from dwservice.dws_cd_by_supplier_month

-- ***************************************************************************************** --
select count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsbill; --  1683068
select count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsentry; -- 3158888
select count(distinct(fmaterialid)) from eas.ods_eas_new_eas75_t_im_purinwarehsentry; -- 174006
select count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsentry where  fparentid= '/5PdeQWdTU2WI34twX0FaXgwYeM='; --12 
select FPurchasePersonID from eas.ods_eas_new_eas75_t_im_purinwarehsentry where  fparentid= '/5PdeQWdTU2WI34twX0FaXgwYeM=';

-- -- 合并eas 数据， 
insert overwrite table  dwbase.dwb_purchase_eas_combine partition(day='2019-12-03') 
select B.fpurorderNumber as po_number,A.fnumber as stock_number,C.FNumber as material_code,
if(SUBSTRING(C.FNumber,instr(C.FNumber,'-')+1,8) is null or 
SUBSTRING(C.FNumber,instr(C.FNumber,'-')+1,8) = '',C.FNumber,
SUBSTRING(C.FNumber,instr(C.FNumber,'-')+1,8)) as material_8code,
COALESCE(C.fname_l2, C.fname_l1, C.fname_l3) as material_name,
COALESCE(C.fdescription_l2,C.fdescription_l1,C.fdescription_l3) as material_describe,
C.FModel as material_model,'' as material_group_code,'' as material_group_describe,
E.fnumber as supplier_code,COALESCE(E.fname_l2,E.fname_l1,E.fname_l3) as supplier_name,
E.FSimpleName as supplier_simple_name,B.cfoutsupplierno as out_supp_material_code,
B.FPurchaseGroupID as purchase_group_code,B.FPurchaseOrgUnitID as purchase_org_code,
F.fnumber as stock_org_number,COALESCE(F.fname_l2,F.fname_l1,F.fname_l3) as stock_org_name,
A.FAuditTime as stock_in_audit_time,A.FBizDate as stock_in_time,
'' as document_date,G.FBizDate as order_date,P.FDeliveryDate as delivery_date,
'' as stock_goods_describe,D.fname_l2 as secondary_level,'' as third_level,
B.FProjectID as project_id,'' as voucher_project_code, D.fname_l2 as material_type,
H.Fcountry as origin_firm,I.fnumber  as currency,I.fname_l2  as currency_name,
B.FQty as quantity,O.fnumber as unit_number,O.fname_l2 as unit ,'' as price_unit,
A.FExchangeRate as exchange_rate,B.FTaxRate as tax_rate,'' as tax_code,
K.fstartdeferdays as pay_day,B.FPrice as price,'' as usd_price,
B.FTaxPrice as tax_price,B.FLocalAmount as cur_amount,B.FTaxAmount as tax_amount,
B.FTaxAmount as tax_rmb_amount,B.FAmount as amount,'' as start_price,'' as start_diff_price,
-- '?' as bechmark_price,'' as bechmark_tax_price,'' as bechmark_amount,
-- '' as cd_amount,'' as cd_proportion,
K.fstartdeferdays as account_day,
'' as check_bechmark_price,'' as check_bechmark_amount,'' as check_CD_amount,
B.FPurchasePersonID as pic,B.FPurchasePersonID as docu_pic,'' as supp_po_code,
Q.FDescription as prod_line, '' as line_pic,M.area as area,'' as factory_code,'' as factory_area,
L.fnumber as company_code, L.fname_l2 as company_name,'' as branch_of_facoty,
N.fname_l2 as warehouse_name,'' as order_number, '' as check_return_code,
'' as check_number,B.FReturnsQty as check_return_num,B.FReturnsQty as return_num,
B.FLocalTax as cur_tax,N.fname_l2 as delivery_warehouse,'' as inventory_unit,
'' as ori_cur_beftax_amount,'' as ori_cur_tax,B.FTax as tax,'' as ori_cur_amount,
'' as damage_num,'' as scrapped_num,'' as location_code,'' as sales_unit,
'' as appoint,'' as ori_proxy,B.FPurchasePersonID as buyer,B.FRemark as remarks,
case SUBSTRING(TRIM(C.fnumber),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim,
A.FPeriod as period,A.FYear as `year`,A.fperiod as `month`,A.fmonth as `date`,
'eas' as data_sources 
from eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C on C.fid = B.fmaterialid left join
eas.ods_eas_new_eas75_t_bd_materialgroup D on D.fid = C.FMaterialGroupID left join 
eas.ods_eas_new_eas75_t_bd_supplier E on E.fid = A.FSupplierID left join 
eas.ods_eas_new_eas75_t_org_storage F on F.fid = B.FStorageOrgUnitID left join 
eas.ods_eas_new_eas75_t_sm_purorder G on G.fnumber = B.fpurorderNumber left join 
eas.ods_eas_new_eas75_ct_ls_match H on H.CFMaterielNumID = C.fid left join
eas.ods_eas_new_eas75_t_bd_currency I on A.FCurrencyID = I.fid left join 
eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo J on J.fsupplierid = E.fid left JOIN
eas.ods_eas_new_eas75_t_bd_payconditionentry K on K.fparentid = J.fpayconditionid left join
eas.ods_eas_new_eas75_t_org_company L on L.fid = B.FCompanyOrgUnitID left join 
eas.ods_eas_new_eas75_t_org_company_area_relation2 M on M.company_fid = L.fid left join
eas.ods_eas_new_eas75_t_db_warehouse N on  B.FWarehouseID = N.fid left join 
eas.ods_eas_new_eas75_t_bd_measureunit O on O.fid = B.FBaseUnitID left join 
eas.ods_eas_new_eas75_t_sm_purorderentry P on P.fparentid = G.fid left join 
eas.ods_eas_new_eas75_t_sm_purrequest Q on P.fsourcebillnumber = Q.fnumber ;

-- ***************************************************************************************** --

select `date` ,count(1)  from  dwservice.dws_cd_by_material_cut_price_month group by `date`;

-- 查询出来之后，再根据‘unknow’ 查询person，→ BG
left join eas.ods_eas_new_eas75_t_bd_person R  on  B.FPurchasePersonID = R.fid left Join
left join (select * from jituanhr.ods_jituanhr_report_t_sys_hr_user  where day = '2019-11-18') 
S  on S.workno = R.fnumber;

-- -- 根据订单“采购员”，查找对应的BG
-- select A.FPurchasePersonID,B.fnumber,B.fname_l1,c.companyname from eas.ods_eas_new_eas75_t_im_purinwarehsentry B
select DISTINCT (C.companyname) from eas.ods_eas_new_eas75_t_im_purinwarehsentry B
left join eas.ods_eas_new_eas75_t_bd_person A  on  B.FPurchasePersonID = A.fid 
left join (select * from jituanhr.ods_jituanhr_report_t_sys_hr_user  where day = '2019-11-18') C  on C.workno = A.fnumber 
where c.companyname = '冲压BG';

select B.fprice,B.ftaxprice,H.fbenchmarkprice
from eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C on C.fid = B.fmaterialid left join
eas.ods_eas_new_eas75_ct_ls_match H on H.CFMaterielNumID = C.fid 
;
select distinct(N.FDescription) from (
select  B.fpurorderNumber,D.FDescription from eas.ods_eas_new_eas75_t_im_purinwarehsentry B inner join
eas.ods_eas_new_eas75_t_sm_purorder C on C.fnumber = B.fpurorderNumber inner JOIN
eas.ods_eas_new_eas75_t_sm_purorderentry E on E.fparentid = C.fid inner JOIN
eas.ods_eas_new_eas75_t_sm_purrequest D on E.fsourcebillnumber = D.fnumber
) N ;
select * from eas.ods_eas_new_eas75_t_sm_purorder A inner join eas.ods_eas_new_eas75_t_sm_purorderentry B on A.fid = B.fparentid;
select distinct(account_day) from dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month;
select fnumber from eas.ods_eas_new_eas75_t_org_company;
select distinct(Fcountry) from eas.ods_eas_new_eas75_ct_ls_match ;
select distinct(fclassify) from eas.ods_eas_new_eas75_ct_ls_match ;
select distinct(FBenchmarkPrice) from eas.ods_eas_new_eas75_ct_ls_match ;
select fnumber,fname_l2 from  eas.ods_eas_new_eas75_t_bd_materialgroup;
select  FMaterialGroupID from eas.ods_eas_new_eas75_t_bd_material;
select PEINH, EKORG ,EKGRP,MATKL,WGBEZ from saptest.ods_sap_zmmr008_show;
select FSupplierID,FAuditTime,FBizDate,FCreateTime from eas.ods_eas_new_eas75_t_im_purinwarehsbill;
select FUnitID,FBaseUnitID,cfoutsupplierno from eas.ods_eas_new_eas75_t_im_purinwarehsentry;
select DISTINCT(material_name) from dwservice.dws_cd_by_material_cut_price_month;


select 
select * from  dwservice.dws_cd_by_material_type_month where material_type = '半成品' and `date`  BETWEEN '2019-01' and '2019-12' and dim = '1'


-- 生成公司 -material middle表
select distinct(company_name) from dwmiddle.dwm_eas_material_company_no_standard_by_cd ;

insert overwrite table dwmiddle.dwm_eas_material_company_no_standard_by_cd partition(day='2019-11-25')
select C.fnumber as material_code,
case SUBSTRING(TRIM(C.fnumber),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim,
A.fyear as `year` ,A.fperiod as `month`,A.fmonth as `date`,
A.FSupplierID as supplier_id,
B.fprice,B.famount,B.fqty,D.fnumber as company_id, D.fname_l2 as company_name
 from  eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join 
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C  on C.fid = B.fmaterialid left join 
eas.ods_eas_new_eas75_t_org_company D on D.fid = B.FCompanyOrgUnitID left join 
eas.ods_eas_new_eas75_t_org_company_area_relation2 E on E.company_fid = D.fid;


insert overwrite table dwmiddle.dwm_eas_company_material_cd_by_month2 partition(day='2019-11-25')
select A.material_code,A.dim,A.`year`,A.`month`,A.`date`,A.supplier_code,A.price,B.price as standard_price,
A.amount,A.quantity,A.company_id,A.company_name
from dwmiddle.dwm_eas_material_company_no_standard_by_cd A 
left join dwmiddle.dwm_eas_material_company_no_standard_by_cd B
on  A.material_code = B.material_code and A.`year` -1  = B.`year` and B.`month` = 12 
-- )Cwhere C.dim = '2' and C.material_code = '680-AEX773-A0-0-02';

-- -- 按年和月，合并重复的material，amount，price，等 ，且添加supplier——name
insert overwrite table dwmiddle.dwm_eas_material_company_distinct_cd_by_month2 partition(day='2019-11-25') 
select  material_code,dim,`year`,`month`,`date`,sum(price)/count(1) as price,
sum(standard_price)/count(1) as standard_price ,
sum(amount) as amount,sum(quantity) as quantity,company_id,company_name
from dwmiddle.dwm_eas_company_material_cd_by_month2 group by company_id,company_name,material_code,dim,`year`,`month`,`date`;


--- -- -- - --  - 区域, 公司  的CD金额。
insert overwrite table dwservice.DWS_CD_BY_AREA_DAY_MONTH partition(day='2019-11-25')
select W.area,W.company_name, sum(W.cd_amount) as cd_amount,( if (cast(sum(W.cd_amount)/sum(W.amount) as string) is null ,0, sum(W.cd_amount)/sum(W.amount))) as cd_proportion ,sum(W.amount) as amount,'10'as dim,W.`year`,W.`month`,W.`date`
from (select A.area,A.company_name, sum(A.cd_amount) as cd_amount,( if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount))) as cd_proportion ,sum(A.amount) as amount,dim,`year`,`month`,`date`
from (select E.area as area, A.company_name as company_name,A.dim,A.amount,A.standard_price,A.price,A.quantity,(A.standard_price-A.price)*A.quantity as cd_amount
,A.`year`,A.`month`,if(length(A.`month`)=1 ,CONCAT_WS('-0', A.`year`, A.`month`),CONCAT_WS('-', A.`year`, A.`month`)  )as `date`  from dwmiddle.dwm_eas_material_company_distinct_cd_by_month2 A
left join eas.ods_eas_new_eas75_t_org_company D on D.fnumber = A.company_id
left join eas.ods_eas_new_eas75_t_org_company_area_relation2 E on E.company_fid = D.fid
)  A group by area,company_name,dim,`year`,`month`,`date`  
union ALL
select  C.area, C.company_name , sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select '华南' as area, bu_factory_area as company_name ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.area,C.company_name, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.area,D.company_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select E.area as area ,C.butxt as company_name, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,'' as account_day,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A 
left join saptest.ods_sap_zbigdata_md_t001w B on A.werks = B.werks
left join saptest.ods_sap_zbigdata_md_t001 C on A.bukrs = C.bukrs 
left join saptest.ods_sap_company_area_relation E on E.company_fid = A.bukrs
) D group by  D.area,D.company_name,D.dim,D.`year`,D.`month`,D.`date`
) W group by  W.area,W.company_name,W.`year`,W.`month`,W.`date`
UNION ALL
 select A.area,A.company_name, sum(A.cd_amount) as cd_amount,( if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount))) as cd_proportion ,sum(A.amount) as amount,dim,`year`,`month`,`date`
from (select E.area as area, A.company_name as company_name,A.dim,A.amount,A.standard_price,A.price,A.quantity,(A.standard_price-A.price)*A.quantity as cd_amount
,A.`year`,A.`month`,if(length(A.`month`)=1 ,CONCAT_WS('-0', A.`year`, A.`month`),CONCAT_WS('-', A.`year`, A.`month`)  )as `date`  from dwmiddle.dwm_eas_material_company_distinct_cd_by_month2 A
left join eas.ods_eas_new_eas75_t_org_company D on D.fnumber = A.company_id
left join eas.ods_eas_new_eas75_t_org_company_area_relation2 E on E.company_fid = D.fid
)  A group by area,company_name,dim,`year`,`month`,`date`  
union ALL
select  C.area, C.company_name , sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select '华南' as area, bu_factory_area as company_name ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by  C.area,C.company_name, C.dim,C.`year`,C.`month`,C.`date`
union all
select D.area,D.company_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select E.area as area ,B.name1 as industry_area,C.butxt as company_name, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,'' as account_day,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A 
left join saptest.ods_sap_zbigdata_md_t001w B on A.werks = B.werks
left join saptest.ods_sap_zbigdata_md_t001 C on A.bukrs = C.bukrs 
left join saptest.ods_sap_company_area_relation E on E.company_fid = A.bukrs
) D group by  D.area,D.company_name,D.dim,D.`year`,D.`month`,D.`date`;


CREATE EXTERNAL TABLE `dwservice.DWS_CD_BY_AREA_DAY_MONTH`(
  `area`  string COMMENT     '区域',
   `company_name`  string COMMENT     '公司名称',
  `cd_amount`  DECIMAL(28,16)  COMMENT     'cd金额',
  `cd_proportion`   DECIMAL(28,16) COMMENT     'CD比例',    
  `total_amount`   DECIMAL(28,16) COMMENT     '总金额',
  `dim` string COMMENT '维度', 
  `year` string COMMENT '年份', 
  `month` string COMMENT '月份', 
  `date` string COMMENT '日期（年月）')
COMMENT '账期天数名称 cd-by月基础表(去重复)'
PARTITIONED BY ( 
  `day` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\t' 
STORED AS orc
tblproperties('orc.compression' = 'snappy');

ALTER table dwbase.dwb_yifei_display_module drop partition (day='2019-11-24')
select distinct(bu_factory_area) from dwbase.dwb_yifei_display_module;

select purchaser,`year`,sum(cd_amount) as cd_total_amount from dwservice.dws_cd_by_purchaser_month 
group by purchaser,`year`;

-- 采购员新增  按年的cd金额，cd比例，总金额
insert overwrite table dwservice.dws_cd_by_purchaser_month_year partition(day='2019-11-25')
SELECT A.purchaser, A.cd_amount,B.cd_amount_year, A.cd_proportion,
B.cd_amount_year/B.total_amount_year  as cd_proportion_year,
A.total_amount,B.total_amount_year, 
A.dim, A.`year`, A.`month`, A.`date`from dwservice.dws_cd_by_purchaser_month  A
left join (select purchaser,`year`,sum(cd_amount) as cd_amount_year,sum(total_amount) as total_amount_year
from dwservice.dws_cd_by_purchaser_month group by purchaser,`year`) B 
on A.purchaser = B.purchaser and A.`year` = B.`year`;


CREATE EXTERNAL TABLE `dwservice.dws_cd_by_purchaser_month_year`(
  `purchaser` string COMMENT '采购员名称', 
  `cd_amount` decimal(28,16) COMMENT 'cd金额', 
  `cd_amount_year` decimal(28,16) COMMENT 'cd金额（按年求和值）',  
  `cd_proportion` decimal(28,16) COMMENT 'CD比例', 
  `cd_proportion_year` decimal(28,16) COMMENT 'CD比例（按年求和值）', 
  `total_amount` decimal(28,16) COMMENT '总金额', 
  `total_amount_year` decimal(28,16) COMMENT '总金额（按年求和值）', 
  `dim` string COMMENT '维度', 
  `year` string COMMENT '年份', 
  `month` string COMMENT '月份', 
  `date` string COMMENT '日期（年月）')
COMMENT '采购员 cd-by 按年和月统计CD金额)'
PARTITIONED BY ( 
  `day` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\t' 
STORED AS orc
tblproperties('orc.compression' = 'snappy');

select * from dwservice.dws_cd_by_purchaser_month where purchaser = '付明香' and `year` = '2015';
select LGORT from saptest.ods_sap_zdmmr027_show



CREATE EXTERNAL TABLE IF NOT EXISTS dwbase.dwb_purchase_eas_combine(
po_number string COMMENT     '订单编号[eas]/采购单号[sap]',
stock_number string  COMMENT     '入库单号',
material_code string COMMENT     '物料编码[eas]/(品号/物料编号)[sap]',
material_8code string COMMENT     '物料8码',
material_name string COMMENT     '物料名称',
material_describe string COMMENT     '物料描述',
material_model string COMMENT     '物料规格',
material_group_code string COMMENT     '物料组编码(sap)',
material_group_describe string COMMENT     '物料组描述(sap)',
supplier_code string COMMENT     '供应商编码',
supplier_name string COMMENT     '供应商名称',
supplier_simple_name string COMMENT     '供应商简称',
out_supp_material_code	string COMMENT     '外部供应商物料编码',
purchase_group_code  string COMMENT     '采购组编码[sap/eas]',  
purchase_org_code  string COMMENT     '采购组织编码[sap/eas]',  
stock_org_number string COMMENT     '库存组织编码', 
stock_org_name string COMMENT     '库存组织名称',
stock_in_audit_time string COMMENT     '入库审核时间',
stock_in_time   string COMMENT     '入库时间(验收/退货日)[yifei]/sap', 
document_date   string COMMENT     '凭证日期[sap]', 
order_date   string COMMENT     '订单日期', 
delivery_date   string COMMENT     '交货日期',   -- 采购订单分录上的交货日期
stock_goods_describe  string COMMENT     '存货描述[sap]',
secondary_level   string COMMENT   '二级分类', 
third_level   string COMMENT     '三级分类', 
project_id	string COMMENT     '项目号/采购订单号行项目号[sap]',
voucher_project_code string COMMENT     '物料凭证中的项目编码[sap]',
material_type string COMMENT     '物料类型',
origin_firm string COMMENT     '原厂商',
currency string COMMENT     '币别',
currency_name string COMMENT     '币别名称',
quantity DECIMAL(28,16) COMMENT     '收货数量（本次收货数量）/[sap]入库数量',
unit_number string COMMENT     '单位编码（采购）',-- 关联(T_IM_PurInWarehsEntry.FBaseUnitID= T_BD_MeasureUnit.fid)，取fnumber,fname_l2
unit string COMMENT     '单位（采购）', -- 关联(T_IM_PurInWarehsEntry.FBaseUnitID= T_BD_MeasureUnit.fid)，取fnumber,fname_l2
price_unit string COMMENT     '价格单位',
exchange_rate DECIMAL(28,16) COMMENT     '汇率',
tax_rate DECIMAL(28,16) COMMENT     '税率',
tax_code string COMMENT     '税码[sap]',
pay_day string COMMENT     '付款天数',
price DECIMAL(28,16) COMMENT     '不含税单价[eas]/BC未税单价[yifei]',
usd_price DECIMAL(28,16) COMMENT     '不含税usd单价/美金单价[yifei]',
tax_price DECIMAL(28,16) COMMENT     '含税单价[eas/sap]/BC含税单价[yifei]',
cur_amount DECIMAL(28,16) COMMENT     '本位币收货金额（未税）[eas]/本位币税前金额[yifei]',
tax_amount DECIMAL(28,16) COMMENT     '含税金额/价税合计',
tax_rmb_amount DECIMAL(28,16) COMMENT     '含税金额/价税合计（RMB）',
amount DECIMAL(28,16) COMMENT     '未税金额/本次收货金额',
start_price  DECIMAL(28,16) COMMENT     '起始价（未税）[sap]',
start_diff_price  DECIMAL(28,16) COMMENT     '起始价与当前价差异（未税）[sap]',

account_day  string COMMENT     '账期天数（供应商）', 
check_bechmark_price DECIMAL(28,16) COMMENT     '经管复核基准价',
check_bechmark_amount DECIMAL(28,16) COMMENT     '经管复核基准价金额',
check_CD_amount DECIMAL(28,16) COMMENT     '经管复核CD',
pic string COMMENT     '负责人',
docu_pic string COMMENT     '跟单负责人',
supp_po_code string COMMENT     '供应商订单编号',
prod_line string COMMENT     '产品线',  -- 对应采购申请单的摘要（采购申请单，怎么和采购入库单关联）
line_pic string COMMENT     '产品线负责人',
area  string COMMENT     '区域',     
factory_code  string COMMENT     '工厂代码', 
factory_area  string COMMENT     'BU/厂区/工厂描述', 
company_code  string COMMENT     '公司编码', 
company_name  string COMMENT     '公司名称/描述',      
branch_of_facoty  string COMMENT     '小厂/分厂',   
warehouse_name   string COMMENT     '仓库名称',		 
order_number  decimal(30,6) COMMENT     '订单数量[sap]',
check_return_code  string COMMENT     '验收/退货单号[yifei]',    
check_number   decimal(30,6) COMMENT     '验收数量[yifei]',
check_return_num   decimal(30,6) COMMENT     '验退数量[yifei]',
return_num  decimal(30,6) COMMENT     '退货数量/ 计价/退货数量[yifei]',
cur_tax   decimal(30,12) COMMENT     '本位币税额', 
delivery_warehouse   string COMMENT     '交货仓库[yifei]',
inventory_unit   string COMMENT     '库存单位[yifei]',
ori_cur_beftax_amount   DECIMAL(28,16) COMMENT     '原币税前金额[yifei]',
ori_cur_tax   DECIMAL(28,16) COMMENT     '原币税额[yifei]',
tax DECIMAL(28,16) COMMENT     '税额',
ori_cur_amount   DECIMAL(28,16) COMMENT     '原币金额[yifei]',
damage_num   DECIMAL(28,16) COMMENT     '破坏数量[yifei]', 
scrapped_num   DECIMAL(28,16) COMMENT     '报废数量[yifei]',
location_code   string COMMENT     '库位编号',
sales_unit   string COMMENT     '计价单位[yifei]',
appoint  string COMMENT     '是否指定[yifei]/是否客指[sap]',
ori_proxy  string COMMENT     '原厂/代理[yifei]',               
buyer  string COMMENT    '采购员[yifei/sap]',       
remarks  string COMMENT    '备注[yifei]',
dim  string COMMENT    '维度(1 CNC、2 冲压、3 模切、4 设备、5 组装、6 深圳结构件、7 东莞结构件、8 显示模组、9 磁材、10 汇总)', 
period	string COMMENT    '业务期间',	
`year`	string COMMENT    '业务年度',	
`month`  string COMMENT     '月份', 
`date` string COMMENT     '年月', 
data_sources string COMMENT '数据来源'
) COMMENT 'CD月报基础合并数据EAS'
PARTITIONED BY (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS orc
tblproperties('orc.compression' = 'snappy');


CREATE EXTERNAL TABLE IF NOT EXISTS dwmiddle.dwb_purchase_combine_mid1(
po_number string COMMENT     '订单编号[eas]/采购单号[sap]',
stock_number string  COMMENT     '入库单号',
material_code string COMMENT     '物料编码[eas]/(品号/物料编号)[sap]',
material_8code string COMMENT     '物料8码',
material_name string COMMENT     '物料名称',
material_describe string COMMENT     '物料描述',
material_model string COMMENT     '物料规格',
material_group_code string COMMENT     '物料组编码(sap)',
material_group_describe string COMMENT     '物料组描述(sap)',
supplier_code string COMMENT     '供应商编码',
supplier_name string COMMENT     '供应商名称',
supplier_simple_name string COMMENT     '供应商简称',
out_supp_material_code	string COMMENT     '外部供应商物料编码',
purchase_group_code  string COMMENT     '采购组编码[sap/eas]',  
purchase_org_code  string COMMENT     '采购组织编码[sap/eas]',  
stock_in_audit_time string COMMENT     '入库审核时间',
stock_in_time   string COMMENT     '入库时间(验收/退货日)[yifei]/sap', 
document_date   string COMMENT     '凭证日期[sap]', 
stock_goods_describe  string COMMENT     '存货描述[sap]',
secondary_level   string COMMENT   '二级分类', 
third_level   string COMMENT     '三级分类', 
project_id	string COMMENT     '项目号/采购订单号行项目号[sap]',
voucher_project_code string COMMENT     '物料凭证中的项目编码[sap]',
material_type string COMMENT     '物料类型',
quantity DECIMAL(28,16) COMMENT     '收货数量（本次收货数量）/[sap]入库数量',
price_unit string COMMENT     '价格单位',
exchange_rate DECIMAL(28,16) COMMENT     '汇率',
tax_rate DECIMAL(28,16) COMMENT     '税率',
tax_code string COMMENT     '税码[sap]',
price DECIMAL(28,16) COMMENT     '不含税单价[eas]/BC未税单价[yifei]',
usd_price DECIMAL(28,16) COMMENT     '不含税usd单价/美金单价[yifei]',
tax_price DECIMAL(28,16) COMMENT     '含税单价[eas/sap]/BC含税单价[yifei]',
cur_amount DECIMAL(28,16) COMMENT     '本位币收货金额（未税）[eas]/本位币税前金额[yifei]',
tax_amount DECIMAL(28,16) COMMENT     '含税金额/价税合计',
tax_rmb_amount DECIMAL(28,16) COMMENT     '含税金额/价税合计（RMB）',
amount DECIMAL(28,16) COMMENT     '未税金额/本次收货金额',
start_price  DECIMAL(28,16) COMMENT     '起始价（未税）[sap]',
start_diff_price  DECIMAL(28,16) COMMENT     '起始价与当前价差异（未税）[sap]',
check_bechmark_price DECIMAL(28,16) COMMENT     '经管复核基准价',
check_bechmark_amount DECIMAL(28,16) COMMENT     '经管复核基准价金额',
check_CD_amount DECIMAL(28,16) COMMENT     '经管复核CD',
pic string COMMENT     '负责人',
docu_pic string COMMENT     '跟单负责人',
supp_po_code string COMMENT     '供应商订单编号',
line_pic string COMMENT     '产品线负责人',
area  string COMMENT     '区域',     
factory_code  string COMMENT     '工厂代码', 
factory_area  string COMMENT     'BU/厂区/工厂描述', 
branch_of_facoty  string COMMENT     '小厂/分厂', 
order_number  decimal(30,6) COMMENT     '订单数量[sap]',
check_return_code  string COMMENT     '验收/退货单号[yifei]',    
check_number   decimal(30,6) COMMENT     '验收数量[yifei]',
check_return_num   decimal(30,6) COMMENT     '验退数量[yifei]',
return_num  decimal(30,6) COMMENT     '退货数量/ 计价/退货数量[yifei]',
cur_tax   decimal(30,12) COMMENT     '本位币税额', 
inventory_unit   string COMMENT     '库存单位[yifei]',
ori_cur_beftax_amount   DECIMAL(28,16) COMMENT     '原币税前金额[yifei]',
ori_cur_tax   DECIMAL(28,16) COMMENT     '原币税额[yifei]',
tax DECIMAL(28,16) COMMENT     '税额',
ori_cur_amount   DECIMAL(28,16) COMMENT     '原币金额[yifei]',
damage_num   DECIMAL(28,16) COMMENT     '破坏数量[yifei]', 
scrapped_num   DECIMAL(28,16) COMMENT     '报废数量[yifei]',
location_code   string COMMENT     '库位编号',
sales_unit   string COMMENT     '计价单位[yifei]',
appoint  string COMMENT     '是否指定[yifei]/是否客指[sap]',
ori_proxy  string COMMENT     '原厂/代理[yifei]',               
buyer  string COMMENT    '采购员[yifei/sap]',       
remarks  string COMMENT    '备注[yifei]',
dim  string COMMENT    '维度(1 CNC、2 冲压、3 模切、4 设备、5 组装、6 深圳结构件、7 东莞结构件、8 显示模组、9 磁材、10 汇总)', 
period	string COMMENT    '业务期间',	
`year`	string COMMENT    '业务年度',	
`month`  string COMMENT     '月份', 
`date` string COMMENT     '年月', 
data_sources string COMMENT '数据来源',
stock_org_number string COMMENT     '库存组织编码', 
stock_org_name string COMMENT     '库存组织名称',
unit_number string COMMENT     '单位编码（采购）',
unit string COMMENT     '单位（采购）', 
warehouse_name   string COMMENT     '仓库名称',	
delivery_warehouse   string COMMENT     '交货仓库[yifei]',
company_code  string COMMENT     '公司编码', 
company_name  string COMMENT     '公司名称/描述',   
fpurorderNumber string COMMENT     '关联字段（ods_eas_new_eas75_t_im_purinwarehsentry）',   
material_fid  string COMMENT     '关联字段（ods_eas_new_eas75_t_bd_material）',   
FCurrencyID  string COMMENT     '关联字段（ods_eas_new_eas75_t_im_purinwarehsbill）',   
supplier_fid string COMMENT     '关联字段（ods_eas_new_eas75_t_bd_supplier）'
) COMMENT 'CD月报基础合并数据  中间表'
PARTITIONED BY (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS orc
tblproperties('orc.compression' = 'snappy');



CREATE EXTERNAL TABLE IF NOT EXISTS dwmiddle.dwb_purchase_combine_mid2(
po_number string COMMENT     '订单编号[eas]/采购单号[sap]',
stock_number string  COMMENT     '入库单号',
material_code string COMMENT     '物料编码[eas]/(品号/物料编号)[sap]',
material_8code string COMMENT     '物料8码',
material_name string COMMENT     '物料名称',
material_describe string COMMENT     '物料描述',
material_model string COMMENT     '物料规格',
material_group_code string COMMENT     '物料组编码(sap)',
material_group_describe string COMMENT     '物料组描述(sap)',
supplier_code string COMMENT     '供应商编码',
supplier_name string COMMENT     '供应商名称',
supplier_simple_name string COMMENT     '供应商简称',
out_supp_material_code	string COMMENT     '外部供应商物料编码',
purchase_group_code  string COMMENT     '采购组编码[sap/eas]',  
purchase_org_code  string COMMENT     '采购组织编码[sap/eas]',  
stock_in_audit_time string COMMENT     '入库审核时间',
stock_in_time   string COMMENT     '入库时间(验收/退货日)[yifei]/sap', 
document_date   string COMMENT     '凭证日期[sap]', 
stock_goods_describe  string COMMENT     '存货描述[sap]',
secondary_level   string COMMENT   '二级分类', 
third_level   string COMMENT     '三级分类', 
project_id	string COMMENT     '项目号/采购订单号行项目号[sap]',
voucher_project_code string COMMENT     '物料凭证中的项目编码[sap]',
material_type string COMMENT     '物料类型',
quantity DECIMAL(28,16) COMMENT     '收货数量（本次收货数量）/[sap]入库数量',
price_unit string COMMENT     '价格单位',
exchange_rate DECIMAL(28,16) COMMENT     '汇率',
tax_rate DECIMAL(28,16) COMMENT     '税率',
tax_code string COMMENT     '税码[sap]',
price DECIMAL(28,16) COMMENT     '不含税单价[eas]/BC未税单价[yifei]',
usd_price DECIMAL(28,16) COMMENT     '不含税usd单价/美金单价[yifei]',
tax_price DECIMAL(28,16) COMMENT     '含税单价[eas/sap]/BC含税单价[yifei]',
cur_amount DECIMAL(28,16) COMMENT     '本位币收货金额（未税）[eas]/本位币税前金额[yifei]',
tax_amount DECIMAL(28,16) COMMENT     '含税金额/价税合计',
tax_rmb_amount DECIMAL(28,16) COMMENT     '含税金额/价税合计（RMB）',
amount DECIMAL(28,16) COMMENT     '未税金额/本次收货金额',
start_price  DECIMAL(28,16) COMMENT     '起始价（未税）[sap]',
start_diff_price  DECIMAL(28,16) COMMENT     '起始价与当前价差异（未税）[sap]',
check_bechmark_price DECIMAL(28,16) COMMENT     '经管复核基准价',
check_bechmark_amount DECIMAL(28,16) COMMENT     '经管复核基准价金额',
check_CD_amount DECIMAL(28,16) COMMENT     '经管复核CD',
pic string COMMENT     '负责人',
docu_pic string COMMENT     '跟单负责人',
supp_po_code string COMMENT     '供应商订单编号',
line_pic string COMMENT     '产品线负责人',
area  string COMMENT     '区域',     
factory_code  string COMMENT     '工厂代码', 
factory_area  string COMMENT     'BU/厂区/工厂描述', 
branch_of_facoty  string COMMENT     '小厂/分厂', 
order_number  decimal(30,6) COMMENT     '订单数量[sap]',
check_return_code  string COMMENT     '验收/退货单号[yifei]',    
check_number   decimal(30,6) COMMENT     '验收数量[yifei]',
check_return_num   decimal(30,6) COMMENT     '验退数量[yifei]',
return_num  decimal(30,6) COMMENT     '退货数量/ 计价/退货数量[yifei]',
cur_tax   decimal(30,12) COMMENT     '本位币税额', 
inventory_unit   string COMMENT     '库存单位[yifei]',
ori_cur_beftax_amount   DECIMAL(28,16) COMMENT     '原币税前金额[yifei]',
ori_cur_tax   DECIMAL(28,16) COMMENT     '原币税额[yifei]',
tax DECIMAL(28,16) COMMENT     '税额',
ori_cur_amount   DECIMAL(28,16) COMMENT     '原币金额[yifei]',
damage_num   DECIMAL(28,16) COMMENT     '破坏数量[yifei]', 
scrapped_num   DECIMAL(28,16) COMMENT     '报废数量[yifei]',
location_code   string COMMENT     '库位编号',
sales_unit   string COMMENT     '计价单位[yifei]',
appoint  string COMMENT     '是否指定[yifei]/是否客指[sap]',
ori_proxy  string COMMENT     '原厂/代理[yifei]',               
buyer  string COMMENT    '采购员[yifei/sap]',       
remarks  string COMMENT    '备注[yifei]',
dim  string COMMENT    '维度(1 CNC、2 冲压、3 模切、4 设备、5 组装、6 深圳结构件、7 东莞结构件、8 显示模组、9 磁材、10 汇总)', 
period	string COMMENT    '业务期间',	
`year`	string COMMENT    '业务年度',	
`month`  string COMMENT     '月份', 
`date` string COMMENT     '年月', 
data_sources string COMMENT '数据来源',
stock_org_number string COMMENT     '库存组织编码', 
stock_org_name string COMMENT     '库存组织名称',
unit_number string COMMENT     '单位编码（采购）',
unit string COMMENT     '单位（采购）', 
warehouse_name   string COMMENT     '仓库名称',	
delivery_warehouse   string COMMENT     '交货仓库[yifei]',
company_code  string COMMENT     '公司编码', 
company_name  string COMMENT     '公司名称/描述',   
order_date string COMMENT     '订单日期',   
origin_firm string COMMENT     '原厂商',  
currency string COMMENT     '币别',  
currency_name string COMMENT     '币别名称',  
pay_day string COMMENT     '付款天数',  
account_day string COMMENT     '账期天数（供应商）',  
purorder_fid string COMMENT     'purorder_fid'
) COMMENT 'CD月报基础合并数据  中间表'
PARTITIONED BY (day string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS orc
tblproperties('orc.compression' = 'snappy');

select count(distinct(material_code)) from  dwmiddle.dwb_purchase_combine_mid1 ;



--------------------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------------------- 
-- 												step开始前准备
						-- step1  生成部分字段 mid1
insert overwrite table  dwmiddle.dwb_purchase_combine_mid1 partition(day='2019-12-03')
select B.fpurorderNumber as po_number,A.fnumber as stock_number,C.FNumber as material_code,
if(SUBSTRING(C.FNumber,instr(C.FNumber,'-')+1,8) is null or
SUBSTRING(C.FNumber,instr(C.FNumber,'-')+1,8) = '',C.FNumber,
SUBSTRING(C.FNumber,instr(C.FNumber,'-')+1,8)) as material_8code,
COALESCE(C.fname_l2, C.fname_l1, C.fname_l3) as material_name,
COALESCE(C.fdescription_l2,C.fdescription_l1,C.fdescription_l3) as material_describe,
C.FModel as material_model,'' as material_group_code,'' as material_group_describe,
E.fnumber as supplier_code,COALESCE(E.fname_l2,E.fname_l1,E.fname_l3) as supplier_name,
E.FSimpleName as supplier_simple_name,B.cfoutsupplierno as out_supp_material_code,
B.FPurchaseGroupID as purchase_group_code,B.FPurchaseOrgUnitID as purchase_org_code,
A.FAuditTime as stock_in_audit_time,A.FBizDate as stock_in_time,'' as document_date,'' as stock_goods_describe,
D.fname_l2 as secondary_level,'' as third_level,
B.FProjectID as project_id,'' as voucher_project_code, D.fname_l2 as material_type,
B.FQty as quantity,'' as price_unit,
A.FExchangeRate as exchange_rate,B.FTaxRate as tax_rate,'' as tax_code,
B.FPrice as price,'' as usd_price,
B.FTaxPrice as tax_price,B.FLocalAmount as cur_amount,B.FTaxAmount as tax_amount,
B.FTaxAmount as tax_rmb_amount,B.FAmount as amount,'' as start_price,'' as start_diff_price,
'' as check_bechmark_price,'' as check_bechmark_amount,'' as check_CD_amount,
B.FPurchasePersonID as pic,B.FPurchasePersonID as docu_pic,'' as supp_po_code,
'' as line_pic,M.area as area,'' as factory_code,'' as factory_area,'' as branch_of_facoty,
'' as order_number, '' as check_return_code,
'' as check_number,B.FReturnsQty as check_return_num,B.FReturnsQty as return_num,B.FLocalTax as cur_tax,
'' as inventory_unit,
'' as ori_cur_beftax_amount,'' as ori_cur_tax,B.FTax as tax,'' as ori_cur_amount,
'' as damage_num,'' as scrapped_num,'' as location_code,'' as sales_unit,
'' as appoint,'' as ori_proxy,B.FPurchasePersonID as buyer,B.FRemark as remarks,
case SUBSTRING(TRIM(C.fnumber),0,3)
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim,
A.FPeriod as period,A.FYear,A.fperiod,A.fmonth ,
'eas' as data_sources,
F.fnumber as stock_org_number,COALESCE(F.fname_l2,F.fname_l1,F.fname_l3) as stock_org_name,
O.fnumber as unit_number,O.fname_l2 as unit, N.fname_l2 as warehouse_name,
N.fname_l2 as delivery_warehouse,L.fnumber as company_code, L.fname_l2 as company_name,
B.fpurorderNumber,C.fid,A.FCurrencyID,E.fid
from eas.ods_eas_new_eas75_t_im_purinwarehsbill A inner join
eas.ods_eas_new_eas75_t_im_purinwarehsentry B  on A.fid = B.fparentid inner join
eas.ods_eas_new_eas75_t_bd_material C on C.fid = B.fmaterialid left join
eas.ods_eas_new_eas75_t_bd_materialgroup D on D.fid = C.FMaterialGroupID left join
eas.ods_eas_new_eas75_t_bd_supplier E on E.fid = A.FSupplierID left join
eas.ods_eas_new_eas75_t_org_storage F on F.fid = B.FStorageOrgUnitID left join
eas.ods_eas_new_eas75_t_org_company L on L.fid = B.FCompanyOrgUnitID left join
eas.ods_eas_new_eas75_t_org_company_area_relation2 M on M.company_fid = L.fid left join
eas.ods_eas_new_eas75_t_db_warehouse N on  B.FWarehouseID = N.fid left join
eas.ods_eas_new_eas75_t_bd_measureunit O on O.fid = B.FBaseUnitID

/**
-- step2  生成部分字段 mid2[pedding 。。。。] （因为表ods_eas_new_eas75_t_sm_purorder 数据过大）
insert overwrite table dwmiddle.dwb_purchase_combine_mid2 partition(day="2019-12-03")
SELECT
        mid1.po_number,
        mid1.stock_number,
        mid1.material_code,
        mid1.material_8code,
        mid1.material_name,
        mid1.material_describe,
        mid1.material_model,
        mid1.material_group_code,
        mid1.material_group_describe,
        mid1.supplier_code,
        mid1.supplier_name,
        mid1.supplier_simple_name,
        mid1.out_supp_material_code,
        mid1.purchase_group_code,
        mid1.purchase_org_code,
        mid1.stock_in_audit_time,
        mid1.stock_in_time,
        mid1.document_date,
        mid1.stock_goods_describe,
        mid1.secondary_level,
        mid1.third_level,
        mid1.project_id,
        mid1.voucher_project_code,
        mid1.material_type,
        mid1.quantity,
        mid1.price_unit,
        mid1.exchange_rate,
        mid1.tax_rate,
        mid1.tax_code,
        mid1.price,
        mid1.usd_price,
        mid1.tax_price,
        mid1.cur_amount,
        mid1.tax_amount,
        mid1.tax_rmb_amount,
        mid1.amount,
        mid1.start_price,
        mid1.start_diff_price,
        mid1.check_bechmark_price,
        mid1.check_bechmark_amount,
        mid1.check_cd_amount,
        mid1.pic,
        mid1.docu_pic,
        mid1.supp_po_code,
        mid1.line_pic,
        mid1.area,
        mid1.factory_code,
        mid1.factory_area,
        mid1.branch_of_facoty,
        mid1.order_number,
        mid1.check_return_code,
        mid1.check_number,
        mid1.check_return_num,
        mid1.return_num,
        mid1.cur_tax,
        mid1.inventory_unit,
        mid1.ori_cur_beftax_amount,
        mid1.ori_cur_tax,
        mid1.tax,
        mid1.ori_cur_amount,
        mid1.damage_num,
        mid1.scrapped_num,
        mid1.location_code,
        mid1.sales_unit,
        mid1.appoint,
        mid1.ori_proxy,
        mid1.buyer,
        mid1.remarks,
        mid1.dim,
        mid1.period,
        mid1.`year`,
        mid1.`month`,
        mid1.`date`,
        mid1.data_sources,
        mid1.stock_org_number,
        mid1.stock_org_name,
        mid1.unit_number,
        mid1.unit,
        mid1.warehouse_name,
        mid1.delivery_warehouse,
        mid1.company_code,
        mid1.company_name,
        G.FBizDate AS order_date,
        H.Fcountry AS origin_firm,
        I.fnumber AS currency,
        I.fname_l2 AS currency_name,
        K.fstartdeferdays AS pay_day,
        K.fstartdeferdays AS account_day,
        G.fid as purorder_fid
FROM
        dwmiddle.dwb_purchase_combine_mid1 mid1
        LEFT JOIN eas.ods_eas_new_eas75_t_sm_purorder G ON G.fnumber = mid1.fpurorderNumber
        LEFT JOIN eas.ods_eas_new_eas75_ct_ls_match H ON H.CFMaterielNumID = mid1.material_fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_currency I ON mid1.FCurrencyID = I.fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo J ON J.fsupplierid = mid1.supplier_fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_payconditionentry K ON K.fparentid = J.fpayconditionid
--' >  combine_eas_mid2.log
*/
						
												
												-- step开始 --
------------------------------------------------------------------------------------------------------------------------------------
--  step1（上接step3） 生成部分报表数据 ，以及去除重复的数据 【 mid1 关联一部分表生成  dwb_purchase_combine_mid_report_eas（报表基本数据【未去重】）】
/**
--  step1 生成部分报表数据 ，以及去除重复的数据  【old】
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas partition(day="2019-12-03")
SELECT
        mid1.po_number,
        mid1.stock_number,
        mid1.material_code,
        mid1.material_8code,
        mid1.material_name,
        mid1.material_describe,
        mid1.material_model,
        mid1.material_group_code,
        mid1.material_group_describe,
        mid1.supplier_code,
        mid1.supplier_name,
        mid1.supplier_simple_name,
        mid1.out_supp_material_code,
        mid1.purchase_group_code,
        mid1.purchase_org_code,
        mid1.stock_in_audit_time,
        mid1.stock_in_time,
        mid1.document_date,
        mid1.stock_goods_describe,
        mid1.secondary_level,
        mid1.third_level,
        mid1.project_id,
        mid1.voucher_project_code,
        mid1.material_type,
        mid1.quantity,
        mid1.price_unit,
        mid1.exchange_rate,
        mid1.tax_rate,
        mid1.tax_code,
        mid1.price,
        mid1.usd_price,
        mid1.tax_price,
        mid1.cur_amount,
        mid1.tax_amount,
        mid1.tax_rmb_amount,
        mid1.amount,
        mid1.start_price,
        mid1.start_diff_price,
        mid1.check_bechmark_price,
        mid1.check_bechmark_amount,
        mid1.check_cd_amount,
        mid1.pic,
        mid1.docu_pic,
        mid1.supp_po_code,
        mid1.line_pic,
        mid1.area,
        mid1.factory_code,
        mid1.factory_area,
        mid1.branch_of_facoty,
        mid1.order_number,
        mid1.check_return_code,
        mid1.check_number,
        mid1.check_return_num,
        mid1.return_num,
        mid1.cur_tax,
        mid1.inventory_unit,
        mid1.ori_cur_beftax_amount,
        mid1.ori_cur_tax,
        mid1.tax,
        mid1.ori_cur_amount,
        mid1.damage_num,
        mid1.scrapped_num,
        mid1.location_code,
        mid1.sales_unit,
        mid1.appoint,
        mid1.ori_proxy,
        mid1.buyer,
        mid1.remarks,
        mid1.dim,
        mid1.period,
        mid1.`year`,
        mid1.`month`,
        mid1.`date`,
        mid1.data_sources,
        mid1.stock_org_number,
        mid1.stock_org_name,
        mid1.unit_number,
        mid1.unit,
        mid1.warehouse_name,
        mid1.delivery_warehouse,
        mid1.company_code,
        mid1.company_name,
        I.fnumber AS currency,
        I.fname_l2 AS currency_name,
        K.fstartdeferdays AS pay_day,
        K.fstartdeferdays AS account_day
       -- ,L.fname_l2 AS pay_type
FROM
        dwmiddle.dwb_purchase_combine_mid1 mid1
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_currency I ON mid1.FCurrencyID = I.fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo J ON J.fsupplierid = mid1.supplier_fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_payconditionentry K ON K.fparentid = J.fpayconditionid;
       -- 添加付款方式
       -- LEFT JOIN eas.eas.ods_eas_new_eas75_t_bd_settlementtype L ON L.out_put_filefid = J.fsettlementtypeid;
    
       
      --  step1.1 -- 去重
     insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct partition(day="2019-12-03")
select area,factory_code,factory_area,stock_org_number,stock_org_name,`date` ,stock_in_audit_time,secondary_level,third_level,
po_number,supplier_code,supplier_name,supplier_simple_name,material_code,material_8code,material_name,material_model,quantity,
unit,currency,currency_name,tax_price,tax_rate,
exchange_rate,price,tax_amount,amount,account_day,material_type,buyer,company_code,company_name,
docu_pic,remarks from dwmiddle.dwb_purchase_combine_mid_report_eas where day="2019-12-03"
group by area,factory_code,factory_area,stock_org_number,stock_org_name,`date` ,stock_in_audit_time,secondary_level,third_level,
po_number,supplier_code,supplier_name,supplier_simple_name,material_code,material_8code,material_name,material_model,quantity,
unit,currency,currency_name,tax_price,tax_rate,
exchange_rate,price,tax_amount,amount,account_day,material_type,buyer,company_code,company_name,
docu_pic,remarks;

  **/     
       
--  step1  -、生成部分报表数据 ，以及去除重复的数据  【new】   ---、   添加付款条件
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas2 partition(day="2019-12-16")
SELECT
        mid1.po_number,
        mid1.stock_number,
        mid1.material_code,
        mid1.material_8code,
        mid1.material_name,
        mid1.material_describe,
        mid1.material_model,
        mid1.material_group_code,
        mid1.material_group_describe,
        mid1.supplier_code,
        mid1.supplier_name,
        mid1.supplier_simple_name,
        mid1.out_supp_material_code,
        mid1.purchase_group_code,
        mid1.purchase_org_code,
        mid1.stock_in_audit_time,
        mid1.stock_in_time,
        mid1.document_date,
        mid1.stock_goods_describe,
        mid1.secondary_level,
        mid1.third_level,
        mid1.project_id,
        mid1.voucher_project_code,
        mid1.material_type,
        mid1.quantity,
        mid1.price_unit,
        mid1.exchange_rate,
        mid1.tax_rate,
        mid1.tax_code,
        mid1.price,
        mid1.usd_price,
        mid1.tax_price,
        mid1.cur_amount,
        mid1.tax_amount,
        mid1.tax_rmb_amount,
        mid1.amount,
        mid1.start_price,
        mid1.start_diff_price,
        mid1.check_bechmark_price,
        mid1.check_bechmark_amount,
        mid1.check_cd_amount,
        mid1.pic,
        mid1.docu_pic,
        mid1.supp_po_code,
        mid1.line_pic,
        mid1.area,
        mid1.factory_code,
        mid1.factory_area,
        mid1.branch_of_facoty,
        mid1.order_number,
        mid1.check_return_code,
        mid1.check_number,
        mid1.check_return_num,
        mid1.return_num,
        mid1.cur_tax,
        mid1.inventory_unit,
        mid1.ori_cur_beftax_amount,
        mid1.ori_cur_tax,
        mid1.tax,
        mid1.ori_cur_amount,
        mid1.damage_num,
        mid1.scrapped_num,
        mid1.location_code,
        mid1.sales_unit,
        mid1.appoint,
        mid1.ori_proxy,
        mid1.buyer,
        mid1.remarks,
        mid1.dim,
        mid1.period,
        mid1.`year`,
        mid1.`month`,
        mid1.`date`,
        mid1.data_sources,
        mid1.stock_org_number,
        mid1.stock_org_name,
        mid1.unit_number,
        mid1.unit,
        mid1.warehouse_name,
        mid1.delivery_warehouse,
        mid1.company_code,
        mid1.company_name,
        I.fnumber AS currency,
        I.fname_l2 AS currency_name,
        K.fstartdeferdays AS pay_day,
        K.fstartdeferdays AS account_day,
        L.fname_l2 AS pay_type
FROM
        dwmiddle.dwb_purchase_combine_mid1 mid1
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_currency I ON mid1.FCurrencyID = I.fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo J ON J.fsupplierid = mid1.supplier_fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_payconditionentry K ON K.fparentid = J.fpayconditionid
        LEFT JOIN eas.eas.ods_eas_new_eas75_t_bd_settlementtype L ON L.out_put_filefid = J.fsettlementtypeid;    
       
  
        --  step1.1 -- 去重  【新增付块类型】
     insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct2 partition(day="2019-12-16")
select area,factory_code,factory_area,stock_org_number,stock_org_name,`date` ,stock_in_audit_time,secondary_level,third_level,
po_number,supplier_code,supplier_name,supplier_simple_name,material_code,material_8code,material_name,material_model,quantity,
unit,currency,currency_name,tax_price,tax_rate,
exchange_rate,price,tax_amount,amount,account_day,material_type,buyer,company_code,company_name,
docu_pic,pay_type,remarks from dwmiddle.dwb_purchase_combine_mid_report_eas2 where day="2019-12-16"
group by area,factory_code,factory_area,stock_org_number,stock_org_name,`date` ,stock_in_audit_time,secondary_level,third_level,
po_number,supplier_code,supplier_name,supplier_simple_name,material_code,material_8code,material_name,material_model,quantity,
unit,currency,currency_name,tax_price,tax_rate,
exchange_rate,price,tax_amount,amount,account_day,material_type,buyer,company_code,company_name,
docu_pic,pay_type,remarks;

---------------------------------------------------------------------------------------------------

/**  【old 】【old 】【old 】【ol【old 】d 】【old 】【old 】【old 】【old 】
 * -- 查询  付款方式（计算类型）
  select distinct(fsettlementtypeid) from  eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo  where day='2019-12-16';
 *   添加供应商测试 计算CD 
 *    -1.1 获取 正确的汇率  [当月获取当月的。]
 * 
 select distinct(day) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct ;
 select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct  where day='2019-12-03';
 
 insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct partition(day="2019-12-16")
   SELECT B.area, B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
   B.stock_in_audit_time, B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name,
   B.supplier_simple_name, B.material_code, B.material_8code, B.material_name, B.material_model, 
  B.quantity, B.unit, B.currency, B.currency_name, B.tax_price, B.tax_rate,
   if(B.exchange_rate='1' and B.currency_name in('美元','港币') ,  D.fconvertrate, B.exchange_rate) as exchange_rate ,
    B.price, 
  B.tax_amount, B.amount, B.account_day, B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code,
   B.company_name
 from ( select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct where day='2019-12-16') B
   left join (
   select N.fname_l2, cast(collect_set(N.fconvertrate)[0] as decimal(28,16)) as fconvertrate,N.avail_date from (
 select C.fname_l2,A.fconvertrate,concat(split(A.favailtime,'/')[0],split(A.favailtime,'/')[1]) as avail_date
 from eas.ods_eas_new_eas75_t_bd_exchangerate  A
INNER JOIN eas.ods_eas_new_eas75_T_BD_ExchangeAux  B on  A.FExchangeAuxID = B.FID
INNER JOIN eas.ods_eas_new_eas75_T_BD_Currency C ON B.FSourceCurrencyID = C.FID ) N
 group by N.fname_l2,N.avail_date ) D
    on D.avail_date = B.`date` and  D.fname_l2 = B.currency_name 
    
  
 *   -1-)、1-- dwb_purchase_combine_mid_report_eas_distinct  全部转化为人民币 
 * 		   2 -- price 保留2位小数
  insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_rmb partition(day='2019-12-16')
  SELECT area, factory_code, factory_area, stock_org_number, stock_org_name,
   `date`, stock_in_audit_time, secondary_level, third_level, po_number, 
  supplier_code, supplier_name, supplier_simple_name, material_code, material_8code,
   material_name, material_model, quantity, unit, currency, currency_name, 
  if(currency_name in ('港币','美元'),tax_price*exchange_rate,tax_price) as tax_price,
   tax_rate, exchange_rate, 
  if(currency_name in ('港币','美元'),price*exchange_rate,price) as price,
  if(currency_name in ('港币','美元'),tax_amount*exchange_rate,tax_amount) as tax_amount,
  if(currency_name in ('港币','美元'),amount*exchange_rate,amount) as amount,
  account_day, material_type, buyer,
   docu_pic, remarks, company_code, company_name
  FROM dwmiddle.dwb_purchase_combine_mid_report_eas_distinct where day='2019-12-16';

 *  
 * -- 1-1)、与上一年的月份降序  关联，取标准价
 *  --  drop  table  dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier
 * 
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier partition(day='2019-12-16')
select B.area,B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
B.stock_in_audit_time, B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name, 
B.supplier_simple_name,B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, B.unit, 
B.currency,B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate, B.price, B.tax_amount, B.amount, B.account_day,
B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name 
,C.stand_price from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_rmb B left join 
(select A.material_code, A.supplier_code,cast(collect_set(A.price)[0] as decimal(28,16)) as stand_price,
cast(A.`year` as int) + 1 as year from
(select material_code,supplier_code,price,`date`,SUBSTRING(`date`,0,4) as `year` 
from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_rmb where price > 0 and price is not null 
ORDER by material_code,`date` desc ) A  group by A.material_code,supplier_code,A.`year`) C 
on B.material_code = C.material_code and B.supplier_code = C.supplier_code and  SUBSTRING(B.`date`,0,4) = cast(C.year as string);
	-- 2-2)、上一年没取标准价，取当前年份正序有值作为标准价【待优化】
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier partition(day='2019-12-16')
select B.area,B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
B.stock_in_audit_time, B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name, 
B.supplier_simple_name,B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, B.unit, 
B.currency,B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate, B.price, B.tax_amount, B.amount, B.account_day,
B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name 
,if(B.stand_price is null,B.price,B.stand_price) as stand_price from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier B



-- step3 遗漏 dwmiddle.dwb_purchase_combine_mid_report_eas的dim,重新生成dim  
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_dim_sup partition(day='2019-12-16')
select B.area,B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
B.stock_in_audit_time, B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name, 
B.supplier_simple_name,B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, B.unit, 
B.currency,B.currency_name,
B.tax_price,
B.tax_rate, B.exchange_rate,
round(B.price,4) as price ,
B.tax_amount,
B.amount,
 B.account_day,
B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name 
,round(B.stand_price,4) as stand_price ,
case SUBSTRING(TRIM(B.material_code),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier B;
 
    		
-- step 4 计算报表cd金额，
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup partition(day='2019-12-05')
select B.area,B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
B.stock_in_audit_time,'' as first_level,  B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name, 
B.supplier_simple_name,B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity,
B.unit,B.currency,B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate, B.price, B.tax_amount, 
B.amount,B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name 
,B.stand_price as bechmark_price,(B.stand_price * B.quantity) as bechmark_amount ,
(B.stand_price - B.price)*B.quantity as cd_amount,
(B.stand_price - B.price)*B.quantity/B.amount as cd_proportion,
B.account_day,B.tax_amount * B.account_day as account_amount,B.dim
from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_dim_sup B;
 
 *
 *  -- 对比 没有加供应商关联的 标准价
 * -- old   >0 2826664   <0 1132959  =0 5983975   all=9943598
 * select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final where cd_amount <0 ; 
 * -- new [reserve 2 decimal]    >0 1439569   <0 445811   =0 8056973   all=9943598
 * select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup  where cd_amount >0 ;
 * -- new [reserve 4 decimal]    >0 2296874   <0 671296   =0 6974183   all=9943598 isnull=1245  ''=0
 * select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup where day='2019-12-05' and cd_amount <0; 
 *
 *
  select area,stock_org_name,supplier_name,material_code,first_level,material_name,
  quantity,currency_name,exchange_rate,price,
  bechmark_price,amount,cd_amount, cd_proportion,buyer,account_day,`date`
   from dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup 
   where `date` = '201911' and dim = '2' and cd_amount <0 ; 
   
   -- 1 cnc  8248
   select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup
    where `date` like '%2019%' and dim = '1' and cd_amount <0 ;  
   -- 2 冲压  6117
    select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup
    where `date` like '%2019%' and dim = '2' and cd_amount <0 ;
   -- 3 模切  90475
    select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup
    where `date` like '%2019%' and dim = '3' and cd_amount <0 ;
    -- 5 组装  643
    select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup
    where `date` like '%2019%' and dim = '5' and cd_amount <0 ;
    
    
    -- 测试出现标准价 < 单价的情况
    
    -- 0.2052	201812	美元	1	881-STF790-A0-A	包装(白色/NDA14)	东莞盛翔精密金属有限公司
    select price,`date`,currency_name,exchange_rate,material_code,material_name,supplier_name 
    from  dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup 
     where `date` like '%2018%' and  material_code = '881-STF790-A0-A' and dim = '1'
    
    -- 0.0101	201812	美元	1	880-LBG619-A0-L	LBG619成品	东莞盛翔精密金属有限公司
    -- 0.0689	201911	人民币	1	880-LBG619-A0-L	LBG619成品	东莞盛翔精密金属有限公司
        select po_number,price,`date`,currency_name,exchange_rate,material_code,material_name,supplier_name 
    from  dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup 
    where `date` like '%2019%' and dim = '2'  and  material_code = '880-LBG619-A0-L'
     --  where `date` like '%2018%' and dim = '2' and currency_name = '美元' and  material_code = '880-LBG619-A0-L'  
      
    
    select * from dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup 
    where material_code = '881-STF790-A0-A' and  `date` = '%2018%'and dim = '1' and cd_amount <0 ; 
    
    select *  from dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup 
    where currency_name in( '美元' ,'港币')  and exchange_rate=1
    
    --华南			01.05.01	TRIUMPH LEAD GROUP LIMITED	201512	2015/12/31 14:13:59.000000000		11	
    	*LSHKCR2015128991254	RD02	NITTO   DENKO  (HK)  CO   LTD	NITTO	110-250PB4NM-0470	250PB4NM	
    	*哑黑麦拉胶带	470mmX100mX0.02mmT	-3572	㎡	BB02	美元	9.41	0	1	9.41	-33612.52	-33612.52	11		
    	*01.05.01	TRIUMPH LEAD GROUP LIMITED			
    4.7047	-16805.1884	16807.3316	-0.5000318809776833			unknown	2019-12-05
    
    select FExchangeRate from eas.ods_eas_new_eas75_t_sm_purorder where   day = '2019-12-16' and
    FNumber = 'SXHJDD20180331001' 
    
    
    -- 确认是否大部分 汇率为1，且为美元 ，,是本公司
    select A.supplier_name, A.number from 
    (select supplier_name, count(1) as number from dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup 
    where currency_name in( '美元' ,'港币')  and exchange_rate=1 group by supplier_name) A order by A.number desc;
    
    
    -- 得出当月 汇率值关联关系
    select *  from (
    select C.fname_l2,A.fconvertrate,concat(split(A.favailtime,'/')[0],split(A.favailtime,'/')[1]) as avail_date
     from eas.ods_eas_new_eas75_t_bd_exchangerate  A
    INNER JOIN eas.ods_eas_new_eas75_T_BD_ExchangeAux  B on  A.FExchangeAuxID = B.FID
    INNER JOIN eas.ods_eas_new_eas75_T_BD_Currency C ON B.FSourceCurrencyID = C.FID
    ) AA where AA.fname_l2 in 
    ('人民币','美元','港币')
 **/
select count(1)  from dwmiddle.dwb_purchase_combine_mid1 where day = '2019-12-03'; -- 2969133
select count(1)  from dwmiddle.dwb_purchase_combine_mid1 where day = '2019-12-16'; -- 3043320

-- alter table dwmiddle.dwb_purchase_combine_mid_report_eas drop PARTITION(day='${l_date}')
select distinct(day) from dwmiddle.dwb_purchase_combine_mid_report_eas; 
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas where day = '2019-12-03'; -- 75716945
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas where day = '2019-12-16'; -- 77616903
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas2 where day = '2019-12-16'; -- 77616903
-- 去除重复之后 7000W 变为 1000W
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct where day = '2019-12-03'; --  9943598
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct  where day = '2019-12-16'; -- 10176959

-- 测试stand_price 值。
insert overwrite table dwmiddle.dwm_eas_material_cd_by_month2 partition(day='2019-11-25')
select A.material_code,A.dim,A.`year`,A.`month`,A.`date`,A.supplier_code,A.price,B.price as standard_price,
A.amount,A.quantity
from dwmiddle.dwm_eas_material_no_standard_by_cd A 
left join dwmiddle.dwm_eas_material_no_standard_by_cd B
on  A.material_code = B.material_code and A.`year` -1 = B.`year` and B.`month` = 12 ;

select * from dwmiddle.dwm_eas_material_cd_by_month2 where standard_price is null or standard_price = '';
select count(1) from dwmiddle.dwm_eas_material_no_standard_by_cd ; -- 2969133
select A.material_code,concat_ws('|', collect_set(cast(A.price as string))) ,A.`year` from (select material_code,price,`year`,`month`,`date` from dwmiddle.dwm_eas_material_no_standard_by_cd 
ORDER by material_code,`year`,`month`,`date`) A  group by A.material_code,A.`year`  ; 

-- price 不存在null值，对它进行按照时间倒序，取值作为stand_price.
-- select count(1) from (
select A.material_code,collect_set(A.price)[0] as stand_price,A.`year` from
(select material_code,price,`date`,SUBSTRING(`date`,0,4) as `year` from dwmiddle.dwm_eas_material_no_standard_by_cd  
where material_code != '' or  material_code  is not null 
ORDER by material_code,`date` desc ) A  group by A.material_code,A.`year`
--) A where A.stand_price is null or A.stand_price = '' group by A.stand_price ; 

-- price 不存在null值，对它进行按照时间倒序，取值作为stand_price.
select price  from dwmiddle.dwm_eas_material_no_standard_by_cd where price = '' or price is null ;

-- 使用物料的最大值，作为标准价。 ？？？？？？
select material_code,material_name,price from (
select material_code,material_name,price,ROW_NUMBER() over (PARTITION by material_code order by price desc) rn 
from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct where material_code is not null or material_code != ''
)A where A.rn =1;

select count(1) from (
select C.*,B.price as bechmark_price from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct C left join 
(select material_code,material_name,price from (
select material_code,material_name,price,ROW_NUMBER() over (PARTITION by material_code order by price desc) rn 
from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct )A where A.rn =1) B on C.material_code = B.material_code
) A;
-- step 2 : 生成stand_price  【随后增加了 添加供应商神合成stand_price ,在注释中。】
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price partition(day='2019-12-05')
select B.area,B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
B.stock_in_audit_time, B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name, 
B.supplier_simple_name,B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, B.unit, 
B.currency,B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate, B.price, B.tax_amount, B.amount, B.account_day,
B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name 
,C.stand_price from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct B left join 
(select A.material_code,collect_set(A.price)[0] as stand_price,
cast(A.`year` as int) + 1 as year from
(select material_code,price,`date`,SUBSTRING(`date`,0,4) as `year` 
from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct where price > 0 and price is not null 
ORDER by material_code,`date` desc ) A  group by A.material_code,A.`year`) C 
on B.material_code = C.material_code and  SUBSTRING(B.`date`,0,4) = cast(C.year as string);

insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price partition(day='2019-12-05')
select B.area,B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
B.stock_in_audit_time, B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name, 
B.supplier_simple_name,B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, B.unit, 
B.currency,B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate, B.price, B.tax_amount, B.amount, B.account_day,
B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name 
,if(B.stand_price is null,B.price,B.stand_price) as stand_price from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price B

-- step3 遗漏 dwmiddle.dwb_purchase_combine_mid_report_eas的dim,重新生成dim
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_dim partition(day='2019-12-05')
select B.area,B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
B.stock_in_audit_time, B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name, 
B.supplier_simple_name,B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, B.unit, 
B.currency,B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate, B.price, B.tax_amount, B.amount, B.account_day,
B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name 
,B.stand_price,
case SUBSTRING(TRIM(B.material_code),0,3) 
when '881'  then '1'
when '882'  then '1'
when '887'  then '1'
when '888'  then '1'
when '889'  then '1'
when '681'  then '1'
when '682'  then '1'
when '687'  then '1'
when '688'  then '1'
when '880'  then '2'
when '883'  then '2'
when '680'  then '2'
when '683'  then '2'
when '689'  then '2'
when '800'  then '3'
when '810'  then '3'
when '886'  then '3'
when '600'  then '3'
when '610'  then '3'
when '686'  then '3'
when '63'  then '3'
when '64'  then '3'
when '631'  then '3'
when '632'  then '3'
when '633'  then '3'
when '634'  then '3'
when '635'  then '3'
when '636'  then '3'
when '651'  then '3'
when '652'  then '3'
when '885'  then '5'
when '685'  then '5'
else 'unknown'
end as dim from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price B;

-- step 4 计算报表cd金额，
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final partition(day='2019-12-05')
select B.area,B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
B.stock_in_audit_time,'' as first_level,  B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name, 
B.supplier_simple_name,B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity,
B.unit,B.currency,B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate, B.price, B.tax_amount, 
B.amount,B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name 
,B.stand_price as bechmark_price,(B.stand_price * B.quantity) as bechmark_amount ,
(B.stand_price - B.price)*B.quantity as cd_amount,
(B.stand_price - B.price)*B.quantity/B.amount as cd_proportion,
B.account_day,B.tax_amount * B.account_day as account_amount,B.dim
from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_dim B;

-- 
--  1132959 30%   --      2826664 70%  	  3959623 【cd_amount  前者<0,后者>0,最后是汇总 】
--  [717783] 29%  --	 [1722821] 71%    2440604【cd_amount < 0 and dim != 'unknown'】
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final where cd_amount < 0 and dim != 'unknown';
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final where cd_amount > 0 and dim != 'unknown'; 
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price;-- 9943598

select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct where material_code ='110-3M244000-1250';
-- 测试 stand_price 比 price小的情况
select SUBSTRING(`date`,0,4) , collect_set(price) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct 
where material_code ='110-DSS200AL-1040'
group by SUBSTRING(`date`,0,4) ;
select price,`date` from   dwmiddle.dwb_purchase_combine_mid_report_eas_distinct 
where material_code ='110-DSS200AL-1040' and SUBSTRING(`date`,0,4) = '2017';
-- 测试 物料只有一年有数据 5.768091 ，5.767999
select `date`,price from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct  where material_code ='110-3M9722S3-0018'
-- step5 dwmiddle.dwb_purchase_combine_mid_report_eas_final
-- 表中company_code company_name docu_pic  remarks 顺序颠倒，重新生成。
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final partition(day='2019-12-05')
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`,
stock_in_audit_time, first_level, secondary_level, third_level, po_number, supplier_code,
supplier_name, supplier_simple_name, material_code, material_8code, material_name, material_model, 
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price, tax_amount,
amount, material_type, buyer, company_code, company_name, docu_pic, remarks,bechmark_price,
bechmark_amount, cd_amount, cd_proportion, account_day, account_amount, dim
FROM dwmiddle.dwb_purchase_combine_mid_report_eas_final;

-- step6
-- 1、 添加采购员和跟单负责人的名称和fnumber 至表dwmiddle.dwb_purchase_combine_mid_report_eas_final2
      -- 1.2 、dwmiddle.dwb_purchase_combine_mid_report_eas_final3 ( 生成first_level)
      -- 1.3、dwmiddle.dwb_purchase_combine_mid_report_eas_final4  (统一位RMB,根据采购员区分设备BG)  
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final2 partition(day='2019-12-05')
SELECT B.area, B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`, 
B.stock_in_audit_time, B.first_level, B.secondary_level, B.third_level, B.po_number, B.supplier_code, 
B.supplier_name, B.supplier_simple_name, B.material_code, B.material_8code, B.material_name,
B.material_model, B.quantity, B.unit, B.currency, B.currency_name, B.tax_price, B.tax_rate,
B.exchange_rate, B.price, B.tax_amount, B.amount, B.material_type,
A.fnumber as buyer_id,A.fname_l2 as buyer, A.fname_l2 as docu_pic, B.remarks,
B.company_code, B.company_name, B.bechmark_price, B.bechmark_amount, B.cd_amount, B.cd_proportion, 
B.account_day, B.account_amount, B.dim
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final B left join eas.ods_eas_new_eas75_t_bd_person
A  on A.fid = B.buyer ;

-- step7  将报表数据导出dwsevice。 【dwb_purchase_combine_mid_report_eas_final2 中取固定字段作为最终报表】
insert overwrite table dwservice.dws_purchase_report_by_eas partition(day='2019-12-05')
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time, 
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name, supplier_simple_name,
material_code, material_8code, material_name, material_model, quantity, unit, currency, currency_name,
tax_price, tax_rate, exchange_rate, price, tax_amount, amount, material_type, buyer_id, buyer, docu_pic, 
remarks, company_code, company_name, bechmark_price, bechmark_amount, cd_amount, cd_proportion, account_day, 
account_amount, dim
FROM dwmiddle.dwb_purchase_combine_mid_report_eas_final2;

-- 【computer】step8 计算其他的CD金额。
-- 一、计算 "时间段采购额" CD分析  
  -- 备注: 新增设备之后数据，写入day='2019-12-12'
  -- select count(1) from dwservice.dws_cd_by_amount_month2 where day = '2019-12-05'
--insert overwrite table dwservice.dws_cd_by_amount_month2 partition(day='2019-12-05')
insert overwrite table dwservice.dws_cd_by_amount_month2 partition(day='2019-12-12')
select sum(B.cd_amount) as cd_amount,
if(cast(sum(B.cd_amount)/sum(B.total_amount) as string) is null,0,sum(B.cd_amount)/sum(B.total_amount)) as cd_proportion ,
sum(B.total_amount) as total_amount,'10' as dim,`year`,`month`,`date`
from(select if(cast(sum(cd_amount) as string) is null ,0,sum(cd_amount)) as cd_amount,
if(cast(sum(cd_amount)/sum(amount) as string) is null,0,sum(cd_amount)/sum(amount)) as cd_proportion,
if(cast(sum(amount) as string) is null,0,sum(amount)) as total_amount,
dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month` ,
CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
from dwmiddle.dwb_purchase_combine_mid_report_eas_final4
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final2
group by dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select if(cast(sum(C.cd_amount) as string) is null ,0,sum(C.cd_amount)) as cd_amount,
 if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount)) as cd_proportion ,
 if(cast(sum(C.amount) as string) is null ,0, sum(C.amount)) as total_amount,dim,`year`,`month`,`date`
from (select  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.dim,C.`year`,C.`month`,C.`date`
union ALL
select if(cast(sum(D.cd_amount) as string) is null ,0, sum(D.cd_amount))  as cd_amount,
 if(cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) as cd_proportion ,
if(cast(sum(D.amount) as string) is null ,0, sum(D.amount)) as total_amount,dim,`year`,`month`,`date`
from (select cast(WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(ZPRCZ as DECIMAL(28,16)) as amount,if(WERKS = '8800','6','7') as dim ,
GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` from saptest.ods_sap_zdmmr027_show ) 
D group by D.dim,D.`year`,D.`month`,D.`date`) 
B  group by B.`year`,B.`month`,B.`date` 
union all
select if(cast(sum(cd_amount) as string) is null ,0,sum(cd_amount)) as cd_amount,
if(cast(sum(cd_amount)/sum(amount) as string) is null,0,sum(cd_amount)/sum(amount)) as cd_proportion,
if(cast(sum(amount) as string) is null,0,sum(amount)) as total_amount,
dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month` ,
CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final2
from dwmiddle.dwb_purchase_combine_mid_report_eas_final4
group by dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select if(cast(sum(C.cd_amount) as string) is null ,0,sum(C.cd_amount)) as cd_amount,
 if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount)) as cd_proportion ,
 if(cast(sum(C.amount) as string) is null ,0, sum(C.amount)) as total_amount,dim,`year`,`month`,`date`
from (select  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.dim,C.`year`,C.`month`,C.`date`
union ALL
select if(cast(sum(D.cd_amount) as string) is null ,0, sum(D.cd_amount))  as cd_amount,
 if(cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) as cd_proportion ,
if(cast(sum(D.amount) as string) is null ,0, sum(D.amount)) as total_amount,dim,`year`,`month`,`date`
from (select cast(WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(ZPRCZ as DECIMAL(28,16)) as amount,if(WERKS = '8800','6','7') as dim ,
GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` from saptest.ods_sap_zdmmr027_show ) 
D group by D.dim,D.`year`,D.`month`,D.`date`;


-- 二、计算物料降价  波动分析 [相同 物料8码&&物料名称的价格如何取舍？ ==> 按照名称分组，取时间最近的那条 | 汇总时，不同BG，相同物料名称，相同年月的数据，取第一条][物料名称中特殊字符-- 替换]
-- [按照物料名称+dim  的降价幅度，给物料排序]
  -- 备注: 新增设备之后数据，写入day='2019-12-12'
  -- select count(1) from dwmiddle.dwm_cd_by_material_cut_price_mid where day = '2019-12-12'
--select material_8code,count(1) from (

-- select distinct(length(`date`))  from dwservice.dws_cd_by_material_cut_price_month2;
-- select distinct(length(`date`))  from dwservice.dws_cd_by_material_cut_price_month3;
insert overwrite table dwmiddle.dwm_cd_by_material_cut_price_mid partition(day='2019-12-12')
select collect_set(W.material_8code)[0] as material_8code,W.material_name,collect_set(W.price)[0] as price,'10' as dim ,W.`year`,W.`month`,W.`date`
from (select A.* from (
select collect_set(if(material_8code is null or material_8code = '' ,material_code,material_8code))[0] as material_8code,
regexp_replace(regexp_replace(material_name,'"',''),"'","") as material_name,
collect_set(price)[0] as price,dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final2
from dwmiddle.dwb_purchase_combine_mid_report_eas_final4
group by material_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date` order by `date` desc ) A
union ALL
select collect_set(product_materiel_code)[0] as material_8code,regexp_replace(regexp_replace(prodect_materiel_name,'"',''),"'","") as material_name,
collect_set(unit_price)[0] as price,'8' as dim,SUBSTRING(natural_month,0,4) as `year`,
SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module
group by prodect_materiel_name,SUBSTRING(natural_month,0,4),SUBSTRING(natural_month,5,2),CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2))
union ALL
select collect_set(MATNR)[0] AS  material_8code ,regexp_replace(regexp_replace(MAKTX,'"',''),"'","") as material_name ,
collect_set(if(NETPR is null or NETPR = '', (cast(HSDAJ as decimal(28,6)) / cast(MWSKZ1 as decimal(28,6))) , cast(NETPR as decimal(28,6))))[0] as price,
if(WERKS = '8800','6','7') as dim ,GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show 
group by MAKTX,if(WERKS = '8800','6','7'),GJAHR,SUBSTRING(LFDAT,6,2)  ,SUBSTRING(LFDAT,0,7) )
W group by  W.material_name,W.`year`,W.`month`,W.`date`
union ALL
select A.* from (
select collect_set(if(material_8code is null or material_8code = '' ,material_code,material_8code))[0] as material_8code,
regexp_replace(regexp_replace(material_name,'"',''),"'","") as material_name,
collect_set(price)[0] as price,dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final2
from dwmiddle.dwb_purchase_combine_mid_report_eas_final4
group by material_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date` order by `date` desc ) A
union ALL
select collect_set(product_materiel_code)[0] as material_8code,regexp_replace(regexp_replace(prodect_materiel_name,'"',''),"'","") as material_name,
collect_set(unit_price)[0] as price,'8' as dim,SUBSTRING(natural_month,0,4) as `year`,
SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module
group by prodect_materiel_name,SUBSTRING(natural_month,0,4),SUBSTRING(natural_month,5,2),CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2))
union ALL
select collect_set(MATNR)[0] AS  material_8code ,regexp_replace(regexp_replace(MAKTX,'"',''),"'","") as material_name ,
collect_set(if(NETPR is null or NETPR = '', (cast(HSDAJ as decimal(28,6)) / cast(MWSKZ1 as decimal(28,6))) , cast(NETPR as decimal(28,6))))[0] as price,
if(WERKS = '8800','6','7') as dim ,GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show 
group by MAKTX,if(WERKS = '8800','6','7'),GJAHR,SUBSTRING(LFDAT,6,2)  ,SUBSTRING(LFDAT,0,7);
-- ) total group by material_8code,material_name,price,dim ;

-- 生成  降价幅度排名 ,价格波动数量排名，价格数量排名
-- insert overwrite table dwservice.dws_cd_by_material_cut_price_month2 partition(day='2019-12-05')
insert overwrite table dwservice.dws_cd_by_material_cut_price_month2 partition(day='2019-12-12')
select A.material_8code, A.material_name, A.price,B.diff_num,B.count_num, A.dim, A.`month`, A.`year`, A.`date`
 from  dwmiddle.dwm_cd_by_material_cut_price_mid A  right join 
(select material_8code,material_name,dim,count(1) as diff_num,sum(num) as count_num from 
(select material_8code,material_name,count(1) as num ,dim,price from dwmiddle.dwm_cd_by_material_cut_price_mid
where day='2019-12-12' group by material_8code,material_name,price,dim) C group by material_8code,material_name,dim) B 
on A.material_8code = B.material_8code 
and A.material_name = B.material_name and A.dim = B.dim
and A.day = '2019-12-12';

-- select count(1) from dwservice.dws_cd_by_material_cut_price_month2  where day='2019-12-12';
-- select count(1) from dwservice.dws_cd_by_material_cut_price_month2  where day='2019-12-05';
-- 三、左上角 统计，所有BG统计 

-- 四、物料类型CD金额。（根据dwmiddle.dwb_purchase_combine_mid_report_eas_final3中的first_level）
  -- 备注: 新增设备之后数据，写入day='2019-12-12'
--insert overwrite table dwservice.dws_cd_by_material_type_month2 partition(day='2019-12-05')
insert overwrite table dwservice.dws_cd_by_material_type_month2 partition(day='2019-12-12')
select P.material_type ,sum(P.cd_amount) as cd_amount,if( cast(sum(P.cd_amount)/sum(P.amount) as string) is null ,0 ,sum(P.cd_amount)/sum(P.amount)) as cd_proportion ,sum(P.amount) as amount,'10' as dim,P.`year`,P.`month`,P.`date`
from(select first_level as material_type,
if(cast(sum(cd_amount) as string) is null ,0,sum(cd_amount)) as cd_amount,
if(cast(sum(cd_amount)/sum(amount) as string) is null,0,sum(cd_amount)/sum(amount)) as cd_proportion,
if(cast(sum(amount) as string) is null,0,sum(amount)) as amount,
dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final3
from dwmiddle.dwb_purchase_combine_mid_report_eas_final4
group by first_level,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select C.material_type,sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount,dim,`year`,`month`,`date`
from (select first_level as material_type,  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.material_type,C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.material_type,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select mtbez as material_type,cast(WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(ZPRCZ as DECIMAL(28,16)) as amount,if(WERKS = '8800','6','7') as dim ,GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show ) D group by D.material_type,D.dim,D.`year`,D.`month`,D.`date`)
p group by P.material_type,P.`year`,P.`month`,P.`date`
union all
select first_level as material_type,
if(cast(sum(cd_amount) as string) is null ,0,sum(cd_amount)) as cd_amount,
if(cast(sum(cd_amount)/sum(amount) as string) is null,0,sum(cd_amount)/sum(amount)) as cd_proportion,
if(cast(sum(amount) as string) is null,0,sum(amount)) as amount,
dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final3
from dwmiddle.dwb_purchase_combine_mid_report_eas_final4
group by first_level,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select C.material_type,sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount,dim,`year`,`month`,`date`
from (select first_level as material_type,  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.material_type,C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.material_type,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select mtbez as material_type,cast(WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(ZPRCZ as DECIMAL(28,16)) as amount,if(WERKS = '8800','6','7') as dim ,GJAHR as `year`, SUBSTRING(LFDAT,6,2) as `month` ,SUBSTRING(LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show ) D group by D.material_type,D.dim,D.`year`,D.`month`,D.`date`;

-- select DISTINCT(length(`date`)) from dwservice.dws_cd_by_material_type_month2;

-- 五、供应商 的cd金额报表数 【账期天数， 原始数据order by account_day 取最大值】  
-- select distinct(`day`) from dwservice.dws_cd_by_supplier_month2;
-- select DISTINCT(length(`date`)) from dwservice.dws_cd_by_supplier_month2;
    -- 备注: 新增设备之后数据，写入day='2019-12-12'
-- insert overwrite table dwservice.dws_cd_by_supplier_month2 partition(day='2019-12-06') 
insert overwrite table dwservice.dws_cd_by_supplier_month2 partition(day='2019-12-12') 
select E.supplier_code,E.supplier_name,sum(E.cd_amount) as cd_amount,
if(cast(sum(E.cd_amount)/sum(E.amount) as string) is null , 0,sum(E.cd_amount)/sum(E.amount)) as cd_proportion ,sum(E.amount) as amount,
collect_set(E.account_day)[0] as account_day,'10' as dim,E.`year`,E.`month`,E.`date`
from 
(select M.* from 
(select N.supplier_code,N.supplier_name,
if(cast(sum(N.cd_amount) as string) is null ,0,sum(N.cd_amount)) as cd_amount,
if(cast(sum(N.cd_amount)/sum(N.amount) as string) is null,0,sum(N.cd_amount)/sum(N.amount)) as cd_proportion,
if(cast(sum(N.amount) as string) is null,0,sum(N.amount)) as amount,
collect_set(N.account_day)[0] as account_day,
N.dim,SUBSTRING(N.`date`,0,4) as `year`,SUBSTRING(N.`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(N.`date`,0,4), SUBSTRING(N.`date`,5,2)) as `date`
from (select *  from
-- dwmiddle.dwb_purchase_combine_mid_report_eas_final3  
dwmiddle.dwb_purchase_combine_mid_report_eas_final4
order by account_day desc) N 
group by supplier_code,supplier_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select C.supplier_code,C.supplier_name, sum(C.cd_amount) as cd_amount,
 if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount)) as cd_proportion ,
sum(C.amount) as amount ,collect_set(C.account_day)[0] as account_day,dim,`year`,`month`,`date`
from (select  supplier_code,supplier_name,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim, case days_of_account
when '现结' then '0'
when '预付' then '60'
when '半月结' then '0'
when '月结30天' then '30'
when '月结60天' then '60'
when '月结90天' then '90'
else ''
end as account_day, 
SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  order by account_day desc  ) C group by C.supplier_code,C.supplier_name, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.supplier_code,D.supplier_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 ,
sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,
collect_set(D.account_day)[0]  as account_day,dim,`year`,`month`,`date`
from (select B.lifnr as supplier_code,B.name1 as supplier_name, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,'' as account_day,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A  left join saptest.ods_sap_zbigdata_md_lfa1 B on  A.LIFNR = B.lifnr 
) D group by  D.supplier_code,D.supplier_name,D.dim,D.`year`,D.`month`,D.`date`)M order by M.account_day desc
) E group by  E.supplier_code,E.supplier_name,E.`year`,E.`month`,E.`date` 
union all
select N.supplier_code,N.supplier_name,
if(cast(sum(N.cd_amount) as string) is null ,0,sum(N.cd_amount)) as cd_amount,
if(cast(sum(N.cd_amount)/sum(N.amount) as string) is null,0,sum(N.cd_amount)/sum(N.amount)) as cd_proportion,
if(cast(sum(N.amount) as string) is null,0,sum(N.amount)) as amount,
collect_set(N.account_day)[0] as account_day,
N.dim,SUBSTRING(N.`date`,0,4) as `year`,SUBSTRING(N.`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(N.`date`,0,4), SUBSTRING(N.`date`,5,2)) as `date`
from (select *  from 
-- dwmiddle.dwb_purchase_combine_mid_report_eas_final3 
dwmiddle.dwb_purchase_combine_mid_report_eas_final4
order by account_day desc) N 
group by supplier_code,supplier_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select C.supplier_code,C.supplier_name, sum(C.cd_amount) as cd_amount,
 if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount)) as cd_proportion ,
sum(C.amount) as amount ,collect_set(C.account_day)[0] as account_day,dim,`year`,`month`,`date`
from (select  supplier_code,supplier_name,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim, case days_of_account
when '现结' then '0'
when '预付' then '60'
when '半月结' then '0'
when '月结30天' then '30'
when '月结60天' then '60'
when '月结90天' then '90'
else ''
end as account_day, 
SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  order by account_day desc  ) C group by C.supplier_code,C.supplier_name, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.supplier_code,D.supplier_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 ,
sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,
collect_set(D.account_day)[0]  as account_day,dim,`year`,`month`,`date`
from (select B.lifnr as supplier_code,B.name1 as supplier_name, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,'' as account_day,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A  left join saptest.ods_sap_zbigdata_md_lfa1 B on  A.LIFNR = B.lifnr 
) D group by  D.supplier_code,D.supplier_name,D.dim,D.`year`,D.`month`,D.`date`  ;


-- select distinct(length(`date`)) from dwservice.dws_cd_by_supplier_month2;
-- select DISTINCT(`day`)  from  dwservice.dws_cd_by_supplier_month2

-- 六、账期天数 的cd金额报表数据  【根据供应商表，生成】
-- select DISTINCT(`day`)  from dwservice.dws_cd_by_account_day_month2;
-- select distinct(length(`date`)) from dwservice.dws_cd_by_account_day_month2;
-- insert overwrite table dwservice.dws_cd_by_account_day_month2 partition(day='2019-12-05')
insert overwrite table dwservice.dws_cd_by_account_day_month2 partition(day='2019-12-12')
select D.account_day,sum(D.cd_amount) as cd_amount,
sum(D.cd_amount)/sum(D.total_amount) as cd_proportion,
sum(D.total_amount) as total_amount,
D.dim,D.`year`,D.`month`,D.`date` 
from (select case account_day
when '0' then '现结/半月结/COD'
when '1' then '现结/半月结'
when '10' then 'COD.'
when '105' then '月结90天'
when '120' then '月结105天'
when '135' then '月结120天'
when '195' then '票结90天+90天承兑汇票'
when '30' then '月结30天'
when '45' then '月结30天'
when '60' then '月结45天'
when '75' then '月结60天'
when '90' then '月结75天'
ELSE '' end as account_day,
cd_amount,
total_amount,
dim,`year`,`month`,`date`
from  dwservice.dws_cd_by_supplier_month2 where day = '2019-12-12') 
D group by  D.account_day,D.dim,D.`year`,D.`month`,D.`date`  ;

-- 七、区域  的cd金额报表数据  【根据供应商表，生成】
-- select distinct(length(`date`)) from  dwservice.dws_cd_by_area_day_month2;
-- select DISTINCT(`day`)  from dwservice.dws_cd_by_area_day_month2;
-- insert overwrite table dwservice.dws_cd_by_area_day_month2 partition(day='2019-11-25')
insert overwrite table dwservice.dws_cd_by_area_day_month2 partition(day='2019-12-12')
select W.area,W.company_name, sum(W.cd_amount) as cd_amount,
if (cast(sum(W.cd_amount)/sum(W.amount) as string) is null ,0, sum(W.cd_amount)/sum(W.amount)) as cd_proportion ,
sum(W.amount) as amount,'10'as dim,W.`year`,W.`month`,W.`date`
from(select A.area,A.company_name, sum(A.cd_amount) as cd_amount,
if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount)) as cd_proportion ,
sum(A.amount) as amount,dim,
SUBSTRING(A.`date`,0,4) as `year`,SUBSTRING(A.`date`,5,2) as `month`,
CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2)) as `date`
--from  dwmiddle.dwb_purchase_combine_mid_report_eas_final3  A 
from  dwmiddle.dwb_purchase_combine_mid_report_eas_final4  A 
group by A.area,A.company_name,A.dim,SUBSTRING(A.`date`,0,4),SUBSTRING(A.`date`,5,2),CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2))  
union ALL
select  C.area, C.company_name , sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select '华南' as area, bu_factory_area as company_name ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by  C.area,C.company_name, C.dim,C.`year`,C.`month`,C.`date`
union all
select D.area,D.company_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select E.area as area ,B.name1 as industry_area,C.butxt as company_name, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,'' as account_day,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A 
left join saptest.ods_sap_zbigdata_md_t001w B on A.werks = B.werks
left join saptest.ods_sap_zbigdata_md_t001 C on A.bukrs = C.bukrs 
left join saptest.ods_sap_company_area_relation E on E.company_fid = A.bukrs
) D group by  D.area,D.company_name,D.dim,D.`year`,D.`month`,D.`date`)
W group by  W.area,W.company_name,W.`year`,W.`month`,W.`date`
UNION ALL
select A.area,A.company_name, sum(A.cd_amount) as cd_amount,
if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount)) as cd_proportion ,
sum(A.amount) as amount,dim,
SUBSTRING(A.`date`,0,4) as `year`,SUBSTRING(A.`date`,5,2) as `month`,
CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2)) as `date`
--from  dwmiddle.dwb_purchase_combine_mid_report_eas_final3  A 
from  dwmiddle.dwb_purchase_combine_mid_report_eas_final4  A 
group by A.area,A.company_name,A.dim,SUBSTRING(A.`date`,0,4),SUBSTRING(A.`date`,5,2),CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2))  
union ALL
select  C.area, C.company_name , sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select '华南' as area, bu_factory_area as company_name ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by  C.area,C.company_name, C.dim,C.`year`,C.`month`,C.`date`
union all
select D.area,D.company_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select E.area as area ,B.name1 as industry_area,C.butxt as company_name, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,'' as account_day,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A 
left join saptest.ods_sap_zbigdata_md_t001w B on A.werks = B.werks
left join saptest.ods_sap_zbigdata_md_t001 C on A.bukrs = C.bukrs 
left join saptest.ods_sap_company_area_relation E on E.company_fid = A.bukrs
) D group by  D.area,D.company_name,D.dim,D.`year`,D.`month`,D.`date`;


-- 八、采购员的cd金额报表数据  【根据供应商表，生成】
-- select distinct(length(`date`)) from  dwservice.DWS_CD_BY_PURCHASER_MONTH2;
-- select DISTINCT(`day`)  from dwservice.DWS_CD_BY_PURCHASER_MONTH2;
-- insert overwrite table dwservice.DWS_CD_BY_PURCHASER_MONTH2 partition(day='2019-12-06') 
insert overwrite table dwservice.DWS_CD_BY_PURCHASER_MONTH2 partition(day='2019-12-12') 
select W.person_name, sum(W.cd_amount) as cd_amount,( if (cast(sum(W.cd_amount)/sum(W.amount) as string) is null ,0, sum(W.cd_amount)/sum(W.amount))) as cd_proportion ,sum(W.amount) as amount,'10' as dim,`year`,`month`,`date`
from (select A.buyer as person_name , sum(A.cd_amount) as cd_amount,
if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount)) as cd_proportion ,
sum(A.amount) as amount,dim,
SUBSTRING(A.`date`,0,4) as `year`,SUBSTRING(A.`date`,5,2) as `month`,
CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final3 A
from dwmiddle.dwb_purchase_combine_mid_report_eas_final4 A
group by buyer,dim,SUBSTRING(A.`date`,0,4),SUBSTRING(A.`date`,5,2),CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2))
union ALL
select C.buyer as person_name, sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select  buyer ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,
SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.buyer, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.UNSEZ as person_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select A.UNSEZ as UNSEZ, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A 
) D group by  D.UNSEZ,D.dim,D.`year`,D.`month`,D.`date`) W group by  W.person_name,W.`year`,W.`month`,W.`date`

union all 
select A.buyer as person_name , sum(A.cd_amount) as cd_amount,
if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount)) as cd_proportion ,
sum(A.amount) as amount,dim,
SUBSTRING(A.`date`,0,4) as `year`,SUBSTRING(A.`date`,5,2) as `month`,
CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final3 A
from dwmiddle.dwb_purchase_combine_mid_report_eas_final4 A
group by buyer,dim,SUBSTRING(A.`date`,0,4),SUBSTRING(A.`date`,5,2),CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2))
union ALL
select C.buyer as person_name, sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select  buyer ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,
SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module  ) C group by C.buyer, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.UNSEZ as person_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select A.UNSEZ as UNSEZ, cast(A.WSCD as DECIMAL(28,16)) as cd_amount,
cast(A.ZPRCZ as DECIMAL(28,16)) as amount,if(A.WERKS = '8800','6','7') as dim ,A.GJAHR as `year`, SUBSTRING(A.LFDAT,6,2) as `month` ,SUBSTRING(A.LFDAT,0,7) as `date` 
from saptest.ods_sap_zdmmr027_show  A 
) D group by  D.UNSEZ,D.dim,D.`year`,D.`month`,D.`date`;

-- 采购员新增  按年的cd金额，cd比例，总金额
--insert overwrite table dwservice.dws_cd_by_purchaser_month_year2 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_purchaser_month_year2 partition(day='2019-12-12')
SELECT A.purchaser, A.cd_amount,B.cd_amount_year, A.cd_proportion,
B.cd_amount_year/B.total_amount_year  as cd_proportion_year,
A.total_amount,B.total_amount_year, 
A.dim, A.`year`, A.`month`, A.`date`from dwservice.DWS_CD_BY_PURCHASER_MONTH2  A
right join (select purchaser,`year`,sum(cd_amount) as cd_amount_year,sum(total_amount) as total_amount_year
from dwservice.DWS_CD_BY_PURCHASER_MONTH2 where day= '2019-12-12'  group by purchaser,`year`) B 
on A.purchaser = B.purchaser and A.`year` = B.`year`
and A.day= '2019-12-12';

-- select count(1) from dwservice.dws_cd_by_purchaser_month_year2 where  day= '2019-12-12' 
-- select count(1) from dwservice.dws_cd_by_purchaser_month_year2 where  day= '2019-12-06' 

-- step 10 
-- 新增字段 BG名称
-- insert overwrite table dwservice.dws_cd_by_amount_month3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_amount_month3 partition(day='2019-12-12')
select case dim
when '1' then 'cnc'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE '' end as BG,
cd_amount,cd_proportion,total_amount,dim,`year`, `month`,`date` 
from  dwservice.dws_cd_by_amount_month2 where day='2019-12-12';

--select count(1) from dwservice.dws_cd_by_amount_month3 where  day='2019-12-12';
-- select count(1) from dwservice.dws_cd_by_amount_month3 where  day='2019-12-06';

-- select count(1) from dwservice.dws_cd_by_area_day_month3 where  day='2019-12-06';
-- select * from dwservice.dws_cd_by_area_day_month3 where  day='2019-12-12' and dim = '4';


-- insert overwrite table dwservice.dws_cd_by_area_day_month3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_area_day_month3 partition(day='2019-12-12')
select case dim
when '1' then 'cnc'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE '' end as BG,
area, company_name, cd_amount, cd_proportion, total_amount, dim, `year`, `month`, `date`
FROM dwservice.dws_cd_by_area_day_month2 where day='2019-12-12'; 

-- select distinct(length(`date`)) from dwservice.dws_cd_by_material_cut_price_month2;
--  select distinct(`day`) from dwservice.dws_cd_by_material_cut_price_month3;
-- insert overwrite table dwservice.dws_cd_by_material_cut_price_month3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_material_cut_price_month3 partition(day='2019-12-12')
select case dim
when '1' then 'cnc'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE '' end as BG,
material_8code, material_name, price, diff_num, count_num, dim, `year`, `month`, `date`
FROM dwservice.dws_cd_by_material_cut_price_month2 where day='2019-12-12'; 


-- select * from dwservice.dws_cd_by_material_cut_price_month3 where  day='2019-12-12' and dim = '4';
-- select count(1) from dwservice.dws_cd_by_material_cut_price_month3 where  day='2019-12-12'
-- select count(1) from dwservice.dws_cd_by_material_cut_price_month3 where  day='2019-12-06'

--   select count(1) from dwservice.dws_cd_by_material_type_month3 where  day='2019-12-12'
 
-- insert overwrite table dwservice.dws_cd_by_material_type_month3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_material_type_month3 partition(day='2019-12-12')
select case dim
when '1' then 'cnc'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE '' end as BG,
material_type, cd_amount, cd_proportion, total_amount, dim, `year`, `month`, `date`
FROM dwservice.dws_cd_by_material_type_month2 where day='2019-12-12'; 



-- select count(1) from dwservice.dws_cd_by_purchaser_month_year3 where  day='2019-12-06'
-- insert overwrite table dwservice.dws_cd_by_purchaser_month_year3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_purchaser_month_year3 partition(day='2019-12-12')
select case dim
when '1' then 'cnc'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE '' end as BG,
purchaser, cd_amount, cd_amount_year, cd_proportion, cd_proportion_year, total_amount, total_amount_year, dim,
 `year`, `month`, `date`
FROM dwservice.dws_cd_by_purchaser_month_year2 where day='2019-12-12'; 


-- select count(1) from dwservice.dws_cd_by_supplier_month3 where  day='2019-12-12' and dim = '4'
-- insert overwrite table dwservice.dws_cd_by_supplier_month3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_supplier_month3 partition(day='2019-12-12')
select case dim
when '1' then 'cnc'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE '' end as BG,
supplier_code, supplier_name, cd_amount, cd_proportion, total_amount, account_day, dim, `year`, `month`, `date`
FROM dwservice.dws_cd_by_supplier_month2 where day='2019-12-12'; 

-- select * from dwservice.dws_cd_by_account_day_month3 where  day='2019-12-12' and dim = '1'
-- insert overwrite table dwservice.dws_cd_by_account_day_month3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_account_day_month3 partition(day='2019-12-12')
select case dim
when '1' then 'cnc'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE '' end as BG,
 account_day, cd_amount, cd_proportion, total_amount, dim, `year`, `month`, `date`
FROM dwservice.dws_cd_by_account_day_month2 where day='2019-12-12'; 

---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
/**
 * 
  *           	1、 切换 所有币别为RMD,重新计算  CD金额，单价，总金额 
  * 			2、新增设备 BG 
  * 
 */

select * from jituanhr.ods_jituanhr_report_t_sys_hr_department where simname like  '%冲压采购部%'

select * from dijinghr.ods_dijinghr_ce_hrm_dept_class where dept_namel '%冲压采购部%'


select area,`date`,	material_code,exchange_rate,price,bechmark_price,quantity,currency_name,
cd_amount,cd_proportion,amount 
from dwmiddle.dwb_purchase_combine_mid_report_eas_final3 where currency_name in ('港币','美元');


select distinct(dim) from dwmiddle.dwb_purchase_combine_mid_report_eas_final3 


select * from jituanhr.ods_jituanhr_report_t_sys_hr_user  where day = '2019-11-18' and workno = 'SZ-13397';

select distinct(companyname) from jituanhr.ods_jituanhr_report_t_sys_hr_user  where day = '2019-11-18';

select companyname,cname from jituanhr.ods_jituanhr_report_t_sys_hr_user  where workno = 'HN-7867';

select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final3 where buyer_id in 
('HN-7867','HN-18267','HN-13896','HN-4593','HN-6606','FT-3465','FT-2118','HN-12371',
'6048040','6048045','FT-3842','6070094','6113405','DT00013820','DT00010869','36010489','SD-031258','36020298'
,'26017982','DT00000298','6060436','6098623','6119124') ;

select * from dwmiddle.dwb_purchase_combine_mid_report_eas_final3 where buyer_id = 'HN-7867';

select if(dim = 'unknown' and buyer_id in ('HN-7867','HN-18267','HN-13896','HN-4593','HN-6606','FT-3465','FT-2118','HN-12371',
'6048040','6048045','FT-3842','6070094','6113405','DT00013820','DT00010869','36010489','SD-031258','36020298'
,'26017982','DT00000298','6060436','6098623','6119124') ,'4',dim) as dim from dwmiddle.dwb_purchase_combine_mid_report_eas_final3
where buyer_id = 'HN-7867' ;


drop table dwmiddle.dwb_purchase_combine_mid_report_eas_final4

--  切换 所有币别为RMD,重新计算  CD金额，单价，总金额，
--  数据统一为 RMB
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final4 partition(day='2019-12-11')
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `year`, `month`, `date`,
stock_in_audit_time, first_level, secondary_level, third_level, po_number, supplier_code, supplier_name, 
supplier_simple_name, material_code, material_8code,
regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace(material_name,'"',''),"'",""),'\\^',''),'\t',''),',','.') as material_name,
material_model, quantity, unit,
currency, currency_name, 
if(currency_name in ('港币','美元'),tax_price*exchange_rate,tax_price) as tax_price,
tax_rate, exchange_rate,
if(currency_name in ('港币','美元'),price*exchange_rate,price) as price,
if(currency_name in ('港币','美元'),tax_amount*exchange_rate,tax_amount) as tax_amount,
if(currency_name in ('港币','美元'),amount*exchange_rate,amount) as amount,
material_type,buyer_id, buyer, docu_pic, remarks, company_code, company_name,
if(currency_name in ('港币','美元'),bechmark_price*exchange_rate,bechmark_price) as bechmark_price,
if(currency_name in ('港币','美元'),bechmark_amount*exchange_rate,bechmark_amount) as bechmark_amount,
if(currency_name in ('港币','美元'),cd_amount*exchange_rate,cd_amount) as cd_amount,
cd_proportion,account_day,
if(currency_name in ('港币','美元'),account_amount*exchange_rate,account_amount) as account_amount,
if(dim = 'unknown' and buyer_id in ('HN-7867','HN-18267','HN-13896','HN-4593','HN-6606','FT-3465','FT-2118','HN-12371',
'6048040','6048045','FT-3842','6070094','6113405','DT00013820','DT00010869','36010489','SD-031258','36020298'
,'26017982','DT00000298','6060436','6098623','6119124') ,'4',dim) as dim
FROM dwmiddle.dwb_purchase_combine_mid_report_eas_final3;

select distinct(dim) from dwmiddle.dwb_purchase_combine_mid_report_eas_final3;
select distinct(dim) from dwmiddle.dwb_purchase_combine_mid_report_eas_final4;
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final4;

	-- 出现107条 错乱数据
select * from dwmiddle.dwb_purchase_combine_mid_report_eas_final4 where dim not in 
('1','unknown','2','3','4','5','6','7','8','9','10');

select regexp_replace(material_name,'\\^','') as A,material_name from  dwmiddle.dwb_purchase_combine_mid_report_eas_final3 
where material_code= '180-QP220150-0000';
select regexp_replace(material_name,'\t','p') ,material_name from  dwmiddle.dwb_purchase_combine_mid_report_eas_final3 
where material_code = '110-DKM03003-1020';


-- material_model有特殊字符  
select * from  dwmiddle.dwb_purchase_combine_mid_report_eas_final3 
where material_code ='190-BEMI3218-1473';
-- 创建多分割符
CREATE EXTERNAL TABLE `dwmiddle.dwb_purchase_combine_mid_report_eas_final4`(
  `area` string COMMENT '区域', 
  `factory_code` string COMMENT '工厂代码', 
  `factory_area` string COMMENT 'BU/厂区/工厂描述', 
  `stock_org_number` string COMMENT '库存组织编码', 
  `stock_org_name` string COMMENT '库存组织名称', 
  `year` string COMMENT '年', 
  `month` string COMMENT '月', 
  `date` string COMMENT '日期', 
  `stock_in_audit_time` string COMMENT '入库审核时间', 
  `first_level` string COMMENT '一级分类', 
  `secondary_level` string COMMENT '二级分类', 
  `third_level` string COMMENT '三级分类', 
  `po_number` string COMMENT '订单编号[eas]/采购单号[sap]', 
  `supplier_code` string COMMENT '供应商编码', 
  `supplier_name` string COMMENT '供应商名称', 
  `supplier_simple_name` string COMMENT '供应商简称', 
  `material_code` string COMMENT '物料编码[eas]/(品号/物料编号)[sap]', 
  `material_8code` string COMMENT '物料8码', 
  `material_name` string COMMENT '物料名称', 
  `material_model` string COMMENT '物料规格', 
  `quantity` decimal(28,16) COMMENT '收货数量（本次收货数量）/[sap]入库数量', 
  `unit` string COMMENT '单位（采购）', 
  `currency` string COMMENT '币别', 
  `currency_name` string COMMENT '币别名称', 
  `tax_price` decimal(28,16) COMMENT '含税单价[eas/sap]/BC含税单价[yifei]', 
  `tax_rate` decimal(28,16) COMMENT '税率', 
  `exchange_rate` decimal(28,16) COMMENT '汇率', 
  `price` decimal(28,16) COMMENT '不含税单价[eas]/BC未税单价[yifei]', 
  `tax_amount` decimal(28,16) COMMENT '含税金额/价税合计', 
  `amount` decimal(28,16) COMMENT '未税金额/本次收货金额', 
  `material_type` string COMMENT '物料类型', 
  `buyer_id` string COMMENT '采购员id[yifei/sap]', 
  `buyer` string COMMENT '采购员[yifei/sap]', 
  `docu_pic` string COMMENT '跟单负责人', 
  `remarks` string COMMENT '备注[yifei]', 
  `company_code` string COMMENT '公司编码', 
  `company_name` string COMMENT '公司名称/描述', 
  `bechmark_price` string COMMENT '标准价', 
  `bechmark_amount` decimal(28,16) COMMENT '标准金额', 
  `cd_amount` decimal(28,16) COMMENT 'cd金额', 
  `cd_proportion` decimal(28,16) COMMENT 'cd比例', 
  `account_day` string COMMENT '账期天数（供应商）', 
  `account_amount` decimal(28,16) COMMENT '账期金额', 
  `dim` string COMMENT '维度(1 CNC、2 冲压、3 模切、4 设备、5 组装、6 深圳结构件、7 东莞结构件、8 显示模组、9 磁材、10 汇总)')
COMMENT 'CD月报基础合并数据  中间表'
PARTITIONED BY ( 
  `day` string)
  row format serde 'org.apache.hadoop.hive.contrib.serde2.MultiDelimitSerDe' 
 with serdeproperties ('field.delim'='^#');

-- material_name like '%\t%'

-- 新增设备 （4），更新dwservice.dws_purchase_report_by_eas 表。 【2019-12-05】

insert overwrite table dwservice.dws_purchase_report_by_eas partition(day='2019-12-12')
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`,
stock_in_audit_time, first_level, secondary_level, third_level, po_number, supplier_code, 
supplier_name, supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price, tax_amount, amount, 
material_type, buyer_id, buyer, docu_pic, remarks, company_code, company_name, bechmark_price, bechmark_amount,
cd_amount, cd_proportion, account_day, account_amount,
if(dim = 'unknown' and buyer_id in ('HN-7867','HN-18267','HN-13896','HN-4593','HN-6606','FT-3465','FT-2118','HN-12371',
'6048040','6048045','FT-3842','6070094','6113405','DT00013820','DT00010869','36010489','SD-031258','36020298'
,'26017982','DT00000298','6060436','6098623','6119124') ,'4',dim) as dim
FROM dwservice.dws_purchase_report_by_eas where day = '2019-12-05';

	-- 删除 分区 '2019-12-05'的数据。 
	-- hdfs://mycluster/apps/hive/warehouse/dwservice.db/dws_purchase_report_by_eas
alter table dwservice.dws_purchase_report_by_eas drop PARTITION(day='2019-12-05');

select count(1) from dwservice.dws_purchase_report_by_eas where day = '2019-12-12';

-- cnc，冲压，	

--  月结类型 

select * from eas.ods_eas_new_eas75_t_bd_paycondition where fusage = 'PAYMENT'


/**
 * 测试 supplier 和 person 是否每天都执行
 *  
 */

select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_person;  -- 2019-09-24   2019-11-25
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_supplier;  -- 2019-11-14
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_period;  -- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_ct_ls_match;  -- 2019-11-14
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_accountview; -- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_cashflowitem; --2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_currency; -- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_customer;-- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_exchangeaux;-- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_material;-- 2019-11-14
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_materialgroup; -- 2019-11-25
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_materialgroupdetial;-- 2019-11-25
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_measureunit;-- 2019-11-25
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_paycondition;-- 2019-11-25
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_payconditionentry; -- 2019-11-25
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo;-- 2019-11-25
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_bd_vouchertypes; -- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_db_location; -- 2019-11-25
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_db_warehouse;-- 2019-11-25
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_gl_accountbalance;-- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_gl_voucher;-- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_gl_voucherentry; -- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_im_purinwarehsbill; -- 2019-11-14
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_im_purinwarehsentry; -- 2019-11-14
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_org_admin; -- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_org_company; -- 2019-09-24
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_org_company_area_relation2; -- 2019-11-27
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_org_storage;-- 2019-11-14
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_sm_purorder;-- 2019-11-14
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_sm_purorderentry; -- 2019-11-25
select DISTINCT(DAY) from eas.ods_eas_new_eas75_t_sm_purrequest; -- 2019-11-25



---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

select material_name,dim,count(1) as diff_num,sum(num) as count_num from 
(select material_8code,material_name,count(1) as num ,dim,price 
from dwmiddle.dwm_cd_by_material_cut_price_mid
WHERE `date` BETWEEN '2019-01' AND  '2019-12'
group by material_8code,material_name,price,dim)
C group by material_name,dim1
ORDER BY diff_num DESC ,count_num DESC ;

select * from dwmiddle.dwb_purchase_combine_mid_report_eas_final2
where  `DATE` like '201902'
-- material_name like '%测试架%'  and dim = '8'  and
 `DATE` BETWEEN '201901' AND '201912';

select * from dwservice.dws_cd_by_material_cut_price_month3 where material_name  = 'A12.中框耳机密封泡棉组件'

select count(1) from dwservice.dws_cd_by_material_cut_price_month3; -- 999679
select count(1) from dwservice.dws_cd_by_area_day_month3;


select fprice from  eas.ods_eas_new_eas75_t_im_purinwarehsentry;

select material_name from dwmiddle.dwb_purchase_combine_mid_report_eas_final2
where material_name like '%,%';

-- 测试，单价的单位。--
/**
 美元	3117285
港币	24
人民币	6826289
 */
select currency_name,count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final3
group by currency_name;

select  prodect_materiel_name from dwbase.dwb_yifei_display_module
where prodect_materiel_name like '%,%';

select fname_l2 from eas.ods_eas_new_eas75_t_bd_material where fname_l2 like '%,%';
 

select bu_factory_area from dwbase.dwb_yifei_display_module where bu_factory_area like '%江粉%'


select istinct(FHROrgUnitID) from eas.ods_eas_new_eas75_t_bd_person;

select distinct(`day`) from dwservice.dws_cd_by_area_day_month2 

select distinct(LENGTH(`date`)) from  dwservice.dws_cd_by_material_cut_price_month2; -- √
select distinct(LENGTH(`date`)) from  dwservice.dws_cd_by_amount_month2;-- √

select distinct(LENGTH(`date`)) from dwservice.dws_cd_by_area_day_month2;  -- ×
select distinct(LENGTH(`date`)) from  dwservice.dws_cd_by_account_day_month2; -- ×
select distinct(LENGTH(`date`)) from dwservice.dws_cd_by_material_type_month2;  -- x
select distinct(LENGTH(`date`)) from dwservice.dws_cd_by_purchaser_month_year2;  -- x
select distinct(LENGTH(`date`)) from dwservice.dws_cd_by_supplier_month2; -- x

select * from dwmiddle.dwb_purchase_combine_mid_report_eas_final2 ;

select distinct(docu_pic) from dwmiddle.dwb_purchase_combine_mid_report_eas_final;
select count(1) from  dwmiddle.dwb_purchase_combine_mid_report_eas_final; -- 9943598
select count(1) from  dwmiddle.dwb_purchase_combine_mid_report_eas_final2; -- 9943598

select count(1) from  dwmiddle.dwm_eas_material_cd_by_month2 
where standard_price = '' or standard_price is null ;  --  1548072
select count(1) from dwmiddle.dwm_eas_material_company_distinct_cd_by_month2;
select count(1) from dwmiddle.dwm_eas_material_company_distinct_cd_by_month2 
where standard_price = '' or standard_price is null ;
select count(1) from dwservice.dws_cd_by_supplier_month3 where total_amount < 0;
select count(1) from  dwmiddle.dwb_purchase_combine_mid_report_eas_final2 where amount < 0 ; 
select * from eas.ods_eas_new_eas75_t_im_purinwarehsentry where famount < 0 ; 


select DISTINCT(dim) from dwservice.dws_purchase_report_by_eas

-- 681-NVF653-01-B-06  
select count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsbill; -- 1683068
select count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsentry; -- 3158888
select count(1) from eas.ods_eas_new_eas75_t_bd_material; -- 1001786
select count(1) from eas.ods_eas_new_eas75_t_bd_materialgroup; -- 83
select count(1) from eas.ods_eas_new_eas75_t_bd_supplier; --  7169
select count(1) from eas.ods_eas_new_eas75_t_org_storage; -- 39
select count(1) from eas.ods_eas_new_eas75_t_sm_purorder;  --  649472
select count(1) from eas.ods_eas_new_eas75_ct_ls_match;  -- 122812
select count(1) from eas.ods_eas_new_eas75_t_bd_currency; -- 12
select count(1) from eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo ; -- 40073
select count(1) from eas.ods_eas_new_eas75_t_bd_payconditionentry; -- 86
select count(1) from eas.ods_eas_new_eas75_t_org_company;  -- 41
select count(1) from eas.ods_eas_new_eas75_t_org_company_area_relation2;-- 41
select count(1) from eas.ods_eas_new_eas75_t_db_warehouse; --2556
select count(1) from eas.ods_eas_new_eas75_t_bd_measureunit; --20
select count(1) from eas.ods_eas_new_eas75_t_sm_purorderentry; -- 1419171
seLect count(1) from eas.ods_eas_new_eas75_t_sm_purrequest;  -- 61195
seLect count(1) from eas.ods_eas_new_eas75_t_bd_person; -- 7945
