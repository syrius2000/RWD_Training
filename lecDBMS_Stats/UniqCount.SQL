SELECT
    'COVID19ワクチン接種' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    'DEPARTMENTCODE' AS column_name,
    COUNT(DISTINCT DEPARTMENTCODE) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    'DEPTNAME' AS column_name,
    COUNT(DISTINCT DEPTNAME) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    'EVENTDATE' AS column_name,
    COUNT(DISTINCT EVENTDATE) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '更新日時' AS column_name,
    COUNT(DISTINCT `更新日時`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '問診1_過去2週間の曝露歴' AS column_name,
    COUNT(DISTINCT `問診1_過去2週間の曝露歴`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '問診2_濃厚接触者' AS column_name,
    COUNT(DISTINCT `問診2_濃厚接触者`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '問診3_症状の有無' AS column_name,
    COUNT(DISTINCT `問診3_症状の有無`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '問診4_家族_同僚症状の有無' AS column_name,
    COUNT(DISTINCT `問診4_家族_同僚症状の有無`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '問診5_接種歴' AS column_name,
    COUNT(DISTINCT `問診5_接種歴`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '接種日1回目' AS column_name,
    COUNT(DISTINCT `接種日1回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '日付不明1回目' AS column_name,
    COUNT(DISTINCT `日付不明1回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '年1回目' AS column_name,
    COUNT(DISTINCT `年1回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '月1回目' AS column_name,
    COUNT(DISTINCT `月1回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '接種日2回目' AS column_name,
    COUNT(DISTINCT `接種日2回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '日付不明2回目' AS column_name,
    COUNT(DISTINCT `日付不明2回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '年2回目' AS column_name,
    COUNT(DISTINCT `年2回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '月2回目' AS column_name,
    COUNT(DISTINCT `月2回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '接種日3回目' AS column_name,
    COUNT(DISTINCT `接種日3回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '日付不明3回目' AS column_name,
    COUNT(DISTINCT `日付不明3回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '年3回目' AS column_name,
    COUNT(DISTINCT `年3回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '月3回目' AS column_name,
    COUNT(DISTINCT `月3回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '接種日4回目' AS column_name,
    COUNT(DISTINCT `接種日4回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '日付不明4回目' AS column_name,
    COUNT(DISTINCT `日付不明4回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '年4回目' AS column_name,
    COUNT(DISTINCT `年4回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '月4回目' AS column_name,
    COUNT(DISTINCT `月4回目`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '問診6_新型コロナ感染症の罹患歴' AS column_name,
    COUNT(DISTINCT `問診6_新型コロナ感染症の罹患歴`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '診断日' AS column_name,
    COUNT(DISTINCT `診断日`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '診断日日付不明' AS column_name,
    COUNT(DISTINCT `診断日日付不明`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '診断日年1' AS column_name,
    COUNT(DISTINCT `診断日年1`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '診断日月1' AS column_name,
    COUNT(DISTINCT `診断日月1`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID19ワクチン接種' AS table_name,
    '問診7_過去6か月以内の海外渡航歴' AS column_name,
    COUNT(DISTINCT `問診7_過去6か月以内の海外渡航歴`) AS unique_count
FROM COVID19ワクチン接種
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'COLLECTDATE' AS column_name,
    COUNT(DISTINCT COLLECTDATE) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'TESTITEMCODE' AS column_name,
    COUNT(DISTINCT TESTITEMCODE) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'TESTITEMNAME' AS column_name,
    COUNT(DISTINCT TESTITEMNAME) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'ADDCOMMENT1' AS column_name,
    COUNT(DISTINCT ADDCOMMENT1) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'ADDCOMMENT2' AS column_name,
    COUNT(DISTINCT ADDCOMMENT2) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'OUTOFSTANDARD' AS column_name,
    COUNT(DISTINCT OUTOFSTANDARD) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'REPORTVALUE' AS column_name,
    COUNT(DISTINCT REPORTVALUE) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'MATERIALSNAME' AS column_name,
    COUNT(DISTINCT MATERIALSNAME) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'EDITORIALRESULT' AS column_name,
    COUNT(DISTINCT EDITORIALRESULT) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    'COVID検査' AS table_name,
    'SPECIMENCOMMENTFLG' AS column_name,
    COUNT(DISTINCT SPECIMENCOMMENTFLG) AS unique_count
FROM COVID検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'COLLECTDATE' AS column_name,
    COUNT(DISTINCT COLLECTDATE) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'COLLECTTIME' AS column_name,
    COUNT(DISTINCT COLLECTTIME) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'TESTITEMCODE' AS column_name,
    COUNT(DISTINCT TESTITEMCODE) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'TESTITEMNAME' AS column_name,
    COUNT(DISTINCT TESTITEMNAME) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'ADDCOMMENT1' AS column_name,
    COUNT(DISTINCT ADDCOMMENT1) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'ADDCOMMENT2' AS column_name,
    COUNT(DISTINCT ADDCOMMENT2) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'OUTOFSTANDARD' AS column_name,
    COUNT(DISTINCT OUTOFSTANDARD) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'REPORTVALUE' AS column_name,
    COUNT(DISTINCT REPORTVALUE) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'MATERIALSNAME' AS column_name,
    COUNT(DISTINCT MATERIALSNAME) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'EDITORIALRESULT' AS column_name,
    COUNT(DISTINCT EDITORIALRESULT) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '一般検査' AS table_name,
    'SPECIMENCOMMENTFLG' AS column_name,
    COUNT(DISTINCT SPECIMENCOMMENTFLG) AS unique_count
FROM 一般検査
UNION ALL
SELECT
    '入院情報' AS table_name,
    'ADMISSIONNO' AS column_name,
    COUNT(DISTINCT ADMISSIONNO) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'DETAILNO' AS column_name,
    COUNT(DISTINCT DETAILNO) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'SEX' AS column_name,
    COUNT(DISTINCT SEX) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'PATIENTAGE' AS column_name,
    COUNT(DISTINCT PATIENTAGE) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'STARTSTATUS' AS column_name,
    COUNT(DISTINCT STARTSTATUS) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'STARTDATE' AS column_name,
    COUNT(DISTINCT STARTDATE) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'ENDSTATUS' AS column_name,
    COUNT(DISTINCT ENDSTATUS) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'ENDDATE' AS column_name,
    COUNT(DISTINCT ENDDATE) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'DEPTCODE' AS column_name,
    COUNT(DISTINCT DEPTCODE) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'DEPTNAME' AS column_name,
    COUNT(DISTINCT DEPTNAME) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'WARDCODE' AS column_name,
    COUNT(DISTINCT WARDCODE) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'ROOMCODE' AS column_name,
    COUNT(DISTINCT ROOMCODE) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'ADMISSIONDATE' AS column_name,
    COUNT(DISTINCT ADMISSIONDATE) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'PURPOSECODE' AS column_name,
    COUNT(DISTINCT PURPOSECODE) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'PURPOSENAME' AS column_name,
    COUNT(DISTINCT PURPOSENAME) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'DISFINALDATE' AS column_name,
    COUNT(DISTINCT DISFINALDATE) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'DISREASONCODE' AS column_name,
    COUNT(DISTINCT DISREASONCODE) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '入院情報' AS table_name,
    'DISREASONNAME' AS column_name,
    COUNT(DISTINCT DISREASONNAME) AS unique_count
FROM 入院情報
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'STARTDATE' AS column_name,
    COUNT(DISTINCT STARTDATE) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'ENDDATE' AS column_name,
    COUNT(DISTINCT ENDDATE) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'PATIENTTYPE' AS column_name,
    COUNT(DISTINCT PATIENTTYPE) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'ORDERDEPARTMENT' AS column_name,
    COUNT(DISTINCT ORDERDEPARTMENT) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'DOSAGECODE' AS column_name,
    COUNT(DISTINCT DOSAGECODE) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'DOSAGENAME' AS column_name,
    COUNT(DISTINCT DOSAGENAME) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'TIMES' AS column_name,
    COUNT(DISTINCT TIMES) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'WELFARECODE' AS column_name,
    COUNT(DISTINCT WELFARECODE) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'MEDICINENAME' AS column_name,
    COUNT(DISTINCT MEDICINENAME) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'QUANTITY' AS column_name,
    COUNT(DISTINCT QUANTITY) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '処方薬剤' AS table_name,
    'UNIT1' AS column_name,
    COUNT(DISTINCT UNIT1) AS unique_count
FROM 処方薬剤
UNION ALL
SELECT
    '外来情報' AS table_name,
    'APPOINTMENTNO' AS column_name,
    COUNT(DISTINCT APPOINTMENTNO) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'DEPARTMENTCODE' AS column_name,
    COUNT(DISTINCT DEPARTMENTCODE) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'DEPARTMENTNAME' AS column_name,
    COUNT(DISTINCT DEPARTMENTNAME) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'SEX' AS column_name,
    COUNT(DISTINCT SEX) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'PATIENTAGE' AS column_name,
    COUNT(DISTINCT PATIENTAGE) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'VISITDATE' AS column_name,
    COUNT(DISTINCT VISITDATE) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'VISITTIME' AS column_name,
    COUNT(DISTINCT VISITTIME) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'CONSULTSTARTTIME' AS column_name,
    COUNT(DISTINCT CONSULTSTARTTIME) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'CONSULTENDTIME' AS column_name,
    COUNT(DISTINCT CONSULTENDTIME) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'ADMISSIONDEPT' AS column_name,
    COUNT(DISTINCT ADMISSIONDEPT) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'ADMISSIONDEPTNAME' AS column_name,
    COUNT(DISTINCT ADMISSIONDEPTNAME) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '外来情報' AS table_name,
    'ADMISSIONWARD' AS column_name,
    COUNT(DISTINCT ADMISSIONWARD) AS unique_count
FROM 外来情報
UNION ALL
SELECT
    '患者基本情報' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 患者基本情報
UNION ALL
SELECT
    '患者基本情報' AS table_name,
    'SEX' AS column_name,
    COUNT(DISTINCT SEX) AS unique_count
FROM 患者基本情報
UNION ALL
SELECT
    '患者基本情報' AS table_name,
    'BIRTHDAY' AS column_name,
    COUNT(DISTINCT BIRTHDAY) AS unique_count
FROM 患者基本情報
UNION ALL
SELECT
    '患者基本情報_身長体重' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 患者基本情報_身長体重
UNION ALL
SELECT
    '患者基本情報_身長体重' AS table_name,
    'SEX' AS column_name,
    COUNT(DISTINCT SEX) AS unique_count
FROM 患者基本情報_身長体重
UNION ALL
SELECT
    '患者基本情報_身長体重' AS column_name,
    'HEIGHTWEIGHTSTATUS' AS column_name,
    COUNT(DISTINCT HEIGHTWEIGHTSTATUS) AS unique_count
FROM 患者基本情報_身長体重
UNION ALL
SELECT
    '患者基本情報_身長体重' AS table_name,
    'HEIGHTWEIGHT' AS column_name,
    COUNT(DISTINCT HEIGHTWEIGHT) AS unique_count
FROM 患者基本情報_身長体重
UNION ALL
SELECT
    '患者基本情報_身長体重' AS table_name,
    'HEIGHTWEIGHTDATE' AS column_name,
    COUNT(DISTINCT HEIGHTWEIGHTDATE) AS unique_count
FROM 患者基本情報_身長体重
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'STARTDATE' AS column_name,
    COUNT(DISTINCT STARTDATE) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'PATIENTTYPE' AS column_name,
    COUNT(DISTINCT PATIENTTYPE) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'ORDERDEPARTMENT' AS column_name,
    COUNT(DISTINCT ORDERDEPARTMENT) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'ACCOUNTSTATUS2' AS column_name,
    COUNT(DISTINCT ACCOUNTSTATUS2) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'ROUTECODE' AS column_name,
    COUNT(DISTINCT ROUTECODE) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'ROUTENAME' AS column_name,
    COUNT(DISTINCT ROUTENAME) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'TIMES' AS column_name,
    COUNT(DISTINCT TIMES) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'WELFARECODE' AS column_name,
    COUNT(DISTINCT WELFARECODE) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'MEDICINENAME1' AS column_name,
    COUNT(DISTINCT MEDICINENAME1) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'QUANTITY' AS column_name,
    COUNT(DISTINCT QUANTITY) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'SELECTEDUNIT' AS column_name,
    COUNT(DISTINCT SELECTEDUNIT) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'QUANTITY1' AS column_name,
    COUNT(DISTINCT QUANTITY1) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'UNIT1' AS column_name,
    COUNT(DISTINCT UNIT1) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'QUANTITY2' AS column_name,
    COUNT(DISTINCT QUANTITY2) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'UNIT2' AS column_name,
    COUNT(DISTINCT UNIT2) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'QUANTITY3' AS column_name,
    COUNT(DISTINCT QUANTITY3) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '注射薬剤' AS table_name,
    'UNIT3' AS column_name,
    COUNT(DISTINCT UNIT3) AS unique_count
FROM 注射薬剤
UNION ALL
SELECT
    '病名データ_DPC' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 病名データ_DPC
UNION ALL
SELECT
    '病名データ_DPC' AS table_name,
    'NYUINNO' AS column_name,
    COUNT(DISTINCT NYUINNO) AS unique_count
FROM 病名データ_DPC
UNION ALL
SELECT
    '病名データ_DPC' AS table_name,
    'SEQNO' AS column_name,
    COUNT(DISTINCT SEQNO) AS unique_count
FROM 病名データ_DPC
UNION ALL
SELECT
    '病名データ_DPC' AS table_name,
    'BYOMEICD' AS column_name,
    COUNT(DISTINCT BYOMEICD) AS unique_count
FROM 病名データ_DPC
UNION ALL
SELECT
    '病名データ_DPC' AS table_name,
    'BYOMEI' AS column_name,
    COUNT(DISTINCT BYOMEI) AS unique_count
FROM 病名データ_DPC
UNION ALL
SELECT
    '病名データ_DPC' AS table_name,
    'SHINRYOKACD' AS column_name,
    COUNT(DISTINCT SHINRYOKACD) AS unique_count
FROM 病名データ_DPC
UNION ALL
SELECT
    '病名データ_DPC' AS table_name,
    'KAISHIYMD' AS column_name,
    COUNT(DISTINCT KAISHIYMD) AS unique_count
FROM 病名データ_DPC
UNION ALL
SELECT
    '病名データ_DPC' AS table_name,
    'SHURYOYMD' AS column_name,
    COUNT(DISTINCT SHURYOYMD) AS unique_count
FROM 病名データ_DPC
UNION ALL
SELECT
    '病名データ_カルテオーダ' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 病名データ_カルテオーダ
UNION ALL
SELECT
    '病名データ_カルテオーダ' AS table_name,
    'DEPARTMENTCODE' AS column_name,
    COUNT(DISTINCT DEPARTMENTCODE) AS unique_count
FROM 病名データ_カルテオーダ
UNION ALL
SELECT
    '病名データ_カルテオーダ' AS table_name,
    'DISEASECODE' AS column_name,
    COUNT(DISTINCT DISEASECODE) AS unique_count
FROM 病名データ_カルテオーダ
UNION ALL
SELECT
    '病名データ_カルテオーダ' AS table_name,
    'DIAGNOSISDISEASE' AS column_name,
    COUNT(DISTINCT DIAGNOSISDISEASE) AS unique_count
FROM 病名データ_カルテオーダ
UNION ALL
SELECT
    '病名データ_カルテオーダ' AS table_name,
    'VALIDSTARTDATE' AS column_name,
    COUNT(DISTINCT VALIDSTARTDATE) AS unique_count
FROM 病名データ_カルテオーダ
UNION ALL
SELECT
    '病名データ_カルテオーダ' AS table_name,
    'VALIDENDDATE' AS column_name,
    COUNT(DISTINCT VALIDENDDATE) AS unique_count
FROM 病名データ_カルテオーダ
UNION ALL
SELECT
    '病名データ_カルテオーダ' AS table_name,
    'MAINDISEASESTATUS' AS column_name,
    COUNT(DISTINCT MAINDISEASESTATUS) AS unique_count
FROM 病名データ_カルテオーダ
UNION ALL
SELECT
    '病名データ_カルテオーダ' AS table_name,
    'FINISHSTATUS' AS column_name,
    COUNT(DISTINCT FINISHSTATUS) AS unique_count
FROM 病名データ_カルテオーダ
UNION ALL
SELECT
    '病名データ_カルテオーダ' AS table_name,
    'DIAGNOSISSTATUS' AS column_name,
    COUNT(DISTINCT DIAGNOSISSTATUS) AS unique_count
FROM 病名データ_カルテオーダ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'ADMISSIONNO' AS column_name,
    COUNT(DISTINCT ADMISSIONNO) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'ADMISSIONDATE' AS column_name,
    COUNT(DISTINCT ADMISSIONDATE) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'DISFINALDATE' AS column_name,
    COUNT(DISTINCT DISFINALDATE) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'RENNO' AS column_name,
    COUNT(DISTINCT RENNO) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'APKBN' AS column_name,
    COUNT(DISTINCT APKBN) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'SEIKYUFROMDTE' AS column_name,
    COUNT(DISTINCT SEIKYUFROMDTE) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'SEIKYUENDDTE' AS column_name,
    COUNT(DISTINCT SEIKYUENDDTE) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'HOUKATSUTEN' AS column_name,
    COUNT(DISTINCT HOUKATSUTEN) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'DPCDEKIDAKATEN' AS column_name,
    COUNT(DISTINCT DPCDEKIDAKATEN) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '請求データ' AS table_name,
    'DPCSYOKUJI' AS column_name,
    COUNT(DISTINCT DPCSYOKUJI) AS unique_count
FROM 請求データ
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'ADMISSIONNO' AS column_name,
    COUNT(DISTINCT ADMISSIONNO) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'PATIENTNO' AS column_name,
    COUNT(DISTINCT PATIENTNO) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'ADMISSIONDATE' AS column_name,
    COUNT(DISTINCT ADMISSIONDATE) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'SHIBOU' AS column_name,
    COUNT(DISTINCT SHIBOU) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINJCS' AS column_name,
    COUNT(DISTINCT NYUINJCS) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINJCS' AS column_name,
    COUNT(DISTINCT TAIINJCS) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINADL1' AS column_name,
    COUNT(DISTINCT NYUINADL1) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINADL2' AS column_name,
    COUNT(DISTINCT NYUINADL2) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINADL3' AS column_name,
    COUNT(DISTINCT NYUINADL3) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINADL4' AS column_name,
    COUNT(DISTINCT NYUINADL4) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINADL5' AS column_name,
    COUNT(DISTINCT NYUINADL5) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINADL6' AS column_name,
    COUNT(DISTINCT NYUINADL6) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINADL7' AS column_name,
    COUNT(DISTINCT NYUINADL7) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINADL8' AS column_name,
    COUNT(DISTINCT NYUINADL8) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINADL9' AS column_name,
    COUNT(DISTINCT NYUINADL9) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'NYUINADL10' AS column_name,
    COUNT(DISTINCT NYUINADL10) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINADL1' AS column_name,
    COUNT(DISTINCT TAIINADL1) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINADL2' AS column_name,
    COUNT(DISTINCT TAIINADL2) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINADL3' AS column_name,
    COUNT(DISTINCT TAIINADL3) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINADL4' AS column_name,
    COUNT(DISTINCT TAIINADL4) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINADL5' AS column_name,
    COUNT(DISTINCT TAIINADL5) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINADL6' AS column_name,
    COUNT(DISTINCT TAIINADL6) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINADL7' AS column_name,
    COUNT(DISTINCT TAIINADL7) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINADL8' AS column_name,
    COUNT(DISTINCT TAIINADL8) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINADL9' AS column_name,
    COUNT(DISTINCT TAIINADL9) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'TAIINADL10' AS column_name,
    COUNT(DISTINCT TAIINADL10) AS unique_count
FROM 重症度・転帰
UNION ALL
SELECT
    '重症度・転帰' AS table_name,
    'SHUYAKUKBN' AS column_name,
    COUNT(DISTINCT SHUYAKUKBN) AS unique_count
FROM 重症度・転帰;

-- -- ヘッダー行と実データを結合し、ファイルに出力する
-- (SELECT 'table_name', 'column_name', 'unique_count') -- CSVヘッダー
-- UNION ALL
-- (
--     -- ここからが前回提示したユニークカウント集計クエリ本体です
--     SELECT
--         'COVID19ワクチン接種' AS table_name,
--         'PATIENTNO' AS column_name,
--         COUNT(DISTINCT `PATIENTNO`) AS unique_count
--     FROM
--         `COVID19ワクチン接種`
--     UNION ALL
--     SELECT 'COVID19ワクチン接種', 'DEPARTMENTCODE', COUNT(DISTINCT `DEPARTMENTCODE`) FROM `COVID19ワクチン接種`
--     UNION ALL
--     SELECT 'COVID19ワクチン接種', 'DEPTNAME', COUNT(DISTINCT `DEPTNAME`) FROM `COVID19ワクチン接種`
--     UNION ALL
--     SELECT 'COVID19ワクチン接種', 'EVENTDATE', COUNT(DISTINCT `EVENTDATE`) FROM `COVID19ワクチン接種`
--     UNION ALL
--     SELECT 'COVID19ワクチン接種', '更新日時', COUNT(DISTINCT `更新日時`) FROM `COVID19ワクチン接種`
--     UNION ALL
--     SELECT 'COVID19ワクチン接種', '問診1_過去2週間の曝露歴', COUNT(DISTINCT `問診1_過去2週間の曝露歴`) FROM `COVID19ワクチン接種`
--     UNION ALL
--     SELECT 'COVID19ワクチン接種', '問診2_濃厚接触者', COUNT(DISTINCT `問診2_濃厚接触者`) FROM `COVID19ワクチン接種`
--     UNION ALL
--     SELECT 'COVID19ワクチン接種', '問診3_症状の有無', COUNT(DISTINCT `問診3_症状の有無`) FROM `COVID19ワクチン接種`
--     UNION ALL
--     SELECT 'COVID19ワクチン接種', '問診4_家族_同僚症状の有無', COUNT(DISTINCT `問診4_家族_同僚症状の有無`) FROM `COVID19ワクチン接種`
--     UNION ALL
--     SELECT 'COVID19ワクチン接種', '問診5_接種歴', COUNT(DISTINCT `問診5_接種歴`) FROM `COVID19ワクチン接種`
--     UNION ALL
--     SELECT 'COVID19ワクチン接種', '接種日1回目', COUNT(DISTINCT `接種日1回目`) FROM `COVID19ワクチン接種`
--     -- ... (以下、すべての中間クエリが続きます) ...
--     UNION ALL
--     SELECT '重症度・転帰', 'SHUYAKUKBN', COUNT(DISTINCT `SHUYAKUKBN`) FROM `重症度・転帰`
-- )
-- -- ここからがファイル出力のための句です
-- INTO OUTFILE '/tmp/result.csv'
-- -- CSVの書式を指定
-- FIELDS TERMINATED BY ','        -- フィールド(列)の区切り文字をカンマにする
-- OPTIONALLY ENCLOSED BY '"'      -- 各フィールドをダブルクォートで囲む（必要な場合のみ）
-- LINES TERMINATED BY '\n';       -- 行の終わりを改行コードにする
