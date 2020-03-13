--------------------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------------------- 
------------
/**
-- 1、mid1_new 设置多分割符，去重，以及以后。
     ALTER TABLE dwmiddle.dwb_purchase_combine_mid1_new SET FILEFORMAT ORC;
	 ALTER TABLE dwmiddle.dwb_purchase_combine_mid_report_eas_new SET FILEFORMAT ORC;
	 ALTER TABLE dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new SET FILEFORMAT ORC;  【表未见】
	 ALTER TABLE dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new SET FILEFORMAT ORC;
	 ALTER TABLE dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb SET FILEFORMAT ORC;
	 ALTER TABLE dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd SET FILEFORMAT ORC;
  链接：http://www.imooc.com/article/252830
  
	2、时间传入正确，relation不用过滤时间。
   -- 3043320
   select count(1) from  dwmiddle.dwb_purchase_combine_mid1_new where day='2019-12-16'
   -- 3079505  
     select count(1) from  dwmiddle.dwb_purchase_combine_mid1_new where day='2019-01-01'
      --   7933585  8036126
     select count(1) from dwmiddle.dwb_purchase_combine_mid1_new3   where day='2019-01-01'
  -- 测试start1 数据是否正常
  select count(1)  from dwmiddle.dwb_purchase_combine_mid1_new3  where day='2020-02-04';
  	select dim,count(1) from dwmiddle.dwb_purchase_combine_mid1_new3  where day='2020-02-04' group by dim;
  select count(1)  from dwmiddle.account_mid where day='2020-02-04';
  select count(1)  from dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3  where day='2020-02-04';  --21480032
  select count(1)  from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-04'; --10829476
  select dim,count(1)  from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-04' 
  group by dim;
  
  select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-04'
  and material_code = '180-QP220150-0000' ;
  
  -- 测试start2 
  select BG,count(1) from dwmiddle.dwb_purchase_standard_price   where day='2020-02-04' group by BG;
  select dim,count(1) from dwmiddle.dwb_purchase_standard_price   where day='2020-02-04' group by dim;
  
-- 测试模具系统，sap（cnc,冲压，模切等）  ，易飞数据
select count(1)  FROM dwbase.dwb_mould_poorder where day='2020-01-15';
select count(1)  FROM sap.ods_sap_zfmm_044_jituan where day='2020-02-04';
select count(1)  FROM dwbase.dwb_yifei_display_module where day='2020-01-02';  -- 319570
**/
--------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------------------- 
--------------------------------------------------------------------------------------------------------------------------------- 
-- 												step开始前准备


						-- step1  生成部分字段 mid1
insert overwrite table  dwmiddle.dwb_purchase_combine_mid1_new partition(day='2019-12-16')
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
        dwmiddle.dwb_purchase_combine_mid1_new mid1
        LEFT JOIN eas.ods_eas_new_eas75_t_sm_purorder G ON G.fnumber = mid1.fpurorderNumber
        LEFT JOIN eas.ods_eas_new_eas75_ct_ls_match H ON H.CFMaterielNumID = mid1.material_fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_currency I ON mid1.FCurrencyID = I.fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo J ON J.fsupplierid = mid1.supplier_fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_payconditionentry K ON K.fparentid = J.fpayconditionid
--' >  combine_eas_mid2.log
*/
						
												
												-- step 二阶段 开始 --
------------------------------------------------------------------------------------------------------------------------------------
--  step1（上接step3） 生成部分报表数据 ，以及去除重复的数据 【 mid1 关联一部分表生成  dwb_purchase_combine_mid_report_eas（报表基本数据【未去重】）】
       -- 78485353
       --  select count(1) from  dwmiddle.dwb_purchase_combine_mid_report_eas_new where day='2019-01-01'
--  step1    1.1-、生成部分报表数据 ， 添加付款条件 【new】 
-- 			 1.2-、以及去除重复的数据

insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_new partition(day="2019-12-16")
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
        dwmiddle.dwb_purchase_combine_mid1_new mid1
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_currency I ON mid1.FCurrencyID = I.fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo J ON J.fsupplierid = mid1.supplier_fid
        LEFT JOIN eas.ods_eas_new_eas75_t_bd_payconditionentry K ON K.fparentid = J.fpayconditionid
        LEFT JOIN eas.eas.ods_eas_new_eas75_t_bd_settlementtype L ON L.out_put_filefid = J.fsettlementtypeid;    
            -- 11822932
        -- select count(1) from  dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new where day='2019-01-01'
        --  1.2 -- 去重   
     insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new partition(day="2019-12-16")
select area,factory_code,factory_area,stock_org_number,stock_org_name,`year`,`month`,`date` ,stock_in_audit_time,secondary_level,third_level,
po_number,supplier_code,supplier_name,supplier_simple_name,material_code,material_8code,material_name,material_model,material_describe,quantity,
unit,currency,currency_name,tax_price,tax_rate,
exchange_rate,price,tax_amount,amount,account_day,material_type,buyer,company_code,company_name,
docu_pic,pay_type,remarks,dim
from dwmiddle.dwb_purchase_combine_mid_report_eas_new where day="2019-12-16"
group by area,factory_code,factory_area,stock_org_number,stock_org_name,`year`,`month`,`date` ,stock_in_audit_time,secondary_level,third_level,
po_number,supplier_code,supplier_name,supplier_simple_name,material_code,material_8code,material_name,material_model,material_describe,quantity,
unit,currency,currency_name,tax_price,tax_rate,
exchange_rate,price,tax_amount,amount,account_day,material_type,buyer,company_code,company_name,
docu_pic,pay_type,remarks,dim;

---------------------------------------------------------------------------------------------------

/**  【old 】【old 】【old 】【ol【old 】d 】【old 】【old 】【old 】【old 】
 * -- 查询  付款方式（计算类型）
  select distinct(fsettlementtypeid) from  eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo  where day='2019-12-16';
 *   添加（供应商关联物料id ）测试 计算CD 
 *    -1.1 获取 正确的汇率  [当月获取当月的。]
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
    
  
 *   -1.2-)、1-- dwb_purchase_combine_mid_report_eas_distinct  全部转化为人民币 
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
 * -- 1.3)、与上一年的月份降序  关联，取标准价
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
 
 *<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  测试  start >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
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
	
	<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  测试 end >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 
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

**/
-- step 2 : 生成stand_price  
		--【 1、添加供应商与物料id 关联得出 stand_price ,在注释中。】
		--【 2、添加遗漏的dim】

-- 		2-1)、取上一年的月份，12，11倒序取值，作为stand_price  [添加 dim（遗漏补加）,stand_exchange_rate，stand_currency_name,stand_date,pay_type 五个字段。]
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new partition(day='2019-12-16')
select B.area,B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
B.stock_in_audit_time, B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name, 
B.supplier_simple_name,B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, B.unit, 
B.currency,B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate, B.price, B.tax_amount, B.amount, B.account_day,
B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name ,  
 B.dim ,B.pay_type,C.stand_exchange_rate,C.stand_currency_name,C.stand_date
,C.stand_price from (select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new where day='2019-12-16') B left join 
(select A.material_code, A.supplier_code,cast(collect_set(A.price)[0] as decimal(28,16)) as stand_price,
cast(collect_set(A.exchange_rate)[0] as decimal(28,16)) as stand_exchange_rate,
collect_set(A.currency_name)[0] as stand_currency_name,
collect_set(A.`date`)[0] as stand_date,
cast(A.`year` as int) + 1 as year from
(select material_code,supplier_code,price,exchange_rate,currency_name,`date`,SUBSTRING(`date`,0,4) as `year` 
from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new where day='2019-12-16' and price > 0 and price is not null 
ORDER by material_code,`date` desc ) A  group by A.material_code,A.supplier_code,A.`year`) C 
on B.material_code = C.material_code and B.supplier_code = C.supplier_code and  SUBSTRING(B.`date`,0,4) = cast(C.year as string);
-- 		2-2)、上一年没取标准价，取当前年份正序有值作为标准价 [添加 dim（遗漏补加）,stand_exchange_rate，stand_currency_name,stand_date, pay_type五个字段。]
-- "'${l_date}'"
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new partition(day='2019-12-16')
select B.area,B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`,
B.stock_in_audit_time, B.secondary_level, B.third_level, B.po_number, B.supplier_code, B.supplier_name, 
B.supplier_simple_name,B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, B.unit, 
B.currency,B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate, B.price, B.tax_amount, B.amount, B.account_day,
B.material_type, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name, 
B.dim,B.pay_type,
if(B.stand_exchange_rate is null or B.stand_exchange_rate = 0,C.stand_exchange_rate,B.stand_exchange_rate) as stand_exchange_rate ,
if(B.stand_currency_name is null or B.stand_currency_name = '',C.stand_currency_name,B.stand_currency_name) as stand_currency_name ,
if(B.stand_date is null or B.stand_date = '',C.stand_date,B.stand_date) as stand_date,
if(B.stand_price is null or B.stand_price = 0,C.stand_price,B.stand_price) as stand_price 
from (select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new where day='2019-12-16') B
left join 
(select A.material_code, A.supplier_code,cast(collect_set(A.price)[0] as decimal(28,16)) as stand_price,
cast(collect_set(A.exchange_rate)[0] as decimal(28,16)) as stand_exchange_rate,
collect_set(A.currency_name)[0] as stand_currency_name,
collect_set(A.`date`)[0] as stand_date,
A.`year` as year from
(select material_code,supplier_code,price,exchange_rate,currency_name,`date`,SUBSTRING(`date`,0,4) as `year` 
from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new where day='2019-12-16' and price > 0 and price is not null  
ORDER by material_code,`date`) A  group by A.material_code,A.supplier_code,A.`year`) C 
on B.material_code = C.material_code and B.supplier_code = C.supplier_code and  SUBSTRING(B.`date`,0,4) = cast(C.year as string);

-- step3 :  换算为正确的汇率值  

	-- 3.1：修正price的汇率值为正确。 【出现stand_price = null ,date = null ,stand_exchange_rate=null】
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new  partition(day="2019-12-16")
SELECT B.area, B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`, B.stock_in_audit_time, B.secondary_level, B.third_level,
 B.po_number, B.supplier_code, B.supplier_name, B.supplier_simple_name, B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, 
 B.unit, B.currency, B.currency_name, B.tax_price, B.tax_rate, 
 if(B.exchange_rate='1' and B.currency_name in('美元','港币') , D.fconvertrate, B.exchange_rate) as exchange_rate ,
 B.price, B.tax_amount, B.amount, B.account_day, B.material_type, B.buyer,
 B.docu_pic, B.remarks, B.company_code, B.company_name, B.dim,B.pay_type, B.stand_exchange_rate, B.stand_currency_name, B.stand_date, B.stand_price
FROM (select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new where day="2019-12-16") B
left join 
(select N.fname_l2, cast(collect_set(N.fconvertrate)[0] as decimal(28,16)) as fconvertrate,N.avail_date from (
select C.fname_l2,A.fconvertrate,concat(split(A.favailtime,'/')[0],split(A.favailtime,'/')[1]) as avail_date
from eas.ods_eas_new_eas75_t_bd_exchangerate  A
INNER JOIN eas.ods_eas_new_eas75_T_BD_ExchangeAux  B on  A.FExchangeAuxID = B.FID
INNER JOIN eas.ods_eas_new_eas75_T_BD_Currency C ON B.FSourceCurrencyID = C.FID ) N
group by N.fname_l2,N.avail_date ) D
on D.avail_date = B.`date` and  D.fname_l2 = B.currency_name ;

--		 3.2：修正stand_price的汇率值为正确 [当前如果标准价的汇率有误，取当前月报日期的汇率]
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new  partition(day="2019-12-16")
SELECT B.area, B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`, B.stock_in_audit_time, B.secondary_level, B.third_level,
 B.po_number, B.supplier_code, B.supplier_name, B.supplier_simple_name, B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, 
 B.unit, B.currency, B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate,
 B.price, B.tax_amount, B.amount, B.account_day, B.material_type, B.buyer,
 B.docu_pic, B.remarks, B.company_code, B.company_name, B.dim,B.pay_type,
 if(B.stand_exchange_rate='1' and B.stand_currency_name in('美元','港币') , D.fconvertrate, B.stand_exchange_rate) as stand_exchange_rate ,
 B.stand_currency_name, B.stand_date, B.stand_price
FROM (select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new where day="2019-12-16") B
left join 
(select N.fname_l2, cast(collect_set(N.fconvertrate)[0] as decimal(28,16)) as fconvertrate,N.avail_date from (
select C.fname_l2,A.fconvertrate,concat(split(A.favailtime,'/')[0],split(A.favailtime,'/')[1]) as avail_date
from eas.ods_eas_new_eas75_t_bd_exchangerate  A
INNER JOIN eas.ods_eas_new_eas75_T_BD_ExchangeAux  B on  A.FExchangeAuxID = B.FID
INNER JOIN eas.ods_eas_new_eas75_T_BD_Currency C ON B.FSourceCurrencyID = C.FID ) N
group by N.fname_l2,N.avail_date ) D
on D.avail_date = B.`date` and  D.fname_l2 = B.stand_currency_name ;
	

/**
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
**/

 --step4
   -- 1、生成基础报表，计算时转换，CD金额根据当前的币别转化。  
   -- 2、生成基础报表全部转化为RMB的数据，保留币别。（便于后续计算）

--   -1.1)、1-- dwb_purchase_combine_mid_report_eas_distinct  全部转化为人民币 
-- 	  	    2-- price 保留6位小数 ，展示保留2位。
-- 			3-- 新增 first_level,采购员名字，
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb partition(day='2019-12-16')
SELECT N.area, N.factory_code, N.factory_area, N.stock_org_number, N.stock_org_name, N.`date`, N.stock_in_audit_time,  
if(V.fname_l2 is null or V.fname_l2 = '',N.secondary_level,V.fname_l2 ) as first_level ,
N.secondary_level, N.third_level, N.po_number, N.supplier_code, N.supplier_name,
 N.supplier_simple_name, N.material_code, N.material_8code, N.material_name, N.material_model, N.quantity, 
 N.unit, N.currency, N.currency_name, N.tax_price, N.tax_rate,  N.exchange_rate,
N.price,N.tax_amount,N.amount, N.account_day, N.material_type, 
 N.buyer_id as buyer_id,N.buyer as buyer, N.docu_pic as docu_pic, 
 N.remarks, N.company_code, N.company_name, N.dim,N.pay_type,N.stand_exchange_rate, N.stand_currency_name, N.stand_date, N.stand_price
from (SELECT B.area, B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`, B.stock_in_audit_time, B.secondary_level, B.third_level,
 B.po_number, B.supplier_code, B.supplier_name, B.supplier_simple_name, B.material_code, B.material_8code, B.material_name, B.material_model, B.quantity, 
 B.unit, B.currency, B.currency_name, 
 if(B.currency_name in ('港币','美元'), round(B.tax_price*B.exchange_rate,6),round(B.tax_price,6)) as tax_price,
 B.tax_rate,  B.exchange_rate,
 if(B.currency_name in ('港币','美元'), round(B.price*B.exchange_rate,6),round(B.price,6)) as price,
 if(B.currency_name in ('港币','美元'), round(B.tax_amount*B.exchange_rate,6),round(B.tax_amount,6)) as tax_amount,
 if(B.currency_name in ('港币','美元'), round(B.amount*B.exchange_rate,6),round(B.amount,6)) as amount,
 B.account_day, B.material_type, 
 A.fnumber as buyer_id,A.fname_l2 as buyer, A.fname_l2 as docu_pic, 
 B.remarks, B.company_code, B.company_name, B.dim,B.pay_type,B.stand_exchange_rate, B.stand_currency_name, B.stand_date,
  if(B.stand_currency_name in ('港币','美元'), round(B.stand_price*B.stand_exchange_rate,6),round(B.stand_price,6)) as stand_price,W.fparentid 
 FROM (select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new where day="2019-12-16") B
 left join (select * from eas.ods_eas_new_eas75_t_bd_person where day="2019-12-16") A  on A.fid = B.buyer 
 LEFT JOIN (select * from eas.ods_eas_new_eas75_t_bd_material where day="2019-12-16") M on M.fnumber = B.material_code
LEFT join (select * from eas.ods_eas_new_eas75_t_bd_materialgroup where day="2019-12-16") W on W.fid = M.fmaterialgroupid )
 N left join  (select * from eas.ods_eas_new_eas75_t_bd_materialgroup where day="2019-12-16") V on V.fid = N.fparentid;


 --   1.2)、1-- 计算CD金额，生成用于计算的报表（RMB）。dwb_purchase_combine_mid_report_eas_final
 /*
select `date`,count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD 
where day='2019-01-01' group by `date`
select dim,count(1)  from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD 
where `date`='202001'  group by dim
*/
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD partition(day='2019-01-01')
SELECT B.area, B.factory_code, B.factory_area, B.stock_org_number, B.stock_org_name, B.`date`, 
B.stock_in_audit_time, B.first_level, B.secondary_level,B.third_level, B.po_number, B.supplier_code, B.supplier_name,
 B.supplier_simple_name, B.material_code, B.material_8code, 
 regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace( B.material_name,'"',''),"'",""),'\\^',''),'\t',''),',','.') as material_name,
 B.material_model, B.quantity,
 B.unit, B.currency, B.currency_name, B.tax_price, B.tax_rate, B.exchange_rate, B.price, B.tax_amount, 
 B.amount,B.stand_price as bechmark_price,(B.stand_price * B.quantity) as bechmark_amount ,
(B.stand_price - B.price)*B.quantity as cd_amount,
(B.stand_price - B.price)*B.quantity/B.amount as cd_proportion,
 B.account_day,B.tax_amount * B.account_day as account_amount,
 B.material_type, B.buyer_id, B.buyer, B.docu_pic, B.remarks, B.company_code, B.company_name, B.pay_type,B.dim
FROM ( select * from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb  where day='2019-01-01') B;


-- 1.3.1) ，未能区分BG的。 1、根据新规则区分 eas的cnd，冲压，模切  。 2、 再根据采购员区分
-- 测试 select count(1) from  dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16' and dim = 'unknown';
-- 3468398
--1.3.1.1
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd partition(day='2019-01-01')	
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, 
if(dim = 'unknown',case SUBSTRING(TRIM(material_code),0,3)
when '581'  then '1'
when '580'  then '2'
when '583'  then '3'
when '587'  then '3'
else 'unknown'
end  ,dim) as dim
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-01-01';

-- 1.3.1.2 
-- 3124069   2183239  
-- 测试 select count(1) from  dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16' and dim = 'unknown';
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd partition(day='2019-01-01')	
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, 
 if(dim = 'unknown',
case when buyer_id  in 
 ('SD-035688','SD-038978','36019570','36017123','36007623','36016676','36016489','DT00015560','SD-000134',
 'SD-000767','36017311','6035689','DT00009170','P-140','S-081','HN-7012','HN-1976','HN-7454','HN-20018',
 'HN-13908','HN-13931','HJ-3429','HJ-4124','HJ-5964','HJ-18828','HJ-22597','XY0087','XY0202','HJ-49885',
 'Y-1210','HJ-37343','HJ-8576','HJ-8197','6047999','6068167','6048732','HN-2756','6113508','6114260','6120244') then '1'
when buyer_id  in 
 ('SZ-11537','36011860','36011960','36013547','36016504','36005445','36018262','6030822','6045186',
 '6102361','P035','6120304','DT00014714','DT00007393','DT00015289','6101279','HN-10645','HN-13923',
 'HN-13930','YP004','6015079','6015457','HN-19934','HJ-12112','HN-3056','HJ-3735','HJ-11323',
 'HJ-16898','HN-18298','HN-16436','P026','P029','HN-14238','HN-2769','F033','P-132','P044','6040630',
 '6047483','6059158','6059501','6098498','6101746','6115318','6115796','6121895') then '2'
when buyer_id  in 
 ('6021254','DT00010621','DT00000952','DT00012071','DT00010170','DT00000683','DT00006360',
 'DT00002009','DT00005673','DT00014024','DT00011361','DT00013641','DT00013986','DT00013988',
 'SZ-7676','DT00009522','DT00010511','DT00005307','DT00011746','6020429','6030191','6048497',
 '6048498','6048508','6078984','6058793','26017833','26015672','26018297','26018374','36017908',
 '26015855','26007906','26012666','6049787','6049835','6060576','6113422','FT-3736','P017','SZ-17217',
 'P-015','70013','P042','P001','FT-1573','P027','SZ-14289','SZ-15172','HN-13852','HN-13869','HN-13886',
 'HN-13941','SZ-6811','P018','FT-698','SZ-14886','83872','SZ-20184','P025','P015','P071','P-129',
 'HR-009','SZ-15384','SZ-12973','P024','FT-3132','FT-874','HN-6419','SZ-1791','HN-4714','SZ-1722',
 'P-120','SZ-1954','SZ-12782','SZ-6693','FT-191','HN-15973','FT-5022','SZ-12190','6008710','SZ-14619',
 'SZ-10192','6008441','82670','6017892','6020364','6025374','FT-403','6027998','6030259','6030761',
 '6033517','6035292','6036281','HJ-41294','6048044','6048030','6048046','6057342','6057370','6078531',
 '6102192','6114252','6115831','6117210','6121918') then '3'
else 'unknown'
end,dim) as dim
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-01-01';


--  1.3)、 -- 剔除 内部交易的数据。

	-- 1.3.1 剔除cnc[1],冲压[2]内部交易维度
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd partition(day='2019-01-01')	
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-01-01'
and dim in ('1','2') and supplier_name not in(select distinct supplier_name as supplier_name2 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
where day='2019-01-01'  and dim in ('1','2') and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16') union all
select distinct(fname_l2) from eas.ods_eas_new_eas75_t_org_company where day='2019-01-01') 
union all
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-01-01'
and dim not in ('1','2') ;

	-- 1.3.2 显示模组 剔除指定内部交易供应商
	-- select count(1) from dwbase.dwb_yifei_display_module where day='2020-01-02'
	-- select day,count(1) from dwbase.dwb_yifei_display_module  group by day where day='2020-01-02'
	insert overwrite table dwbase.dwb_yifei_display_module partition(day='2020-01-02')	
SELECT supplier_code, supplier_name, warehouse_name, warehousing_time, check_return_code, product_materiel_code, 
purchase_code, prodect_materiel_name, standards, check_number, check_return_num, return_num, valuation_return_num,
unit_price, unit, currency, cur_tax_bef_amount, cur_tax, cur_amount, first_level, secondary_level,
bcnottax_unit_price, bctax_unit_price, ori_cur_beftax_amount, ori_cur_tax_rate, ori_cur_amount, 
exchange_rate, delivery_warehouse, damage_num, scrapped_num, location_code, sales_unit, inventory_unit,
us_dollar_unit_price, bu_factory_area, natural_month, supplier_full_name, third_level, tax_unit_price,
nottax_unit_price, bcnottax_amount, cd_amount, tax_rate, whether_designation, ori_factory_proxy, 
days_of_account, buyer, remarks, data_sources FROM dwbase.dwb_yifei_display_module where day='2020-01-02'
and supplier_name not in ('帝晶大洋田第二分厂','帝晶光电','帝晶光电（深圳）','帝晶科技','帝晶科技（OEM事业部)','赣州帝晶','香港帝晶（友达）');


	-- 1.3.3 剔除模切 [3]内部交易维度
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd partition(day='2019-01-01')	
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-01-01'
and dim ='3' and supplier_name not in(select distinct supplier_name as supplier_name2 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
where day='2019-01-01'  and dim ='3' and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16') union all
select distinct(fname_l2) from eas.ods_eas_new_eas75_t_org_company where day='2019-01-01')
and  first_level not in ('成品','半成品')
union all
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-01-01'
and dim ='3' and  first_level  in ('成品','半成品')
union all
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-01-01'
and dim != '3' ;


-- 1.4
 -- 生成磁材基础报表数据
  --  select in_date, quantity,cd_amount, untax_unit_price,pre_untax_unit_price from dwbase.dwb_sap_cicai_by_cd where cd_amount < 0
   -- select count(1) from dwbase.dwb_sap_cicai_by_cd where cd_amount = 0;  --103101
    -- select distinct(in_date) from dwbase.dwb_sap_cicai_by_cd where day = '2019-12-30';
insert overwrite table dwbase.dwb_sap_cicai_by_cd partition(day='2019-12-30')
SELECT supplier_code, supplier_name, po, material_code, material_des, substring(in_date,0,7) as in_date, unit, 
 cast(order_qty as decimal(19,8)) as order_qty2, cast(in_qty as decimal(19,8))  as quanity,
factory_code , factory_des, company_des, tax_unit_price, in_tax_amout, material_group, material_group_des, 
cast(untax_unit_price as decimal(29,8)) as untax_unit_price2 , buyer, pre_tax_unit_price , pre_untax_unit_price, 
(pre_untax_unit_price/cast(unit as int)-untax_unit_price)* cast(in_qty as int) as cd_amount ,
((pre_untax_unit_price/cast(unit as int)-untax_unit_price)* cast(in_qty as int)) /untax_unit_price * cast(in_qty as int)  as cd_proportion,
untax_unit_price * cast(in_qty as int) as amount,
origin, reserved1, reserved2 FROM dwbase.dwb_sap_cicai where day='2019-12-30' and in_date is not null and in_date not in ('0000-00-00','','1');


-- 1.5 生成结构件报表数据
-- select count(1) from dwbase.dwb_sap_jiegoujian_by_cd where day='2020-02-01' and BG = '深圳结构件' and in_date like '%2019%' ;

insert overwrite table dwbase.dwb_sap_jiegoujian_by_cd partition(day='2020-01-01')
SELECT if(factory = '8800','深圳结构件','东莞结构件') as BG ,if(factory = '8800','6','7') as dim,in_date,
concat(substring(in_date,0,4),'-',substring(in_date,6,2)) as `date`,  rkdh, supplier,
po, material, inventory_des, cast(in_qty as decimal(28,16)) as in_qty, cast(tax_unit_price as decimal(28,16)) as tax_unit_price, 
cast( total_price as decimal(28,16)) as total_price , cast( tax_rate as decimal(28,16)) as tax_rate,
purchase_buyer, purchase_no, company_no,  if(factory = '8800','亮彩第一事业部','领益智造（东莞）第二事业部') as company_name,
 factory, delivery_site, delivery_site_des,
