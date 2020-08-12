﻿<%@ Page Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true"
    CodeFile="CreateRP.aspx.cs" Inherits="CreateRP" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/UIControls/DatePickerControl.ascx" TagName="DatePicker" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMainContent" runat="Server">

    <script type="text/javascript">
        //--Set bg to the tabs
        setbgToTab('ctl00_tabProject', 'ctl00_divProjectSummary');
        
        /**********************Javascript Validation*********************************/
        function Validate(txtboxControlIds, ddlControlIds, ddlSpanControlIds, errorImgIDs)
        {
            var btxtBoxValidate = CheckRequiredTextBoxFields(txtboxControlIds);
            var bddlValidate = CheckRequiredDropDownFields(ddlControlIds, ddlSpanControlIds);
            //Check for field format errors
            var fieldFormatsAreValid = HighlightIncorrectFormatFields(errorImgIDs);
            
            if(btxtBoxValidate == false || bddlValidate == false || fieldFormatsAreValid == false)
            {
                var lblMessage = document.getElementById("<%=lblMessage.ClientID %>");
                lblMessage.innerText = "Kindly enter the duration details.";
                lblMessage.style.color = "Red";
                
                return false;
            }
        }

        function HighLightControl(control)
        {
            control.style.borderStyle = "Solid";
            control.style.borderWidth = "2";
            control.style.borderColor = "Red";                    
        }
        
        function CheckRequiredTextBoxFields(controlIDs)
        {
            var allFieldsAreValid = true;

            //--Check if controlds exits
            if(controlIDs == "")
            { return allFieldsAreValid;}
           
            //Split textbox IDs.
            var controlIDArray = controlIDs.split(',');
            for(i=0; i<controlIDArray.length; i++)
            {
                var control = document.getElementById(controlIDArray[i]);
                if(trim(control.value) == "")
                {        
                    HighLightControl(control) 
                    allFieldsAreValid = false;                    
                }
                else
                {
                    control.style.borderWidth = "1";
                    control.style.borderColor = "#7F9DB9";
                }
            }
            
            return allFieldsAreValid;
        }

        function CheckRequiredDropDownFields(controlIDs,spanControlIds)
        {
            var allFieldsAreValid = true;
            var hasFocus = false;
            
            //Split textbox IDs.
            var controlIDArray = controlIDs.split(',');
            var spancontrolIDArray = spanControlIds.split(',');
            for(i=0; i<controlIDArray.length; i++)
            {
                var control = document.getElementById(controlIDArray[i]);
                var spanControl = document.getElementById(spancontrolIDArray[i]);
                if(trim(control.value) == "")
                {                    
                    HighLightControl(spanControl) 
                    allFieldsAreValid = false;                    
                }
                else
                {
                    spanControl.style.borderWidth = "1";
                    spanControl.style.borderColor = "#7F9DB9";
                }
            }
            return allFieldsAreValid;
        }
               
        function ValidateTextBoxControl(controlobj,imgobj,functionName)
        {   
            var bool = false;
            var controlName = document.getElementById(controlobj);
            var imgName = document.getElementById(imgobj);            
            if(controlName.value == "")
            {
                if(imgName != null)
                {
                    imgName.style.display = "none";
                }
                
                //Reset Control highlighting
                HighLightControl(controlName)
                bool=false;
            }
            else
            {
                if ((functionName !=  null) &&(window[functionName](controlName.value)))
                {
                    imgName.style.display = "inline";
                    
                    //Highlight Control
                    HighLightControl(controlName)
                               
                    bool=false;
                }
                else
                {
                    controlName.style.borderWidth = "1";
                    controlName.style.borderColor = "#7F9DB9";
                    if(imgName != null)
                    {
                        imgName.style.display = "none";
                        imgName.alt = "";
                    }
                    bool=true;
                }
            }
            return bool;
        }
       
        function HighlightIncorrectFormatFields(imageIds)
        {
            var fieldFormatsAreValid = true;
            if(imageIds == null)
            {
                return fieldFormatsAreValid;
            }
            var txtNumberOfResources = document.getElementById("<%=txtNumberOfResources.ClientID %>")
            var txtUtilization = document.getElementById("<%=txtUtilization.ClientID %>")
            var txtBilling = document.getElementById("<%=txtBilling.ClientID %>")
            
            //Split error image IDs.
            var errorImgIDArray = imageIds.split(',');
            for(i=0; i<errorImgIDArray.length; i++)
            {
                var img = document.getElementById(errorImgIDArray[i]);
                if(img.style.display == "inline")
                {
                    //Highlight 'Number of REsources' textbox
                    if(img.id.match("NoOfResources"))
                    {
                        HighLightControl(txtNumberOfResources)
                    }
                    
                    //Highlight 'Utilization' textbox
                    if(img.id.match("Utilization"))
                    {
                        HighLightControl(txtUtilization)
                    }
                    
                    //Highlight 'Billing' textbox
                    if(img.id.match("Billing"))
                    {
                        HighLightControl(txtBilling)
                    }
                    
                    fieldFormatsAreValid = false;
                }
            }
            
            return fieldFormatsAreValid;
        }

        function CheckDates(txtStartDate, txtEndDate, imgStartDate, imgEndDate)
         {
            //debugger;
            var dateIsValid = true ;
            var imgStartDate = document.getElementById(imgStartDate);
            var imgEndDate = document.getElementById(imgEndDate);            
            
            var txtStartDate = document.getElementById(txtStartDate);
            var txtEndDate = document.getElementById(txtEndDate);
            
            var SDate = txtStartDate.value;
            var EDate = txtEndDate.value;
                        
            var endDate = new Date(ddmmyyTommddyyConverter(trim(EDate)));
            var startDate = new Date(ddmmyyTommddyyConverter(trim(SDate)));
            //Check Start Date and End Date range
            if(SDate != '' && EDate != '' && startDate >= endDate)
            {
                imgStartDate.style.display = "inline";
                //imgStartDate.alt = "End Date must be greater than start date.";               
                //Highlight Textbox
                HighLightControl(txtStartDate)
                
                imgEndDate.style.display = "inline";
                //imgEndDate.alt = "End Date must be greater than start date.";
               
                //Highlight Textbox
                HighLightControl(txtEndDate)
            
                //--
                dateIsValid = false;
            }
            else
            {
                if(SDate != '')
                {
                    imgStartDate.style.display = "none";
                    txtStartDate.style.borderWidth = "1";
                    txtStartDate.style.borderColor = "#7F9DB9";
                }
                if(EDate != '')
                {
                    imgEndDate.style.display = "none";
                    txtEndDate.style.borderWidth = "1";
                    txtEndDate.style.borderColor = "#7F9DB9";
                }
            }
            
            return dateIsValid;
       }
       
       function checkTxtBoxRange(txtbox, imgobj ,mssg)
       {
            var txtboxvalue = document.getElementById(txtbox);
            var imgName = document.getElementById(imgobj);
            if(parseInt(txtboxvalue.value) > 100)
            {
                imgName.style.display = "inline";
                //Highlight Control
                HighLightControl(txtboxvalue)
                return false;
            }
      }
       
        /**********************End JS validation**************************************/
    </script>

    <table width="100%">
        <tr>
          <%-- Sanju:Issue Id 50201:Added new class so that header display in other browsers also--%>
            <td align="center" class="header_employee_profile" style="height: 25px; filter: progid:DXImageTransform.Microsoft.Gradient(endColorstr='#7590C8', startColorstr='#0C359A', gradientType='1');">
                <span class="header">Create Resource Plan</span>
            </td>
             <%--   Sanju:Issue Id 50201:End--%>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td align="left">
                <asp:Label runat="server" ID="lblMessage" CssClass="txtstyle"><span >Fields marked with <span class="mandatorymark">*</span> are mandatory.</span></asp:Label>
            </td>
        </tr>
    </table>
    <div class="detailsborder">
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <table cellpadding="2" cellspacing="0" border="0" width="100%">
                        <tr>
                            <td colspan="12">
                                <table width="100%" class="detailsbg" cellspacing="0" cellpadding="4" border="0">
                                    <tr>
                                        <td class="detailsheader">
                                            Resource Plan Details
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <!-- -->
                            <td class="txtstyle" width="12%" align="left">
                                Project Name
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <td width="18%" align="left" class="txtstyle">
                                <asp:Label runat="server" ID="lblProjectName"></asp:Label>
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <td class="txtstyle" width="12%" align="left">
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <td width="18%" align="left">
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <td class="txtstyle" width="12%" align="left">
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <td width="18%" align="left">
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <!-- -->
                        </tr>
                        <tr>
                            <td class="txtstyle" width="12%" align="left">
                                Role<span class="mandatorymark">*</span>
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <td width="18%" align="left">
                                <span id="spanRole">
                                    <asp:DropDownList runat="server" ID="ddlRole" CssClass="mandatoryField" Width="180px">
                                    </asp:DropDownList>
                                </span>
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <td class="txtstyle" width="12%" align="left">
                                <asp:Label runat = "server" ID = "lblNumberOfResources">No. of Resources<span class="mandatorymark">*</span></asp:Label>
                                
                                <%--Start Date<span class="mandatorymark">*</span>--%>
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <td width="18%" align="left">
                                <asp:TextBox runat="server" ID="txtNumberOfResources" CssClass="mandatoryField" MaxLength="2"></asp:TextBox><span id="spanNoOfResourcesTooltip" runat="server"><img id="imgErrorNoOfResources" runat="server" src="Images/cross.png" alt="" style="display: none;border: none;" /></span>
                                <%--<asp:TextBox runat="server" ID="txtResourceStartDate" CssClass="mandatoryField"></asp:TextBox>&nbsp;&nbsp;<asp:ImageButton ID="imgCalResourceStartDate" runat="server" ImageUrl="Images/Calendar_scheduleHS.png" CausesValidation="false" ImageAlign="AbsMiddle" TabIndex="3" /><cc1:CalendarExtender ID="calendarStartDate" runat="server" PopupButtonID="imgCalResourceStartDate" TargetControlID="txtResourceStartDate" Format="dd/MM/yyyy"></cc1:CalendarExtender><span id="spanResourceStartDateTooltip" runat="server"><img id="imgErrorResourceStartDate" runat="server" src="Images/cross.png" alt="" style="display: none; border: none;" /></span>--%>
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <td class="txtstyle" width="12%" align="left">
                                <%--End Date<span class="mandatorymark">*</span>--%>
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                            <td width="18%" align="left">
                                <%--<asp:TextBox runat="server" ID="txtResourceEndDate" CssClass="mandatoryField"></asp:TextBox>&nbsp;&nbsp;<asp:ImageButton ID="imgCalResourceEndDate" runat="server" ImageUrl="Images/Calendar_scheduleHS.png" CausesValidation="false" ImageAlign="AbsMiddle" TabIndex="3" /><cc1:CalendarExtender ID="CalendarExtender1" runat="server" PopupButtonID="imgCalResourceEndDate" TargetControlID="txtResourceEndDate" Format="dd/MM/yyyy"></cc1:CalendarExtender><span id="spanResourceEndDateTooltip" runat="server"><img id="imgErrorResourceEndDate" runat="server" src="Images/cross.png" alt="" style="display: none; border: none;" /></span>--%>
                            </td>
                            <td width="1%">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="13" align="left" class="txtstyle">
                                <span style="font-weight: bold;">Duration Details</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="txtstyle" align="left">
                                Utilization(%)<span class="mandatorymark">*</span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="txtUtilization" MaxLength="3"></asp:TextBox>
                                <span id="spanUtilizationTooltip" runat="server">
                                    <img id="imgUtilization" runat="server" src="Images/cross.png" alt="" style="display: none;
                                        border: none;" />
                                </span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="txtstyle" align="left">
                                Billing(%)<span class="mandatorymark">*</span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="txtBilling" MaxLength="3"></asp:TextBox>
                                <span id="spanBillingTooltip" runat="server">
                                    <img id="imgBilling" runat="server" src="Images/cross.png" alt="" style="display: none;
                                        border: none;" /></span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="txtstyle" align="left">
                                Location<span class="mandatorymark">*</span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td align="left">
                                <span id="spanLocation">
                                    <asp:DropDownList runat="server" ID="ddlLocation" AutoPostBack = "true" CssClass="mandatoryField" Width="180px" OnSelectedIndexChanged ="ddlLocation_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="txtstyle" align="left">
                                Project Location<span class="mandatorymark">*</span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td align="left">
                                <span id="spanProjectLocation">
                                    <asp:DropDownList runat="server" ID="ddlProjectLocation" CssClass="mandatoryField"
                                        Width="180px">
                                    </asp:DropDownList>
                                </span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="txtstyle" align="left" runat = "server" id = "td_StartDate">
                                Start Date<span class="mandatorymark">*</span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td align="left">                                
                                <uc1:DatePicker id="ucDatePickerStartDate" runat="server" Width="80" /> 
                                <%--
                                <asp:TextBox runat="server" ID="txtResourceDurationStartDate"></asp:TextBox>&nbsp;&nbsp;<asp:ImageButton
                                    ID="imgCalResourceDurationStartDate" runat="server" ImageUrl="Images/Calendar_scheduleHS.png"
                                    CausesValidation="false" ImageAlign="AbsMiddle" TabIndex="3" /><cc1:CalendarExtender
                                        ID="CalendarExtender2" runat="server" PopupButtonID="imgCalResourceDurationStartDate"
                                        TargetControlID="txtResourceDurationStartDate" Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>--%>
                                <span id="spanResourceDurationStartDateTooltip" runat="server">
                                    <img id="imgErrorResourceDurationStartDate" runat="server" src="Images/cross.png"
                                        alt="" style="display: none; border: none;" /></span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="txtstyle" align="left" runat = "server" id = "td_EndDate">
                                End Date<span class="mandatorymark">*</span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td align="left">
                            <uc1:DatePicker id="ucDatePickerEndDate" runat="server" Width = "80" /> 
                               <%-- <asp:TextBox runat="server" ID="txtResourceDurationEndDate"></asp:TextBox>&nbsp;&nbsp;<asp:ImageButton
                                    ID="imgCalResourceDurationEndDate" runat="server" ImageUrl="Images/Calendar_scheduleHS.png"
                                    CausesValidation="false" ImageAlign="AbsMiddle" TabIndex="3" /><cc1:CalendarExtender
                                        ID="CalendarExtender3" runat="server" PopupButtonID="imgCalResourceDurationEndDate"
                                        TargetControlID="txtResourceDurationEndDate" Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>--%>
                                <span id="spanResourceDurationEndDateTooltip" runat="server">
                                    <img id="imgErrorResourceDurationEndDate" runat="server" src="Images/cross.png" alt=""
                                        style="display: none; border: none;" /></span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <!-- Split duration for offhore/onsite  -->
                        <tr class="gridheaderStyle" runat = "server" visible = "false" id = "tr_SplitDurationOffshoreOnsite" >
                            <td colspan="12">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td class="txtstyle" align="left">
                                            Start Date<span class="mandatorymark">*</span>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                        <uc1:DatePicker ID="ucDatePickerActualStartDate" runat="server" Width="80" />
                                            <%--<asp:TextBox runat="server" ID="txtActualResourceStartDate"></asp:TextBox>&nbsp;&nbsp;<asp:ImageButton
                                                ID="imgCalActualResourceStartDate" runat="server" ImageUrl="Images/Calendar_scheduleHS.png" CausesValidation="false"
                                                ImageAlign="AbsMiddle" TabIndex="3" /><cc1:CalendarExtender ID="CalendarExtender1"
                                                    runat="server" PopupButtonID="imgCalActualResourceStartDate" TargetControlID="txtActualResourceStartDate"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>--%>
                                            <span id="spanActualResourcesStartDate" runat="server">
                                                <img id="imgErrorActualResourceStartDate" runat="server" src="Images/cross.png" alt="" style="display: none;
                                                    border: none;" /></span>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td class="txtstyle" align="left">
                                            End Date<span class="mandatorymark">*</span>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                        <uc1:DatePicker ID="ucDatePickerActualEndDate" runat="server" Width="80" />
                                            <%--<asp:TextBox runat="server" ID="txtActualResourceEndDate"></asp:TextBox>&nbsp;&nbsp;<asp:ImageButton
                                                ID="imgCalActualResourceEndDate" runat="server" ImageUrl="Images/Calendar_scheduleHS.png" CausesValidation="false"
                                                ImageAlign="AbsMiddle" TabIndex="3" /><cc1:CalendarExtender ID="CalendarExtender4"
                                                    runat="server" PopupButtonID="imgCalActualResourceEndDate" TargetControlID="txtActualResourceEndDate"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>--%>
                                            <span id="spanActualResourceEndDate" runat="server">
                                                <img id="imgErrorActualResourceEndDate" runat="server" src="Images/cross.png" alt="" style="display: none;
                                                    border: none;" /></span>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td class="txtstyle" align="left">
                                            Actual Location<span class="mandatorymark">*</span>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <span id="spanActualLocation">
                                                <asp:DropDownList runat="server" ID="ddlActualLocation" CssClass="mandatoryField" Width="180px">
                                                </asp:DropDownList>
                                            </span>
                                        </td>
                                        <td>
                                            <asp:Button runat="server" ID="btnAddRow" Text="Add Row" CssClass="button" 
                                                Width = "80px" onclick="btnAddRow_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <!-- End of Split duration for offshore/onsite -->
                        <tr style="display:none;">
                            <td colspan="12">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="12">
                                &nbsp;
                            </td>
                        </tr>
                        <tr runat="server" id="tr_RPDurationDetail" visible="false">
                            <td colspan="12">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td>
                                            <asp:GridView runat="server" ID="grdRPDurationDetail" AutoGenerateColumns="False"
                                                Width="100%" EmptyDataText="No Records Found" OnRowCommand="grdRPDurationDetail_RowCommand">
                                                <Columns>
                                                    <%--<asp:BoundField DataField="Utilization" HeaderText="Utilization(%)">
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle Width="14%" />
                                                    </asp:BoundField>--%>
                                                    <%--<asp:BoundField DataField="Billing" HeaderText="Billing(%)">
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle Width="14%" />
                                                    </asp:BoundField>--%>
                                                    <%--<asp:BoundField DataField="ResourceLocation" HeaderText="Location">
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle Width="14%" />--%>
                                                    <asp:BoundField DataField="ResourceLocation" HeaderText="Actual Location">
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle Width="14%" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Start Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblResourceStartDate" runat="server" Text='<%#Eval("ResourceStartDate","{0:dd/MM/yyyy}") %>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="End Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblResourceEndDate" runat="server" Text='<%#Eval("ResourceEndDate","{0:dd/MM/yyyy}") %>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle Width="15%" />
                                                    </asp:TemplateField>
                                                    <%--<asp:BoundField DataField="ProjectLocation" HeaderText="Project Location">
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle Width="16%" />
                                                    </asp:BoundField>--%>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:ImageButton runat="server" ID="lnkRemoveRPDurationDetail" ImageUrl="~/Images/Delete.gif"
                                                                ToolTip="Remove" Width="13px" Height="13px" CommandName="RemoveRPDurationDetail"
                                                                CommandArgument='<%#Eval("RPDId") %>' OnClientClick="return confirm('Are you sure, you want to delete the record of the selected resource?')" />
                                                            <asp:Label runat="server" ID="lblRPDurationID" Text='<%#Eval("ResourcePlanDurationId") %>'
                                                                Visible="false"></asp:Label><asp:Label runat="server" ID="lblRPID" Text='<%#Eval("RPId") %>'
                                                                    Visible="false"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle Width="12%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <HeaderStyle CssClass="gridheaderStyle" />
                                                <AlternatingRowStyle CssClass="alternatingrowStyleRP" />
                                                <RowStyle Height="20px" CssClass="txtstyle" />
                                                <EmptyDataRowStyle CssClass="text" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr style="display:none;"><td>&nbsp;</td></tr>
                                    <tr style="display:none;">
                                        <td align="right" >
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                <tr>
                                                    <td align="right" width="87%">
                                                        <asp:Button runat="server" ID="btnAddResourceDuration" Text="Add Resource" CssClass="button"
                                                            OnClick="btnAddResourceDuration_Click" />
                                                    </td>
                                                    <td width="3%">
                                                        &nbsp;
                                                    </td>
                                                    <td align="right" width="7%">
                                                        <asp:Button runat="server" ID="btnCancelRPDetails" Text="Cancel" CssClass="button"
                                                            Width="100px" OnClick="btnCancelRPDetails_Click" OnClientClick="return confirm('Are you sure?')" />
                                                    </td>
                                                    <td width="3%">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr><td>&nbsp;</td></tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="12">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td width="99%" align="right">
                                            <asp:Button runat="server" ID="btnAddDuration" Text="Add Role" CssClass="button"
                                                OnClick="btnAddDuration_Click" /><asp:Button runat="server" ID="btnUpdateDuration"
                                                    Text="Update Role" CssClass="button" OnClick="btnUpdateDuration_Click" Visible="false" /><asp:Button runat="server" ID="Button1" Text="Clear" CssClass="button" Width="100px" OnClick="btnCancelRPDetails_Click" OnClientClick="return confirm('Are you sure?')" />
                                         <asp:Button runat="server" ID="Button2" Text="Cancel" CssClass="button"
                                                Width="100px" OnClientClick="return confirm('Do you wish to exit without creating the resource plan?')"
                                                OnClick="btnCancelResourcePlan_Click" />
                                        </td>
                                        <td width="1%">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr runat="server" id="tr_ResourcePlan" visible="false">
                <td>
                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                        <tr>
                            <td>
                                <asp:GridView runat="server" ID="grdResourcePlan" AutoGenerateColumns="False" Width="100%"
                                    EmptyDataText="No Records Found" OnRowCommand="grdResourcePlan_RowCommand" OnRowDataBound="grdResourcePlan_RowDataBound"
                                    OnDataBound="grdResourcePlan_DataBound" OnRowCreated="grdResourcePlan_RowCreated"
                                    AllowSorting="true" AllowPaging="true" OnSorting="grdResourcePlan_Sorting">
                                    <HeaderStyle CssClass="gridheaderStyle" />
                                    <AlternatingRowStyle CssClass="alternatingrowStyle" />
                                    <RowStyle Height="20px" CssClass="textstyle" />
                                    <EmptyDataRowStyle CssClass="text" />
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:ImageButton runat="server" ID="imgbtnExpandCollaspeChildGrid" ImageUrl="Images/plus.JPG"
                                                    Width="13px" Height="13px" CommandName="ChildGridRPDuraiton" CommandArgument='<%#Eval("ResourcePlanDurationId") %>' />
                                            </ItemTemplate>
                                            <ItemStyle Width="6%" VerticalAlign="Middle" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="RPDuRowNo" HeaderText="ID" SortExpression="RPDuRowNo">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <%--<HeaderStyle Width="20%" />--%>
                                            <HeaderStyle Width="30%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <%--<HeaderStyle Width="20%" />--%>
                                            <HeaderStyle Width="40%" />
                                        </asp:BoundField>
                                        <%--<asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="StartDate">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <HeaderStyle Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:dd/MM/yyyy}" SortExpression="EndDate">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <HeaderStyle Width="20%" />
                                        </asp:BoundField>--%>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:ImageButton runat="server" ID="imgbtnEditRPDuration" ImageUrl="~/Images/Edit.gif"
                                                    Width="13px" Height="13px" CommandName="EditRPDuration" CommandArgument='<%#Eval("ResourcePlanDurationId") %>' ToolTip = "Edit" />
                                            </ItemTemplate>
                                            <%--<ItemStyle Width="7%" VerticalAlign="Middle" HorizontalAlign="Center" />--%>
                                            <ItemStyle Width="12%" VerticalAlign="Middle" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:ImageButton runat="server" ID="imgDeleteRPDuration" ImageUrl="~/Images/Delete.gif"
                                                    ToolTip="Delete" Width="13px" Height="13px" CommandName="DeleteRPDuration" CommandArgument='<%#Eval("ResourcePlanDurationId") %>'
                                                    OnClientClick="return confirm('Are you sure, you want to delete the record of the selected resource?')" /><asp:Label
                                                        runat="server" ID="lblRPId" Text='<%#Eval("RPId") %>' Visible="false"></asp:Label>
                                                </td></tr>
                                                <tr runat="server" id="tr_ChildRPDuration" style="display: none;">
                                                    <td colspan="8" width="100%">
                                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView runat="server" ID="grdChildRPDurationDetail" AutoGenerateColumns="False"
                                                                        Width="100%" EmptyDataText="No Records Found" OnRowCommand="grdChildRPDurationDetail_RowCommand">
                                                                        <Columns>
                                                                            <asp:BoundField>
                                                                                <HeaderStyle Width="6%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="RPDRowNo" HeaderText="Sr. No">
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                <HeaderStyle Width="11%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ResourceLocation" HeaderText="Location">
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                <HeaderStyle Width="11%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Utilization" HeaderText="Utilization(%)">
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                <HeaderStyle Width="11%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Billing" HeaderText="Billing(%)">
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                <HeaderStyle Width="11%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ProjectLocation" HeaderText="Project Location">
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                <HeaderStyle Width="12%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ResourceStartDate" HeaderText="Start Date" DataFormatString="{0:dd/MM/yyyy}">
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                <HeaderStyle Width="12%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ResourceEndDate" HeaderText="End Date" DataFormatString="{0:dd/MM/yyyy}">
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                <HeaderStyle Width="12%" />
                                                                            </asp:BoundField>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <asp:ImageButton runat="server" ID="imgEdit" ImageUrl="~/Images/Edit.gif" ToolTip="Edit"
                                                                                        Width="13px" Height="13px" CommandName="EditChildRPDetail" CommandArgument='<%#Eval("RPDId") %>' />
                                                                                </ItemTemplate>
                                                                                <ItemStyle Width="7%" VerticalAlign="Middle" HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <asp:ImageButton runat="server" ID="imgDeleteRPDetail" ImageUrl="~/Images/Delete.gif"
                                                                                        ToolTip="Delete" Width="13px" Height="13px" CommandName="ChildDeleteRPDetail"
                                                                                        CommandArgument='<%#Eval("RPDId") %>' OnClientClick="return confirm('Are you sure, you want to delete the record of the selected resource?')" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle Width="7%" VerticalAlign="Middle" HorizontalAlign="Center" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <EmptyDataRowStyle CssClass="text" />
                                                                        <HeaderStyle CssClass="childgridheader" />
                                                                        <RowStyle CssClass="childgridRow" />
                                                                        <AlternatingRowStyle CssClass="childgridAlternatingRow" />
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <%--<ItemStyle Width="7%" VerticalAlign="Middle" HorizontalAlign="Center" />--%>
                                            <ItemStyle Width="12%" VerticalAlign="Middle" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerTemplate>
                                        <table class="tablePager">
                                            <tr>
                                                <td align="center">
                                                    <span class="txtstyle">&lt;&lt;&nbsp;&nbsp;</span><asp:LinkButton ID="lbtnPrevious"
                                                        runat="server" ForeColor="white" CommandName="Previous" OnCommand="ChangePage"
                                                        Font-Underline="true" Enabled="False" CssClass="txtstyle">Previous</asp:LinkButton>
                                                    <span class="txtstyle">Page</span>
                                                    <asp:TextBox ID="txtPages" runat="server" OnTextChanged="txtPages_TextChanged" AutoPostBack="true"
                                                        Width="21px" MaxLength="3" onpaste="return false;" CssClass="txtstyle"></asp:TextBox>
                                                    <span class="txtstyle">of</span>
                                                    <asp:Label ID="lblPageCount" runat="server" ForeColor="white" CssClass="txtstyle"></asp:Label>
                                                    <asp:LinkButton ID="lbtnNext" runat="server" ForeColor="white" CommandName="Next"
                                                        OnCommand="ChangePage" Font-Underline="true" Enabled="False" CssClass="txtstyle">Next</asp:LinkButton><span
                                                            class="txtstyle">&nbsp;&nbsp;&gt;&gt;</span>
                                                </td>
                                            </tr>
                                        </table>
                                    </PagerTemplate>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                    <tr>
                                        <td align="right" width="87%">
                                            <asp:Button runat="server" ID="btnSaveResourcePlan" Text="Send For Approval" CssClass="button" OnClientClick="return confirm('Do you wish to send for approval created resource plan?')"
                                                OnClick="btnSaveResourcePlan_Click" />
                                        </td>
                                        <td width="3%">
                                            &nbsp;
                                        </td>
                                        <td align="right" width="7%">
                                            <asp:Button runat="server" ID="btnCancelResourcePlan" Text="Cancel" CssClass="button"
                                                Width="100px" OnClientClick="return confirm('Do you wish to exit without creating the resource plan?')"
                                                OnClick="btnCancelResourcePlan_Click" />
                                        </td>
                                        <td width="3%">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <asp:Label runat="server" ID="lblRPId" Visible="false"></asp:Label><asp:Label runat="server"
        ID="lblRPDuId" Visible="false"></asp:Label>
</asp:Content>
