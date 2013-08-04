<%--
  Created by IntelliJ IDEA.
  User: GGS
  Date: 13-7-23
  Time: 下午10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@include file="/inc/lib.jsp"%>
</head>
<body>
    <div align="center">
        <h3 style="margin: 10px;">承诺书</h3>
        <textarea name="textarea"  wrap="VIRTUAL" readonly style="padding-top:15px; font-size:12px;width: 100%;line-height: 28px;height: 350px;">
            本人已仔细阅读《福建省公务员局福建省人力资源开发办公室福建省食品药品监督管理局关于做好2013年度全省药学（非临床）专业初中级技术职务任职资格考试有关工作的通知》（闽人发[2013]  120号），完全了解所报考专业技术职务任职资格的条件要求。我在此郑重承诺：
            一、网络报名及现场确认提交的所有信息及考试期间提供的证件、资料准确、真实、有效，不弄虚作假。
            二、在规定时间内完成报名、现场确认、交费和打印准考证事宜，并按时参加考试，逾期按自动放弃考试处理。
            三、认真履行报考人员的各项义务，维护网站和他人的合法权益，不做扰乱报名和考试秩序的行为。
            四、遵守考试纪律和考场规则，遵从考试组织部门的安排，服从监考人员的检查、监督和管理，不参与任何形式的考试舞弊。
            五、本人不属于闽人发[2013]120号文件报考条件中第三条规定的五种不得申请参加药学专业技术职务任职资格考试情形之一。
            六、如有违纪违规及违反上述承诺的行为，自愿按《专业技术人员资格考试违纪违规行为处理规定》（2011年人社部令第12号）处理，并承担相应的责任和由此造成的一切后果。
        </textarea>
        <div style="color:#CC3300;margin: 10px;">点击下一步，表示您已阅读并同意遵守。</div>
        <div align="right">
            <a id="accBtn" href="${ctx}/ShowReport.wx?PAGEID=t_apply_wirte_form_add" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" >下一步</a>
        </div>
    </div>
</body>
</html>