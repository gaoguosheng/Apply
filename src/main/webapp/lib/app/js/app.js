/**
 * 信息框
 * */
function f_alert(msg,fn){
    $.messager.alert("提示",msg,"info",fn);
}
/**
 * 错误提示
 * */
function f_alertError(msg,fn){
    $.messager.alert("提示",msg,"error",fn);
}

/**
 * 确认框
 * */

function f_confirm(msg,fn){
    $.messager.confirm('提示',msg,function(r){
        if (r){
            fn();
        }
    });
}
/**
 * 小帖士提示
 * */
function f_tips(msg){
    $.messager.show({
        title:'提示',
        msg:msg,
        timeout:3000,
        showType:'slide'
    });
}
/**
 * 小帖士提示
 * */
function f_tipsAlways(msg){
    $.messager.show({
        title:'提示',
        msg:msg,
        timeout:0,
        showType:'slide'
    });
}

var appTabs="appTabs";
function f_addTab(title, href,closable,icon){
    var tt = $('#'+appTabs);
    if (tt.tabs('exists', title)){//如果tab已经存在,则选中并刷新该tab
        tt.tabs('select', title);
        f_refreshTab({tabTitle:title,url:href});
    } else {
        if (href){
            var content = '<iframe scrolling="auto" frameborder="0"  src="'+href+'" style="width:100%;height:100%;"></iframe>';
        } else {
            var content = '';
        }
        tt.tabs('add',{
            title:title,
            closable:closable,
            content:content,
            iconCls:icon||'icon-default'
        });
    }
}
function f_refreshTab(cfg){
    var refresh_tab = cfg.tabTitle?$('#'+appTabs).tabs('getTab',cfg.tabTitle):$('#'+appTabs).tabs('getSelected');
    /*if(refresh_tab && refresh_tab.find('iframe').length > 0){
        var _refresh_ifram = refresh_tab.find('iframe')[0];
        var refresh_url = cfg.url?cfg.url:_refresh_ifram.src;        
        _refresh_ifram.contentWindow.location.href=refresh_url;
    }*/
}