purchase_organization, purchase_group, supplier_code, purchase_type, purchase_type_des, 
material_voucher_item, material_group, material_group_des, measurement_unit_stock,
measurement_unit_purchase, lot_no, debtor, pr, currency, cast(net_price as decimal(28,16)) as net_price, price_unit, 
cast(original_currency_unit as decimal(28,16)) as original_currency_unit, tax_code,
cast(original_currency_amount as decimal(28,16)) as original_currency_amount, proof_annual, payment_type,
invoice_number, invoice_date, issue_date, payment_clause, delivery_order, movement_type,
po_voucher_date, posting_people, cast(starting_price as decimal(28,16)) as starting_price , 
 cast(difference_price as decimal(28,16)) as difference_price,
cast(cd_price as decimal(28,16)) as cd_price , first_material, 
second_material, third_material, is_refer, project_number FROM sap.ods_sap_zdmmr027 where day='2020-01-03';

-- 60960
-- select in_date,origin,in_qty,count(1)  FROM dwbase.dwb_sap_cicai where day='2019-12-30'   and in_date like '%0000-00%' group by in_date ,in_qty,origin
-- select in_date,origin,pre_untax_unit_price,in_qty FROM dwbase.dwb_sap_cicai where day='2019-12-30' and in_date like '%0.00000%'
-- select distinct(origin)  FROM dwbase.dwb_sap_cicai where day='2019-12-30' and in_date like '%0.00000%'
-- select in_date,order_qty,quantity,untax_unit_price,pre_untax_unit_price,unit,cd_amount ,amount from   dwbase.dwb_sap_cicai_by_cd where day='2019-12-30' and cd_amount < 0;
-- ,1,10,100,1000,10000,14159.29,32707.96,6.64,74955.75,9690.27,BOX,CM,CT,G,JHR,JUA,KAN,KG,L,LIN,M,M2,M3,PAA,PAK,SET,ST,TO
-- select distinct(unit) from dwbase.dwb_sap_cicai where day='2019-12-30'
--  select * from (select in_qty,count(1) as sum FROM dwbase.dwb_sap_cicai where day='2019-12-30' group by in_qty ) a order by a.sum desc;

/*
-- 报表生成 ------》》》》》》》》》》》》
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


*/ 
-- 【computer】step8 计算其他的CD金额。   
-- select count(1) from dwservice.dws_cd_by_amount_month2 where day='2019-12-12' and cd_amount <0  --495  518   504
-- 一、计算 "时间段采购额" CD分析  
  -- select dim,count(1) from dwservice.dws_cd_by_amount_month3 where day = '2020-02-04' group by dim;
  -- select dim,sum(total_amount) from dwservice.dws_cd_by_amount_month3 where day = '2020-02-04' and `date` = '2020-01' group by dim;
  -- select count(1) from dwservice.dws_cd_by_amount_month3 where day = '2020-01-12' and dim in('6') and `year` like '%2019%'
--insert overwrite table dwservice.dws_cd_by_amount_month2 partition(day='2019-12-05')
insert overwrite table dwservice.dws_cd_by_amount_month3 partition(day='2020-01-12')
select '汇总' as BG, sum(B.cd_amount) as cd_amount,
if(cast(sum(B.cd_amount)/sum(B.total_amount) as string) is null,0,sum(B.cd_amount)/sum(B.total_amount)) as cd_proportion ,
sum(B.total_amount) as total_amount,'10' as dim,`year`,`month`,`date`
from(select case dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'  
ELSE 'unknown' end as BG,if(cast(sum(cd_amount) as string) is null ,0,sum(cd_amount)) as cd_amount,
if(cast(sum(cd_amount)/sum(amount) as string) is null,0,sum(cd_amount)/sum(amount)) as cd_proportion,
if(cast(sum(amount) as string) is null,0,sum(amount)) as total_amount,
dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month` ,
CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final2
group by dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select '显示模组' as BG,if(cast(sum(C.cd_amount) as string) is null ,0,sum(C.cd_amount)) as cd_amount,
 if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount)) as cd_proportion ,
 if(cast(sum(C.amount) as string) is null ,0, sum(C.amount)) as total_amount,dim,`year`,`month`,`date`
from (select  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from  dwbase.dwb_yifei_display_module where day='2020-01-02' ) C group by C.dim,C.`year`,C.`month`,C.`date`
union ALL
select case dim
when '6' then '深圳结构件'
when '7' then '东莞结构件'
ELSE 'unknown' end as BG,if(cast(sum(D.cd_amount) as string) is null ,0, sum(D.cd_amount))  as cd_amount,
 if(cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) as cd_proportion ,
if(cast(sum(D.amount) as string) is null ,0, sum(D.amount)) as total_amount,dim,`year`,`month`,`date`
from (select cast(cd_price as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date` from sap.ODS_SAP_ZDMMR027 where day='2020-01-03') 
D group by D.dim,D.`year`,D.`month`,D.`date`
union all
select '磁材' as BG,if(cast(sum(cd_amount) as string) is null ,0, sum(cd_amount))  as cd_amount,
 if(cast(sum(cd_amount)/sum(amount)  as string) is null ,0 , sum(cd_amount)/sum(amount)) as cd_proportion ,
 if(cast(sum(amount) as string) is null ,0, sum(amount)) as total_amount,'9' as dim,
 SUBSTRING(in_date,0,4) as `year`,
 SUBSTRING(in_date,6,2) as `month`,SUBSTRING(in_date,0,7) as `date`
from dwbase.dwb_sap_cicai_by_cd where day = '2019-12-30' 
group by SUBSTRING(in_date,0,4),SUBSTRING(in_date,6,2),SUBSTRING(in_date,0,7) ) 
B  group by B.`year`,B.`month`,B.`date` 
union all
select case dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
ELSE 'unknown' end as BG,if(cast(sum(cd_amount) as string) is null ,0,sum(cd_amount)) as cd_amount,
if(cast(sum(cd_amount)/sum(amount) as string) is null,0,sum(cd_amount)/sum(amount)) as cd_proportion,
if(cast(sum(amount) as string) is null,0,sum(amount)) as total_amount,
dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month` ,
CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final2
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
group by dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select '显示模组' as BG,if(cast(sum(C.cd_amount) as string) is null ,0,sum(C.cd_amount)) as cd_amount,
 if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount)) as cd_proportion ,
 if(cast(sum(C.amount) as string) is null ,0, sum(C.amount)) as total_amount,dim,`year`,`month`,`date`
from (select  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module where day='2020-01-02' ) C group by C.dim,C.`year`,C.`month`,C.`date`
union ALL
select case dim
when '6' then '深圳结构件'
when '7' then '东莞结构件'
ELSE 'unknown' end as BG,if(cast(sum(D.cd_amount) as string) is null ,0, sum(D.cd_amount))  as cd_amount,
 if(cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) as cd_proportion ,
if(cast(sum(D.amount) as string) is null ,0, sum(D.amount)) as total_amount,dim,`year`,`month`,`date`
from (select cast(cd_price as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date` from sap.ODS_SAP_ZDMMR027 where day='2020-01-03' ) 
D group by D.dim,D.`year`,D.`month`,D.`date`
union all
select '磁材' as BG,if(cast(sum(cd_amount) as string) is null ,0, sum(cd_amount))  as cd_amount,
 if(cast(sum(cd_amount)/sum(amount)  as string) is null ,0 , sum(cd_amount)/sum(amount)) as cd_proportion ,
 if(cast(sum(amount) as string) is null ,0, sum(amount)) as total_amount,'9' as dim,
 SUBSTRING(in_date,0,4) as `year`,
 SUBSTRING(in_date,6,2) as `month`,SUBSTRING(in_date,0,7) as `date`
from dwbase.dwb_sap_cicai_by_cd where day = '2019-12-30' 
group by SUBSTRING(in_date,0,4),SUBSTRING(in_date,6,2),SUBSTRING(in_date,0,7);



-- 二、计算物料降价  波动分析 [相同 物料8码&&物料名称的价格如何取舍？ ==> 按照名称分组，取时间最近的那条 | 汇总时，不同BG，相同物料名称，相同年月的数据，取第一条][物料名称中特殊字符-- 替换]
-- [按照物料名称+dim  的降价幅度，给物料排序]
  -- 备注: 新增设备之后数据，写入day='2019-12-12'
  -- select count(1) from dwmiddle.dwm_cd_by_material_cut_price_mid where day = '2020-01-01' and dim in ('6') and `month` like '%2019%'
--select material_8code,count(1) from (

-- select distinct(length(`date`))  from dwservice.dws_cd_by_material_cut_price_month2;
-- select distinct(dim)  from dwservice.dws_cd_by_material_cut_price_month3 where day='2020-01-01';
insert overwrite table dwmiddle.dwm_cd_by_material_cut_price_mid partition(day='2020-01-01')
select collect_set(W.material_8code)[0] as material_8code,W.material_name,collect_set(W.price)[0] as price,'10' as dim ,W.`year`,W.`month`,W.`date`
from (select A.* from (
select collect_set(if(material_8code is null or material_8code = '' ,material_code,material_8code))[0] as material_8code,
regexp_replace(regexp_replace(material_name,'"',''),"'","") as material_name,
collect_set(price)[0] as price,dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final2
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
group by material_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date` order by `date` desc ) A
union ALL
select collect_set(product_materiel_code)[0] as material_8code,regexp_replace(regexp_replace(prodect_materiel_name,'"',''),"'","") as material_name,
collect_set(unit_price)[0] as price,'8' as dim,SUBSTRING(natural_month,0,4) as `year`,
SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
-- from dwbase.dwb_yifei_display_module
from  dwbase.dwb_yifei_display_module where day='2020-01-02'
group by prodect_materiel_name,SUBSTRING(natural_month,0,4),SUBSTRING(natural_month,5,2),CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2))
union ALL
select collect_set(material)[0] AS  material_8code ,regexp_replace(regexp_replace(inventory_des,'"',''),"'","") as material_name ,  
(cast(collect_set(original_currency_unit)[0] as decimal(28,16)) )as price,
if(factory = '8800','6','7') as dim ,SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date` from sap.ODS_SAP_ZDMMR027 where day='2020-01-03'
group by inventory_des,if(factory = '8800','6','7'),SUBSTRING(in_date,0,4),  SUBSTRING(in_date,6,2)  ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))
union all
select collect_set(material_code)[0] AS  material_8code,regexp_replace(regexp_replace(material_des,'"',''),"'","") as material_name ,
collect_set(untax_unit_price)[0] as price,'9' as dim, SUBSTRING(in_date,0,4) as `year`,
 SUBSTRING(in_date,6,2) as `month`,SUBSTRING(in_date,0,7) as `date`
from dwbase.dwb_sap_cicai_by_cd where day = '2019-12-30' 
group by material_des,SUBSTRING(in_date,0,4),SUBSTRING(in_date,6,2),SUBSTRING(in_date,0,7))
W group by  W.material_name,W.`year`,W.`month`,W.`date`
union ALL    
select A.* from (
select collect_set(if(material_8code is null or material_8code = '' ,material_code,material_8code))[0] as material_8code,
regexp_replace(regexp_replace(material_name,'"',''),"'","") as material_name,
collect_set(price)[0] as price,dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final2
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
group by material_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date` order by `date` desc ) A
union ALL
select collect_set(product_materiel_code)[0] as material_8code,regexp_replace(regexp_replace(prodect_materiel_name,'"',''),"'","") as material_name,
collect_set(unit_price)[0] as price,'8' as dim,SUBSTRING(natural_month,0,4) as `year`,
SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
-- from dwbase.dwb_yifei_display_module
from dwbase.dwb_yifei_display_module where day='2020-01-02'
group by prodect_materiel_name,SUBSTRING(natural_month,0,4),SUBSTRING(natural_month,5,2),CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2))
union ALL
select collect_set(material)[0] AS  material_8code ,regexp_replace(regexp_replace(inventory_des,'"',''),"'","") as material_name ,
(cast(collect_set(original_currency_unit)[0] as decimal(28,16)) )as price,
if(factory = '8800','6','7') as dim ,SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date` from sap.ODS_SAP_ZDMMR027 where day='2020-01-03'
group by inventory_des,if(factory = '8800','6','7'),SUBSTRING(in_date,0,4) ,  SUBSTRING(in_date,6,2)  ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))
union all
select collect_set(material_code)[0] AS  material_8code,regexp_replace(regexp_replace(material_des,'"',''),"'","") as material_name ,
collect_set(untax_unit_price)[0] as price,'9' as dim, SUBSTRING(in_date,0,4) as `year`,
 SUBSTRING(in_date,6,2) as `month`,SUBSTRING(in_date,0,7) as `date`
from dwbase.dwb_sap_cicai_by_cd where day = '2019-12-30' 
group by material_des,SUBSTRING(in_date,0,4),SUBSTRING(in_date,6,2),SUBSTRING(in_date,0,7);
-- ) total group by material_8code,material_name,price,dim ;

-- 生成  降价幅度排名 ,价格波动数量排名，价格数量排名
-- insert overwrite table dwservice.dws_cd_by_material_cut_price_month2 partition(day='2019-12-05')
-- select BG,count(1) from dwservice.dws_cd_by_material_cut_price_month3 where day = '2020-02-04' group by BG
-- select count(1) from dwservice.dws_cd_by_material_cut_price_month3 where day = '2020-01-12' and dim = '7' and `year` like '%2019%'
insert overwrite table dwservice.dws_cd_by_material_cut_price_month3 partition(day='2020-01-12')
select case A.dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE 'unknown' end as BG,A.material_8code, A.material_name, A.price,B.diff_num,B.count_num, A.dim, A.`month`, A.`year`, A.`date`
 from ( select * from dwmiddle.dwm_cd_by_material_cut_price_mid  where day='2020-01-01')A  right join 
(select material_8code,material_name,dim,count(1) as diff_num,sum(num) as count_num from 
(select material_8code,material_name,count(1) as num ,dim,price from dwmiddle.dwm_cd_by_material_cut_price_mid
where day='2020-01-01' group by material_8code,material_name,price,dim) C group by material_8code,material_name,dim) B 
on A.material_8code = B.material_8code 
and A.material_name = B.material_name and A.dim = B.dim;

-- select count(1) from dwservice.dws_cd_by_material_cut_price_month2  where day='2019-12-12';
-- select count(1) from dwservice.dws_cd_by_material_cut_price_month2  where day='2019-12-05';
-- 三、左上角 统计，所有BG统计 

-- 四、物料类型CD金额。（根据dwmiddle.dwb_purchase_combine_mid_report_eas_final3中的first_level）
  -- 备注: 新增设备之后数据，写入day='2019-12-12'
--insert overwrite table dwservice.dws_cd_by_material_type_month2 partition(day='2019-12-05')
-- select count(1) from dwservice.dws_cd_by_material_type_month2 where day='2019-12-16'
-- select count(1) from dwservice.dws_cd_by_material_type_month3 where day = '2020-01-12' and dim = '6' and `year` like '%2019%'
-- select BG,count(1) from dwservice.dws_cd_by_material_type_month3 where day = '2020-02-04' group by BG;
-- 
insert overwrite table dwservice.dws_cd_by_material_type_month3 partition(day='2020-01-12')
select '汇总' as BG,P.material_type ,sum(P.cd_amount) as cd_amount,if( cast(sum(P.cd_amount)/sum(P.amount) as string) is null ,0 ,sum(P.cd_amount)/sum(P.amount)) as cd_proportion ,sum(P.amount) as amount,'10' as dim,P.`year`,P.`month`,P.`date`
from(select  case dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
ELSE 'unknown' end as BG,first_level as material_type,
if(cast(sum(cd_amount) as string) is null ,0,sum(cd_amount)) as cd_amount,
if(cast(sum(cd_amount)/sum(amount) as string) is null,0,sum(cd_amount)/sum(amount)) as cd_proportion,
if(cast(sum(amount) as string) is null,0,sum(amount)) as amount,
dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final3
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
group by first_level,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select '显示模组' as BG, C.material_type,sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount,dim,`year`,`month`,`date`
from (select first_level as material_type,  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module where day='2020-01-02'  ) C group by C.material_type,C.dim,C.`year`,C.`month`,C.`date`
union ALL
select case dim
when '6' then '深圳结构件'
when '7' then '东莞结构件'
ELSE 'unknown' end as BG, D.material_type,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select split(material_group_des,'-')[0] as material_type,cast(cd_price as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date`
from sap.ODS_SAP_ZDMMR027 where day='2020-01-03') D group by D.material_type,D.dim,D.`year`,D.`month`,D.`date`)
p group by P.material_type,P.`year`,P.`month`,P.`date`
union all
select  case dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
ELSE 'unknown' end as BG,first_level as material_type,
if(cast(sum(cd_amount) as string) is null ,0,sum(cd_amount)) as cd_amount,
if(cast(sum(cd_amount)/sum(amount) as string) is null,0,sum(cd_amount)/sum(amount)) as cd_proportion,
if(cast(sum(amount) as string) is null,0,sum(amount)) as amount,
dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final3
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
group by first_level,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select '显示模组' as BG, C.material_type,sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount,dim,`year`,`month`,`date`
from (select first_level as material_type,  if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module where day='2020-01-02' ) C group by C.material_type,C.dim,C.`year`,C.`month`,C.`date`
union ALL
select case dim
when '6' then '深圳结构件'
when '7' then '东莞结构件'
ELSE 'unknown' end as BG, D.material_type,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select split(material_group_des,'-')[0] as material_type,cast(cd_price as DECIMAL(28,16)) as cd_amount,
-- (cast(WSCD as DECIMAL(28,16))/cast(ZPRCZ as DECIMAL(28,16))) as cd_proportion , 
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date`
from sap.ODS_SAP_ZDMMR027 where day='2020-01-03') D group by D.material_type,D.dim,D.`year`,D.`month`,D.`date`;

-- select DISTINCT(length(`date`)) from dwservice.dws_cd_by_material_type_month2;

-- 五、供应商 的cd金额报表数 【账期天数， 原始数据order by account_day 取最大值】  
-- select distinct(`day`) from dwservice.dws_cd_by_supplier_month2;
-- select DISTINCT(length(`date`)) from dwservice.dws_cd_by_supplier_month2;
    -- 备注: 新增设备之后数据，写入day='2019-12-12'
-- insert overwrite table dwservice.dws_cd_by_supplier_month2 partition(day='2019-12-06') 
-- -- select BG,count(1) from dwservice.dws_cd_by_supplier_month3 where day = '2020-02-04' group by BG
 -- select BG,sum(total_amount) from dwservice.dws_cd_by_supplier_month3 where day = '2020-02-04' group by BG
-- -- select count(1) from dwservice.dws_cd_by_supplier_month3 where day = '2020-01-12'and dim = '6' and `year` like '%2019%'
insert overwrite table dwservice.dws_cd_by_supplier_month3 partition(day='2020-01-12') 
select '汇总' as BG,E.supplier_code,E.supplier_name,sum(E.cd_amount) as cd_amount,
if(cast(sum(E.cd_amount)/sum(E.amount) as string) is null , 0,sum(E.cd_amount)/sum(E.amount)) as cd_proportion ,sum(E.amount) as amount,
collect_set(E.account_day)[0] as account_day,'10' as dim,E.`year`,E.`month`,E.`date`
from 
(select M.* from 
(select case N.dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
ELSE 'unknown' end as BG, N.supplier_code,N.supplier_name,
if(cast(sum(N.cd_amount) as string) is null ,0,sum(N.cd_amount)) as cd_amount,
if(cast(sum(N.cd_amount)/sum(N.amount) as string) is null,0,sum(N.cd_amount)/sum(N.amount)) as cd_proportion,
if(cast(sum(N.amount) as string) is null,0,sum(N.amount)) as amount,
collect_set(N.account_day)[0] as account_day,
N.dim,SUBSTRING(N.`date`,0,4) as `year`,SUBSTRING(N.`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(N.`date`,0,4), SUBSTRING(N.`date`,5,2)) as `date`
from (select *  from
-- dwmiddle.dwb_purchase_combine_mid_report_eas_final3  
dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
order by account_day desc) N 
group by supplier_code,supplier_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select '显示模组' as BG,C.supplier_code,C.supplier_name, sum(C.cd_amount) as cd_amount,
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
from dwbase.dwb_yifei_display_module where day='2020-01-02'  order by account_day desc  ) C group by C.supplier_code,C.supplier_name, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select case dim
when '6' then '深圳结构件'
when '7' then '东莞结构件'
ELSE 'unknown' end as BG,D.supplier_code,D.supplier_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 ,
sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,
collect_set(D.account_day)[0] as account_day,dim,`year`,`month`,`date`
from (select supplier_code,supplier as supplier_name, cast(cd_price as DECIMAL(28,16)) as cd_amount,
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,'' as account_day,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date`
from sap.ODS_SAP_ZDMMR027  where day='2020-01-03'
) D group by  D.supplier_code,D.supplier_name,D.dim,D.`year`,D.`month`,D.`date` 
union all
select '磁材' as BG,supplier_code,supplier_name,if(cast(sum(cd_amount) as string) is null ,0, sum(cd_amount))  as cd_amount,
 if(cast(sum(cd_amount)/sum(amount)  as string) is null ,0 , sum(cd_amount)/sum(amount)) as cd_proportion ,
 if(cast(sum(amount) as string) is null ,0, sum(amount)) as total_amount,'' as account_day, '9' as dim,
 SUBSTRING(in_date,0,4) as `year`, SUBSTRING(in_date,6,2) as `month`,SUBSTRING(in_date,0,7) as `date`
from dwbase.dwb_sap_cicai_by_cd where day = '2019-12-30' 
group by supplier_code,supplier_name,SUBSTRING(in_date,0,4),SUBSTRING(in_date,6,2),SUBSTRING(in_date,0,7))M order by M.account_day desc
) E group by  E.supplier_code,E.supplier_name,E.`year`,E.`month`,E.`date` 
union all
select case N.dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
ELSE 'unknown' end as BG,N.supplier_code,N.supplier_name,
if(cast(sum(N.cd_amount) as string) is null ,0,sum(N.cd_amount)) as cd_amount,
if(cast(sum(N.cd_amount)/sum(N.amount) as string) is null,0,sum(N.cd_amount)/sum(N.amount)) as cd_proportion,
if(cast(sum(N.amount) as string) is null,0,sum(N.amount)) as amount,
collect_set(N.account_day)[0] as account_day,
N.dim,SUBSTRING(N.`date`,0,4) as `year`,SUBSTRING(N.`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(N.`date`,0,4), SUBSTRING(N.`date`,5,2)) as `date`
from (select *  from 
-- dwmiddle.dwb_purchase_combine_mid_report_eas_final3 
dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
order by account_day desc) N 
group by supplier_code,supplier_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select '显示模组' as BG,C.supplier_code,C.supplier_name, sum(C.cd_amount) as cd_amount,
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
from dwbase.dwb_yifei_display_module where day='2020-01-02' order by account_day desc  ) C group by C.supplier_code,C.supplier_name, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select case dim
when '6' then '深圳结构件'
when '7' then '东莞结构件'
ELSE 'unknown' end as BG,D.supplier_code,D.supplier_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 ,
sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,
collect_set(D.account_day)[0] as account_day,dim,`year`,`month`,`date`
from (select supplier_code,supplier as supplier_name, cast(cd_price as DECIMAL(28,16)) as cd_amount,
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,'' as account_day,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date`
from sap.ODS_SAP_ZDMMR027  where day='2020-01-03'
) D group by  D.supplier_code,D.supplier_name,D.dim,D.`year`,D.`month`,D.`date`
union all
select '磁材' as BG,supplier_code,supplier_name,if(cast(sum(cd_amount) as string) is null ,0, sum(cd_amount))  as cd_amount,
 if(cast(sum(cd_amount)/sum(amount)  as string) is null ,0 , sum(cd_amount)/sum(amount)) as cd_proportion ,
 if(cast(sum(amount) as string) is null ,0, sum(amount)) as total_amount,'' as account_day, '9' as dim,
 SUBSTRING(in_date,0,4) as `year`, SUBSTRING(in_date,6,2) as `month`,SUBSTRING(in_date,0,7) as `date`
from dwbase.dwb_sap_cicai_by_cd where day = '2019-12-30' 
group by supplier_code,supplier_name,SUBSTRING(in_date,0,4),SUBSTRING(in_date,6,2),SUBSTRING(in_date,0,7);


-- select distinct(length(`date`)) from dwservice.dws_cd_by_supplier_month2;
-- select DISTINCT(`day`)  from  dwservice.dws_cd_by_supplier_month2
/**
-- 六、账期天数 的cd金额报表数据  【根据供应商表，生成】
-- select DISTINCT(`day`)  from dwservice.dws_cd_by_account_day_month2;
-- select distinct(length(`date`)) from dwservice.dws_cd_by_account_day_month2;
-- insert overwrite table dwservice.dws_cd_by_account_day_month2 partition(day='2019-12-05')
insert overwrite table dwservice.dws_cd_by_account_day_month2 partition(day='2019-12-16')
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
from  dwservice.dws_cd_by_supplier_month2 where day = '2019-12-16') 
D group by  D.account_day,D.dim,D.`year`,D.`month`,D.`date`  ;
**/
-- 五-五  、供应商  加上 付款条件 = =====
--  的cd金额报表数 【账期天数， 原始数据order by account_day 取最大值】  
-- select distinct(`day`) from dwservice.dws_cd_by_supplier_month2;
-- select DISTINCT(length(`date`)) from dwservice.dws_cd_by_supplier_month2;
    -- 备注: 新增设备之后数据，写入day='2019-12-12'
-- insert overwrite table dwservice.dws_cd_by_supplier_month2 partition(day='2019-12-06') 

insert overwrite table dwservice.dws_cd_by_supplier_pay_type_month2 partition(day='2020-01-12') 
select E.supplier_code,E.supplier_name,sum(E.cd_amount) as cd_amount,
if(cast(sum(E.cd_amount)/sum(E.amount) as string) is null , 0,sum(E.cd_amount)/sum(E.amount)) as cd_proportion ,sum(E.amount) as amount,
collect_set(E.account_day)[0] as account_day,collect_set(E.pay_type)[0] as pay_type,
'10' as dim,E.`year`,E.`month`,E.`date`
from 
(select M.* from 
(select N.supplier_code,N.supplier_name,
if(cast(sum(N.cd_amount) as string) is null ,0,sum(N.cd_amount)) as cd_amount,
if(cast(sum(N.cd_amount)/sum(N.amount) as string) is null,0,sum(N.cd_amount)/sum(N.amount)) as cd_proportion,
if(cast(sum(N.amount) as string) is null,0,sum(N.amount)) as amount,
collect_set(N.account_day)[0] as account_day,
collect_set(N.pay_type)[0] as pay_type,
N.dim,SUBSTRING(N.`date`,0,4) as `year`,SUBSTRING(N.`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(N.`date`,0,4), SUBSTRING(N.`date`,5,2)) as `date`
from (select *  from
-- dwmiddle.dwb_purchase_combine_mid_report_eas_final3  
dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
order by account_day desc) N 
group by supplier_code,supplier_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select C.supplier_code,C.supplier_name, sum(C.cd_amount) as cd_amount,
 if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount)) as cd_proportion ,
sum(C.amount) as amount ,collect_set(C.account_day)[0] as account_day,'' as pay_type,dim,`year`,`month`,`date`
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
from dwbase.dwb_yifei_display_module where day='2020-01-02'  order by account_day desc  ) C group by C.supplier_code,C.supplier_name, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.supplier_code,D.supplier_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 ,
sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,
collect_set(D.account_day)[0]  as account_day,collect_set(D.pay_type)[0]  as pay_type,
dim,`year`,`month`,`date`
from (select supplier_code,supplier as supplier_name, cast(cd_price as DECIMAL(28,16)) as cd_amount,
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,'' as account_day, payment_type as pay_type,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date`
from sap.ODS_SAP_ZDMMR027  where day='2020-01-03'
) D group by  D.supplier_code,D.supplier_name,D.dim,D.`year`,D.`month`,D.`date` )M order by M.account_day desc
) E group by  E.supplier_code,E.supplier_name,E.`year`,E.`month`,E.`date` 
union all
select N.supplier_code,N.supplier_name,
if(cast(sum(N.cd_amount) as string) is null ,0,sum(N.cd_amount)) as cd_amount,
if(cast(sum(N.cd_amount)/sum(N.amount) as string) is null,0,sum(N.cd_amount)/sum(N.amount)) as cd_proportion,
if(cast(sum(N.amount) as string) is null,0,sum(N.amount)) as amount,
collect_set(N.account_day)[0] as account_day,
collect_set(N.pay_type)[0] as pay_type,
N.dim,SUBSTRING(N.`date`,0,4) as `year`,SUBSTRING(N.`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(N.`date`,0,4), SUBSTRING(N.`date`,5,2)) as `date`
from (select *  from 
-- dwmiddle.dwb_purchase_combine_mid_report_eas_final3 
dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
order by account_day desc) N 
group by supplier_code,supplier_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select C.supplier_code,C.supplier_name, sum(C.cd_amount) as cd_amount,
 if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount)) as cd_proportion ,
sum(C.amount) as amount ,collect_set(C.account_day)[0] as account_day,'' as pay_type,dim,`year`,`month`,`date`
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
from dwbase.dwb_yifei_display_module where day='2020-01-02' order by account_day desc  ) C group by C.supplier_code,C.supplier_name, C.dim,C.`year`,C.`month`,C.`date`
union ALL
select D.supplier_code,D.supplier_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 ,
sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,
collect_set(D.account_day)[0]  as account_day,collect_set(D.pay_type)[0]  as pay_type,
dim,`year`,`month`,`date`
from (select supplier_code,supplier as supplier_name, cast(cd_price as DECIMAL(28,16)) as cd_amount,
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,'' as account_day, payment_type as pay_type,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date`
from sap.ODS_SAP_ZDMMR027  where day='2020-01-03'
) D group by  D.supplier_code,D.supplier_name,D.dim,D.`year`,D.`month`,D.`date`  ;




-- 五.六、账期天数   + 付款配型  ----- 的cd金额报表数据  【根据供应商表，生成】
-- select DISTINCT(`day`)  from dwservice.dws_cd_by_account_day_month2;
-- select distinct(length(`date`)) from dwservice.dws_cd_by_account_day_month2;
-- insert overwrite table dwservice.dws_cd_by_account_day_month2 partition(day='2019-12-05')
--  select BG,count(1) from dwservice.dws_cd_by_account_day_pay_type_month where day = '2020-01-01' group by BG
--   select BG,sum(total_amount) from dwservice.dws_cd_by_account_day_pay_type_month where day = '2020-02-04' group by BG
insert overwrite table dwservice.dws_cd_by_account_day_pay_type_month partition(day='2020-01-12')
select D.BG,D.account_day,D.pay_type,sum(D.cd_amount) as cd_amount,
sum(D.cd_amount)/sum(D.total_amount) as cd_proportion,
sum(D.total_amount) as total_amount,
D.dim,D.`year`,D.`month`,D.`date` 
from (select 
case dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE 'unknown' end as BG,
case account_day
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
pay_type,
cd_amount,
total_amount,
dim,`year`,`month`,`date`
from  dwservice.dws_cd_by_supplier_pay_type_month2 where day = '2020-01-12') 
D group by  D.account_day,D.pay_type,D.BG,D.dim,D.`year`,D.`month`,D.`date`  ;



-- 七、区域  的cd金额报表数据  【根据供应商表，生成】
-- sdwmiddle.dwb_purchase_report_cd_tmpelect distinct(length(`date`)) from  dwservice.dws_cd_by_area_day_month2;
-- select DISTINCT(`day`)  from dwservice.dws_cd_by_area_day_month2;
-- insert overwrite table dwservice.dws_cd_by_area_day_month2 partition(day='2019-11-25')
-- select BG,count(1) from dwservice.dws_cd_by_area_day_month3 where day = '2020-02-04' group by BG
-- select BG,sum(total_amount) from dwservice.dws_cd_by_area_day_month3 where day = '2020-02-04' group by BG
insert overwrite table dwservice.dws_cd_by_area_day_month3 partition(day='2020-01-12')
select '汇总' as BG,W.area,W.company_name, sum(W.cd_amount) as cd_amount,
if (cast(sum(W.cd_amount)/sum(W.amount) as string) is null ,0, sum(W.cd_amount)/sum(W.amount)) as cd_proportion ,
sum(W.amount) as amount,'10'as dim,W.`year`,W.`month`,W.`date`
from(select case dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
ELSE 'unknown' end as BG,A.area,A.company_name, sum(A.cd_amount) as cd_amount,
if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount)) as cd_proportion ,
sum(A.amount) as amount,dim,
SUBSTRING(A.`date`,0,4) as `year`,SUBSTRING(A.`date`,5,2) as `month`,
CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2)) as `date`
--from  dwmiddle.dwb_purchase_combine_mid_report_eas_final3  A 
from ( select * from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01' ) A 
group by A.area,A.company_name,A.dim,SUBSTRING(A.`date`,0,4),SUBSTRING(A.`date`,5,2),CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2))  
union ALL
select '显示模组' as BG,C.area, C.company_name , sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select '华南' as area, bu_factory_area as company_name ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module where day='2020-01-02'   ) C group by  C.area,C.company_name, C.dim,C.`year`,C.`month`,C.`date`
union all
select case dim
when '6' then '深圳结构件'
when '7' then '东莞结构件'
ELSE 'unknown' end as BG,D.area,D.company_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select '华南' as area,
'' as industry_area,if(factory = '8800','亮彩第一事业部','领益智造（东莞）第二事业部') as company_name, cast(cd_price as DECIMAL(28,16)) as cd_amount,
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date`
from sap.ODS_SAP_ZDMMR027  where day='2020-01-03'
) D group by  D.area,D.company_name,D.dim,D.`year`,D.`month`,D.`date`
union all
select '磁材' as BG,'华南' as area,company_des as company_name ,if(cast(sum(cd_amount) as string) is null ,0, sum(cd_amount))  as cd_amount,
 if(cast(sum(cd_amount)/sum(amount)  as string) is null ,0 , sum(cd_amount)/sum(amount)) as cd_proportion ,
 if(cast(sum(amount) as string) is null ,0, sum(amount)) as total_amount, '9' as dim,
 SUBSTRING(in_date,0,4) as `year`, SUBSTRING(in_date,6,2) as `month`,SUBSTRING(in_date,0,7) as `date`
from dwbase.dwb_sap_cicai_by_cd where day = '2020-02-04' 
group by company_des,SUBSTRING(in_date,0,4),SUBSTRING(in_date,6,2),SUBSTRING(in_date,0,7))
W group by  W.area,W.company_name,W.`year`,W.`month`,W.`date`
UNION ALL
select case dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
ELSE 'unknown' end as BG,A.area,A.company_name, sum(A.cd_amount) as cd_amount,
if (cast(sum(A.cd_amount)/sum(A.amount) as string) is null ,0, sum(A.cd_amount)/sum(A.amount)) as cd_proportion ,
sum(A.amount) as amount,dim,
SUBSTRING(A.`date`,0,4) as `year`,SUBSTRING(A.`date`,5,2) as `month`,
CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2)) as `date`
--from  dwmiddle.dwb_purchase_combine_mid_report_eas_final3  A 
from  ( select * from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01' )   A 
group by A.area,A.company_name,A.dim,SUBSTRING(A.`date`,0,4),SUBSTRING(A.`date`,5,2),CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2))  
union ALL
select '显示模组' as BG, C.area, C.company_name , sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select '华南' as area, bu_factory_area as company_name ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
 from  dwbase.dwb_yifei_display_module where day='2020-01-02'  ) C group by  C.area,C.company_name, C.dim,C.`year`,C.`month`,C.`date`
union all
select case dim
when '6' then '深圳结构件'
when '7' then '东莞结构件'
ELSE 'unknown' end as BG,D.area,D.company_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select '华南' as area,
'' as industry_area,if(factory = '8800','亮彩第一事业部','领益智造（东莞）第二事业部') as company_name, cast(cd_price as DECIMAL(28,16)) as cd_amount,
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date`
from sap.ODS_SAP_ZDMMR027  where day='2020-01-03'
) D group by  D.area,D.company_name,D.dim,D.`year`,D.`month`,D.`date`
union all
select '磁材' as BG,'华南' as area,company_des as company_name ,if(cast(sum(cd_amount) as string) is null ,0, sum(cd_amount))  as cd_amount,
 if(cast(sum(cd_amount)/sum(amount)  as string) is null ,0 , sum(cd_amount)/sum(amount)) as cd_proportion ,
 if(cast(sum(amount) as string) is null ,0, sum(amount)) as total_amount, '9' as dim,
 SUBSTRING(in_date,0,4) as `year`, SUBSTRING(in_date,6,2) as `month`,SUBSTRING(in_date,0,7) as `date`
