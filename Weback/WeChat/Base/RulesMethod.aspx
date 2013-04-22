﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RulesMethod.aspx.cs" Inherits="WeChat.Base.RulesMethod" %><!DOCTYPE html>
<html lang="zh">
<head>
    <title>代码处理规则列表-<%=UIConfig("AppName")%></title>
    <%= GetTemplate("_meta") %>
    <link href="../res/miniui/themes/default/miniui.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div id="content" style=" margin:0px;">
  <div id="content-header">
    <div id="breadcrumb"> <a href="/main.aspx" title="返回首页" class="tip-bottom"><i class="icon-home"></i>未来鸟微信平台</a> <a href="/base/rulesmethod.aspx" class="current">代码处理规则</a></div>   
  </div>

        <div class="container-fluid">
            <div class="row-fluid">
              <div class="span12">
                <div class="widget-box">
                     <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
                        <div style=" float:right; padding:3px;">
                            <a class="btn btn-primary" href="rulesform.aspx?type=method">新建规则</a>
                        </div>
                        <h5>代码处理规则列表</h5>
                    </div>
                    <div class="mini-fit" style="clear:both;height:560px;">
                        <div id="datagrid" class="mini-datagrid" style="width:100%;height:100%" pageSize="18" showPageIndex="true" showLoading="false" showTotalCount="true" allowResize="false" url="rulesmethod.aspx?action=getlist" idField="Guid" multiSelect="true" >
                            <div property="columns">
                                <div type="checkcolumn" width="18"></div>
                                <div field="RuleName" width="120" headerAlign="center" align="left" allowSort="false" renderer="onRuleName">规则名称</div>
                                <div field="DoMethod" width="120" headerAlign="center" align="left" allowSort="false" renderer="onDoMethod">调用的代码函数</div>
                                <div field="RuleHelp" width="360" headerAlign="center" align="left" allowSort="false" renderer="onContent">使用帮助</div>
                                <div field="Guid" width="60" headerAlign="center" align="center" allowSort="false" renderer="onOp">操作</div>
                            </div>
                        </div>
                    </div>
                </div>
              </div>
            </div>
        </div>

</div>

    <%= GetTemplate("_loader") %>
<script src="../res/miniui/miniui.js" type="text/javascript"></script>
<script type="text/javascript">
    mini.parse();
    var grid = mini.get("datagrid");
    grid.load();
    function edit(guid) {
        window.location.href = 'rulesform.aspx?type=method&Guid=' + guid;
    }
    function del(guid) {
        $.dialog({
            lock: true,
            fixed: true,
            content: '注意：<br/>数据删除后无法恢复，需谨慎操作；<br/>您确定要删除当前规则吗？',
            ok: function () {
                $.getJSON("rulesmethod.aspx", { "action": "del", "Guid": guid }, function (json) {
                    if (json.success) {
                        grid.reload();
                        $.dialog({
                            time: 2,
                            lock: true,
                            fixed: true,
                            icon: 'succeed',
                            content: 'Success,操作保存成功！'
                        });
                    } else {
                        $.dialog({
                            lock: true,
                            fixed: true,
                            icon: 'error',
                            content: json.msg
                        });
                    }
                });
            },
            okVal: '是,删除',
            cancelVal: '取消',
            cancel: true //为true等价于function(){}
        });
    }
    function onRuleName(e) {
        if (e.value) {
            return e.value;
        } else {
            return '<a style="color:gray;">未知</a>';
        }
    }
    function onContent(e) {
        return e.value;
    }
    function onOp(e) {
        return '<a href="javascript:edit(\'' + e.value + '\');">编辑</a>&nbsp;<a href="javascript:del(\'' + e.value + '\');">删除</a>';
    }
</script>
</body>
</html>

