/**
 * Created with IntelliJ IDEA.
 * User: GGS
 * Date: 13-7-24
 * Time: 下午2:51
 * To change this template use File | Settings | File Templates.
 */

var my_pageid=f_getQueryString("PAGEID");
var is_save_succ=0;
$(function(){
    window.setTimeout(f_selTestSubject,300);
});

function f_selTestSubject(){

    var my_test_level = document.getElementById(my_pageid+"_guid_report1_wxcol_test_level");
    var my_test_subject = document.getElementById(my_pageid+"_guid_report1_wxcol_test_subject");
    var my_spec_class =document.getElementById(my_pageid+"_guid_report1_wxcol_spec_class");
    $(my_test_subject).removeAttr("disabled");

    if(my_test_level.value==4){
        window.setTimeout(function(){
            for(var i=0;i<my_test_subject.options.length;i++){
                my_test_subject.options[i].selected="selected";
            }
            $(my_test_subject).attr("disabled",true);
            $(my_test_subject).find("option").css("background-color","#3399FF");

        },300);
    }else{

         //   my_test_subject.selectedIndex=0;


    }



}


function f_apply_commit(){
    wx_alert("提交成功");
    artDialog.open.origin.refreshComponent('ShowReport.wx?PAGEID=t_apply_write');
    art.dialog.close();
}
function f_getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}
function f_set_apply_commit(){
    var my_iscommit = document.getElementById(my_pageid+"_guid_report1_wxcol_iscommit");
    my_iscommit.value=1;
}

function f_apply_save(iscommit){
    var my_iscommit = document.getElementById(my_pageid+"_guid_report1_wxcol_iscommit");
    if(iscommit){
        my_iscommit.value=1;
        $(":input[value='提交']").attr("disabled",true);
    }else{
        $(":input[value='保存']").attr("disabled",true);
       var valid=$("#"+my_pageid+"_guid_report1_metadata");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_photo");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_grad_scholl");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_grad_date");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_birthday");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_work_date");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_job_resume");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_grad_spec");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_company");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_test_subject");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_mobile");
        my_iscommit.value=0;
    }
    try{
        saveEditableReportData({pageid:my_pageid,savingReportIds:[{reportid:'report1',updatetype:'save'}]});
        window.setTimeout(function(){
            if(is_save_succ){
                if(my_pageid=='t_apply_wirte_form_add'){
                    location='ShowReport.wx?PAGEID=t_apply_write';
                    is_save_succ=0;
                }
            }
        },1000);


    }catch(e){
        logErrorsAsJsFileLoad(e);
    }

}


function f_apply_commit_save(iscommit){
    var my_iscommit = document.getElementById(my_pageid+"_guid_report1_wxcol_iscommit");
    if(iscommit){
        my_iscommit.value=1;
        $(":input[value='提交']").attr("disabled",true);
    }else{
        $(":input[value='保存']").attr("disabled",true);
        var valid=$("#"+my_pageid+"_guid_report1_metadata");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_photo");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_grad_scholl");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_grad_date");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_birthday");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_work_date");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_job_resume");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_grad_spec");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_company");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_test_subject");
        $(valid).removeAttr("validatemethod_"+my_pageid+"_guid_report1_wxcol_mobile");
        my_iscommit.value=0;
    }
    try{
        saveEditableReportData({pageid:my_pageid,savingReportIds:[{reportid:'report1',updatetype:'save'}]});
        window.setTimeout(function(){
            if(iscommit){
                parent.location='ShowReport.wx?PAGEID=t_apply_commit';
            }else{
                parent.location='ShowReport.wx?PAGEID=t_apply_write';
            }
        },1000);


    }catch(e){
        logErrorsAsJsFileLoad(e);
    }

}