from dwbase.dwb_sap_cicai_by_cd where day = '2019-12-30' 
group by company_des,SUBSTRING(in_date,0,4),SUBSTRING(in_date,6,2),SUBSTRING(in_date,0,7);



/**
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
from  ( select * from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-12-16' ) A
group by buyer,dim,SUBSTRING(A.`date`,0,4),SUBSTRING(A.`date`,5,2),CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2))
union ALL
select C.buyer as person_name, sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select  buyer ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,
SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from (select * from  dwbase.dwb_yifei_display_module where day='2019-12-16' ) ) C group by C.buyer, C.dim,C.`year`,C.`month`,C.`date`
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
from  ( select * from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-12-16' )A
group by buyer,dim,SUBSTRING(A.`date`,0,4),SUBSTRING(A.`date`,5,2),CONCAT_WS('-', SUBSTRING(A.`date`,0,4), SUBSTRING(A.`date`,5,2))
union ALL
select C.buyer as person_name, sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount ,dim,`year`,`month`,`date`
from (select  buyer ,if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,
SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from (select * from  dwbase.dwb_yifei_display_module where day='2019-12-16' )  ) C group by C.buyer, C.dim,C.`year`,C.`month`,C.`date`
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


**/
-- select count(1) from dwservice.dws_cd_by_purchaser_month_year2 where  day= '2019-12-12' 
-- select count(1) from dwservice.dws_cd_by_purchaser_month_year2 where  day= '2019-12-06' 

	
-- 九、物料名称（物料类型）的CD金额。（根据dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD中的first_level）
  -- 备注: 新增设备之后数据，写入day='2019-12-12'
