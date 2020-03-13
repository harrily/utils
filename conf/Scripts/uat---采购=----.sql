create database test;
	CREATE TABLE `test.ly_test2` (
	`id` STRING,
	 `name` STRING,
	 `age` STRING,
	 `sex` STRING)
	ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
	
	
select * from test.ly_test2 A left join test.ly_test1 B on A.id = B.id;
show databases;
show create table test.student1;


select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3 where day='2020-02-13'
select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 where day='2020-02-13'

drop table dwmiddle.dwb_purchase_combine_mid1_new3
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3
drop table dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3
drop table dwmiddle.dwb_purchase_report
drop table dwmiddle.dwb_purchase_report_cd
drop table dwmiddle.dwb_purchase_report_cd2
drop table dwmiddle.dwb_purchase_report_cd_tmp
drop table dwmiddle.dwb_purchase_standard_price
drop table dwmiddle.dwm_cd_by_material_cut_price_mid
drop table dwmiddle.dwm_eas_exchangerate

select count(1) from dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3 where day='2020-02-13' and `date` like '%2019%';

insert overwrite table dwmiddle.dwb_purchase_combine_mid_report_eas_distinct_new3 partition(day='${l_date}')
SELECT po_number, stock_number, material_code, material_8code, material_name, material_describe, material_model, 
material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name, out_supp_material_code,
purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time, stock_in_time, document_date, 
stock_goods_describe, first_level, secondary_level, third_level, project_id, voucher_project_code, material_type,
quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price, tax_price, cur_amount, tax_amount, 
tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price, check_bechmark_amount, check_cd_amount, 
if(pic is null,'',pic) as pic, if(docu_pic is null,'',docu_pic) as docu_pic,
 supp_po_code, line_pic, area, factory_code, factory_area, branch_of_facoty, order_number, check_return_code,
 check_number, check_return_num, return_num, cur_tax, inventory_unit, ori_cur_beftax_amount, ori_cur_tax, tax, 
 ori_cur_amount, damage_num, scrapped_num, location_code, sales_unit, appoint, ori_proxy, 
if(buyer is null ,'',buyer) as buyer ,
 remarks, period, `year`, `month`, `date`, data_sources, stock_org_number, stock_org_name, unit_number, unit,
 warehouse_name, delivery_warehouse, company_code, company_name, order_date, purorder_fid, supplier_po_number,
 origin_firm, classify, costcenter_code, costcenter_name, pay_condition, currency, currency_name, pay_day, 
 account_day, pay_type, acreage, line, type_pic, project_pic, big_classify, reduce_price_orig, avg_pay_day, 
 rebate_ratio, update_statement_price, diff_amount, update_bechmark_price, rpl_cd_amount, all_cd, bg, dim
 FROM dwmiddle.dwb_purchase_combine_mid_report_eas_new_test3  where day='${l_date}'
group by po_number, stock_number, material_code, material_8code, material_name, material_describe,
material_model, material_group_code, material_group_describe, supplier_code, supplier_name, supplier_simple_name, 
out_supp_material_code, purchase_group_code, purchase_group_name, purchase_org_code, stock_in_audit_time, 
stock_in_time, document_date, stock_goods_describe, first_level, secondary_level, third_level, project_id,
voucher_project_code, material_type, quantity, price_unit, exchange_rate, tax_rate, tax_code, price, usd_price,
tax_price, cur_amount, tax_amount, tax_rmb_amount, amount, start_price, start_diff_price, check_bechmark_price,
check_bechmark_amount, check_cd_amount, pic, docu_pic, supp_po_code, line_pic, area, factory_code, factory_area,
branch_of_facoty, order_number, check_return_code, check_number, check_return_num, return_num, cur_tax, 
inventory_unit, ori_cur_beftax_amount, ori_cur_tax, tax, ori_cur_amount, damage_num, scrapped_num, location_code,
sales_unit, appoint, ori_proxy, buyer, remarks, period, `year`, `month`, `date`, data_sources, 
stock_org_number, stock_org_name, unit_number, unit, warehouse_name, delivery_warehouse, company_code,
company_name, order_date, purorder_fid, supplier_po_number, origin_firm, classify, costcenter_code, 
costcenter_name, pay_condition, currency, currency_name, pay_day, account_day, pay_type, acreage, line, 
type_pic, project_pic, big_classify, reduce_price_orig, avg_pay_day, rebate_ratio, update_statement_price,
diff_amount, update_bechmark_price, rpl_cd_amount, all_cd, bg, dim;



select  fnumber,fname_l2  from eas.ods_eas_new_eas75_t_bd_person where day='2020-02-23' 
and fname_l2 like '%Ñî¼×Ïã%'









  