--insert overwrite table dwservice.dws_cd_by_material_type_month2 partition(day='2019-12-05')
--  select BG,count(1) from dwservice.dws_cd_by_material_month3 where day = '2020-02-04' group by BG
--  select BG,sum(total_amount) from dwservice.dws_cd_by_material_month3 where day = '2020-02-04' group by BG
-- select count(1) from dwservice.dws_cd_by_material_month3 where day = '2020-01-12'and dim = '6' and `year` like '%2019%'
insert overwrite table dwservice.dws_cd_by_material_month3 partition(day='2020-01-12')
select '汇总' as BG,P.material_type ,P.material_name ,sum(P.cd_amount) as cd_amount,if( cast(sum(P.cd_amount)/sum(P.amount) as string) is null ,0 ,sum(P.cd_amount)/sum(P.amount)) as cd_proportion ,sum(P.amount) as amount,'10' as dim,P.`year`,P.`month`,P.`date`
from(select case dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
ELSE 'unknown' end as BG,first_level as material_type,material_name,
if(cast(sum(cd_amount) as string) is null ,0,sum(cd_amount)) as cd_amount,
if(cast(sum(cd_amount)/sum(amount) as string) is null,0,sum(cd_amount)/sum(amount)) as cd_proportion,
if(cast(sum(amount) as string) is null,0,sum(amount)) as amount,
dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final3
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
group by first_level,material_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select '显示模组' as BG, C.material_type, C.material_name,sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount,dim,`year`,`month`,`date`
from (select first_level as material_type, prodect_materiel_name as material_name , if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from  dwbase.dwb_yifei_display_module where day='2020-01-02' ) C group by C.material_type,C.material_name,C.dim,C.`year`,C.`month`,C.`date`
union ALL
select case dim
when '6' then '深圳结构件'
when '7' then '东莞结构件'
ELSE 'unknown' end as BG, D.material_type,D.material_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select split(material_group_des,'-')[0] as material_type,regexp_replace(regexp_replace(inventory_des,'"',''),"'","") as material_name ,
cast(cd_price as DECIMAL(28,16)) as cd_amount,
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date`
from sap.ODS_SAP_ZDMMR027 where day='2020-01-03') D group by D.material_type,D.material_name,D.dim,D.`year`,D.`month`,D.`date`)
p group by P.material_type,P.material_name,P.`year`,P.`month`,P.`date`
union all
select case dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
ELSE 'unknown' end as BG,first_level as material_type,material_name,
if(cast(sum(cd_amount) as string) is null ,0,sum(cd_amount)) as cd_amount,
if(cast(sum(cd_amount)/sum(amount) as string) is null,0,sum(cd_amount)/sum(amount)) as cd_proportion,
if(cast(sum(amount) as string) is null,0,sum(amount)) as amount,
dim,SUBSTRING(`date`,0,4) as `year`,SUBSTRING(`date`,5,2) as `month`,CONCAT_WS('-', SUBSTRING(`date`,0,4), SUBSTRING(`date`,5,2)) as `date`
-- from dwmiddle.dwb_purchase_combine_mid_report_eas_final3
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD where day='2019-01-01'
group by first_level,material_name,dim,SUBSTRING(`date`,0,4),SUBSTRING(`date`,5,2),`date`
union ALL
 select '显示模组' as BG,C.material_type, C.material_name,sum(C.cd_amount) as cd_amount,( if(cast(sum(C.cd_amount)/sum(C.amount) as string) is null ,0 , sum(C.cd_amount)/sum(C.amount))) as cd_proportion ,sum(C.amount) as amount,dim,`year`,`month`,`date`
from (select first_level as material_type, prodect_materiel_name as material_name , if (cd_amount='' or cd_amount is null,0, cast(cd_amount as DECIMAL(28,16) )) as cd_amount ,
-- ((cast(cd_amount as DECIMAL(28,16)))/((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) ) as cd_proportion ,
((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) as amount 
,'8' as dim,SUBSTRING(natural_month,0,4) as `year` ,SUBSTRING(natural_month,5,2) as `month` ,CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) as `date`
from dwbase.dwb_yifei_display_module where day='2020-01-02' ) C group by C.material_type,C.material_name,C.dim,C.`year`,C.`month`,C.`date`
union ALL
select case dim
when '6' then '深圳结构件'
when '7' then '东莞结构件'
ELSE 'unknown' end as BG, D.material_type,D.material_name,sum(D.cd_amount) as cd_amount,( if ( cast(sum(D.cd_amount)/sum(D.amount)  as string) is null ,0 , sum(D.cd_amount)/sum(D.amount)) ) as cd_proportion ,sum(D.amount) as amount,dim,`year`,`month`,`date`
from (select split(material_group_des,'-')[0] as material_type,regexp_replace(regexp_replace(inventory_des,'"',''),"'","") as material_name ,
cast(cd_price as DECIMAL(28,16)) as cd_amount,
cast(original_currency_amount as DECIMAL(28,16)) as amount,if(factory = '8800','6','7') as dim ,
SUBSTRING(in_date,0,4) as `year`,  SUBSTRING(in_date,6,2) as `month` ,concat(SUBSTRING(in_date,0,4),'-',SUBSTRING(in_date,6,2))as `date`
from sap.ODS_SAP_ZDMMR027 where day='2020-01-03') D group by D.material_type,D.material_name,D.dim,D.`year`,D.`month`,D.`date`;



-- step 10 
-- 新增字段 BG名称
-- insert overwrite table dwservice.dws_cd_by_amount_month3 partition(day='2019-12-06')
/***
insert overwrite table dwservice.dws_cd_by_amount_month3 partition(day='2019-12-16')
select case dim
when '1' then 'CNC'
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
from  dwservice.dws_cd_by_amount_month2 where day='2019-12-16';

--select count(1) from dwservice.dws_cd_by_amount_month3 where  day='2019-12-12';
-- select count(1) from dwservice.dws_cd_by_amount_month3 where  day='2019-12-06';

-- select count(1) from dwservice.dws_cd_by_area_day_month3 where  day='2019-12-06';
-- select * from dwservice.dws_cd_by_area_day_month3 where  day='2019-12-12' and dim = '4';


-- insert overwrite table dwservice.dws_cd_by_area_day_month3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_area_day_month3 partition(day='2019-12-16')
select case dim
when '1' then 'CNC'
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
FROM dwservice.dws_cd_by_area_day_month2 where day='2019-12-16'; 

-- select distinct(length(`date`)) from dwservice.dws_cd_by_material_cut_price_month2;
--  select distinct(`day`) from dwservice.dws_cd_by_material_cut_price_month3;
-- insert overwrite table dwservice.dws_cd_by_material_cut_price_month3 partition(day='2019-12-06')
--  select count(1) from dwservice.dws_cd_by_material_cut_price_month3 where  day='2019-12-16'
insert overwrite table dwservice.dws_cd_by_material_cut_price_month3 partition(day='2019-12-16')
select case dim
when '1' then 'CNC'
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
FROM dwservice.dws_cd_by_material_cut_price_month2 where day='2019-12-16'; 


-- select * from dwservice.dws_cd_by_material_cut_price_month3 where  day='2019-12-12' and dim = '4';
-- select count(1) from dwservice.dws_cd_by_material_cut_price_month3 where  day='2019-12-12'
-- select count(1) from dwservice.dws_cd_by_material_cut_price_month3 where  day='2019-12-06'

--   select count(1) from dwservice.dws_cd_by_material_type_month3 where  day='2019-12-12'
 
-- insert overwrite table dwservice.dws_cd_by_material_type_month3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_material_type_month3 partition(day='2019-12-16')
select case dim
when '1' then 'CNC'
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
FROM dwservice.dws_cd_by_material_type_month2 where day='2019-12-16'; 


/**
-- select count(1) from dwservice.dws_cd_by_purchaser_month_year3 where  day='2019-12-06'
-- insert overwrite table dwservice.dws_cd_by_purchaser_month_year3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_purchaser_month_year3 partition(day='2019-12-16')
select case dim
when '1' then 'CNC'
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
FROM dwservice.dws_cd_by_purchaser_month_year2 where day='2019-12-16'; 
**/
/**
-- select count(1) from dwservice.dws_cd_by_supplier_month3 where  day='2019-12-12' and dim = '4'
-- insert overwrite table dwservice.dws_cd_by_supplier_month3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_supplier_month3 partition(day='2019-12-16')
select case dim
when '1' then 'CNC'
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
FROM dwservice.dws_cd_by_supplier_month2 where day='2019-12-16'; 
**/
/**
-- select * from dwservice.dws_cd_by_account_day_month3 where  day='2019-12-12' and dim = '1'
-- insert overwrite table dwservice.dws_cd_by_account_day_month3 partition(day='2019-12-06')
insert overwrite table dwservice.dws_cd_by_account_day_month3 partition(day='2019-12-16')
select case dim
when '1' then 'CNC'
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
FROM dwservice.dws_cd_by_account_day_month2 where day='2019-12-16'; 
**/
/**
insert overwrite table dwservice.dws_cd_by_material_month3 partition(day='2019-12-16')
select case dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE '' end as BG,material_type,
 material_name, cd_amount, cd_proportion, total_amount, dim, `year`, `month`, `date`
FROM dwservice.dws_cd_by_material_month2	 where day='2019-12-16'; 
**/
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


-- 2019-01-01  2019-11-14 2019-12-16
-- select count(1) from eas.ods_eas_new_eas75_t_bd_supplier where day='2019-11-14';  --   7169 7258  7305
--  alter table eas.ods_eas_new_eas75_t_sm_purorder  add columns(cfbgid string);
-- select distinct(cfbgid) from eas.ods_eas_new_eas75_t_sm_purorder where day='2020-02-04';
-- select cfbgid,count(1) from eas.ods_eas_new_eas75_t_sm_purorder where day='2020-02-04' group by  cfbgid;
-- 681-NVF653-01-B-06  
select count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsbill where day='2020-02-04'; -- 1683068  1766362
select count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsentry  where day='2020-02-04'; -- 3158888 3302716
select count(1) from eas.ods_eas_new_eas75_t_bd_material where day='2020-02-04'; -- 1001786  1057373
select count(1) from eas.ods_eas_new_eas75_t_bd_materialgroup where day='2020-02-04'; -- 83 88
	select count(1)  from eas.ods_eas_new_eas75_t_bd_supplier where day='2020-02-04'; --  7169  7402
select count(1) from eas.ods_eas_new_eas75_t_org_storage where day='2020-02-04'; -- 39 39
select count(1) from eas.ods_eas_new_eas75_t_sm_purorder where day='2020-02-04';  --  649472 682768
select count(1) from eas.ods_eas_new_eas75_ct_ls_match where day='2020-02-04';   -- 122812 126871
	select count(1) from eas.ods_eas_new_eas75_t_bd_currency where day='2020-02-04'; -- 12  12
select count(1) from eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo where day='2020-02-04'; -- 40073 40951
select count(1) from eas.ods_eas_new_eas75_t_bd_payconditionentry where day='2020-02-04'; -- 86  86
	select count(1) from eas.ods_eas_new_eas75_t_org_company where day='2020-02-04';  -- 41   41
select count(1) from eas.ods_eas_new_eas75_t_org_company_area_relation2;-- 41
select count(1) from eas.ods_eas_new_eas75_t_db_warehouse where day='2020-02-04'; --2556 2609
select count(1) from eas.ods_eas_new_eas75_t_bd_measureunit where day='2020-02-04';  --20  20
select count(1) from eas.ods_eas_new_eas75_t_sm_purorderentry where day='2020-02-04'; --  1460547 1480049
seLect count(1) from eas.ods_eas_new_eas75_t_sm_purrequest where day='2020-02-04';  -- 61195 67517
	seLect count(1) from eas.ods_eas_new_eas75_t_bd_person where day='2020-02-04';-- 7945   8332
seLect count(1) from eas.ods_eas_new_eas75_t_bd_purchasegroup where day='2020-02-04';  -- 31
seLect count(1) from  eas.ods_eas_new_eas75_t_org_costcenter  where day='2020-02-04';  -- 356
seLect count(1) from  eas.ODS_EAS_NEW_EAS75_T_ORG_ADMIN where day='2020-02-04';  -- 2045

select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb
where day='2019-12-16'  -- 11691795v  
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new
where day='2019-12-16'   --11691785

-- cd_amount>0  [4306583]
-- cd_amount=0  [5451594]
-- cd_amount<0  [1831862]
-- cd_amount is null [101756]
/*
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd
where day='2019-12-16'  and cd_amount is null ; 


select material_name,regexp_replace(material_name,'\\^','') from  dwservice.dws_cd_by_material_month2 
select material_name,
regexp_replace(regexp_replace(regexp_replace(regexp_replace(regexp_replace( material_name,'"',''),"'",""),'\\^',''),'\t',''),',','.') as A from
 dwmiddle.dwb_purchase_combine_mid_report_eas_final_RMB_CD
 where day='2019-12-16' and material_name like '%"%'
 
 select * from dwservice.dws_cd_by_account_day_pay_type_month where day='2019-12-16'
 select count(1) from dwservice.dws_cd_by_account_day_month3 where day='2019-12-12'


select distinct(dim) from  dwservice.dws_cd_by_supplier_month3 where day='2019-12-16'
select distinct(dim) from dwservice.dws_cd_by_account_day_pay_type_month  where day='2019-12-16'


-- 测试 供应商那些是内部交易 
select distinct supplier_code,supplier_name from  dwservice.dws_cd_by_supplier_month3
where `day` = '2019-12-16' and supplier_name like '%领%' and dim in ('1','2');
select fnumber,fname_l2 from eas.ods_eas_new_eas75_t_org_company where `day` = '2019-12-16';
select distinct(supplier_name) from  dwservice.dws_cd_by_supplier_month3 where `day` = '2019-12-16' and supplier_code  in 
(select fnumber from eas.ods_eas_new_eas75_t_org_company where `day` = '2019-12-16');

select distinct(fname_l2) from eas.ods_eas_new_eas75_t_org_company where day='2019-12-16' fname_l2 like  '%盛翔%';

select * from dwservice.dws_cd_by_supplier_month3 where `day` = '2019-12-16' and supplier_code= '01.02.08'
	-- cnc 和 冲压  自身公司表 ，1、模糊查，去除异类 2、union 公司表
	--  选择方式2，效率更高。 
	 
	--  1，2 维度中    823878（不包含内部）  1413240（内部交易部分）
	select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16'
	and supplier_name not in(select distinct supplier_name from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
where day='2019-12-16' and dim in ('1','2') and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16') union all
select distinct(fname_l2) from eas.ods_eas_new_eas75_t_org_company where day='2019-12-16')
 -- and dim in ('1','2') ;

-- 11691795  all  
--  10278555  方式1[not in 两个字段合并]    42seconds
select area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16'
and concat(supplier_name,dim) not in(select distinct(concat( supplier_name, dim)) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
where day='2019-12-16' and dim in ('1','2') and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16') union all
select distinct(concat(fname_l2,'1')) from eas.ods_eas_new_eas75_t_org_company where day='2019-12-16' union all
select distinct(concat(fname_l2,'2')) from eas.ods_eas_new_eas75_t_org_company where day='2019-12-16') ;

-- 10278555  方式2[1 ,2 和其他维度union]  24seconds
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16'
and dim in ('1','2') and supplier_name not in(select distinct supplier_name as supplier_name2 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
where day='2019-12-16'  and dim in ('1','2') and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16') union all
select distinct(fname_l2) from eas.ods_eas_new_eas75_t_org_company where day='2019-12-16') 
union all
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16'
and dim not in ('1','2') ;

	     --  2237118
	    select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16'
and dim in ('1','2') ;
	  
	  -- 1 2 维度 查找内部交易的供应商。
select distinct supplier_name from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
where day='2019-12-16' and dim in ('1','2') and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16')
union all
select distinct(fname_l2) from eas.ods_eas_new_eas75_t_org_company where day='2019-12-16';

	-- 显示模组，剔除自身公司表。
insert overwrite table dwbase.dwb_yifei_display_module partition(day='2019-12-18')	
SELECT supplier_code, supplier_name, warehouse_name, warehousing_time, check_return_code, product_materiel_code, 
purchase_code, prodect_materiel_name, standards, check_number, check_return_num, return_num, valuation_return_num,
unit_price, unit, currency, cur_tax_bef_amount, cur_tax, cur_amount, first_level, secondary_level,
bcnottax_unit_price, bctax_unit_price, ori_cur_beftax_amount, ori_cur_tax_rate, ori_cur_amount, 
exchange_rate, delivery_warehouse, damage_num, scrapped_num, location_code, sales_unit, inventory_unit,
us_dollar_unit_price, bu_factory_area, natural_month, supplier_full_name, third_level, tax_unit_price,
nottax_unit_price, bcnottax_amount, cd_amount, tax_rate, whether_designation, ori_factory_proxy, 
days_of_account, buyer, remarks, data_sources FROM dwbase.dwb_yifei_display_module where day='2019-12-18'
and supplier_name not in ('帝晶大洋田第二分厂','帝晶光电','帝晶光电（深圳）','帝晶科技','帝晶科技（OEM事业部)','赣州帝晶','香港帝晶（友达）');
	
	
	
		--   剔除模切 [3]内部交易维度
insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd partition(day='2019-12-16')	
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16'
and dim ='3' and supplier_name not in(select distinct supplier_name as supplier_name2 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
where day='2019-12-16'  and dim ='3' and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16') union all
select distinct(fname_l2) from eas.ods_eas_new_eas75_t_org_company where day='2019-12-16')
and  first_level not in ('成品','半成品')
union all
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16'
and dim ='3' and  first_level  in ('成品','半成品')
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16'
and dim != '3') ;
	-- end

 -- 手动更换 first_level 为null/'' 的数据， 替换为second_level
 -- select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16' 
 and secondary_level is null or secondary_level=''  ; --10278555   --692754
 
	insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd partition(day='2019-12-16')	
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
if(first_level is null or first_level='',secondary_level,first_level) as first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16';
  
   -- masterial_name 去掉 /
   --  测试 select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16' 
 and material_name like '%\' ;
 
 	insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd partition(day='2019-12-16')	
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, `date`, stock_in_audit_time,
 first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code,  regexp_replace(material_name,'\\\\','') as material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16'


-- 插入生成 基础报表数据(去掉内部交易的数据)  --10038878
-- 测试 select count(1) from dwservice.dws_purchase_report_by_eas2 ;
insert overwrite table dwservice.dws_purchase_report_by_eas2 partition(day='2019-12-30')
SELECT area, factory_code, factory_area, stock_org_number, stock_org_name, 
concat(SUBSTRING(`date`,0,4),'-',SUBSTRING(`date`,5,2)) as `date`, stock_in_audit_time,
first_level, secondary_level, third_level, po_number, supplier_code, supplier_name,
supplier_simple_name, material_code, material_8code, material_name, material_model,
quantity, unit, currency, currency_name, tax_price, tax_rate, exchange_rate, price,
tax_amount, amount, bechmark_price, bechmark_amount, cd_amount, cd_proportion, 
account_day, account_amount, material_type, buyer_id, buyer, docu_pic, remarks, 
company_code, company_name, pay_type, dim 
 from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd where day='2019-12-16'


-- 2019-12-24 新需求 
	1、测试   成品之外的原材料 不纳入采购金额
	select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
	where day='2019-12-16';
	/**
	 * 原材料,成品 , 主材料, 辅助材料,  半成品
	
	select distinct(first_level) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
		where day='2019-12-16' and dim = '3' ;
		/**
		   * 	 15761
			原材料	 6349
			成品	5650053
			主材料	149
			辅助材料	239
			半成品	 257361
		
		select first_level,count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
		where day='2019-12-16' and dim = '3' group by first_level ;
	/**
	 * 冲压,模切半成品,DDDHHH,12,塑胶,F11,F13,涂层半成品(610/620/630),模具半成品,导电布,原材料,成品,分切半成品,
	 * 13,11,模切,包材,SY半成品,其他半成品,冲压半成品,SY,刀具,F14,主材料,辅助材料,14,半成品
	 * 
	select distinct first_level,secondary_level from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
	where day='2019-12-16' and dim = '3' ;
	select  first_level,secondary_level,count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
	where day='2019-12-16' and dim = '3' group by first_level,secondary_level ;
	
	
	
	-- 物料 parentId and id的关系
	select distinct(fparentid) from eas.ods_eas_new_eas75_t_bd_materialgroup where day='2019-12-16';
	select fid,fname_l2,fparentid from eas.ods_eas_new_eas75_t_bd_materialgroup where day='2019-12-16' order by fparentid;
	
	select distinct fid ,fname_l2 from eas.ods_eas_new_eas75_t_bd_materialgroup where day='2019-12-16'
	and  fid in (select distinct(A.fparentid) from eas.ods_eas_new_eas75_t_bd_materialgroup  
	A where A.day='2019-12-16');
	
	
	-- 磁材  【净价 = 不含税单价 * 价格单位】
	select MATNR as material_code, SHUIL as tax_rate,PEINH as price_unit,NETPR as jing_jia,DJ as tax_price,BHSDJ as price ,CD01,CD02,
	ZJ as tax_amount,RKZJ as real_tax_amount,DMBTR as origin_amount,
	MENGE as quantity , LFIMG as real_quantity,MENGE1 as sup_quantity
	 from sap.ods_sap_zmmr008_show where day='2019-12-24';
	 
	 
	 -- 物料名称 特殊字符替换 =
	  select material_name from dwservice.dws_cd_by_material_cut_price_month3 where day='2019-12-25'
and material_name like '%\\';

insert overwrite table dwservice.dws_cd_by_material_cut_price_month3 partition(day='2019-12-25')
SELECT bg, material_8code, regexp_replace(material_name,'\\\\',''), price, diff_num, count_num, dim, `year`, `month`, `date`
FROM dwservice.dws_cd_by_material_cut_price_month3  where day='2019-12-25';


	  select material_name from dwservice.dws_cd_by_material_month3 where day='2019-12-25'
and material_name like '%\\';

insert overwrite table dwservice.dws_cd_by_material_month3 partition(day='2019-12-25')
SELECT bg, material_type, regexp_replace(material_name,'\\\\',''), cd_amount, cd_proportion, total_amount, dim, `year`, `month`, `date`
 FROM dwservice.dws_cd_by_material_month3  where day='2019-12-25';

select * FROM dwservice.dws_cd_by_material_month3  where day='2019-12-25';
 
 -- 936834
 select count(1) from dwservice.dws_cd_by_material_cut_price_month3 where day='2019-12-25' and dim = '1'
 --  964065
 select count(1) from dwservice.dws_cd_by_material_month3 where day='2019-12-25'
-- 磁材

select  company_des,count(1) from base.dwd_base_cicai where day='2019-12-26' group by company_des;

select count(1) from dwbase.dwb_sap_cicai_by_cd where day='2019-12-30';
 
 insert overwrite table dwbase.dwb_sap_cicai_by_cd partition(day='2019-12-30')
 SELECT supplier_code, supplier_name, po, material_code, material_des, substring(in_date,0,7) as in_date, unit, order_qty, quantity, 
 factory_code, factory_des, company_des, tax_unit_price, in_tax_amout, material_group, material_group_des,
  untax_unit_price, buyer, pre_tax_unit_price, pre_untax_unit_price, cd_amount, cd_proportion, amount, origin, 
  reserved1, reserved2  FROM dwbase.dwb_sap_cicai_by_cd where day='2019-12-30';
  
  
  -- unknown的数据 
  
  select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd 
	where day='2019-01-01' and dim='unknown' ;


-- 查找 订单中， 总金额为 0的数据

select  B.FAmount as amount,B.FQty as quantity,B.FPrice as price,B.FTaxPrice as tax_price,
B.FLocalAmount as cur_amount
 from eas.ods_eas_new_eas75_t_im_purinwarehsentry B where day='2019-01-01' 
  and  B.FAmount = 0 ;
  
  -- 3255130  690396
  -- 91727   -- 45092
  select count(distinct(fpurorderNumber)) 
   from eas.ods_eas_new_eas75_t_im_purinwarehsentry B where day='2019-01-01' and  B.FAmount = 0  ;
   
   -- 成本中心  356   277
   select distinct(fname_l2),
   case 
   when  fname_l2  like '%CNC%' then 'CNC'
   when  fname_l2  like '%模切%' then '模切'
   when  fname_l2  like '%组装%' then '组装'
   when  fname_l2  like '%冲压%' then '冲压'
   else ''
   end as BG
     from eas.ods_eas_new_eas75_t_org_costcenter where day='2020-01-06'
    
    --  618754  1740556
    -- 采购入库单 关联成本中心， BG未区分
    select A.id,B.name,
     case 
   when  B.name  like '%CNC%' then 'CNC'
   when  B.name  like '%模切%' then '模切'
   when  B.name  like '%组装%' then '组装'
   when  B.name  like '%冲压%' then '冲压'
   else ''
   end as BG,
    A.count from (select FCostCenterOrgUnitID as id,count(1) as count
     from eas.ods_eas_new_eas75_t_im_purinwarehsbill 
    where day='2019-01-01'  group by FCostCenterOrgUnitID) A left join
     (select fid,fname_l2 as name from eas.ods_eas_new_eas75_t_org_costcenter where day='2020-01-06') B
    on A.id = B.fid  order by  A.count desc ;
     --采购入库单中，去重成本中心
     select C.name ,C.BG,sum(C.count) from 
     (select A.id,B.name,
     case 
   when  B.name  like '%CNC%' then 'CNC'
   when  B.name  like '%模切%' then '模切'
   when  B.name  like '%组装%' then '组装'
   when  B.name  like '%冲压%' then '冲压'
   else ''
   end as BG,
    A.count from (select FCostCenterOrgUnitID as id,count(1) as count
     from eas.ods_eas_new_eas75_t_im_purinwarehsbill 
    where day='2019-01-01'  group by FCostCenterOrgUnitID) A left join
     (select fid,fname_l2 as name from eas.ods_eas_new_eas75_t_org_costcenter where day='2020-01-06') B
    on A.id = B.fid  order by  A.count desc) C group by C.BG,C.name ;
    
    
    -- 成本中心 关联 库存组织  ，成本中心代码
    
      --采购入库单中，去重成本中心
 select  C.stock_org_number,C.stock_org_name,C.number,C.name ,C.BG,count(1) from 
(select F.fnumber as stock_org_number,
COALESCE(F.fname_l2,F.fname_l1,F.fname_l3) as stock_org_name,
B.number,B.name,
case when  B.name  like '%CNC%' then 'CNC'
when  B.name  like '%模切%' then '模切'
when  B.name  like '%组装%' then '组装'
when  B.name  like '%冲压%' then '冲压'
else '' end as BG from 
(select FCostCenterOrgUnitID ,fid from eas.ods_eas_new_eas75_t_im_purinwarehsbill where day='2019-01-01' ) A  inner join
(select fparentid,FStorageOrgUnitID from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2019-01-01' )D 
on A.fid = D.fparentid left join
(select fid,fnumber,fname_l2,fname_l1,fname_l3 from eas.ods_eas_new_eas75_t_org_storage where day='2019-01-01')F 
on F.fid = D.FStorageOrgUnitID left join
(select fid,fnumber as number,fname_l2 as name from eas.ods_eas_new_eas75_t_org_costcenter where day='2020-01-06')B
on A.FCostCenterOrgUnitID = B.fid 
) C group by C.stock_org_number,C.stock_org_name,C.number,C.name ,C.BG;
     
      -- 部门   459  
   select distinct(fname_l2),
   case 
   when  fname_l2  like '%CNC%' then 'CNC'
   when  fname_l2  like '%模切%' then '模切'
   when  fname_l2  like '%组装%' then '组装'
   when  fname_l2  like '%冲压%' then '冲压'
   else ''
   end as BG
     from eas.ods_eas_new_eas75_t_org_admin where day='2020-01-06'
   
      --  618754  1740556
    -- 采购入库单 关联部门， BG未区分
    select A.id,B.name,
     case 
   when  B.name  like '%CNC%' then 'CNC'
   when  B.name  like '%模切%' then '模切'
   when  B.name  like '%组装%' then '组装'
   when  B.name  like '%冲压%' then '冲压'
   else ''
   end as BG,
    A.count from (select FAdminOrgUnitID as id,count(1) as count
     from eas.ods_eas_new_eas75_t_im_purinwarehsbill 
    where day='2019-01-01'  group by FAdminOrgUnitID) A left join
     ( select fid,fname_l2 as name from eas.ods_eas_new_eas75_t_org_admin where day='2020-01-06') B
    on A.id = B.fid  order by  A.count desc ;
    
    /**
     * 
2014	64541
2016	93780
2017	135391
2018	132103
2013	1230
2015	91602
2019	99929
2020	178 
     
        select FYear, count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsbill 
    where day='2019-01-01'  and FCostCenterOrgUnitID = '' group by FYear ;
    
     select count(distinct(FNumber)) from eas.ods_eas_new_eas75_t_im_purinwarehsbill 
    where day='2019-01-01'  and FCostCenterOrgUnitID = ''   ;
    
    
    -- 261688 1740556
        select FAdminOrgUnitID,  count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsbill 
    where day='2019-01-01' group by FAdminOrgUnitID;
    select  count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsbill 
    where day='2019-01-01' ;
   
   /**
2014	62138
2016	23145
2017	33341
2018	35827
2013	894
2015	77625
2019	28718
    * 
           select FYear, count(1) from eas.ods_eas_new_eas75_t_im_purinwarehsbill 
    where day='2019-01-01'  and FAdminOrgUnitID = '' group by FYear ;
    -- 测试mid1_new2 添加  关联 订单表之后的数据
    select supplier_po_number ,count(1) from 
    dwmiddle.dwb_purchase_combine_mid1_new2 where day='2019-01-01' group by supplier_po_number;
     select order_date ,count(1) from 
    dwmiddle.dwb_purchase_combine_mid1_new2 where day='2019-01-01' group by order_date;
    
    
    -- 10238735
    select count(1) from dwmiddle.dwb_purchase_report_cd where day= '2019-01-01';
    -- 87984
    select count(1) from dwmiddle.dwb_purchase_report_cd where `date`='202001' 
   
   	select dim,count(1) from dwmiddle.dwb_purchase_report_cd where `date`='202001' group by dim; 
   	
   	-- 61393(9649)  25778(5320)
   	select count(distinct(material_code)) from dwmiddle.dwb_purchase_report_cd where day='2020-02-04' and `date`='202001' and dim='unknown' ;
   	
   	select dim,sum(amount) from dwmiddle.dwb_purchase_report_cd where day='2020-02-04' 
   	and `date`='202001' group by dim ;
    
    -- 导出2020年1月的数据
       	select dim,amount,cd_amount,cd_proportion from dwmiddle.dwb_purchase_report_cd where day='2020-02-04' 
   	and `date`='202001' ;
    
    -- 317663
    select stock_in_audit_time,stock_in_time,`date`,order_date from dwmiddle.dwb_purchase_report_cd
     where day='2020-02-04' 
   	and `date` in ('202001','201912') ;
   	
   	
   	-- 26471   15701  16036  
   	-- 184043   309254   317663  315580
   	 select dim,sum(amount) from dwmiddle.dwb_purchase_report_cd 
     where day='2020-02-04' and `date` in ('202001','201912')  
   	and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')) 
   	 group by dim ;
   	 
   	 -- 去掉重复的数据
   	  select A.dim,sum(A.amount) from 
   	  ( select dim,amount from dwmiddle.dwb_purchase_report_cd   where day='2020-02-04' and `date` in ('202001','201912') 
   	   	and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')) group by po_number,stock_in_time,amount,dim
   	   ) A group by A.dim ;
    
   
   	 
   	 
   	 -- 13113576   10222693
   	 select count(1) from (
   	 select po_number FROM dwmiddle.dwb_purchase_report_cd where day='2020-02-04'
   	 group by po_number, stock_number, material_code, material_8code, material_name, material_describe,
   	  material_model, material_group_code, material_group_describe, supplier_code, supplier_name, 
   	  supplier_simple_name, out_supp_material_code, purchase_group_code, purchase_group_name, 
   	  purchase_org_code, stock_in_audit_time, stock_in_time, document_date, stock_goods_describe, 
   	  first_level, secondary_level, third_level, project_id, voucher_project_code, material_type, 
   	  quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price, tax_price, cur_amount, 
   	  tax_amount, tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price, 
   	  check_bechmark_amount, check_cd_amount, pic, docu_pic, supp_po_code, line_pic, area, factory_code,
   	   factory_area, branch_of_facoty, order_number, check_return_code, check_number, check_return_num,
    return_num, cur_tax, inventory_unit, ori_cur_beftax_amount, ori_cur_tax, tax, ori_cur_amount,
     damage_num, scrapped_num, location_code, sales_unit, appoint, ori_proxy, buyer, remarks, period,
      `year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number, unit,
     warehouse_name, delivery_warehouse, company_code, company_name, order_date, purorder_fid, 
     supplier_po_number, origin_firm, classify, pay_condition, currency, currency_name, pay_day,
      account_day, pay_type, acreage, line, type_pic, project_pic, big_classify, reduce_price_orig,
      avg_pay_day, rebate_ratio, update_statement_price, diff_amount, update_bechmark_price, 
   rpl_cd_amount, all_cd, bechmark_price, bechmark_amount, cd_amount, cd_proportion, account_amount,  bg, dim 
   ) A
      
    --   3302733
    select count(FPurOrderID) from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-04'
    --    700038
    select count(distinct(FPurOrderID)) from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-04'
      
    select  fid,FSeq,FSourceBillID,FPurOrderID,FAmount,FPrice,FBizDate,FMaterialID  
    from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-04'
    and FPurOrderID='/OQAAAAHzZExcb+t'
      
      select fid from eas.ods_eas_new_eas75_t_sm_purorder  where day='2020-02-04' 
      and fid='o18a73WnQiaO6miWuVdI8BXyvYM='
      
      
       -- 402 6937 9272.1062  
   	select sum(FAmount) from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-04'
   	   -- 1050 2482 5944.2934
   	select sum(amount) from dwmiddle.dwb_purchase_combine_mid1_new3 where day='2020-02-04'
   	   -- 1282 6271 4357.501867
   	select sum(amount) from dwmiddle.dwb_purchase_standard_price where day='2020-02-04'
   	   -- 1906 0479 8973.784289
   	select sum(amount) FROM dwmiddle.dwb_purchase_report_cd where day='2020-02-04'
   	
   	select amount,count(1) FROM dwmiddle.dwb_purchase_report_cd where day='2020-02-04' group by amount;
   	select count(distinct(po_number)) FROM dwmiddle.dwb_purchase_report_cd where day='2020-02-04' ;
   	
   	 select *  from dwmiddle.dwb_purchase_report_cd 
     where day='2020-02-04' and `date` in ('202001','201912') and supplier_name like '%坂崎雕刻模具（昆山）有限公司%'
     and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115'))
    
    -- 11 1736 3373.23  ods_eas_new_eas75_t_im_purinwarehsentry表
    select sum(FAmount) from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-04'
    and ( (regexp_replace(regexp_replace(substring(FBizDate,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(FBizDate,0,10),'-',''),'/','')
   	 between '20191216' and '20200115'))
    
    select count(1) from sap.ods_sap_zdmmr027  where day='2020-02-04'; -- 567393
    select company_no,count(1) from sap.ods_sap_zdmmr027  where day='2020-02-04' group by company_no; 
    
    select distinct(day) from dwbase.dwb_sap_jiegoujian_by_cd where day='2020-02-04'
    
	
      DW.DWS_CD_BY_MATERIAL_CUT_PRICE_MONTH
    -- 结构件  根据company_no区分数据
    select company_no,sum(original_currency_amount) from sap.ODS_SAP_ZDMMR027 where day='2020-02-04'
    and concat(substring(in_date,0,4),'-',substring(in_date,6,2)) = '2020-01' 
    group by company_no;
   
    select distinct(factory) from sap.ods_sap_zdmmr027 where day='2020-02-04' 
    and concat(substring(in_date,0,4),'-',substring(in_date,6,2)) = '2020-01'  ;
   
    -- 显示模组  1月份的数据
    select sum((cast(ori_cur_beftax_amount as DECIMAL(28,16)))+(cast(ori_cur_tax_rate as DECIMAL(28,16)))) from dwbase.dwb_yifei_display_module where day='2020-02-04'
    and CONCAT_WS('-', SUBSTRING(natural_month,0,4), SUBSTRING(natural_month,5,2)) = '2020-01' ;	
    
    -- 磁材数据
    
    -- 10529442.69 10247796.25
    select sum((NETPR/PEINH)*MENGE) from  sap.ods_sap_zfmm_042 where day='2020-02-07' and
     CONCAT_WS('-',substring(budat,0,4),substring(budat,6,2)) = '2020-01' 
     
   select sum((NETPR/PEINH)*MENGE) from sap.ODS_SAP_ZMMR008_SHOW where day='2020-02-07' and 
   CONCAT_WS('-',substring(budat,0,4),substring(budat,6,2)) = '2020-01' 
   
   
   select distinct(day) from sap.ODS_SAP_ZMMR008_SHOW;
   select CONCAT_WS('-',substring(budat,0,4),substring(budat,6,2)) from sap.ODS_SAP_ZMMR008_SHOW where day='2020-02-07'
    and 
   CONCAT_WS('-',substring(budat,0,4),substring(budat,6,2))
   
    -- 根据集团hr开获取
    select count(1) from dwbase.dwb_sap_cicai where day='2020-02-04'
    select count(1) from dwbase.dwb_sap_cicai where day='2019-12-30'
    
    select distinct(day) from dwbase.dwb_sap_cicai 
    
    select untax_unit_price,tax_unit_price from dwbase.dwb_sap_cicai where day='2019-12-30' 
     and untax_unit_price = 0.007629
     
      insert into table dwbase.dwb_sap_cicai partition(day='2020-02-04')
     SELECT supplier_code, supplier_name, po, material_code, material_des, in_date, unit, order_qty, in_qty,
      factory_code, factory_des, company_des, tax_unit_price, in_tax_amout, material_group, material_group_des, 
      if(untax_unit_price is null or untax_unit_price=0,tax_unit_price/1.16,untax_unit_price) as untax_unit_price , 
      buyer, pre_tax_unit_price, pre_untax_unit_price, cd_amount, cd_percent, origin, reserved1,
       reserved2  FROM dwbase.dwb_sap_cicai where day='2019-12-30'

    
   
   
   select sum(amount2) from sap.ods_sap_zfmm_044_jituan where day='2020-02-04'
   
   select count(1) from dwmiddle.dwb_purchase_report_cd where day='2020-02-04'   
   
   
   select count(1) from dwbase.dwb_sap_cicai_by_cd where day='2020-02-04';
   
   
select * from eas.ods_eas_new_eas75_t_im_purinwarehsbill where day='2020-02-04' and
 fid ='sLdC9UhyTqWJqeskg0YoG3gwYeM='
 select * from  eas.ods_eas_new_eas75_t_sm_purorder where day='2020-02-04' and
  fid ='/OQAAAAHzZExcb+t'
  
  select sum(amount) from  dwbase.dwb_sap_cicai_by_cd  where day='2020-02-04' and in_date = '2020-01' ;
  
  18788000.51  10247796.25  29035796.76
  select sum(untax_unit_price * cast(in_qty as int)) 
  from dwbase.dwb_sap_cicai where day='2020-02-04'
  and in_date between '2019-12-16' and '2020-01-15'
  
  select count(1) from  dwbase.dwb_sap_cicai where day='2020-02-04'  --  103944
   select count(1) from  dwbase.dwb_sap_cicai where day='2019-12-30'   --103106
   
   
    -- all 170150627.50000018
	-- 8800	48118660
	-- 8810	122031967.50000018
   select company_no,sum(original_currency_amount) from sap.ods_sap_zdmmr027 where day='2020-02-04'
    and in_date between '2019.12.16' and '2020.01.15' group by company_no ; 
    
    select in_date,regexp_replace(regexp_replace(in_date,'-',''),'\\.','')
   	 from  sap.ods_sap_zdmmr027 where day='2020-02-04'
    
 --    	0
  -- 8800	44654360
   -- 8810	101390848.09000021
     select company_no,sum(original_currency_amount) from sap.ods_sap_zdmmr027 where day='2020-02-04'
    and  ( (regexp_replace(regexp_replace(in_date,'-',''),'\\.','')
   	 between '20191216' and '20200115')  ) group by company_no
   	 
   	 
   	      select company_no,sum(original_currency_amount) from sap.ods_sap_zdmmr027 where day='2020-02-04'
    and  ( (regexp_replace(regexp_replace(in_date,'-',''),'\\.','')
   	 between '20200101' and '20200131')  ) group by company_no
    
    
     select A.dim,sum(A.amount) from 
   	  ( select dim,amount from dwmiddle.dwb_purchase_report_cd   where day='2020-02-04' and `date` in ('202001','201912') 
   	   	and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(stock_in_audit_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')) group by po_number,stock_in_time,amount,dim
   	   ) A group by A.dim ;
   	   
   	        select A.dim,sum(A.amount) from 
   	  ( select dim,amount from dwmiddle.dwb_purchase_report_cd   where day='2020-02-04' and `date` in ('202001','201912') 
   	   	and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(stock_in_audit_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')) group by po_number,stock_in_time,amount,dim
   	   ) A group by A.dim ;
    
    
    -- 组装数据整理
    select distinct(supplier_name) from dwmiddle.dwb_purchase_report_cd where day='2020-02-04' and dim='5' ;
       -- 东莞盛翔精密金属有限公司，东莞领益精密制造科技有限公司,LY INVESTMENT (VIETNAM) LIMITED,东莞领杰金属精密制造科技有限公司
    select distinct(company_name) from dwmiddle.dwb_purchase_report_cd where day='2020-02-04' and dim='5' ;
    select distinct(stock_org_name) from dwmiddle.dwb_purchase_report_cd where day='2020-02-04' and dim='5' ;
    
    select sum(amount) from  dwmiddle.dwb_purchase_report_cd where day='2020-02-04' and dim='5' 
    and `date` in ('202001','201912') 
    and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(stock_in_audit_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')) ;
   	 
	 select * from   dwmiddle.dwb_purchase_report_cd where day='2020-02-04' 
	 and supplier_name like '%LY INVESTMENT (HK) LIMITED%' 	;
     
     
    --  select amount,buyer,company_name,supplier_name,stock_in_time, stock_in_audit_time,bg,dim,data_sources
     select amount,buyer,company_name,supplier_name,stock_in_time, stock_in_audit_time
     from dwmiddle.dwb_purchase_report where day='2020-02-04'
     and `date` in ('202001','201912') 
    and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115') ) 
   	 and buyer in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉')
   	 and supplier_name != 'LY INVESTMENT (HK) LIMITED'
   	  group by amount,buyer,company_name,supplier_name,stock_in_time,stock_in_audit_time; 
   	 
   	 -- 37611605.350864   -- 37638486  26702588
   	 select sum(A.amount) from (
   	  select amount
     from dwmiddle.dwb_purchase_report where day='2020-02-04'
     and `date` in ('202001','201912') 
    and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')  ) 
   	 and buyer in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉')
   	  and supplier_name != 'LY INVESTMENT (HK) LIMITED'
   	  group by po_number,stock_in_time,amount,buyer ) A
   	  
   	  select data_sources,count(1)
     from dwmiddle.dwb_purchase_report where day='2020-02-04'
     group by data_sources;
   	
       --  2020-01-16 2020-02-04  2020-01-15 2020-01-21
   	  select distinct(buyer) from dwbase.dwb_mould_poorder where day='2020-02-04' ;


select buyer,dim,costcenter_name from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3  where day='2020-02-04'
and buyer  in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉')
group by buyer,dim,costcenter_name;
 -- 10235113  10222693

select 
po_number, stock_number, material_code, material_8code, material_name, material_describe, 
material_model, material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name, 
out_supp_material_code, purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time, 
stock_in_time, document_date, stock_goods_describe, first_level, secondary_level, third_level, project_id,
 voucher_project_code, material_type, quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price,
tax_price, cur_amount, tax_amount, tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price,
check_bechmark_amount, check_cd_amount, pic, docu_pic, supp_po_code, line_pic, area, factory_code, factory_area, 
branch_of_facoty, order_number, check_return_code, check_number, check_return_num, return_num, cur_tax, inventory_unit,
ori_cur_beftax_amount, ori_cur_tax, tax, ori_cur_amount, damage_num, scrapped_num, location_code, sales_unit, appoint, 
ori_proxy, buyer, remarks, period, `year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number,
unit, warehouse_name, delivery_warehouse, company_code, company_name, order_date, purorder_fid, supplier_po_number, 
origin_firm, classify, pay_condition, currency, currency_name, pay_day, account_day, pay_type, acreage, line, type_pic,
project_pic, big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price, diff_amount, 
update_bechmark_price, rpl_cd_amount, all_cd, bechmark_price, bechmark_amount, cd_amount, cd_proportion, account_amount,
bg, dim
   from dwmiddle.dwb_purchase_report_cd where day='2020-02-04'  
and `date` in ('202001','201912')
and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(stock_in_audit_time,0,10),'-',''),'/','')
 between '20191216' and '20200115')) 
 and dim = '3'
group by po_number, stock_number, material_code, material_8code, material_name, material_describe, 
material_model, material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name, 
out_supp_material_code, purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time, 
stock_in_time, document_date, stock_goods_describe, first_level, secondary_level, third_level, project_id,
 voucher_project_code, material_type, quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price,
tax_price, cur_amount, tax_amount, tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price,
check_bechmark_amount, check_cd_amount, pic, docu_pic, supp_po_code, line_pic, area, factory_code, factory_area, 
branch_of_facoty, order_number, check_return_code, check_number, check_return_num, return_num, cur_tax, inventory_unit,
ori_cur_beftax_amount, ori_cur_tax, tax, ori_cur_amount, damage_num, scrapped_num, location_code, sales_unit, appoint, 
ori_proxy, buyer, remarks, period, `year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number,
unit, warehouse_name, delivery_warehouse, company_code, company_name, order_date, purorder_fid, supplier_po_number, 
origin_firm, classify, pay_condition, currency, currency_name, pay_day, account_day, pay_type, acreage, line, type_pic,
project_pic, big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price, diff_amount, 
update_bechmark_price, rpl_cd_amount, all_cd, bechmark_price, bechmark_amount, cd_amount, cd_proportion, account_amount,
bg, dim ;




insert overwrite table dwbase.dwb_sap_jiegoujian_by_cd partition(day='2020-02-04')
SELECT if(company_no = '8800','深圳结构件','东莞结构件') as BG ,if(company_no = '8800','6','7') as dim,in_date,
concat(substring(in_date,0,4),'-',substring(in_date,6,2)) as `date`,  rkdh, supplier,
po, material, inventory_des, cast(in_qty as decimal(28,16)) as in_qty, cast(tax_unit_price as decimal(28,16)) as tax_unit_price, 
cast( total_price as decimal(28,16)) as total_price , cast( tax_rate as decimal(28,16)) as tax_rate,
purchase_buyer, purchase_no, company_no,  if(company_no = '8800','亮彩第一事业部','领益智造（东莞）第二事业部') as company_name,
 factory, delivery_site, delivery_site_des,
purchase_organization, purchase_group, supplier_code, purchase_type, purchase_type_des, 
material_voucher_item, material_group, material_group_des, measurement_unit_stock,
measurement_unit_purchase, lot_no, debtor, pr, currency, cast(net_price as decimal(28,16)) as net_price, price_unit, 
cast(original_currency_unit as decimal(28,16)) as original_currency_unit, tax_code,
cast(original_currency_amount as decimal(28,16)) as original_currency_amount, proof_annual, payment_type,
invoice_number, invoice_date, issue_date, payment_clause, delivery_order, movement_type,
po_voucher_date, posting_people, cast(starting_price as decimal(28,16)) as starting_price , 
 cast(difference_price as decimal(28,16)) as difference_price,
cast(cd_price as decimal(28,16)) as cd_price , first_material, 
second_material, third_material, is_refer, project_number FROM sap.ods_sap_zdmmr027 where day='2020-02-04';

select count(1) from  dwbase.dwb_sap_jiegoujian_by_cd where day='2020-02-04';
select fname_l2,fid ,fnumber from eas.ods_eas_new_eas75_t_bd_person;
select 
 in_date, `date`, rkdh, supplier, po, material, inventory_des, in_qty, tax_unit_price, total_price, 
 tax_rate, purchase_buyer, purchase_no, company_no, company_name, factory, delivery_site, delivery_site_des,
  purchase_organization, purchase_group, supplier_code, purchase_type, purchase_type_des, material_voucher_item,
   material_group, material_group_des, measurement_unit_stock, measurement_unit_purchase, lot_no, debtor, 
   pr, currency, net_price, price_unit, original_currency_unit, tax_code, original_currency_amount,
    proof_annual, payment_type, invoice_number, invoice_date, issue_date, payment_clause, delivery_order,
     movement_type, po_voucher_date, posting_people, starting_price, difference_price, cd_price, 
     first_material, second_material, third_material, is_refer, project_number
     FROM dwbase.dwb_sap_jiegoujian_by_cd where day='2020-02-04' 
     and BG= '深圳结构件' 
     and in_date between '2019.12.16' and '2020.01.15'

select * from sap.ods_sap_zdmmr027 where day='2020-02-04' and company_no = '8800'
 and in_date between '2019.12.16' and '2020.01.15'


select dim from dwmiddle.dwb_purchase_report_cd where day='2020-02-04' and dim='unknown'


 -- unkonw 40390751
  	  select A.dim,sum(A.amount) from 
   	  ( select dim,amount from dwmiddle.dwb_purchase_report_cd  where day='2020-02-04' and `date` in ('202001','201912') 
   	   	and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115') )
   	 and buyer not in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉')
   	 group by po_number,stock_in_time,amount,dim
   	   ) A group by A.dim ;
   	   
   	-- 6 9797 3434.087237  
   	     select A.dim,sum(A.amount) from 
   	  ( select dim,amount from dwmiddle.dwb_purchase_report_cd   where day='2020-02-04' and `date` in ('202001','201912') 
   	   	and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')  )
   	 group by po_number,stock_in_time,amount,dim
   	   ) A group by A.dim ;
   	   
   	  -- 2509 0000.263704
   	   	  select A.dim,sum(A.amount) from 
   	  ( select dim,amount from dwmiddle.dwb_purchase_report_cd   where day='2020-02-04' and `date` in ('202001','201912') 
   	   	and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115') )
   	 and buyer  in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉')
   	 group by po_number,stock_in_time,amount,dim
   	   ) A group by A.dim ;
   	   
   	  
   	   
   	   
   	    select sum(A.amount) from (
   	  select amount
     from dwmiddle.dwb_purchase_report where day='2020-02-04'
     and `date` in ('202001','201912') 
    and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115')  ) 
   	 and buyer in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉')
   	  group by po_number,stock_in_time,amount,buyer ) A
   	  
   	  
   	  -- 测试一个订单 对应多个采购入库单 
   	select * from   eas.ods_eas_new_eas75_t_sm_purorder where day='2020-02-04'
   	and fnumber = 'LYDGPO191214009';
   	
   	select * from  eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-04'
   	and fpurorderNumber = 'LYDGPO191214009';
   	-- xusEFwp4Rg2NxkitmmAotXgwYeM=
   	-- ozsKItXDTMy71yQPR9XTcngwYeM=
   	select * from   eas.ods_eas_new_eas75_t_im_purinwarehsbill where day='2020-02-04'
   	and fid in(  'ozsKItXDTMy71yQPR9XTcngwYeM=' ,'xusEFwp4Rg2NxkitmmAotXgwYeM=') ;
   	
   	select * from dwmiddle.dwb_purchase_report_cd where day='2020-02-04'
   	and po_number = 'LYDGPO191214009';
   	
   	-- 130-P7417000-0980  /OQAAAABHJZECefw
   	select fid from eas.ods_eas_new_eas75_t_bd_material where day='2020-02-04' and fnumber = '130-P7417000-0980'
   	select * from eas.ods_eas_new_eas75_ct_ls_match where day='2020-02-04' and CFMaterielNumID = '/OQAAAABHJZECefw'
   	-- 一条订单对应多个物料。
   	-- /OQAAAaVcAtECefw /OQAAAim6ytECefw /OQAAAsRdtZECefw 7EDCChh5SmWbJUGwQgUKiUQJ5/A= /OQAAAaVcDZECefw	
   	select fmaterialid,fparentid,fid from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-04' 
   	select fnumber,FAuditTime from eas.ods_eas_new_eas75_t_im_purinwarehsbill where day='2020-02-04' 
   	and fid = '++/Z4WDgQeG7goi0aKLeG3gwYeM='
   	-- LYSuZCR19062900029=fnumber fid=++/Z4WDgQeG7goi0aKLeG3gwYeM=
	select material_code,material_name ,stock_in_audit_time,amount,price,bechmark_price from dwmiddle.dwb_purchase_report_cd where day='2020-02-04'
	and  stock_number='LYSuZCR19062900029';
	select material_code,material_name ,stock_in_audit_time,amount,price,bechmark_price from dwmiddle.dwb_purchase_report_cd where day='2020-02-04'
	and  stock_number='LYDGCR19121600023';
	
	select fid,FAuditTime from eas.ods_eas_new_eas75_t_im_purinwarehsbill where day='2020-02-04'
	and fnumber = 'LYDGCR19121600023' ;
	select FAmount,fmaterialid,FQty,FPrice,fpurorderNumber from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-04'
	and fparentid = '2O1qCT8HTEm2igqJyK9pfHgwYeM=';
	select A.fparentid,A.fmaterialid,A.cum from (
	select fparentid,fmaterialid,count(1) as cum from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-04'
	group by fparentid,fmaterialid) A order by A.cum desc
	
	
   	
   	-- eas  日期date转化为 12-16~01-15，  year和month同时更换
   	select `date`,
  if( int(SUBSTRING(stock_in_audit_time,9,2)) >= 16 ,
  if(SUBSTRING(stock_in_audit_time,6,2)='12',concat(int(SUBSTRING(stock_in_audit_time,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(stock_in_audit_time,0,4)) ,'-', if( (int(SUBSTRING(stock_in_audit_time,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(stock_in_audit_time,6,2))+1)), int(SUBSTRING(stock_in_audit_time,6,2))+1 ))),
  concat(SUBSTRING(stock_in_audit_time,0,4),'-' ,SUBSTRING(stock_in_audit_time,6,2)))  as new_date,
    if(int(SUBSTRING(stock_in_audit_time,9,2)) >= 16 ,
  if(SUBSTRING(stock_in_audit_time,6,2)='12',concat(int(SUBSTRING(stock_in_audit_time,0,4))+1 ,'') ,
  SUBSTRING(stock_in_audit_time,0,4) ),
 SUBSTRING(stock_in_audit_time,0,4)) as new_year,
   if( int(SUBSTRING(stock_in_audit_time,9,2)) >= 16 ,
  if(SUBSTRING(stock_in_audit_time,6,2)='12','01' ,
   if( (int(SUBSTRING(stock_in_audit_time,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(stock_in_audit_time,6,2))+1)), int(SUBSTRING(stock_in_audit_time,6,2))+1 ) ),
 SUBSTRING(stock_in_audit_time,6,2) ) as new_month,
   	stock_in_audit_time,
   	stock_in_time,
   	SUBSTRING(stock_in_audit_time,0,4) as year,
   	SUBSTRING(stock_in_audit_time,6,2) as month,
    SUBSTRING(stock_in_audit_time,9,2) as day 
   	from dwmiddle.dwb_purchase_report_cd  where day='2020-02-04'
   	and stock_in_audit_time is null or stock_in_audit_time = '';
   	
  if( int(SUBSTRING(stock_in_audit_time,9,2)) >= 16 ,
  if(SUBSTRING(stock_in_audit_time,6,2)='12',concat(int(SUBSTRING(stock_in_audit_time,0,4))+1 ,'01') ,
  concat(int(SUBSTRING(stock_in_audit_time,0,4)) ,int(SUBSTRING(stock_in_audit_time,6,2))+1)),
  concat(int(SUBSTRING(stock_in_audit_time,0,4)) ,int(SUBSTRING(stock_in_audit_time,6,2))) ) 

-- 易飞日期 修正
	-- 201902
 select natural_month, 
 SUBSTRING(natural_month,0,4) as `year` ,
 SUBSTRING(natural_month,5,2) as `month`
 from dwbase.dwb_yifei_display_module where day='2020-02-04'
 
 -- 结构件数据修正
 
select in_date,
  if( int(SUBSTRING(in_date,9,2)) >= 16 ,
if(SUBSTRING(in_date,6,2)='12',concat(int(SUBSTRING(in_date,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(in_date,0,4)) ,'-', if( (int(SUBSTRING(in_date,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(in_date,6,2))+1)), int(SUBSTRING(in_date,6,2))+1 ))),
  concat(SUBSTRING(in_date,0,4) ,'-',SUBSTRING(in_date,6,2)))  as new_date
 from  sap.ODS_SAP_ZDMMR027 where day='2020-02-04';
 
 
 -- 磁材数据更新
 
 select in_date,
  if( int(SUBSTRING(in_date,9,2)) >= 16 ,
if(SUBSTRING(in_date,6,2)='12',concat(int(SUBSTRING(in_date,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(in_date,0,4)) ,'-', if( (int(SUBSTRING(in_date,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(in_date,6,2))+1)), int(SUBSTRING(in_date,6,2))+1 ))),
  concat(SUBSTRING(in_date,0,4) ,'-',SUBSTRING(in_date,6,2)))  as new_date
 from dwbase.dwb_sap_cicai where day = '2020-02-04' ;
 
 select in_date from dwbase.dwb_sap_cicai_by_cd where day = '2020-02-04' 
   	
   	
   	
   	-- 删除hdfs历史数据  dwmiddle数据
   	
drop table dwmiddle.dwb_purchase_combine_mid2
drop table dwmiddle.dwb_purchase_combine_mid1
drop table dwmiddle.dwb_purchase_combine_mid1_new
drop table dwmiddle.dwb_purchase_combine_mid1_new2
drop table dwmiddle.dwb_purchase_combine_mid_report_eas
drop table dwmiddle.dwb_purchase_combine_mid_report_eas2
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct2
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_rmb
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_dim
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_dim_sup
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_standard_price_supplier_new
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_final
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_final2
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_final3
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_final4
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_final_rmb_cd
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_final_sup
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_new
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_new3
drop table dwmiddle.dwm_eas_company_material_cd_by_month2
drop table dwmiddle.dwm_eas_material_cd_by_month
drop table dwmiddle.dwm_eas_material_cd_by_month2
drop table dwmiddle.dwm_eas_material_company_distinct_cd_by_month2
drop table dwmiddle.dwm_eas_material_company_no_standard_by_cd
drop table dwmiddle.dwm_eas_material_distinct_cd_by_month
drop table dwmiddle.dwm_eas_material_distinct_cd_by_month2
drop table dwmiddle.dwm_eas_material_no_standard_by_cd
drop table dwmiddle.dwm_eas_material_purchaser_distinct_cd_by_month2
drop table dwmiddle.dwm_eas_material_supplier_distinct_cd_by_month
drop table dwmiddle.dwm_eas_purchaser_material_cd_by_month2

select "date",in_date from dwbase.dwb_sap_jiegoujian_by_cd where day='2020-02-04'

select count(1) from dwmiddle.dwb_purchase_report_cd where day='2020-02-04'
select count(1) from dwmiddle.dwb_purchase_report_cd_tmp where day='2020-02-04'

select CFSupplierNumID,CFMaterielNumID eas.ods_eas_new_eas75_ct_ls_match where day='2020-02-04'

alter table dwmiddle.dwb_purchase_report_cd_tmp drop partition(day='2020-02-04')
select FMaterialID from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-04'
select fid from eas.ods_eas_new_eas75_t_bd_material where day='2020-02-04'
alter table dwmiddle.dwb_purchase_report_cd_tmp drop PARTITION(day='2020-02-04');


select distinct(day) from dwmiddle.dwb_purchase_report_cd_tmp where day='2020-02-04';


select count(1) from  dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 
where day='2020-02-04' and dim not in ('1','2','3','5','unknown','')  and dim is null;

10829476

-- 测试 根据采购入库单 的  fid,match多个条件join的结果
-- 3209936
select * from dwmiddle.dwb_purchase_combine_mid1_new3 where day='2020-02-23';
select count(1) from dwmiddle.dwb_purchase_combine_mid1_new3 where day='2020-02-23';
-- 15593506  15593506 -- 3518393  3441929 3441929
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3 where day='2020-02-23';
-- 3374319
select count(1) from dwmiddle.dwb_purchase_report_cd where day='2020-02-23';

--  测试对应维度数据   是否准确
select dim,BG,sum(total_amount) from dwservice.dws_cd_by_amount_month3  where day='2020-02-23' 
and `date` = '2020-01' group by dim,BG;
select dim,count(1) from dwservice.dws_cd_by_material_cut_price_month3  where day='2020-02-23' 
and `date` = '2020-01' group by dim;


select count(1) from dwbase.dwb_sap_jiegoujian_by_cd where day='2020-02-23';
select count(1) from sap.ods_sap_zdmmr027 where day='2020-02-23';

select count(1) from dwmiddle.dwb_purchase_report_cd where  day='2020-02-23' and pic = '王晓';
select stock_in_audit_time,`date`,`year`,`month` from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date`= '2020-01';

select dim,sum(amount) from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date`= '2020-01' group by dim;


/***
 * 

 * 
 */
select dim,sum(amount) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-04'
and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(stock_in_audit_time,0,10),'-',''),'/','')
 between '20191216' and '20200115'))
group by dim;

select stock_in_time from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'

	  select sum(amount) from (
	  select amount,buyer,company_name,supplier_name,stock_in_time, stock_in_audit_time
     from dwmiddle.dwb_purchase_report where day='2020-02-23'
     and `date` in ('202001','201912') 
    and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115') ) 
   	 and pic in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉')
   	 and supplier_name != 'LY INVESTMENT (HK) LIMITED'
   	  ) A


   	  select dim ,sum(amount) from  dwmiddle.dwb_purchase_report where day='2020-02-23' 
   	  and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115') ) 
   	 and supplier_name != 'LY INVESTMENT (HK) LIMITED'
   	 group by dim;
   	
   	
   	select amount,pic,buyer,dim
     from dwmiddle.dwb_purchase_report where day='2020-02-23'
     and `date` in ('202001','201912') 
    and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115') ) 
   	 and pic in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉')
   	 and supplier_name != 'LY INVESTMENT (HK) LIMITED'
   	 order by dim;
   	
   	
   	select * from eas.ods_eas_new_eas75_t_bd_person where day='2020-02-23'
   	and fname_l2 = '帅建明'
   	
   	
   	select distinct supplier_name as supplier_name2 from dwmiddle.dwb_purchase_report
where day='2020-02-23'  and dim in ('1','2','5') and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16') union all
select distinct(fname_l2) from eas.ods_eas_new_eas75_t_org_company where day='2020-02-23'


select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day = '2020-02-23' 
and dim = 'unknown' and  stock_number= 'DTLYZX0002'  and material_code='881-AEX866-A0-0';
/**
 * 	37
1	400334
2	257113
unknown	2296784
5	12611
3	475050
 */
select dim,count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day = '2020-02-23' 
group by dim;

insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 partition(day='${l_date}')
SELECT po_number, stock_number, material_code, material_8code, material_name, material_describe, material_model, material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name, out_supp_material_code, purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time, stock_in_time, document_date, stock_goods_describe, first_level, secondary_level, third_level, project_id, voucher_project_code, material_type, quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price, tax_price, cur_amount, tax_amount, tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price, check_bechmark_amount, check_cd_amount, pic, docu_pic, supp_po_code, line_pic, area, factory_code, factory_area, branch_of_facoty, order_number, check_return_code, check_number, check_return_num, return_num, cur_tax, inventory_unit, ori_cur_beftax_amount, ori_cur_tax, tax, ori_cur_amount, damage_num, scrapped_num, location_code, sales_unit, appoint, ori_proxy, buyer, remarks, period, `year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number, unit, warehouse_name, delivery_warehouse, company_code, company_name, order_date, purorder_fid, supplier_po_number, origin_firm, classify, costcenter_code, costcenter_name, pay_condition, currency, currency_name, pay_day, account_day, pay_type, acreage, line, type_pic, project_pic, big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price, diff_amount, update_bechmark_price, rpl_cd_amount, all_cd, bg,  
case  
when   stock_number= 'DTLYZX0002'  and material_code='881-AEX866-A0-0' and dim in ('unknown','') then '1'
else dim
end as dim
FROM dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3  where day='${l_date}'

   	
select A.dim,sum(A.amount) from (
select amount,dim 
 from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'
and dim in ('1','2','5') and supplier_name not in(select distinct supplier_name as supplier_name2 
from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 
where day='2020-02-23'  and dim in ('1','2','5') and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16') union all
select distinct(fname_l2) from eas.ods_eas_new_eas75_t_org_company where day='2020-02-23')  
) A group by dim;

-- 400334
select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'
and dim not in ('1','2','3',null);



select distinct supplier_name as supplier_name2 from dwmiddle.dwb_purchase_report_cd 
where day='2020-02-04'  and dim ='unknown' and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16');

select count(1) from dwmiddle.dwb_purchase_report_cd where day='2020-02-04'
and dim ='unknown'
and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(stock_in_audit_time,0,10),'-',''),'/','')
 between '20191216' and '20200115'))
 and supplier_name not in(select distinct supplier_name as supplier_name2 from dwmiddle.dwb_purchase_report_cd 
where day='2020-02-04'  and dim ='unknown' and supplier_name like '%领%' 
and supplier_code not in('LT07','LM01','LX04','LC02','JL06','XJ16') union all
select distinct(fname_l2) from eas.ods_eas_new_eas75_t_org_company where day='2020-02-04')
and  first_level not in ('成品','半成品')
and buyer not in
('欧阳楠','黄欣','李婷','张敦锋','黄翠凤','叶淑玲','袁刚','占婷玉','盛婷','李超超','许阿青','李灵杰','周莎莎','虞桦','江荣','郭朝霞',
'王欢','黄利霞','费晨艳','谢淑艳','余建春','杨冉','王明亮','皮丽芳','袁菱鸿','周雅芹','王亚方','刘宣伶','张志芹','王芳','刘晓燕','王艳','杨甲香');

-- 1282  50019 
select count(1) from dwmiddle.dwb_purchase_report_cd where day='2020-02-04'
and dim ='unknown'
and ( (regexp_replace(regexp_replace(substring(stock_in_time,0,10),'-',''),'/','')
 between '20191216' and '20200115')  or (regexp_replace(regexp_replace(substring(stock_in_audit_time,0,10),'-',''),'/','')
 between '20191216' and '20200115'))
and  first_level in ('成品','半成品')
and buyer not in 
('欧阳楠','黄欣','李婷','张敦锋','黄翠凤','叶淑玲','袁刚','占婷玉','盛婷','李超超','许阿青','李灵杰','周莎莎','虞桦','江荣','郭朝霞',
'王欢','黄利霞','费晨艳','谢淑艳','余建春','杨冉','王明亮','皮丽芳','袁菱鸿','周雅芹','王亚方','刘宣伶','张志芹','王芳','刘晓燕','王艳','杨甲香')


select count(1) from dwmiddle.dwb_purchase_report_cd where day='2020-02-23' 
and  BG not null;

select count(1) from eas.ods_eas_new_eas75_t_bd_person where day='2020-02-04' 
and  fname_l2 is null;

select count(1) from dwbase.dwb_sap_cicai  where day='2020-02-04' 
and  in_date is null;

select count(1) from sap.ods_sap_zfmm_044_jituan where day='2020-01-16' 
and stock_org_name is null;


-- select * from (
select * from dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3 where day='2020-02-23'
and appoint= 'unGYb60rRHi6ptv+lZgSI44IhhY=' ;
-- group by appoint )A order by num desc  ;

-- 2020-02-20
select pre_untax_unit_price,untax_unit_price  from dwbase.dwb_sap_cicai where day='2020-02-20'
and pre_untax_unit_price != 0;
select count(1) from sap.ods_sap_zdmmr027  where day='2020-02-20';

-- 10239266  10239266  3441929
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'
and stock_number = 'LSCDCR151200108';
select dim,count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23' 
group by dim;
-- 5457567  5457567
select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'
and appoint = '' ;
-- 0
select count(distinct(po_number ))  from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'
and appoint = 'DB5/NAjwRluHtB+hmga+po4IhhY=' ;
select  * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'
and stock_number = 'LSCHKCR16092800063';

select  * from dwmiddle.dwb_purchase_combine_mid1_new3 where day='2020-02-23'
and stock_number = 'LSCHKCR16092800063  left join 
(select fid,fnumber,fname_l2 from eas.ods_eas_new_eas75_t_bd_currency where day='${l_date}')I ON mid1.FCurrencyID = I.fid';



select * from eas.ods_eas_new_eas75_t_bd_person where day='2020-02-23' and fnumber = '36019570';
select fnumber,fname_l2 from eas.ods_eas_new_eas75_t_bd_person where day='2020-02-23'
-- 660936  订单数量


select dim,count(1) from dwmiddle.dwb_purchase_combine_mid1_new3 where day='2020-02-23'
group by dim;

 -- 10030489
select count(1) from
(select po_number from  dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3
     where day='2020-02-23'
group by  po_number, stock_number, material_code, material_8code, material_name, material_describe,
 material_model, material_group_code, material_group_describe, supplier_code, supplier_name, 
 supplier_simple_name, out_supp_material_code, purchase_group_code, purchase_group_name,
  purchase_org_code, stock_in_audit_time, stock_in_time, document_date, stock_goods_describe, 
  first_level, secondary_level, third_level, project_id, voucher_project_code, material_type, 
  quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price, tax_price, 
  cur_amount, tax_amount, tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price, 
  check_bechmark_amount, check_cd_amount, pic, docu_pic, supp_po_code, line_pic, area, factory_code,
   factory_area, branch_of_facoty, order_number, check_return_code, check_number, check_return_num, 
   return_num, cur_tax, inventory_unit, ori_cur_beftax_amount, ori_cur_tax, tax, ori_cur_amount,
damage_num, scrapped_num, location_code, sales_unit, appoint, ori_proxy, buyer, remarks, period,
 `year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number, unit,
  warehouse_name, delivery_warehouse, company_code, company_name, order_date, 
  supplier_po_number, origin_firm, classify, costcenter_code, costcenter_name, pay_condition,
   currency, currency_name, pay_day, account_day, pay_type, acreage, line, type_pic, project_pic,
    big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price, diff_amount,
     update_bechmark_price, rpl_cd_amount, all_cd, bg, dim 
      ) A ;


-- 1592061
select count(1) from (
select purorder_fid,count(1) as num from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'
 group by purorder_fid  ) A where A.num >1;

select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'
and  purorder_fid =  '/2L6oRINQAGJTNr8cqiY/44IhhY='

----> 差值  = 51 <----
-- all = 3441929   current= 3139257   3139206
select count(1) from (
select A.purorder_fid from 
(select * from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23')  A 
group by A.purorder_fid,A.stock_number,A.stock_in_audit_time,A.material_code,A.material_8code,
A.material_name,A.amount,A.`date`,
A.dim,A.price,A.supplier_code,A.supplier_name,A.first_level,A.area,A.company_name ) B
-- 3139206
select count(distinct(purorder_fid)) from 
 dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23';

-- 测试 组装和成本中心区分是否正确
select dim,count(1) from 
 dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'  group by dim;


-- 324422496
select count(1) from dwbase.dwb_mould_poorder where day='2020-01-16' ; 
-- 测试 入库单=LSCDCR151200108(hCtUH4PbRkydC0EryTif/XgwYeM=) material=180-DUWYE307-0001
select fid,FAmount from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-23' 
and fparentid = 'hCtUH4PbRkydC0EryTif/XgwYeM=';
select fid,FAmount from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-23' 
and fid='';


-- 8036126
select count(1) from dwmiddle.dwb_purchase_combine_mid1_new3 where day='2020-02-04';
-- 21480032
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3 where day='2020-02-';
-- 10829476
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-04';

select dim,count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-04' 
group by dim;

alter table dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3 drop PARTITION(day='2020-02-24')
alter table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 drop PARTITION(day='2020-02-24')

-- 7737  7263
select count(1) from dwmiddle.account_mid  where day='2020-02-04' order by  fsupplierid;
select count(distinct(fsupplierid)) from dwmiddle.account_mid  where day='2020-02-04' ;
-- 1913
select count(distinct(supplier_code)) from dwmiddle.dwb_purchase_combine_mid1_new3 where day='2020-02-23';
select count(distinct(FCurrencyID)) from dwmiddle.dwb_purchase_combine_mid1_new3 where day='2020-02-23';
select count(1) from dwmiddle.dwb_purchase_combine_mid1_new3 where day='2020-02-23'
and (appoint is null  or appoint is null);

select *  from dwmiddle.account_mid  where day='2020-02-23' 
and pay_type is null or pay_type = '' 
or  pay_day is null or pay_day = '' 
 or account_day is null or account_day = ''
or pay_condition is null or pay_condition = '';

--345   31
select * from (
select fsupplierid,count(1) as num from dwmiddle.account_mid  where day='2020-02-23' 
group by fsupplierid ) A where A.num >1 ;

select * from  dwmiddle.account_mid where day='2020-02-23' 
and fsupplierid = '/OQAAAIr/Y43xn38';

select * from eas.ods_eas_new_eas75_t_bd_paycondition where day='2020-02-23';
select * from eas.ods_eas_new_eas75_t_bd_payconditionentry  where day='2020-02-23';
select *  from eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo   where day='2020-02-23';

select fsupplierid,fpayconditionid,fsettlementtypeid  from eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo
where day='2020-02-23' and fsupplierid = '/OQAAAIr/Y43xn38'

insert overwrite table dwmiddle.account_mid partition(day='${l_date}')
select B.fsupplierid,B.pay_type,B.pay_day, B.account_day, B.pay_condition from (
select  A.fsupplierid,A.pay_type,A.pay_day, A.account_day, A.pay_condition,
row_number() OVER (PARTITION BY A.fsupplierid,A.pay_type ORDER BY A.account_day DESC ) rank from (
select J.fsupplierid,L.fname_l2 as pay_type ,K.fstartdeferdays as pay_day,K.fstartdeferdays as account_day,E.fname_l2 as pay_condition 
from 
(select fsupplierid,fpayconditionid,fsettlementtypeid  from eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo
where day='${l_date}' 
and ((fpayconditionid != '' and fpayconditionid is not null)   
or( fsettlementtypeid != ''and fsettlementtypeid is not null)  )  
) j
LEFT JOIN
(select fstartdeferdays,fparentid from eas.ods_eas_new_eas75_t_bd_payconditionentry where day='${l_date}'
)
K ON K.fparentid = J.fpayconditionid 
LEFT JOIN
(select fid,fname_l2 from eas.ods_eas_new_eas75_t_bd_paycondition where day='${l_date}'
)E ON E.fid =  K.fparentid 
LEFT JOIN (select out_put_filefid,fname_l2 from eas.ods_eas_new_eas75_t_bd_settlementtype where day='${l_date}'
 )L ON L.out_put_filefid = J.fsettlementtypeid  
) A )B where B.rank = 1

 --  更新 磁材 和结构件的数据  与   eas的日期一致
  -- eas  2020-02-23

select distinct(day) from dwbase.dwb_sap_cicai;    -- 2020-02-20 2020-02-23
select distinct(day) from dwdetail.dwd_cicai_cd_detail;  -- 2020-02-20 2020-02-23

select distinct(day) from sap.ods_sap_zdmmr027 ;     -- 2020-02-20
select distinct(day) from dwdetail.dwd_jiegoujian_cd_detail;  -- 2020-02-20 2020-02-23

select distinct(day) from sap.ods_sap_zfmm_044_jituan;  -- 2020-02-23
select distinct(day) from dwdetail.dwd_jituan_cd_detail; -- 2020-02-23

select distinct(day) from dwbase.dwb_mould_poorder ;        -- 2020-02-04
select distinct(day) from dwbase.dwb_yifei_display_module ;  -- 2020-02-19

insert overwrite table  dwdetail.dwd_cicai_cd_detail partition(day='2020-02-23')
SELECT supplier_code, supplier_name, po, material_code, material_des, in_date, unit, order_qty, in_qty, factory_code,
factory_des, company_des, tax_unit_price, in_tax_amout, material_group, material_group_des, untax_unit_price, buyer,
pre_tax_unit_price, pre_untax_unit_price, cd_amount, cd_percent, origin, reserved1, reserved2 FROM dwdetail.dwd_cicai_cd_detail
where day='2020-02-20';

insert overwrite table  dwdetail.dwd_jiegoujian_cd_detail partition(day='2020-02-23')
SELECT in_date, rkdh, supplier, po, material, inventory_des, in_qty, tax_unit_price, total_price, tax_rate, purchase_buyer, 
purchase_no, company_no, factory, delivery_site, delivery_site_des, purchase_organization, purchase_group, supplier_code,
purchase_type, purchase_type_des, material_voucher_item, material_group, material_group_des, measurement_unit_stock, 
measurement_unit_purchase, lot_no, debtor, pr, currency, net_price, price_unit, original_currency_unit, tax_code,
original_currency_amount, proof_annual, payment_type, invoice_number, invoice_date, issue_date, payment_clause, 
delivery_order, movement_type, po_voucher_date, posting_people, starting_price, difference_price, cd_price, first_material,
second_material, third_material, is_refer, project_number, origin, reserved1, reserved2
FROM dwdetail.dwd_jiegoujian_cd_detail where day='2020-02-20';



select company_no,sum(original_currency_amount) from sap.ods_sap_zdmmr027  where day='2020-02-20'
group by company_no;

-- 结构件数据 ，日期修改，以及金额测试。
-- 8810  ：供应商剔除领益智造科技（东莞）有限公司和东莞市欧比迪精密五金有限公司（委外，辅料等）   
--  8800：剔除供应商为【东莞市欧珀精密电子有限公司】（客户需求的入库金额）
select A.company_no,
sum(cd_price) as all_cd_price,sum(total_price) as all_total_price ,
sum(original_currency_amount) as all_original_currency_amount from (
select in_date ,
if( int(SUBSTRING(in_date,9,2)) >= 16 ,
if(SUBSTRING(in_date,6,2)='12',concat(int(SUBSTRING(in_date,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(in_date,0,4)) ,'-', if( (int(SUBSTRING(in_date,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(in_date,6,2))+1)), int(SUBSTRING(in_date,6,2))+1 ))),
  concat(SUBSTRING(in_date,0,4) ,'-',SUBSTRING(in_date,6,2))) as new_date ,
  original_currency_amount,company_no,total_price,cd_price
 from  dwdetail.dwd_jiegoujian_cd_detail  where day='2020-02-23' 
and company_no = '8810' and supplier not in ('领益智造科技（东莞）有限公司','东莞市欧比迪精密五金有限公司') 
and purchase_organization<>'8830'
-- and instr(in_date,'-') != 0
union ALL
select in_date ,
if( int(SUBSTRING(in_date,9,2)) >= 16 ,
if(SUBSTRING(in_date,6,2)='12',concat(int(SUBSTRING(in_date,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(in_date,0,4)) ,'-', if( (int(SUBSTRING(in_date,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(in_date,6,2))+1)), int(SUBSTRING(in_date,6,2))+1 ))),
  concat(SUBSTRING(in_date,0,4) ,'-',SUBSTRING(in_date,6,2))) as new_date ,
  original_currency_amount,company_no,total_price,cd_price
 from  dwdetail.dwd_jiegoujian_cd_detail  where day='2020-02-23' 
and company_no = '8800' and supplier != '东莞市欧珀精密电子有限公司'
and  purchase_organization<>'8830'
union ALL
select in_date ,
if( int(SUBSTRING(in_date,9,2)) >= 16 ,
if(SUBSTRING(in_date,6,2)='12',concat(int(SUBSTRING(in_date,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(in_date,0,4)) ,'-', if( (int(SUBSTRING(in_date,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(in_date,6,2))+1)), int(SUBSTRING(in_date,6,2))+1 ))),
  concat(SUBSTRING(in_date,0,4) ,'-',SUBSTRING(in_date,6,2))) as new_date ,
  original_currency_amount,company_no,total_price,cd_price
 from  dwdetail.dwd_jiegoujian_cd_detail  where day='2020-02-23' 
and company_no = '8800' and supplier != '东莞市欧珀精密电子有限公司'
and purchase_organization = '8830'
and purchase_buyer in ('陈霞','方巧慧','曾玲玲','李魏')
union ALL
select in_date ,
if( int(SUBSTRING(in_date,9,2)) >= 16 ,
if(SUBSTRING(in_date,6,2)='12',concat(int(SUBSTRING(in_date,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(in_date,0,4)) ,'-', if( (int(SUBSTRING(in_date,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(in_date,6,2))+1)), int(SUBSTRING(in_date,6,2))+1 ))),
  concat(SUBSTRING(in_date,0,4) ,'-',SUBSTRING(in_date,6,2))) as new_date ,
  original_currency_amount,company_no,total_price,cd_price
 from  dwdetail.dwd_jiegoujian_cd_detail  where day='2020-02-23' 
and company_no not in ('8810','8800')
and  purchase_organization<>'8830'
-- and instr(in_date,'-') != 0
 ) A where A.new_date = '2020-01' group by company_no;


select supplier from  dwdetail.dwd_jiegoujian_cd_detail where day='2020-02-20'  and supplier like '%欧珀%'
select company_no,count(1) from  dwdetail.dwd_jiegoujian_cd_detail where day='2020-02-20' 
;

-- 结构件数据剔除异常数据（in_date格式为2019.12.18的数据，数据错乱）
	select in_date,tax_unit_price,tax_rate,in_qty,original_currency_unit,starting_price,difference_price,cd_price,
	net_price,price_unit,original_currency_amount,total_price
	from  sap.ods_sap_zdmmr027  where day='2020-02-20' 
	and instr(in_date,'-') != 0 
	and in_date BETWEEN '2019-12-16' and '2020-01-15'

select * from test.date_test where `date` BETWEEN '2019.12.15' and '2020.01.15'

select company_no,sum(total_price) from sap.ods_sap_zdmmr027  where day='2020-02-20'  
group by company_no;

select distinct(company_no) from sap.ods_sap_zdmmr027  where day='2020-02-20';  
select distinct(company_no) from  dwdetail.dwd_jiegoujian_cd_detail where day='2020-02-20'; 



-- 571379
select count(1) from sap.ods_sap_zdmmr027  where day='2020-02-20'; 
-- 575034
select count(1) from  dwdetail.dwd_jiegoujian_cd_detail where day='2020-02-20'; 



-- 组装数据
 --37688245.716144

	  select sum(amount) from (
	  select amount,buyer,company_name,supplier_name,stock_in_time, stock_in_audit_time
     from dwmiddle.dwb_purchase_report where day='2020-02-23'
     and `date` in ('202001','201912') 
    and ( (regexp_replace(regexp_replace(substring(stock_in_audit_time,0,10),'-',''),'/','')
   	 between '20191216' and '20200115') ) 
   	 and pic in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉')
   	 and supplier_name != 'LY INVESTMENT (HK) LIMITED'
   	  ) A
   	  -- 完全去重  37688245.716144
   	   select sum(A.amount) from (
	  select purorder_fid,collect_set(amount)[0] as amount
     from dwmiddle.dwb_purchase_report_cd where day='2020-02-23'
    and `date` = '2020-01'
   	 and pic in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉')
   	 and supplier_name != 'LY INVESTMENT (HK) LIMITED'
   	 group by purorder_fid 
   	  ) A
   	  
   	  
   	  
   	  

select * from sap.ods_sap_zdmmr027  where day='2020-02-20'
and supplier not in ('领益智造科技（东莞）有限公司','东莞市欧比迪精密五金有限公司');


select supplier,count(1) from sap.ods_sap_zdmmr027  where day='2020-02-20'
group by supplier ;


select distinct(`date`) from dwbase.dwb_mould_poorder where day='2020-02-24'
select distinct(buyer) from dwbase.dwb_mould_poorder where day='2020-02-24'
select buyer,regexp_extract(buyer,'([\\\u4E00-\\\u9FA5]+)',1) from  dwbase.dwb_mould_poorder where day='2020-02-24'
and buyer in ('li.zhou.rong/李周蓉','liu.xuan.ling/刘宣伶','suzit','wang.feng.mei/王凤梅FT-3132','xiao.jing/肖晶','丁冬冬6015457',
'胡胜SZ-158101')

-- 模具系统 ， price和amount，buyer优化。
select regexp_extract(buyer,'([\\\u4E00-\\\u9FA5]+)',1) as buyer,
( cast((tax_price / ((tax_rate/100)+1)) as decimal(28,2)) *quantity) as amount,
cast((tax_price / ((tax_rate/100)+1)) as decimal(28,2)) as price, quantity,tax_price,tax_rate,`date`,
if( int(SUBSTRING(stock_in_audit_time,9,2)) >= 16 ,
if(SUBSTRING(stock_in_audit_time,6,2)='12',concat(int(SUBSTRING(stock_in_audit_time,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(stock_in_audit_time,0,4)) ,'-', if( (int(SUBSTRING(stock_in_audit_time,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(stock_in_audit_time,6,2))+1)), int(SUBSTRING(stock_in_audit_time,6,2))+1 ))),
  concat(SUBSTRING(stock_in_audit_time,0,4) ,'-',SUBSTRING(stock_in_audit_time,6,2))) as  new_stock_in_audit_time ,
  stock_in_audit_time,stock_in_time,stand_price,supplier_name,currency_name
from dwbase.dwb_mould_poorder where day='2020-03-03'



select data_sources,buyer,count(1) from dwmiddle.dwb_purchase_standard_price where day='2020-02-23' and buyer  like  '%刘宣伶%'
group by  buyer,data_sources;

select sum(amount) from dwmiddle.dwb_purchase_standard_price where day='2020-02-23'
group by data_sources;

select stock_in_audit_time,`date` from dwmiddle.dwb_purchase_standard_price where day='2020-02-23'
and data_sources = 'dgsxmouldm' and stock_in_audit_time!='' ;

select stock_in_audit_time,`date` from dwbase.dwb_mould_poorder where day='2020-02-24'
and data_sources = 'dgsxmouldm';

select tax_rate,count(1) from dwbase.dwb_mould_poorder where day='2020-02-24' group by tax_rate;

select `date` from dwbase.dwb_mould_poorder where day='2020-02-24'
select `date` from dwmiddle.dwb_purchase_standard_price  where day='2020-02-24'


select count(1) from  sap.ods_sap_zfmm_044_jituan where day='2020-02-23'
select count(1) from  dwbase.dwb_sap_cicai where day='2020-02-23'
  
 insert overwrite table dwbase.dwb_sap_cicai partition(day='2020-02-23')
 SELECT supplier_code, supplier_name, po, material_code, material_des, in_date, unit, order_qty, in_qty, factory_code,
  factory_des, company_des, tax_unit_price, in_tax_amout, material_group, material_group_des, untax_unit_price, buyer, 
  pre_tax_unit_price, pre_untax_unit_price, cd_amount, cd_percent, origin, reserved1, reserved2
   FROM dwbase.dwb_sap_cicai where day='2020-02-20';
  
 
 insert overwrite table sap.ods_sap_zdmmr027 partition(day='2020-02-23')
SELECT in_date, rkdh, supplier, po, material, inventory_des, in_qty, tax_unit_price, total_price, tax_rate,
 purchase_buyer, purchase_no, company_no, factory, delivery_site, delivery_site_des, purchase_organization, 
 purchase_group, supplier_code, purchase_type, purchase_type_des, material_voucher_item, material_group,
  material_group_des, measurement_unit_stock, measurement_unit_purchase, lot_no, debtor, pr, currency, net_price, 
  price_unit, original_currency_unit, tax_code, original_currency_amount, proof_annual, payment_type, invoice_number,
   invoice_date, issue_date, payment_clause, delivery_order, movement_type, po_voucher_date, posting_people, 
   starting_price, difference_price, cd_price, first_material, second_material, third_material, is_refer, project_number
  FROM sap.ods_sap_zdmmr027 where day='2020-02-20';

 select dim,sum(total_amount) from dwservice.dws_cd_by_amount_month3 where day='2020-02-23' 
 and `date` = '2020-01'
 group by dim;

select dim,sum(amount) from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date`= '2020-01' group by dim;


-- 导出eas的物料数据

-- 1065991  1065923
select count(DISTINCT(fnumber)) from eas.ods_eas_new_eas75_t_bd_material where day='2020-02-23'

select fnumber,fname_l2 ,FModel,FPricePrecision,
case FStatus
when 0 then '未核准'
when 1 then '核准'
when 2 then '禁用'
when 3 then '已删除'
else 'unknown' 
end as status,
FIsGoods,FCreateTime 
from eas.ods_eas_new_eas75_t_bd_material where day='2020-02-23'

-- cnc  1621814153.197007     
-- cnc    cd表去重（未根据pid唯一）    
-- cnc   1462301521.464599(eas去重后) + 158726304.746408(sap)  =    1621027826.211007  【根据pid】 1620274464
select dim,sum(amount) from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date` like  '%2019-%' group by dim;

-- cnc eas进行去重  ，其他不需要去重
select collect_set(area)[0],collect_set(factory_area)[0],collect_set(stock_org_name)[0],
collect_set(`date`)[0],collect_set(stock_in_audit_time)[0],collect_set(first_level)[0],collect_set(secondary_level)[0],
collect_set(third_level)[0],collect_set(po_number)[0],collect_set(supplier_name)[0],collect_set(material_code)[0],
collect_set(material_name)[0],collect_set(material_model)[0],collect_set(quantity)[0],collect_set(unit)[0],
collect_set(currency_name)[0],collect_set(tax_price)[0],collect_set(tax_rate)[0],collect_set(exchange_rate)[0],
collect_set(price)[0],collect_set(tax_amount)[0],collect_set(amount)[0],collect_set(bechmark_price)[0],
collect_set(bechmark_amount)[0],collect_set(cd_amount)[0],collect_set(account_day)[0],collect_set(account_amount)[0],
collect_set(buyer)[0] from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date` like  '%2019-%'  and dim='1'
and data_sources != 'eas' 
group by purorder_fid;
-- cnc sap系统的数据
select area,factory_area,stock_org_name,`date`,stock_in_audit_time,first_level,secondary_level,
third_level,po_number,supplier_name,material_code,material_name,material_model,quantity,unit,currency_name,
tax_price,tax_rate,exchange_rate,price,tax_amount,amount,bechmark_price,bechmark_amount,cd_amount,account_day,
account_amount,buyer
from  dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date` like  '%2019-%'  and dim='1'
and data_sources != 'eas'
-- 求和  sap
select sum(amount)
from  dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date` like  '%2019-%'  and dim='1'
and data_sources != 'eas'
-- 求和  eas
select sum(amount) from (
select collect_set(amount)[0] as amount
from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date` like  '%2019-%'  and dim='1'
and data_sources = 'eas' 
group by purorder_fid) A;

select dim,count(1) from dwservice.dws_cd_by_amount_month3 where   day='2020-02-23' group by dim;
select count(1) from sap.ods_sap_zfmm_044_jituan where day='2020-02-23'
select distinct(day) from dwdetail.dwd_jituan_cd_detail where day='2020-02-23'

-- start1 第一个脚本
select count(1) from dwmiddle.dwb_purchase_combine_mid1_new3 where day='2020-02-23'  --3209936  975206
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3 where day='2020-02-23' --3518393 975206
select count(1) from dwmiddle.account_mid where day='2020-02-23'  -- 7263 
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'  -- 965026
-- collect_set和sap去重后
--   4299542 
-- 未去重  4603325  
-- 抓取 2019年以后的数据  891771
select count(1) from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' ;
select count(1) from dwmiddle.dwb_purchase_report_cd_tmp
where  day='2020-02-23' ;
-- eas + 模具数据+sap集团 导出（去重） ， 手动导出。  
--select A.dim, sum(A.amount) from (
select count(1) from (
-- select buyer,A.data_sources,count(1) from (
select 
collect_set(po_number)[0],collect_set(stock_number)[0],collect_set(material_code)[0],collect_set(material_8code)[0],collect_set(material_name)[0],
collect_set(material_describe)[0],collect_set(material_model)[0],collect_set(material_group_code)[0],collect_set(material_group_describe)[0],
collect_set(supplier_code)[0],collect_set(supplier_name)[0],collect_set(supplier_simple_name)[0],collect_set(out_supp_material_code)[0],
collect_set(purchase_group_code)[0],collect_set(purchase_group_name)[0],collect_set(purchase_org_code)[0],collect_set(stock_in_audit_time)[0],
collect_set(stock_in_time)[0],collect_set(document_date)[0],collect_set(stock_goods_describe)[0],collect_set(first_level)[0],collect_set(secondary_level)[0],
collect_set(third_level)[0],collect_set(project_id)[0],collect_set(voucher_project_code)[0],collect_set(material_type)[0],collect_set(quantity)[0],
collect_set(price_unit)[0],collect_set(exchange_rate)[0],collect_set(tax_rate)[0],collect_set(tax_code)[0],collect_set(price)[0],collect_set(usd_price)[0],
collect_set(tax_price)[0],collect_set(cur_amount)[0],collect_set(tax_amount)[0],collect_set(tax_rmb_amount)[0],collect_set(amount)[0] as amount,collect_set(start_price)[0],
collect_set(start_diff_price)[0],collect_set(check_bechmark_price)[0],collect_set(check_bechmark_amount)[0],collect_set(check_cd_amount)[0],collect_set(pic)[0],
collect_set(docu_pic)[0] as docu_pic,collect_set(supp_po_code)[0],collect_set(line_pic)[0],collect_set(area)[0],collect_set(factory_code)[0],collect_set(factory_area)[0],
collect_set(branch_of_facoty)[0],collect_set(order_number)[0],collect_set(check_return_code)[0],collect_set(check_number)[0],collect_set(check_return_num)[0],
collect_set(return_num)[0],collect_set(cur_tax)[0],collect_set(inventory_unit)[0],collect_set(ori_cur_beftax_amount)[0],collect_set(ori_cur_tax)[0],
collect_set(tax)[0],collect_set(ori_cur_amount)[0],collect_set(damage_num)[0],collect_set(scrapped_num)[0],collect_set(location_code)[0],
collect_set(sales_unit)[0],collect_set(appoint)[0],collect_set(ori_proxy)[0],collect_set(buyer)[0] as buyer,collect_set(remarks)[0],collect_set(period)[0],
collect_set(`year`)[0],collect_set(`month`)[0],collect_set(`date`)[0],collect_set(data_sources)[0] as data_sources,collect_set(stock_org_number)[0],collect_set(stock_org_name)[0],
collect_set(unit_number)[0],collect_set(unit)[0],collect_set(warehouse_name)[0],collect_set(delivery_warehouse)[0],collect_set(company_code)[0],
collect_set(company_name)[0],collect_set(order_date)[0], purorder_fid,collect_set(supplier_po_number)[0],collect_set(origin_firm)[0],
collect_set(classify)[0],collect_set(pay_condition)[0],collect_set(currency)[0],collect_set(currency_name)[0],collect_set(pay_day)[0],
collect_set(account_day)[0],collect_set(pay_type)[0],collect_set(acreage)[0],collect_set(line)[0],collect_set(type_pic)[0],collect_set(project_pic)[0],
collect_set(big_classify)[0],collect_set(reduce_price_orig)[0],collect_set(avg_pay_day)[0],collect_set(rebate_ratio)[0],collect_set(update_statement_price)[0],
collect_set(diff_amount)[0],collect_set(update_bechmark_price)[0],collect_set(rpl_cd_amount)[0],collect_set(all_cd)[0],collect_set(bechmark_price)[0],
collect_set(bechmark_amount)[0],collect_set(cd_amount)[0],collect_set(cd_proportion)[0],collect_set(account_amount)[0],collect_set(bg)[0],collect_set(dim)[0]  as dim
from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' 
-- and `date` =  '2020-01'
and data_sources = 'eas'
group by purorder_fid
union ALL
SELECT po_number, stock_number, material_code, material_8code, material_name, material_describe, material_model,
material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name, out_supp_material_code, 
purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time, stock_in_time, document_date,
stock_goods_describe, first_level, secondary_level, third_level, project_id, voucher_project_code, material_type, 
quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price, tax_price, cur_amount, tax_amount, 
tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price, check_bechmark_amount, check_cd_amount, pic,
docu_pic, supp_po_code, line_pic, area, factory_code, factory_area, branch_of_facoty, order_number, check_return_code, 
check_number, check_return_num, return_num, cur_tax, inventory_unit, ori_cur_beftax_amount, ori_cur_tax, tax, 
ori_cur_amount, damage_num, scrapped_num, location_code, sales_unit, appoint, ori_proxy, buyer, remarks, period,
`year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number, unit, warehouse_name,
delivery_warehouse, company_code, company_name, order_date, purorder_fid, supplier_po_number, origin_firm, 
classify, pay_condition, currency, currency_name, pay_day, account_day, pay_type, acreage, line, type_pic, 
project_pic, big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price, diff_amount, 
update_bechmark_price, rpl_cd_amount, all_cd, bechmark_price, bechmark_amount, cd_amount, cd_proportion,
account_amount, bg, dim  FROM dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
-- and `date` =  '2020-01'
and data_sources = 'sap.ods_sap_zfmm_044'
group by 
po_number, stock_number, material_code, material_8code, material_name, material_describe, material_model,
material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name, out_supp_material_code, 
purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time, stock_in_time, document_date,
stock_goods_describe, first_level, secondary_level, third_level, project_id, voucher_project_code, material_type, 
quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price, tax_price, cur_amount, tax_amount, 
tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price, check_bechmark_amount, check_cd_amount, pic,
docu_pic, supp_po_code, line_pic, area, factory_code, factory_area, branch_of_facoty, order_number, check_return_code, 
check_number, check_return_num, return_num, cur_tax, inventory_unit, ori_cur_beftax_amount, ori_cur_tax, tax, 
ori_cur_amount, damage_num, scrapped_num, location_code, sales_unit, appoint, ori_proxy, buyer, remarks, period,
`year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number, unit, warehouse_name,
delivery_warehouse, company_code, company_name, order_date, purorder_fid, supplier_po_number, origin_firm, 
classify, pay_condition, currency, currency_name, pay_day, account_day, pay_type, acreage, line, type_pic, 
project_pic, big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price, diff_amount, 
update_bechmark_price, rpl_cd_amount, all_cd, bechmark_price, bechmark_amount, cd_amount, cd_proportion,
account_amount, bg, dim
union ALL
SELECT po_number, stock_number, material_code, material_8code, material_name, material_describe, material_model,
material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name, out_supp_material_code, 
purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time, stock_in_time, document_date,
stock_goods_describe, first_level, secondary_level, third_level, project_id, voucher_project_code, material_type, 
quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price, tax_price, cur_amount, tax_amount, 
tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price, check_bechmark_amount, check_cd_amount, pic,
docu_pic, supp_po_code, line_pic, area, factory_code, factory_area, branch_of_facoty, order_number, check_return_code, 
check_number, check_return_num, return_num, cur_tax, inventory_unit, ori_cur_beftax_amount, ori_cur_tax, tax, 
ori_cur_amount, damage_num, scrapped_num, location_code, sales_unit, appoint, ori_proxy, buyer, remarks, period,
`year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number, unit, warehouse_name,
delivery_warehouse, company_code, company_name, order_date, purorder_fid, supplier_po_number, origin_firm, 
classify, pay_condition, currency, currency_name, pay_day, account_day, pay_type, acreage, line, type_pic, 
project_pic, big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price, diff_amount, 
update_bechmark_price, rpl_cd_amount, all_cd, bechmark_price, bechmark_amount, cd_amount, cd_proportion,
account_amount, bg, dim  FROM dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and data_sources not in( 'eas','sap.ods_sap_zfmm_044')
) A
-- group by A.buyer,A.data_sources;
-- ) A group by A.dim;

--  17363
select count(1)
FROM dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and `date` = '2020-01'
and dim = '3'
and data_sources not in( 'eas','sap.ods_sap_zfmm_044')

select po_number,stock_number,buyer,pic,amount,dim,stock_in_audit_time  -- 31489 
FROM dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and `date` = '2020-01'
and dim = '3'
and data_sources ='eas'
order by pic 
-- 因为eas为pic为空的数据没取到。
select po_number,material_code,buyer,pic,amount,dim,costcenter_name   
FROM dwmiddle.dwb_purchase_report
where  day='2020-02-23' 
and dim = '3'
and data_sources ='eas'
and amount = '2030.21'
and stock_in_audit_time = '2020/01/11 02:29:43.633000000'
-- 采购员不为''的数据，模切的采购额为多少
select sum(amount)   -- 264880607.944844 + 80266173.66 = 345146781
FROM dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and `date` = '2020-01'
and dim = '3'
and data_sources ='eas'
and buyer =  ''

-- LLSZDD20200105002   800-NWR138-0A-R
select fid,fparentid,FPurchasePersonID from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-03-08'
and  fpurorderNumber like 'LLSZDD20200105002';
select FCreatorID,FAuditTime from eas.ods_eas_new_eas75_t_im_purinwarehsbill where day='2020-03-08'
and fnumber = 'LSSZCR19122600012'
-- hQR9Yv0QQwGeq/dgxk0D4xO33n8=
select fname_l2,fid ,fnumber,day from eas.ods_eas_new_eas75_t_pm_user where day='2020-02-19'
and fid = 'hQR9Yv0QQwGeq/dgxk0D4xO33n8='


-- 查看eas中模切的数据，采购为空的，找下单人的名称。
select distinct(C.fname_l2) from (
select po_number,stock_number,buyer,pic,amount,dim,stock_in_audit_time  -- 31489 
FROM dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and `date` = '2020-01'
and dim = '3'
and data_sources ='eas'
and buyer = '' )A  left join 
(select FCreatorID,FAuditTime,fnumber from eas.ods_eas_new_eas75_t_im_purinwarehsbill where day='2020-03-08') B on 
A.stock_number = B.fnumber 
left join 
(select fname_l2,fid ,fnumber,day from eas.ods_eas_new_eas75_t_pm_user where day='2020-02-19')C
on B.FCreatorID = C.fid



select count(1)    --4165
FROM dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and `date` = '2020-01'
and dim = '3'
and data_sources ='sap.ods_sap_zfmm_044'

-- 53017
select count(1) FROM dwmiddle.dwb_purchase_report_cd where day='2020-02-23' 
and `date` = '2020-01'
and dim = '3'


-- 测试账期天数 多个值情况
-- 290737
select A.purorder_fid,A.dim,A.account_day,A.pay_type,A.new_date from (
select 
count(account_day) as num,collect_set(dim) as dim,collect_set(account_day) as account_day,
collect_set(purorder_fid) as purorder_fid ,collect_set(pay_type) as pay_type,collect_set(`date`) as new_date
from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' 
and data_sources = 'eas'
group by purorder_fid
) A where A.num >1 
order by new_date desc

-- hive collect_set相同的值只会显示一次。
-- 账期天数相等，付款条件 = 现金 ，null
select purorder_fid,account_day,pay_type from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' 
and data_sources = 'eas'
and purorder_fid = '+0OecuMdT3iZCFY/Lb+H744IhhY='

-- 账期天数相等，付款条件 = 现金 ，银行付款
select purorder_fid,account_day,pay_type from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' 
and data_sources = 'eas'
and purorder_fid = '+tXPHQUhTIuRFtq2llZHs44IhhY='

--相同的入库分库单， 账期天数不相等，付款条件  分别= 现金 ，银行付款
-- iMtrwWbDS7GgcU3fApqI544IhhY=
select po_number,supplier_code,supplier_name,purorder_fid as fid,material_code,account_day,pay_type from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' 
and data_sources = 'eas'
and purorder_fid = 'iMtrwWbDS7GgcU3fApqI544IhhY='


select count(1) from  eas.ods_eas_new_eas75_t_im_purinwarehsbill where day='2020-02-23'  --1773698
and FAuditTime >= '2019-01-01'  -- 499830
and instr(FAuditTime,'-') !=0 ;

select FAuditTime from  eas.ods_eas_new_eas75_t_im_purinwarehsbill where day='2020-02-23'  --1773698
and FAuditTime < '2019-01-01' order by FAuditTime desc;
-- 3209936 (账期天数根据公司过滤后，)
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3 where day='2020-02-23' --3518393
select count(1) from dwmiddle.account_mid where day='2020-02-23'  -- 7271
select count(1) from eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo where day='2020-02-23'
and ((fpayconditionid != '' and fpayconditionid is not null)   
or( fsettlementtypeid != ''and fsettlementtypeid is not null))  --39649

-- select mid.fsupplierid,mid.pay_type,mid.pay_day,mid.fnumber ,mid.company_name from (
select count(1) from(  --39649
select J.fsupplierid,L.fname_l2 as pay_type ,K.fstartdeferdays as pay_day,K.fstartdeferdays as account_day,
E.fname_l2 as pay_condition ,c.fnumber as fnumber,c.fname_l2 as company_name
from 
(select fsupplierid,fpayconditionid,fsettlementtypeid,fcomorgid from eas.ods_eas_new_eas75_t_bd_suppliercompanyinfo
where day='${l_date}' 
and ((fpayconditionid != '' and fpayconditionid is not null)   
or( fsettlementtypeid != ''and fsettlementtypeid is not null))  
) j
left join 
(select fnumber,fid,fname_l2 from eas.ods_eas_new_eas75_t_org_company   where day='${l_date}') 
c on j.fcomorgid = c.fid
LEFT JOIN
(select fstartdeferdays,fparentid from eas.ods_eas_new_eas75_t_bd_payconditionentry where day='${l_date}'
)
K ON K.fparentid = J.fpayconditionid 
LEFT JOIN
(select fid,fname_l2 from eas.ods_eas_new_eas75_t_bd_paycondition where day='${l_date}'
)E ON E.fid =  K.fparentid 
LEFT JOIN (select out_put_filefid,fname_l2 from eas.ods_eas_new_eas75_t_bd_settlementtype where day='${l_date}'
 )L ON L.out_put_filefid = J.fsettlementtypeid  
) mid 
-- where  mid.fsupplierid = '/OQAAAJqsps3xn38'
-- 
select fid from eas.ods_eas_new_eas75_t_bd_supplier where day='2020-02-23'
and fnumber='DGZX127'

-- 计算模切 1月份，不同数据源，金额总计
select A.data_sources,sum(A.amount) from (
SELECT po_number, stock_number, material_code, material_8code, material_name, material_describe, material_model,
material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name, out_supp_material_code,
purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time, stock_in_time, document_date,
stock_goods_describe, first_level, secondary_level, third_level, project_id, voucher_project_code, material_type,
quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price, tax_price, cur_amount, tax_amount,
tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price, check_bechmark_amount, check_cd_amount, pic,
docu_pic, supp_po_code, line_pic, area, factory_code, factory_area, branch_of_facoty, order_number, check_return_code,
check_number, check_return_num, return_num, cur_tax, inventory_unit, ori_cur_beftax_amount, ori_cur_tax, tax,
ori_cur_amount, damage_num, scrapped_num, location_code, sales_unit, appoint, ori_proxy, buyer, remarks, period,
`year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number, unit, warehouse_name,
delivery_warehouse, company_code, company_name, order_date, purorder_fid, supplier_po_number, origin_firm,
classify, pay_condition, currency, currency_name, pay_day, account_day, pay_type, acreage, line, type_pic,
project_pic, big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price, diff_amount,
update_bechmark_price, rpl_cd_amount, all_cd, bechmark_price, bechmark_amount, cd_amount, cd_proportion,
account_amount, bg, dim  FROM dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' and `date` =  '2020-01'
and dim = '3'
group by
po_number, stock_number, material_code, material_8code, material_name, material_describe, material_model,
material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name, out_supp_material_code,
purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time, stock_in_time, document_date,
stock_goods_describe, first_level, secondary_level, third_level, project_id, voucher_project_code, material_type,
quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price, tax_price, cur_amount, tax_amount,
tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price, check_bechmark_amount, check_cd_amount, pic,
docu_pic, supp_po_code, line_pic, area, factory_code, factory_area, branch_of_facoty, order_number, check_return_code,
check_number, check_return_num, return_num, cur_tax, inventory_unit, ori_cur_beftax_amount, ori_cur_tax, tax,
ori_cur_amount, damage_num, scrapped_num, location_code, sales_unit, appoint, ori_proxy, buyer, remarks, period,
`year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number, unit, warehouse_name,
delivery_warehouse, company_code, company_name, order_date, purorder_fid, supplier_po_number, origin_firm,
classify, pay_condition, currency, currency_name, pay_day, account_day, pay_type, acreage, line, type_pic,
project_pic, big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price, diff_amount,
update_bechmark_price, rpl_cd_amount, all_cd, bechmark_price, bechmark_amount, cd_amount, cd_proportion,
account_amount, bg, dim) A group by A.data_sources



select count(1)  from dwmiddle.dwb_purchase_report_cd where  day='2020-02-23'; -- 2151400

select dim,sum(amount),collect_set(data_sources) from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date`= '2020-03' group by dim;

select data_sources,sum(amount) from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date`= '2020-01' 
and dim='2'
group by data_sources;

-- 测试 02-04数据 的eas库数据
select sum(A.amount),A.data_sources from(
select B.dim,B.amount,B.data_sources, if( int(SUBSTRING(B.stock_in_audit_time,9,2)) >= 16 ,
if(SUBSTRING(B.stock_in_audit_time,6,2)='12',concat(int(SUBSTRING(B.stock_in_audit_time,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(B.stock_in_audit_time,0,4)) ,'-', if( (int(SUBSTRING(B.stock_in_audit_time,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(B.stock_in_audit_time,6,2))+1)), int(SUBSTRING(B.stock_in_audit_time,6,2))+1 ))),
  concat(SUBSTRING(B.stock_in_audit_time,0,4) ,'-',SUBSTRING(B.stock_in_audit_time,6,2)))  as new_date from (
select dim,amount,data_sources,stock_number,material_code,material_name,price,
supplier_code,supplier_name,area,company_name,stock_in_audit_time
  from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-04' ) B group by 
B.stock_number,B.stock_in_audit_time,B.material_code,B.material_name,B.amount,
B.dim,B.price,B.supplier_code,B.supplier_name,B.area,B.company_name,B.data_sources
)A
where A.new_date= '2020-01' 
and dim = '2'
group by A.data_sources;


select data_sources,count(1) from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' group by data_sources;

select data_sources,`date` ,amount from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and  data_sources = 'zzmetalmould' ;

-- 导出CNC1月份的数据，按照采购员
select po_number,material_code,material_name,supplier_name,price,quantity,amount, buyer from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01'
order by buyer

select buyer,sum(amount) from dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01'
group by  buyer

select sum(amount) from test.cnc ;
select sum(fact_price) from test.cnc ;

select A.buyer1,A.num1,B.buyer2,B.num2 ,(B.num2-A.num1) as diff from (
select buyer as buyer1,sum(amount) as num1 from test.cnc2
group by buyer) A 
full join 
(select case buyer
when '阳贤' then 'yang.xian'
when '赵伟' then 'zhao.wei1'
else buyer end as buyer2 ,sum(amount) as num2 from dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01'
group by buyer) B 
on A.buyer1= B.buyer2

-- group by  之前
--  11140   sum(amount) = 219521215.6
select A.buyer1,A.amount1,A.material_code1,A.supplier_name1, B.buyer2,B.amount2,B.material_code2,B.supplier_name2 from (
select buyer as buyer1,round(amount,2) as amount1, material_code as material_code1,supplier_name as supplier_name1
from test.cnc2
) A 
 left outer join
--inner join 
(select case buyer
when '阳贤' then 'yang.xian'
when '赵伟' then 'zhao.wei1'
else buyer end as buyer2 ,round(amount,2) as amount2 , material_code as material_code2 ,supplier_name as supplier_name2 
from dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01') B 
on A.buyer1 = B.buyer2 and 
 A.amount1= B.amount2 and 
 A.material_code1= B.material_code2 and 
 A.supplier_name1= B.supplier_name2
 and B.buyer2 is null
and B.amount2 is null
and B.material_code2 is null
and B.supplier_name2 is null



-- group by  之后

--  common 116354636.3 ( 119962569 ->  119880754.1 )
-- private1(common) 1541440.11 (1543086.74  -> 1540684.98)
-- 业务   92702752.27    (95402168.17  -> 95486384.83)

-- private2(common) 1655615.52 (1835251.5  -> 1832853.27)
-- 大数据   127674504 (123886935.3  -> 123971148.4)


-- inner join   求交集，以及交集中的私有成分
select A.buyer1,A.amount1,A.material_code1,A.supplier_name1,A.quantity1,A.fact_price1,(A.count1 - B.count2) as diff1,
(if((A.count1 - B.count2) >= 0 ,(A.count1 - B.count2),0) * A.amount1) as private1_amount1, 
(A.count1*A.amount1) as count1_amount1, A.count1, 
if(A.count1 <= B.count2 , A.count1,B.count2) as common,
(A.amount1 * (if(A.count1 <= B.count2 , A.count1,B.count2)) ) as common_amount,
B.count2,(B.count2*B.amount2) as count2_amount2,
(if((B.count2 - A.count1) >= 0 ,(B.count2 - A.count1),0) * B.amount2) as private2_amount2,
(B.count2 - A.count1) as diff2,B.buyer2,B.amount2,B.material_code2,B.supplier_name2,B.quantity2,B.price2 from (
select buyer as buyer1,round(amount,2) as amount1, material_code as material_code1,supplier_name as supplier_name1,quantity as quantity1,
round(fact_price,2) as fact_price1,
count(1) as count1
from test.cnc group by buyer,round(amount,2),material_code,supplier_name,quantity,round(fact_price,2)
) A 
inner join 
(select case buyer
when '阳贤' then 'yang.xian'
when '赵伟' then 'zhao.wei1'
else buyer end as buyer2 ,round(amount,2) as amount2 , material_code as material_code2 ,supplier_name as supplier_name2,
round(price,2) as price2 , quantity as quantity2 ,
count(1) as count2
from dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01'
group by buyer,round(amount,2),material_code,supplier_name,quantity,round(price,2)
) B 
on A.buyer1 = B.buyer2 and 
 A.amount1= B.amount2 and 
 A.material_code1= B.material_code2 and 
 A.supplier_name1= B.supplier_name2 and 
 A.quantity1= B.quantity2 and 
 A.fact_price1= B.price2
 


	-- left outer join  where   求差集 
select A.buyer1,A.amount1,A.material_code1,A.supplier_name1,A.quantity1,A.fact_price1,(A.count1 - B.count2) as diff1,
(A.count1*A.amount1) as count1_amount1, A.count1, 
if(A.count1 <= B.count2 , A.count1,B.count2) as common,
(A.amount1 * (if(A.count1 <= B.count2 , A.count1,B.count2)) ) as common_amount,
B.count2,(B.count2*B.amount2) as count2_amount2,(B.count2 - A.count1) as diff2,B.buyer2,B.amount2,B.material_code2,B.supplier_name2,
B.quantity2,B.price2 from (
select buyer as buyer1,round(amount,2) as amount1, material_code as material_code1,supplier_name as supplier_name1,quantity as quantity1,
round(fact_price,2) as fact_price1,
count(1) as count1
from test.cnc group by buyer,round(amount,2),material_code,supplier_name,quantity,round(fact_price,2)
) A 
--right outer join
 left outer join 
(select case buyer
when '阳贤' then 'yang.xian'
when '赵伟' then 'zhao.wei1'
else buyer end as buyer2 ,round(amount,2) as amount2 , material_code as material_code2 ,supplier_name as supplier_name2,
round(price,2) as price2 , quantity as quantity2 ,
count(1) as count2
from dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01'
group by buyer,round(amount,2),material_code,supplier_name,quantity,round(price,2)
) B 
on A.buyer1 = B.buyer2 and 
 A.amount1= B.amount2 and 
 A.material_code1= B.material_code2 and 
 A.supplier_name1= B.supplier_name2 and
  A.quantity1= B.quantity2 and 
 A.fact_price1= B.price2
 where  
 -- A.buyer1 is null
 --and A.amount1 is null
 --and A.material_code1 is null
 --and A.supplier_name1 is null
 --and A.quantity1 is null
 -- and A.fact_price1 is null
B.buyer2 is null
 and B.amount2 is null
and B.material_code2 is null
 and B.supplier_name2 is null
and B.quantity2 is null
and B.price2 is null



---- -- - -- - -- - -- - - - - -- - - - -- - - - - - - - - - -  - - - -- - - - - > 导出数据

-- inner join   求交集，以及交集中的私有成分
select 
A.bu, A.first_level, A.second_level, A.third_level, A.project, A.`month`, A.refer,A.biz_date, A.week, A.supplier_name1,
A.material_code1, A.material_name, A.model, A.is_bo, A.unit, A.quantity1, A.fact_price1, A.original_price, A.cd, A.fact_tax_price, A.amount1,
A.tax_amount, A.buyer1, A.buyer_dev, A.amount_wan, A.cd_wan,
(A.count1 - B.count2) as diff1,
(if((A.count1 - B.count2) >= 0 ,(A.count1 - B.count2),0) * A.amount1) as private1_amount1, 
(A.count1*A.amount1) as count1_amount1, A.count1, 
if(A.count1 <= B.count2 , A.count1,B.count2) as common,
(A.amount1 * (if(A.count1 <= B.count2 , A.count1,B.count2)) ) as common_amount
,B.count2
-- ,B.count2,(B.count2*B.amount2) as count2_amount2,
-- (if((B.count2 - A.count1) >= 0 ,(B.count2 - A.count1),0) * B.amount2) as private2_amount2,
-- (B.count2 - A.count1) as diff2,B.buyer2,B.amount2,B.material_code2,B.supplier_name2,B.quantity2,B.price2 
from (
select 
 collect_set(bu)[0] as bu , collect_set(first_level)[0] as first_level , collect_set(second_level)[0] as second_level , 
 collect_set(third_level)[0] as third_level , collect_set(project)[0] as project ,
collect_set(`month`)[0] as `month` , collect_set(refer)[0] as  refer, collect_set(biz_date)[0] as biz_date,
collect_set(week)[0] as week,collect_set(material_name)[0] as material_name ,  collect_set(model)[0] as  model ,
 collect_set(is_bo)[0] as is_bo, collect_set(unit)[0] as unit, collect_set(original_price)[0] as original_price ,
 collect_set(cd)[0] as cd, collect_set(fact_tax_price)[0] as fact_tax_price ,collect_set( tax_amount)[0] as tax_amount,
 collect_set(buyer_dev)[0] as buyer_dev , collect_set(amount_wan)[0] as amount_wan , collect_set(cd_wan)[0] as  cd_wan,
buyer as buyer1,round(amount,2) as amount1, material_code as material_code1,supplier_name as supplier_name1,quantity as quantity1,
round(fact_price,2) as fact_price1,
count(1) as count1
from test.cnc group by buyer,round(amount,2),material_code,supplier_name,quantity,round(fact_price,2)
) A 
inner join 
(select case buyer
when '阳贤' then 'yang.xian'
when '赵伟' then 'zhao.wei1'
else buyer end as buyer2 ,round(amount,2) as amount2 , material_code as material_code2 ,supplier_name as supplier_name2,
round(price,2) as price2 , quantity as quantity2 ,
count(1) as count2
from dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01'
group by buyer,round(amount,2),material_code,supplier_name,quantity,round(price,2)
) B 
on A.buyer1 = B.buyer2 and 
 A.amount1= B.amount2 and 
 A.material_code1= B.material_code2 and 
 A.supplier_name1= B.supplier_name2 and 
 A.quantity1= B.quantity2 and 
 A.fact_price1= B.price2
 


	-- left outer join  where   求差集 
select 
A.bu, A.first_level, A.second_level, A.third_level, A.project, A.`month`, A.refer,A.biz_date, A.week, A.supplier_name1,
A.material_code1, A.material_name, A.model, A.is_bo, A.unit, A.quantity1, A.fact_price1, A.original_price, A.cd, A.fact_tax_price, A.amount1,
A.tax_amount, A.buyer1, A.buyer_dev, A.amount_wan, A.cd_wan,
(A.count1 - B.count2) as diff1,
(A.count1*A.amount1) as count1_amount1, A.count1, 
if(A.count1 <= B.count2 , A.count1,B.count2) as common,
(A.amount1 * (if(A.count1 <= B.count2 , A.count1,B.count2)) ) as common_amount,

-- B.count2 
--(B.count2*B.amount2) as count2_amount2,(B.count2 - A.count1) as diff2,B.buyer2,B.amount2,B.material_code2,B.supplier_name2,
--B.quantity2,B.price2 
from (
select 
collect_set(bu)[0] as bu , collect_set(first_level)[0] as first_level , collect_set(second_level)[0] as second_level , 
 collect_set(third_level)[0] as third_level , collect_set(project)[0] as project ,
collect_set(`month`)[0] as `month` , collect_set(refer)[0] as  refer, collect_set(biz_date)[0] as biz_date,
collect_set(week)[0] as week,collect_set(material_name)[0] as material_name ,  collect_set(model)[0] as  model ,
 collect_set(is_bo)[0] as is_bo, collect_set(unit)[0] as unit, collect_set(original_price)[0] as original_price ,
 collect_set(cd)[0] as cd, collect_set(fact_tax_price)[0] as fact_tax_price ,collect_set( tax_amount)[0] as tax_amount,
 collect_set(buyer_dev)[0] as buyer_dev , collect_set(amount_wan)[0] as amount_wan , collect_set(cd_wan)[0] as  cd_wan,
buyer as buyer1,round(amount,2) as amount1, material_code as material_code1,supplier_name as supplier_name1,quantity as quantity1,
round(fact_price,2) as fact_price1,
count(1) as count1
from test.cnc group by buyer,round(amount,2),material_code,supplier_name,quantity,round(fact_price,2)
) A 
 left outer join 
(select case buyer
when '阳贤' then 'yang.xian'
when '赵伟' then 'zhao.wei1'
else buyer end as buyer2 ,round(amount,2) as amount2 , material_code as material_code2 ,supplier_name as supplier_name2,
round(price,2) as price2 , quantity as quantity2 ,
count(1) as count2
from dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01'
group by buyer,round(amount,2),material_code,supplier_name,quantity,round(price,2)
) B 
on A.buyer1 = B.buyer2 and 
 A.amount1= B.amount2 and 
 A.material_code1= B.material_code2 and 
 A.supplier_name1= B.supplier_name2 and
  A.quantity1= B.quantity2 and 
 A.fact_price1= B.price2
 where  
B.buyer2 is null
 and B.amount2 is null
and B.material_code2 is null
 and B.supplier_name2 is null
and B.quantity2 is null
and B.price2 is null


-- right join
select 
-- A.buyer1,A.amount1,A.material_code1,A.supplier_name1,A.quantity1,A.fact_price1,(A.count1 - B.count2) as diff1,
-- (A.count1*A.amount1) as count1_amount1, A.count1, 
if(A.count1 <= B.count2 , A.count1,B.count2) as common,
(A.amount1 * (if(A.count1 <= B.count2 , A.count1,B.count2)) ) as common_amount,
B.count2,(B.count2*B.amount2) as count2_amount2,(B.count2 - A.count1) as diff2,
 B.bg, B.first_level, B.second_level, B.third_level, B.project, B.`month`, B.refer,B.stock_in_audit_time, B.week, B.supplier_name2,
B.material_code2, B.material_name, B.material_model, B.is_bo, B.unit, B.quantity2, B.price2, B.bechmark_price, B.cd_amount, B.tax_price,
B.amount2,B.tax_amount, B.buyer2, B.buyer_dev, B.amount_wan, B.cd_wan
from (
select buyer as buyer1,round(amount,2) as amount1, material_code as material_code1,supplier_name as supplier_name1,quantity as quantity1,
round(fact_price,2) as fact_price1,
count(1) as count1
from test.cnc group by buyer,round(amount,2),material_code,supplier_name,quantity,round(fact_price,2)
) A 
 right outer join 
(select 
collect_set(bg)[0] as bg , collect_set(first_level)[0] as first_level , collect_set(secondary_level)[0] as second_level , 
 collect_set(third_level)[0] as third_level , collect_set(project_id)[0] as project ,
collect_set(`month`)[0] as `month` , '' as  refer, collect_set(stock_in_audit_time)[0] as stock_in_audit_time,
'' as week,collect_set(material_name)[0] as material_name ,  collect_set(material_model)[0] as  material_model ,
'' as is_bo, collect_set(unit)[0] as unit, collect_set(bechmark_price)[0] as bechmark_price ,
 collect_set(cd_amount)[0] as cd_amount, collect_set(tax_price)[0] as tax_price ,collect_set( tax_amount)[0] as tax_amount,
 '' as buyer_dev ,'' as amount_wan , '' as  cd_wan,
case buyer
when '阳贤' then 'yang.xian'
when '赵伟' then 'zhao.wei1'
else buyer end as buyer2 ,round(amount,2) as amount2 , material_code as material_code2 ,supplier_name as supplier_name2,
round(price,2) as price2 , quantity as quantity2 ,
count(1) as count2
from dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01'
group by buyer,round(amount,2),material_code,supplier_name,quantity,round(price,2)
) B 
on A.buyer1 = B.buyer2 and 
 A.amount1= B.amount2 and 
 A.material_code1= B.material_code2 and 
 A.supplier_name1= B.supplier_name2 and
  A.quantity1= B.quantity2 and 
 A.fact_price1= B.price2
 where  
 A.buyer1 is null
and A.amount1 is null
and A.material_code1 is null
and A.supplier_name1 is null
and A.quantity1 is null
and A.fact_price1 is null




------------------------------------------ <<<<<<<<<<<<<<<<<<<<<<<<<<<,,,,,, end
select material_code ,material_name,exchange_rate,price,tax_price,tax_amount,amount
from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23'
and supplier_name like '%厦门创信%'

select tax_price,price,tax_amount,amount,currency,currency_name,exchange_rate,tax_rate,supplier_name,
material_code,material_name,data_sources ,buyer
from dwmiddle.dwb_purchase_report_cd where day='2020-02-23'
-- and material_code = '611-A200752-01-HS'
-- and tax_price < price; 
and tax_amount =0 or tax_amount is null

select count(1) from test.cnc2;  -- 15168
select * from (   -- 13531
select case buyer
when '阳贤' then 'yang.xian'
when '赵伟' then 'zhao.wei1'
else buyer end as buyer2 ,round(amount,2) as amount2 , material_code as material_code2 ,supplier_name as supplier_name2 
from dwmiddle.dwb_purchase_report_cd
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01') A 
where A.buyer2 = '何玉英' and A.amount2 = '11296.96';

-- 11 

select DISTINCT buyer ,data_sources from dwmiddle.dwb_purchase_report_cd  where  day='2020-02-23' and buyer like '%赵伟%'
select * from eas.ods_eas_new_eas75_t_bd_person where day='2020-02-23' 
and fname_l2 like '%谢文隆%'
-- /OQAAABIKBSA733t
select distinct(FPurchasePersonID) from eas.ods_eas_new_eas75_t_im_purinwarehsentry where day='2020-02-23' 

select sum(amount), buyer from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' 
and dim = '1' 
and `date` = '2020-01'
group by  buyer




---------------  模具系统数据(根据采购员区分，以及切分字符串date=2020-01。）)

select sum(A.amount) as all_amount,dim from  (
select  B.stock_in_audit_time,B.stock_in_time,
if( int(SUBSTRING(stock_in_audit_time,9,2)) >= 16 ,
if(SUBSTRING(stock_in_audit_time,6,2)='12',concat(int(SUBSTRING(stock_in_audit_time,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(stock_in_audit_time,0,4)) ,'-', if( (int(SUBSTRING(stock_in_audit_time,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(stock_in_audit_time,6,2))+1)), int(SUBSTRING(stock_in_audit_time,6,2))+1 ))),
  concat(SUBSTRING(stock_in_audit_time,0,4) ,'-',SUBSTRING(stock_in_audit_time,6,2)))  as new_date,
B.`date`,B.amount,buyer, B.data_sources,
case
when B.buyer in ('HN-19934','6059501') and B.dim in ('unknown','') then '2'
when B.buyer in ('颜冬梅','李秋云','曾庆燊','黄利霞','皮丽芳','何清秀','杨冉','罗建婷','邹伯富','胡志美','丁冬冬','李小鹏','钱梦','王欢','晏燕芳','彭清华','李鑫','钟文','陈正蝶','岳忠林','郭梦婷','赵楠楠','胡文龙','帅建明','龚小会','苏韬','熊惠','邹依伶','罗春燕','田明舟','廖飞','凌英','徐淑伟','盛婷','朱彩玲','高美娇','陈波','陈小娟','仲玲玲','王晓','李倩倩','刘小青','史明明','王璇','魏志颖','张丹')and dim in ('unknown','') then '2'
when B.buyer in ('fanny.wang') and B.dim in ('unknown','') then '3'
when B.buyer in ('温馨','曾敏','陈大军','戴虹虹','丁丹丹','丁丽琴','丁素兰','房艳倩','高伟','古小委','顾敏','何玉玲','胡晾','季丽霞','江木兰','江荣','蒋月香','金宇倩','孔卫霞','梁月琴','刘斌','缪月','邵雅婷','孙文天','唐小燕','王万圆','吴志兰','谢芸','徐平平','徐艳','杨丽研','姚香','袁刚','张春兰','张凌云','张肖肖','赵莉','周敏','周小霞','朱欢欢','丁曼','杜丽娟','郭蓉','何寻','黄开炎','黄维维','江淋淋','李春花','李清秀','李婷','林金梅','林敏','刘爱美','刘利利','刘美','刘青玲','刘婷','刘怿','卢钰','罗依霞','欧阳楠','彭莉','任路尧','苏容','谭千','谭旋','汤夏媛','唐令','陶娟','陶仙荣','汪云','王彩霞','王晨','王凤梅','王红','王万花','王文静','巫莉琴','夏珊妹','肖梅花','谢淑艳','熊云秀','徐会','杨彩票','杨小芬','尹彩云','张艳丽','张园','赵月华','钟颖娟','周丽娟','周娜英','胡清泉','廖新华','徐彦','易思','喻璇','张炳兰','张凤梅','舒亚萍','王留芳','张静冉')and dim in ('unknown','') then '3'
when B.buyer in ('蔡清明','陈立月','方轶','付顺喜','郭磊','何玉英','贺英凡','黄佳青','李小强','林玉梅','刘淳','刘何','刘玉','陆健爱','罗正钧','裴瑞博','秦龙海','孙文婷','王亚方','翁辉英','谢文隆','殷亚娟','杨丽红','余建春','虞桦','喻清容','袁菱鸿','占婷玉','张黎明','张晓康','张志芹','赵伟','庄金慧')and dim in ('unknown','') then '1'
when B.buyer in ('卢娜灵','阳贤')and B.dim in ('unknown','') and B.costcenter_name != '组装生产' then '1'
when B.buyer in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉','高大顺')and dim in ('unknown','') and B.costcenter_name = '组装生产' then '5'
else dim
end as  dim
from (
SELECT stock_in_audit_time, stock_in_time, `date`,
(cast((cast(tax_price as decimal(28,2)) / ((cast(tax_rate as decimal(28,2))/100)+1)) as decimal(28,2)) * quantity) as amount,
  regexp_extract(buyer,'([\\\u4E00-\\\u9FA5]+)',1) as buyer, data_sources,'' as dim,costcenter_name
  FROM dwbase.dwb_mould_poorder where day='2020-03-03'
group by
   po_number, stock_number, material_code, material_8code, material_name, material_describe, material_model,
   material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name,
   out_supp_material_code, purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time,
   stock_in_time, document_date, stock_goods_describe, first_level, secondary_level, third_level, project_id, 
   voucher_project_code, material_type, quantity, price_unit, exchange_rate, tax_rate, tax_code,
   cast(( cast(tax_price as decimal(28,2))  / (( cast(tax_rate as decimal(28,2))/100)+1)) as decimal(28,2)), usd_price, tax_price, cur_amount, tax_amount,
   tax_rmb_amount,(cast((cast(tax_price as decimal(28,2)) / ((cast(tax_rate as decimal(28,2))/100)+1)) as decimal(28,2)) * quantity), start_price, 
   start_diff_price, check_bechmark_price, check_bechmark_amount, check_cd_amount, pic, docu_pic, 
   supp_po_code, line_pic, area, factory_code, factory_area, branch_of_facoty, order_number,
   check_return_code, check_number, check_return_num, return_num, cur_tax, inventory_unit, ori_cur_beftax_amount, 
   ori_cur_tax, tax, ori_cur_amount, damage_num, scrapped_num, location_code, sales_unit, appoint,
   ori_proxy,regexp_extract(buyer,'([\\\u4E00-\\\u9FA5]+)',1), remarks, period, `year`, `month`, `date`, 
   data_sources, stock_org_number, stock_org_name, unit_number, unit, warehouse_name, delivery_warehouse,
   company_code, company_name, order_date, purorder_fid, supplier_po_number, origin_firm, classify, costcenter_code, 
   costcenter_name, pay_condition, currency, currency_name, pay_day, account_day, pay_type, acreage, line,
   type_pic, project_pic, big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price, 
   diff_amount, update_bechmark_price, rpl_cd_amount, all_cd, bg, dim, stand_exchange_rate, stand_currency_name, 
   stand_date, cast((tax_price / ((tax_rate/100)+1)) as string) ) B
) A 
 -- where  A.new_date = '2020-01'
 where A.stock_in_audit_time between '2019/12/16' and '2020/01/15 23:59:59'
group by A.dim;


-- 模具系统 去重(根据 puroderId)

select sum(A.amount) as all_amount,dim from  (
select  B.stock_in_audit_time,B.stock_in_time,
if( int(SUBSTRING(stock_in_audit_time,9,2)) >= 16 ,
if(SUBSTRING(stock_in_audit_time,6,2)='12',concat(int(SUBSTRING(stock_in_audit_time,0,4))+1 ,'-','01') ,
  concat(int(SUBSTRING(stock_in_audit_time,0,4)) ,'-', if( (int(SUBSTRING(stock_in_audit_time,6,2))+1) < 10 ,
  concat('0',(int(SUBSTRING(stock_in_audit_time,6,2))+1)), int(SUBSTRING(stock_in_audit_time,6,2))+1 ))),
  concat(SUBSTRING(stock_in_audit_time,0,4) ,'-',SUBSTRING(stock_in_audit_time,6,2)))  as new_date,
(cast((cast(B.tax_price as decimal(28,2)) / ((cast(B.tax_rate as decimal(28,2))/100)+1)) as decimal(28,2)) * B.quantity) as amount,
 regexp_extract(B.buyer,'([\\\u4E00-\\\u9FA5]+)',1) as buyer, B.data_sources,
case
when regexp_extract(B.buyer,'([\\\u4E00-\\\u9FA5]+)',1) in ('HN-19934','6059501') and B.dim in ('unknown','') then '2'
when regexp_extract(B.buyer,'([\\\u4E00-\\\u9FA5]+)',1) in ('颜冬梅','李秋云','曾庆燊','黄利霞','皮丽芳','何清秀','杨冉','罗建婷','邹伯富','胡志美','丁冬冬','李小鹏','钱梦','王欢','晏燕芳','彭清华','李鑫','钟文','陈正蝶','岳忠林','郭梦婷','赵楠楠','胡文龙','帅建明','龚小会','苏韬','熊惠','邹依伶','罗春燕','田明舟','廖飞','凌英','徐淑伟','盛婷','朱彩玲','高美娇','陈波','陈小娟','仲玲玲','王晓','李倩倩','刘小青','史明明','王璇','魏志颖','张丹')and dim in ('unknown','') then '2'
when regexp_extract(B.buyer,'([\\\u4E00-\\\u9FA5]+)',1) in ('fanny.wang') and B.dim in ('unknown','') then '3'
when regexp_extract(B.buyer,'([\\\u4E00-\\\u9FA5]+)',1) in ('温馨','曾敏','陈大军','戴虹虹','丁丹丹','丁丽琴','丁素兰','房艳倩','高伟','古小委','顾敏','何玉玲','胡晾','季丽霞','江木兰','江荣','蒋月香','金宇倩','孔卫霞','梁月琴','刘斌','缪月','邵雅婷','孙文天','唐小燕','王万圆','吴志兰','谢芸','徐平平','徐艳','杨丽研','姚香','袁刚','张春兰','张凌云','张肖肖','赵莉','周敏','周小霞','朱欢欢','丁曼','杜丽娟','郭蓉','何寻','黄开炎','黄维维','江淋淋','李春花','李清秀','李婷','林金梅','林敏','刘爱美','刘利利','刘美','刘青玲','刘婷','刘怿','卢钰','罗依霞','欧阳楠','彭莉','任路尧','苏容','谭千','谭旋','汤夏媛','唐令','陶娟','陶仙荣','汪云','王彩霞','王晨','王凤梅','王红','王万花','王文静','巫莉琴','夏珊妹','肖梅花','谢淑艳','熊云秀','徐会','杨彩票','杨小芬','尹彩云','张艳丽','张园','赵月华','钟颖娟','周丽娟','周娜英','胡清泉','廖新华','徐彦','易思','喻璇','张炳兰','张凤梅','舒亚萍','王留芳','张静冉')and dim in ('unknown','') then '3'
when regexp_extract(B.buyer,'([\\\u4E00-\\\u9FA5]+)',1) in ('蔡清明','陈立月','方轶','付顺喜','郭磊','何玉英','贺英凡','黄佳青','李小强','林玉梅','刘淳','刘何','刘玉','陆健爱','罗正钧','裴瑞博','秦龙海','孙文婷','王亚方','翁辉英','谢文隆','殷亚娟','杨丽红','余建春','虞桦','喻清容','袁菱鸿','占婷玉','张黎明','张晓康','张志芹','赵伟','庄金慧')and dim in ('unknown','') then '1'
when regexp_extract(B.buyer,'([\\\u4E00-\\\u9FA5]+)',1) in ('卢娜灵','阳贤')and B.dim in ('unknown','') and B.costcenter_name != '组装生产' then '1'
when regexp_extract(B.buyer,'([\\\u4E00-\\\u9FA5]+)',1) in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉','高大顺')and dim in ('unknown','') and B.costcenter_name = '组装生产' then '5'
else dim
end as  dim
from (
SELECT stock_in_audit_time, stock_in_time,tax_price,quantity,tax_rate,buyer,
 data_sources,'' as dim, collect_set(costcenter_name)[0] as costcenter_name
  FROM dwbase.dwb_mould_poorder where day='2020-03-03'
group by
   po_number, tax_price,stock_in_audit_time,stock_in_time,quantity,
   buyer,data_sources,tax_rate
 ) B
) A 
 --where  A.new_date = '2020-01'
  where A.stock_in_audit_time between '2019/12/16' and '2020/01/15 23:59:59'
group by A.dim;

select stock_org_name,company_name  
FROM dwbase.dwb_mould_poorder where day='2020-03-03'

SELECT stock_in_audit_time, to_date(stock_in_audit_time) as aduit_new,stock_in_time, `date`,
(cast((cast(tax_price as decimal(28,2)) / ((cast(tax_rate as decimal(28,2))/100)+1)) as decimal(28,2)) * quantity) as amount,
  regexp_extract(buyer,'([\\\u4E00-\\\u9FA5]+)',1) as buyer, data_sources,'' as dim,costcenter_name
  FROM dwbase.dwb_mould_poorder where day='2020-03-03'

select stock_number,area,factory_area,company_name,`date`,first_level,secondary_level,
third_level,po_number,supplier_name,material_code,material_name,material_model,quantity,unit,currency_name,
tax_price,tax_rate,exchange_rate,price,tax_amount,amount,bechmark_price,bechmark_amount,cd_amount,account_day,
account_amount,buyer 
 from dwmiddle.dwb_purchase_report_cd
 where  day='2020-02-23'  and data_sources not in('sap.ods_sap_zfmm_044','eas')
 and `date` = '2020-01'
 and buyer = ''

select `date`,sum(amount) from dwmiddle.dwb_purchase_report_cd 
where  day='2020-02-23' and `date` like  '%2020-%' and dim = '1' group by `date`;

select dim,sum(amount) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23' 
and   (regexp_replace(regexp_replace(substring(stock_in_audit_time,0,10),'-',''),'/','')
 between '20191216' and '20200115') 
group by dim;


select amount,costcenter_name,pic,dim from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-23' 
and   (regexp_replace(regexp_replace(substring(stock_in_audit_time,0,10),'-',''),'/','')
 between '20191216' and '20200115') 
 and pic in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉','高大顺')
 
 select amount,pic,costcenter_name,dim  from dwmiddle.dwb_purchase_report_cd
 where  day='2020-02-23' 
 and `date` = '2020-01'
 and pic in ('卢娜灵','阳贤','杨甲香','王艳','李周蓉','高大顺')
 

 
 -- 集团数据比对
 select count(1) from dwdetail.dwd_jituan_cd_detail where day=='2020-02-23'  -- 135084
 select count(1) from sap.ods_sap_zfmm_044_jituan where day=='2020-02-23'   --135084
 
 
 

select costcenter_name,count(1) from dwbase.dwb_mould_poorder where day='2020-02-24'
group by costcenter_name;
select distinct(day) from dwbase.dwb_mould_poorder;
-- 1226031
select count(1) from dwbase.dwb_mould_poorder where day='2020-03-03'

select po_number,price from dwbase.dwb_mould_poorder where day='2020-03-03'

select distinct(costcenter_name) from dwbase.dwb_mould_poorder where day='2020-02-24';

select count(1) from sap.ods_sap_zfmm_044_jituan where day='2020-02-23'; 

select SUBSTRING(period,0,4) , SUBSTRING(period,5,2), period
from sap.ods_sap_zfmm_044_jituan where day='2020-02-23'; 

select * 
from sap.ods_sap_zfmm_044_jituan where day='2020-02-23'; 

select pic,buyer, currency_name ,dim,BG from dwbase.dwb_mould_poorder where day='2020-02-24';
select pic,count(1) from dwbase.dwb_mould_poorder where day='2020-02-24'
group by pic

-- 测试 material_cut  ，cd生成第二张表时报错 = =
-- 测试 material_cut  ，生成 
select count(1) from dwmiddle.dwm_cd_by_material_cut_price_mid where day='2020-02-23';
select count(1) from dwservice.dws_cd_by_material_cut_price_month3 where day='2020-02-23'; 

insert overwrite table dwservice.dws_cd_by_material_cut_price_month3 partition(day='${l_date}')
select case A.dim
when '1' then 'CNC'
when '2' then '冲压'
when '3' then '模切'
when '4' then '设备'
when '5' then '组装'
when '6' then '深圳结构件'
when '7' then '东莞结构件'
when '8' then '显示模组'
when '9' then '磁材'
when '10' then '汇总'
ELSE 'unknown' end as BG,A.material_8code, A.material_name, A.price,0,0, A.dim, A.`month`, A.`year`, A.`date`
 from ( select * from dwmiddle.dwm_cd_by_material_cut_price_mid  where day='${l_date}')A 
 /*
 right join
(select material_8code,material_name,dim,count(1) as diff_num,sum(num) as count_num from
(select material_8code,material_name,count(1) as num ,dim,price from dwmiddle.dwm_cd_by_material_cut_price_mid
where day='${l_date}' group by material_8code,material_name,price,dim) C group by material_8code,material_name,dim) B
on A.material_8code = B.material_8code
and A.material_name = B.material_name and A.dim = B.dim;
*/

 
 -- 到部分数据-phoenix
 
select dim,sum(total_amount) from dwservice.dws_cd_by_amount_month3 where day='2020-02-23' 
and `date` = '2020-01'group by dim;
select dim,count(1) from dwservice.dws_cd_by_area_day_month3 where day='2020-02-23'group by dim;
select dim,count(1) from dwservice.dws_cd_by_supplier_month3 where day='2020-02-23'group by dim;
select dim,count(1) from dwservice.dws_cd_by_account_day_pay_type_month  where day='2020-02-23'group by dim;

-- 手动导出结构件数据
SELECT bg, dim, in_date, `date`, rkdh, supplier, po, material, inventory_des, in_qty, tax_unit_price, 
	total_price, tax_rate, purchase_buyer, purchase_no, company_no, company_name, factory, delivery_site, 
delivery_site_des, purchase_organization, purchase_group, supplier_code, purchase_type, purchase_type_des,
material_voucher_item, material_group, material_group_des, measurement_unit_stock, measurement_unit_purchase,
lot_no, debtor, pr, currency, net_price, price_unit, original_currency_unit, tax_code, original_currency_amount,
proof_annual, payment_type, invoice_number, invoice_date, issue_date, payment_clause, delivery_order, movement_type,
po_voucher_date, posting_people, starting_price, difference_price, cd_price, first_material, second_material, 
third_material, is_refer, project_number, `day` FROM dwbase.dwb_sap_jiegoujian_by_cd
where day='2020-02-23' and 
`date` = '2020-01' and
dim = '7';

-- 3039
select count(1) from dwservice.dws_cd_by_area_day_month3 where day='2020-02-23'
group by area,company_name;

select distinct(area) from dwmiddle.dwb_purchase_report_cd where day='2020-02-23'
and  area = '' or area is null
select DISTINCT(data_sources) from dwmiddle.dwb_purchase_report_cd where day='2020-02-23'
and  area = ''
select DISTINCT company_name,data_sources  from dwmiddle.dwb_purchase_report_cd where day='2020-02-23'
and  area = ''

select DISTINCT area,company_name,data_sources  from dwmiddle.dwb_purchase_report_cd where day='2020-02-23'

select distinct(day) from dwmiddle.dwb_purchase_report_cd where day='2020-02-23'

ALTER table dwmiddle.dwb_purchase_report_cd  drop PARTITION(day='2019-01-01')