$(function () {
   $(window).resize();
   $("#logoutButton").click(function () {
        $("#logoutForm").submit();
    });

    $(document).ajaxStart(function () {
            WaitDialog(1);
    }).ajaxError(function (e, xhr, settings) {
        WaitDialog(0);
        try {
            if ($('#patsdialog').closest('.ui-dialog').is(':visible'))
                $("#patsdialog").dialog('close');
        }
        catch (err) {
            $("#patsdialog").dialog('destroy');
            // $("#patsdialog").unload();
        }
        if (xhr.status == 401) {
            window.location = "/";
            xhr.status = 0;
            return false;
        }
    }).ajaxStop(function (e, xhr, settings) {
          WaitDialog(0);
        if ($('#patsdialog').closest('.ui-dialog').is(':visible'))
            $("#patsdialog").dialog("close");
            return -1;
    });
    
    function MinTextArea(obj, e, height) {
        var textwidth = obj.width;
        obj.animate({
            width: textwidth,
            height: height
        }, 0);
    };
  
    $(document).on('keydown', function (e) {
        var $target = $(e.target || e.srcElement);
        if (e.keyCode == 8 && $target.is('textarea') && $target.is('[readonly="readonly"]')) {
            e.preventDefault();
            return false;
        }
    })
    $.fn.serializeAllArray = function () {
        var obj = {};
        $('textarea', this).each(function () {
            obj[this.name] = $(this).val();
        });

        $('input', this).each(function () {
            if (obj[this.name] == undefined && this.className != "neverDisable") {
                if (this.type == "checkbox")
                    obj[this.name] = this.checked.toString();
                else
                    obj[this.name] = $(this).val();
            }
        });

        return $.param(obj);
    }
});
PullToRefresh.init({
    mainElement: 'body',
    onRefresh: function () {
        // What do you want to do when the user does the pull-to-refresh gesture
        //window.location.reload();
        $(window).resize();
    },
    distThreshold: 50, // Minimum distance required to trigger the refresh.
    iconArrow: '<span class="fa fa-arrow-down"></span>', // The icon for both instructionsPullToRefresh and instructionsReleaseToRefresh
    instructionsPullToRefresh: "Pull down",
    instructionsReleaseToRefresh: "Release"
});
function is_valid_date(value) {
    // capture all the parts
    var matches = value.match(/^(\d{2})\/(\d{2})\/(\d{4})$/);
    if (matches === null) {
        return true;
    } else {
        // now lets check the date sanity
        var year = parseInt(matches[3], 10);
        var month = parseInt(matches[1], 10) - 1; // months are 0-11
        var day = parseInt(matches[2], 10);

        var date = new Date(year, month, day);
        if (date.getFullYear() !== year
          || date.getMonth() != month
          || date.getDate() !== day

        ) {
            return false;
        } else {
            return true;
        }
    }S
}
$(window).resize(function () {
    // your code
    //245 = header height + footer height 
    var hvh = $(window).height(); 

    // Edge 20+
    //var isEdge = (navigator.userAgent.indexOf("Edg") > 0);
    var isIE = !(navigator.userAgent.indexOf("Edg") > 0 || navigator.userAgent.indexOf("Chrome") > 0);
    // Chrome 1 - 79
    var whvh = hvh - 255;
    if (isIE)
        $("#appttabs").css({ 'height': (hvh - 105) + "px" });
    else 
        $("#appttabs").css({ 'height': (hvh - 115) + "px" });
    
    $("#editingpane").css({ "height": whvh});
    $('#editingpane').css({ "min-height": whvh });
    $("#loginForm").css({ "height": (hvh - 145) + "px" });
    $('#rptReport').css({ 'height': (hvh - 115) + "px" });
    $('#assigneditem2').css({ 'height': (hvh - 110) + "px" });
    $('#assigneditem2').css({ 'min-height': (hvh - 110) + "px" });
    $('#apptitem2').css({ 'height': (hvh - 110) + "px" });
    $('#apptitem2').css({ 'min-height': (hvh - 110) + "px" });
    $("#divAppointment").css({ 'min-height': (hvh - 175) + "px" });
    $("#divAppointment").css({ 'height': (hvh - 175) + "px" });
    $("#divAssignment").css({ 'min-height': (hvh - 175) + "px" });
    $("#divAssignment").css({ 'height': (hvh - 175) + "px" });
    
    var grid = $("#gridAssignment");
    if (grid != undefined) {
        var gHeight = ($("#divAssignment").height() - 100);
        grid.children(".k-grid-content").height(gHeight);
    }
    var grid1 = $("#gridScheduler");
    if (grid1 != undefined) {
        var gHeight1 = ($("#divAppointment").height() - 150);
        grid1.children(".k-grid-content").height(gHeight1);
    }
});
function LoadSelectedTab(url, fndata, target) {
    $.ajax({
        url: url,
        data: fndata,
        cache: false,
        type: "POST",
        dataType: "html",
        success: function (data, textStatus, xhr) {
            var div = document.getElementById(target);
            if (div == undefined || div == null) {
                var newdiv = document.createElement('div');
                newdiv.id = target;
                newdiv.class = "table table-hove";
                document.getElementById("editingpane").appendChild(newdiv);
            }
            $(target).html(data); // HTML DOM replace
            WaitDialog(0);
            return true;
        },
        error: function (data, textStatus, xhr) {
            if (data.status != 401)
                NotifyMessage(textStatus + " load " + target + ".")
            //alert(textStatus + " load " + target + ".")
            WaitDialog(0);
            return false;
        }
    });
}

function TextarePopup(e, edit, color) {
    edit = (edit && e.target.className.indexOf("alwayReadonly") < 0);
    var object = "<textarea id='notebox' name='notebox' style='width: 99%; height: 100%; background-color:white; font-size:16px;' onKeyUp = 'TAKeyUp(event)'></textarea>";
    var ttl = (edit) ? (e.target.value.length == 0 ? "Add Note" : "Edit Note") : "View Note";
    var buttons = {
        "1": { id: 'close', text: 'Close(Esc)', click: function () { $(this).dialog("close"); }, "class": "ui-dialog-button" }
    };
    //Add another button to that object if some condition is true
    if (edit) {
        buttons = {
            "1": { id: 'close', text: 'Close(Esc)', click: function () { $(this).dialog("close"); }, "class": "ui-dialog-button" },
            "2": { id: 'save', text: 'Save(Ctrl+q)', click: function () {
                var val = $("#notebox").val();
                if (val.length > 0) {
                    if (val.length > e.target.maxLength) {
                        NotifyMessage("The input string exceeds the maximum size: " + e.target.maxLength);
                        return;
                    }
                    val = remove_non_ascii(val);
                }
                e.target.value = val;
                $(".textareaforcasemanngement").trigger('change');
                $(this).dialog("close"); }, "class": "ui-dialog-button" }
        };
    }
    
    if (edit == false)
        object = "<textarea id='notebox' name='notebox' style='width: 99%; height: 100%; background-color:white; font-size:16px;' readonly='readonly' ></textarea>";

    $("#pdfdialog").html(object)
        .dialog({
            modal: true,
            width: '80vw',
            height: 400,
            title: ttl,
            resizable: true,
            responsive: true,
            dialogClass: color,
            buttons: buttons,
            closeText: ''
        });
   
    document.getElementById("notebox").value =e.target.value; 
    return;
}
function TAKeyUp(e)
{  //F4 key -115  Q key-66
    if (e.keyCode == '81' && e.ctrlKey) {
        $("#save").trigger('click');
    }
}

function DDLOnCloseIgnoreFilter(e) {
    if (e.sender._state === "filter")
        e.preventDefault();
}
function changeNewLine(text) {
    var regexp = new RegExp('\n', 'g');
    return text.replace(regexp, '<br>');
}
function ReloadClientPage(objname) {
    var url = "";
    var tab = "";
    var fndata = "";
    switch (objname) {
        case "Client Profile": { tab = "clientprofile"; break; }
        case "Address": { tab = "address"; break; }
        case "Client Alert": { tab = "clientalerts"; break; }
        case "Health Care Benefits": { tab = "healthcare"; break; }
        case "File upload": { tab = "clientFileUpload"; break; }
        case "Client Assignment": { tab = "individualAssignment"; break; }
        case "Case Re-entry Initial Mental Health Screening": { tab = "ReEntry"; break; }
        case "Case Management Individualized Re-entry Plan": { tab = "IRP"; break; }
        case "DSM-5 Self-Rated Level 1 Cross-Cutting Symptom Measure--Adult": { tab = "DSM5"; break; }
        case "Multnomah Community Ability Scale": { tab = "Multnomah"; break; }
        case "Case Management Re-entry Needs Assessment": { tab = "Assessment"; break; }
        case "PMHS Profile": { tab = "PMHSProfile"; break; }
        case "Interdisciplinary Treatment Team (IDTT) Meeting Clinical": { tab = "IDTT"; break; }
        case "PAROLEE MENTAL HEALTH SYSTEM PLACEMENT AND CHANGE": { tab = "PMHSPC"; break; }
        case "PAROLEE MENTAL HEALTH SYSTEM REMOVAL": { tab = "PMHSR"; break; }
        case "DSM Diagnosis": { tab = "dsmmain"; break; }
        case "Legal Document": { tab = "legaldocChecklist"; break; }
        case "Evaluation": { tab = "evaluationmain"; break; }
            //default: { return;}
    }
    switch (tab) {
        case "clientprofile": case "address": case "clientalerts": case "healthcare": case "allnotes": case "clientFileUpload": {
            url = '@Url.Action("GetClientProfileIndex", "Client")';
            fndata = {
                EpisodeID: $("#AllSelectedOffenderEpisodeResult").val(),
                ActiveTabIn: tab,
                NewClient: false,
                FromCMRequested: false
            };
            LoadSelectedTab(url, fndata, "#viewPlaceHolder");
            return;
        }
        case "individualAssignment": case "singleAssignmentHistory": {
            url = '@Url.Action("ClientAssignmentIndex", "Assignment")';
            fndata = { EpisodeID: $("#AllSelectedOffenderEpisodeResult").val(), ActiveTabIn: tab };
            LoadSelectedTab(url, fndata, "#viewPlaceHolder");
            return;
        }
        case "ReEntry": case "IDTT": case "IRP": case "Multnomah": case "Assessment": case "PMHSProfile": case "PMHSPC": case "PMHSR": case "clinicalNote": case "DSM5": {
            url = '@Url.Action("GetSocialWork", "Client")';
            fndata = { EpisodeID: $("#AllSelectedOffenderEpisodeResult").val(), ActiveTabIn: tab };
            LoadSelectedTab(url, fndata, "#viewPlaceHolder");
            return;
        }
        case "appointment": {
            url = '@Url.Action("GetAppointmentClientManagement", "Appointment")';
            var activetab = 0;
            if ($(e.item).children(".k-link").text() == "DAILY ACTIVITY REPORT") activetab = 1;
            fndata = { EpisodeID: $("#AllSelectedOffenderEpisodeResult").val(), ParoleLocationID:0, tab: activetab };
            LoadSelectedTab(url, fndata, "#viewPlaceHolder");
            return;
        }
        case "mma": case "psychiatryNote": {
            url = '@Url.Action("GetPsychiatry", "Client")';
            fndata = { EpisodeID: $("#AllSelectedOffenderEpisodeResult").val(), ActiveTabIn: tab };
            LoadSelectedTab(url, fndata, "#viewPlaceHolder");
            return;
        }
        case "dsmmain": case "dsmhis": {
            url = '@Url.Action("GetDsm", "Client")';
            fndata = { EpisodeID: $("#AllSelectedOffenderEpisodeResult").val(), ActiveTabIn: tab };
            LoadSelectedTab(url, fndata, "#viewPlaceHolder");
            return;
        }
        case "legaldocChecklist": {
            url = '@Url.Action("GetLegalDocument", "Client")';
            fndata = { EpisodeID: $("#AllSelectedOffenderEpisodeResult").val() };
            LoadSelectedTab(url, fndata, "#viewPlaceHolder");
            return;
        }
        case "evaluationmain": case "evaluationhis": {
            url = '@Url.Action("GetInitialEval", "Client")';
            fndata = { EpisodeID: $("#AllSelectedOffenderEpisodeResult").val(), ActiveTabIn: tab };
            LoadSelectedTab(url, fndata, "#viewPlaceHolder");
            return;
        }
        default: { return; }
    }
}
function postFormAndReplaceDivHtmlPats(formObj) {
    WaitDialog(1);
    var url = formObj.attr("action");
    var submission = formObj.serialize();
    var name = formObj.attr("name");
    $.ajax({
        type: 'POST',
        url: url,
        data: submission,
        cache: false,
        dataType: "Html",
        success: function (data, status, xhr) {
            //success: function (data, status, xhr) {
           // var eip = data.EpisodeID;
            if (name == "Case Management Re-entry Needs Assessment" || "Client Alert" ||
                        "PAROLEE MENTAL HEALTH SYSTEM PLACEMENT AND CHANGE" || "Address" ||
                        "PAROLEE MENTAL HEALTH SYSTEM REMOVAL" || "Client Profile")
                LoadSummary($("#AllSelectedOffenderEpisodeResult").val());
                   
            ReloadClientPage(name);
            WaitDialog(1);
            NotifyMessage(name + " successfully saved."); 
        },
        error: function (data, textStatus, xhr) {
            WaitDialog(0);
            NotifyMessage(name + " cannot be saved due to an error.");
            return false;
        }
    });
    WaitDialog(0);
    return false;
}
function postFormForNewProfile(formObj) {
    WaitDialog(1);
    var url = formObj.attr("action");
    var submission = formObj.serialize();
    var name = formObj.attr("name");
    $.ajax({
        type: 'POST',
        url: url,
        data: submission,
        cache: false,
        dataType: "json",
        success: function (data, status, xhr) {
            if (name == "Client Alert" || "PAROLEE MENTAL HEALTH SYSTEM REMOVAL" || "Client Profile")
                LoadSummary($("#AllSelectedOffenderEpisodeResult").val());
            WaitDialog(0);
            NotifyMessage(name + " successfully saved.");
            ReloadClientPage(name);
        },
        error: function (data, textStatus, xhr) {
            WaitDialog(0);
            NotifyMessage(name + " cannot be saved due to an error.");
            return false;
        }
    });
    WaitDialog(0);
    return false;
}
function WaitDialog(obj) {
   var model = document.getElementById('loading');
    if (model == null)
        return false;
    model.style.display = "block";
    model.style.backgroundColor = "#ffe087";
    if (obj == 1) {
        if ($('#loading').closest('.ui-dialog').is(':visible'))
            $("#loading").dialog('close');

        $("#loading").dialog({
            modal: true,
            resizeable: false,
            draggable: false,
            width: 250,
            height: 175,
        });
  
        $("#loading").siblings(".ui-dialog-titlebar").hide();
    }
    else $('#loading').dialog('close');
}
function NotifyMessage(obj) {
   var model = document.getElementById('patsdialog');
    if (model == null)
        return false;
    model.style.display = "block";
    model.style.backgroundColor = "#e1f4f2";
    WaitDialog(0);

    $("#patsdialog").dialog({
        modal: true,
        resizeable: false,
        draggable: false,
        width: 300,
        height: 100,
        open: function (event, ui) {
            setTimeout(function () {
                var model = document.getElementById('patsdialog');
                try {
                    if ($('#patsdialog').closest('.ui-dialog').is(':visible'))
                        $("#patsdialog").dialog('close');
                }
                catch (err) {
                    $("#patsdialog").dialog('destroy');
                   // $("#patsdialog").unload();
                }
                model.style.display = "none";
           }, 6000);
        }
    });

    if (obj == null || obj == undefined || obj == "")
        obj = "Nothing changed!";
    
    $("#patsdialog").siblings(".ui-dialog-titlebar").hide()
    $("#patsdialog").html("<div style='height:100px; width:300px;padding:10px;border-style:none;'><center>" + obj + "</center></div>").dialog();
}
function checkBoxChecked(e, obj) {
    if (e.originalEvent.target.checked) {
        var objId = e.originalEvent.target.id;
        $(obj).each(function () {
            if (this.id != objId) {
                $(this).prop('checked', false);
            }
        })
    }
}
function TimeOut(obj) {
    var model = document.getElementById('patsdialog');
    try {
        $("#patsdialog").dialog("close");
    }
    catch (err) {
        $("#patsdialog").unload();
    }

    model.style.display = "none";
}
function IgnoreEnterKey(e) {
    if (e.keyCode === 13) {
        e.preventDefault();
    }
    else if ((e.currentTarget.id === "Profile_ParoleAgent" || e.currentTarget.id === "txtLastName" ||
              e.currentTarget.id === "txtFirstName" || e.currentTarget.id === "Profile_MidName") && e.keyCode === 34) {
        e.preventDefault();
    }
    else if(e.currentTarget.id==="notebox" && e.keyCode ===  8){
        e.preventDefault();
    }
}
//Client
function EditableEpisode(obj) {
    var editable = false;
    var ddp = $("#AllSelectedOffenderEpisodeResult").data("kendoDropDownList");
    if (ddp === undefined)
        return editable;

    if (ddp.text().indexOf("*") > 0) {
        if (!($("#AllSelectedOffenderEpisodeResult").data("kendoDropDownList").text().indexOf("Closed") > 0) && obj == "True")
            editable = true;
    }
    return editable;
}

function DisableAllInputFields(formString, editable, closed) {
    var edit =  EditableEpisode(editable);
    if (closed != null && closed != undefined && !($("#AllSelectedOffenderEpisodeResult").data("kendoDropDownList").text().indexOf("Closed") > 0)) {
        edit = closed;
    }

    DisableInputFields(formString, edit)
}

function DisableInputFields(formString, edit) {
    $(formString).each(function () {
        if (this.className.indexOf("textarea") > -1) {
            if (this.className.indexOf("alwayReadonly") > -1)
                $(this).prop('readonly', true);
            else
                 $(this).prop('readonly', !edit);
        }
        else if (this.className.indexOf("kendoEditor") > -1) {
            $($("#" + (this.id)).data().kendoEditor.body).attr("contenteditable", edit);
        }
        else if (this.className.indexOf("alwayDisabled") > -1) {
            $(this).prop('disabled', true);
        }
        else if (this.className.indexOf("neverDisable") > -1) {
            $(this).prop('disabled', false);
        }
        else if (this.className.indexOf("k-textbox") > -1) {
            if (edit) {
                if ($(this).hasClass("k-state-disabled"))
                    $(this).prop("disabled", false).removeClass("k-state-disabled");
            }
            else {
                if (!$(this).hasClass("k-state-disabled"))
                    $(this).prop("disabled", false).addClass("k-state-disabled");
            }
        }
        else {
            if (!(formString == "#getClientProfileForm :input" && this.id == "date-picker-closure" && $("#AllSelectedOffenderEpisodeResult").data("kendoDropDownList").text().indexOf("Closed") > 0)) {
                if (this.id != "txtPID" && this.id != "txtCDCRNumber" && this.id != "bntmatch")
                    $(this).prop('disabled', !edit);
            }
        }
        //DisableAllLinks(formString, edit)
        $(".k-list-container").each(function () {
            var elementId = this.id.substring(0, this.id.length - 5)
            var tempDL = $("#" + elementId).data("kendoDropDownList");
            if (tempDL != undefined) {
                if (!tempDL._arrow.children()[0].hasAttribute("unselectable"))
                    tempDL._arrow.children().attr("unselectable", "on");
            }
        });
    });
    //var form = formString.substring(0, formString.indexOf(":input"));
    if (formString.indexOf("#getClientProfileForm") >= 0 || formString.indexOf("#idttform") >= 0) {
        $(".k-list-container").each(function () {
            var elementId = this.id.substring(0, this.id.length - 5)
            var tempDL = $("#" + elementId).data("kendoDropDownList");      
            if (tempDL != undefined) {
                if (tempDL.element[0].className == "neverDisable")
                    tempDL.enable(true);
                else if (tempDL.element[0].className == "alwayDisabled")
                    tempDL.enable(false);
                else
                    tempDL.enable(edit);
            }
        });
    }

    $(".k-calendar-container").each(function () {
        var elementId = this.id.split("_")[0];
        var tempDP = $("#" + elementId).data("kendoDatePicker");
        if (tempDP != undefined && formString.indexOf(tempDP.element[0].form.id) >= 0) {
            if (elementId == "date-picker-intake" && $("#AllSelectedOffenderEpisodeResult").data("kendoDropDownList").text().indexOf("*") > 0)
                tempDP.enable(true);
            else
                tempDP.enable(edit);
        }
    });

    if (!edit) {
        $(".appointmentLink").hide();
    }
    else {
        $(".appointmentLink").show();
        if (formString == "#getClientProfileForm :input") {
            CaseDatePickerChanges();
            ISMIPDatePickerChanges();
            CMDatePickerChanges();
            MATDatePickerChanges();
            CmrpeDatePickerChanges();
        }
    }
}
function DateTimeCompare(startDate, endDate) {
    if (new Date(endDate).valueOf() < new Date(startDate).valueOf()) {
        alert('Start/Open date must be before end/close date.');
        return false;
    }
    return true;
}
function remove_non_ascii(str) {

    if ((str === null) || (str === ''))
        return false;
    else
        str = str.toString();
    //str = str.replace(/^\s+|\s+$/g, '');
    str = str.replace(/[^\t\n\r\x20-\x7E]/g, '');
    return str;
}
function disableDates(date) {
    var date1 = new Date(date);
    if (date1 == undefined || date1 == null || date1 == "Invalid Date") {
        return false;
    }
    switch (date1.getDay()) {
        case 0:
        case 6: return true;
    }
    var dates = [
          new Date("1/1/2016"),
          new Date("1/19/2016"),
          new Date("2/16/2016"),
          new Date("5/25/2016"),
          new Date("7/3/2016"),
          new Date("9/7/2016"),
          new Date("11/11/2016"),
          new Date("11/26/2016"),
          new Date("11/27/2016"),
          new Date("12/25/2016"),
          new Date("1/1/2017"),
          new Date("1/16/2017"),
          new Date("5/29/2017"),
          new Date("7/4/2017"),
          new Date("9/4/2017"),
          new Date("11/11/2017"),
          new Date("11/23/2017"),
          new Date("11/24/2017"),
          new Date("12/25/2017"),
          new Date("1/1/2018"),
          new Date("1/15/2018"),
          new Date("2/19/2018"),
          new Date("5/28/2018"),
          new Date("7/4/2018"),
          new Date("9/3/2018"),
          new Date("11/12/2018"),
          new Date("11/22/2018"),
          new Date("11/23/2018"),
          new Date("12/25/2018"),
          new Date("1/1/2019"),
          new Date("1/21/2019"),
          new Date("2/18/2019"),
          new Date("5/27/2019"),
          new Date("7/4/2019"),
          new Date("9/2/2019"),
          new Date("11/11/2019"),
          new Date("11/28/2019"),
          new Date("11/29/2019"),
          new Date("12/25/2019"),
          new Date("1/1/2020"),
          new Date("1/20/2020"),
          new Date("2/17/2020"),
          new Date("3/31/2020"),
          new Date("5/25/2020"),
          new Date("7/4/2020"),
          new Date("9/7/2020"),
          new Date("11/11/2020"),
          new Date("11/26/2020"),
          new Date("11/27/2020"),
          new Date("12/25/2020"),
          new Date("1/1/2021"),
          new Date("1/18/2021"),
          new Date("2/15/2021"),
          new Date("3/31/2021"),
          new Date("5/30/2021"),
          new Date("7/5/2021"),
          new Date("9/6/2021"),
          new Date("11/11/2021"),
          new Date("11/25/2021"),
          new Date("11/26/2021"),
          new Date("12/25/2021"),
          new Date("1/1/2022"),
          new Date("1/17/2022"),
          new Date("2/21/2022"),
          new Date("3/31/2022"),
          new Date("5/30/2022"),
          new Date("7/4/2022"),
          new Date("9/5/2022"),
          new Date("11/11/2022"),
          new Date("11/24/2022"),
          new Date("11/25/2022"),
          new Date("12/25/2022"),
          new Date("12/26/2022"),
          new Date("1/1/2023")];

    if (date && compareApptDates(date, dates)) {
        return true;
    } else {
        return false;
    }
}
//date compareson
function compareApptDates(date, dates) {
    for (var i = 0; i < dates.length; i++) {
        if (dates[i].getDate() == date.getDate() &&
          dates[i].getMonth() == date.getMonth() &&
            dates[i].getYear() == date.getYear()) {
            return true
        }
    }
}
function CheckIsHoliday(e) {
    var date = e.date;
    if (e.action == "previous") {
        while (disableDates(date)) {
            date = new Date(date.setDate(date.getDate() - 1));
            CheckIsHoliday(e);
        }
    }
    else if (e.action == "next") {
        while (disableDates(date)) {
            date = new Date(date.setDate(date.getDate() + 1));
            CheckIsHoliday(e);
        }
    }
    else {
        if (disableDates(date)) {
            e.preventDefault()
            var scheduler = $("#OfficeTimeLine").data("kendoScheduler");
            var calendar = scheduler.calendar;
            scheduler.editable = false;
            return true;
        }
    }

    refreshScheduler(e);
}
function makestartsameasendday(e) {
    var startdate = new Date($("#startApptDate").val());
    if (disableDates(startdate)) {
        $("#startApptDate").val("");
        e.preventDefault();
        return;
    }
    var enddate = startdate;
}
//function makeendsameasstarttime(e) {
//    var starttime = new Date($("#startApptTime").val());
//    var endtime = new Date($("#endApptTime").val());
//    if (kendo.toString(starttime, 'hh:mm tt') !== kendo.toString(endtime, 'hh:mm tt')) {
//        var datePicker = $("#endApptTime").data('kendoTimePicker');
//        var NewDate = kendo.toString(this.value(), 'hh:mm tt');
//        datePicker.value(NewDate);
//        endtime = starttime;
//    }
//}
function ChangeSelectedTime(e) {
    if ($("#Availability").val() == "")
        return;

    var data = $("#Availability").data("kendoDropDownList").text().split('-');

    var b = toDate(data[0]);
    var c = toDate(data[1]);
    var startpicker = $("#startApptTime").data("kendoTimePicker");
    var endpicker = $("#endApptTime").data("kendoTimePicker");
    startpicker.value(b);
    endpicker.value(c);
}
function toDate(dStr) {
    var now = new Date($("#startApptDate").data("kendoDatePicker").value());

    var datePart = "0";
    if (dStr.slice(-2) == "PM")
        datePart = (parseInt(dStr.substr(0, dStr.indexOf(":"))) + 12).toString();
    else
        datePart = dStr.substr(0, dStr.indexOf(":"));
    now.setHours(datePart);
    now.setMinutes(dStr.substr(dStr.indexOf(":") + 1, 2));
    now.setSeconds(0);
    return now;
}
function RefreshList(e) {
    if (e.response == undefined)
        return;

    var multiselect = $("#SelectedStaffs").data('kendoMultiSelect');
    if (e.response.length > 0) {
        for (var i = 0; i < e.response.length; i++) {
            multiselect.dataSource.add(e.response[i]);
            var values = multiselect.value().slice();
            $.merge(values, [e.response[i].StaffId.toString()]);
            multiselect.value(values);
        }
    }
}
function OpenStatus(e) {
    e.preventDefault();
}
function TriggerPDF(e) {
    if ($('#gridScheduler').data('kendoGrid').dataSource.data().length > 0) {
        var staffID = $("#DarStaffIDs").val();
        var StartD = $("#apptdatepicker").val();
        printPATSPDF(staffID, StartD, "Staff Appointment List","");
    }
    else {
        alert("No Data");
        //e.preventDefault();      
    }
}
function TriggerClientPDF() {
    if ($('#gridClientScheduler').data('kendoGrid').dataSource.data().length > 0) {
        var EpisodeID = $("#hdEpisodeId").val();
        var StartD = $("#apptclientdatepicker").val();
        printPATSPDF(EpisodeID, StartD, "Parolee Appointment List", "");
    }
    else {
        alert("No Data");
        //e.preventDefault();      
    }
    //return true;
}
function GetRomanString(obj) {
    switch (obj) {
        case 1: return "I.";
        case 2: return "II.";
        case 3: return "III.";
        case 4: return "IV.";
        case 5: return "V.";
        case 6: return "VI.";
        case 7: return "VII.";
        case 8: return "VIII.";
        case 9: return "IX.";
        case 10: return "X.";
        case 11: return "XI.";
        case 12: return "XII.";
        case 13: return "XIII.";
    }
}
function printPATSPDF(EpisodeID, id, Title, Color) {
    var cls = "ui-dialog-button";
    if (Color != undefined && Color != "")
    {
        cls = cls + " " + Color;
    }
    else {
        cls = cls + " " + "color-default";
    }
    var btn = {"1": { id: 'close', text: 'Close', click: function () { $(this).dialog("close"); }, "class": "ui-dialog-button" } };
    // btn = {id: 'close', text: 'Close', click: function () { $(this).dialog("close"); }, "class": "ui-dialog-button" };
    var url = '/Client/PrintCaseNote?EpisodeId=' + EpisodeID + '&' + 'CaseNoteId=' + id;
    switch (Title) {
        case "Client Profile":
            {
                url = '/Client/PrintProfile?EpisodeId=' + EpisodeID;
                break;
            }
        case "Case Re-entry Initial MH Screening":
            {
                url = '/Client/PrintReEntry?EpisodeId=' + EpisodeID + '&' + 'CaseREIMHSID=' + id;
                break;
            }
        case "Multnomah Community Ability Scale":
            {
                url = '/Client/PrintMCASR?EpisodeId=' + EpisodeID + '&' + 'MCASRID=' + id;
                break;
            }
        case "Case Managemnent Individualized Re-entry Plan":
            {
                url = '/Client/PrintIRP?EpisodeId=' + EpisodeID + '&' + 'IRPID=' + id;
                break;
            }
            case "DSM-5 Self-Rated Level 1 Cross-Cutting Symptom Measure--Adult":
            {
                url = '/Client/PrintDSM5?EpisodeId=' + EpisodeID + '&' + 'DSM5ID=' + id;
                break;
            }
        case "Case Management Re-entry Needs Assessment":
            {
                url = '/Client/PrintNeedsAssessment?EpisodeId=' + EpisodeID + '&' + "AssessmentId=" + id;
                break;
            }
        case "Clinical IDTT Meeting": {
            url = '/Client/PrintClinicalIDTT?EpisodeID=' + EpisodeID + '&' + "IDTTId=" + id;
            break;
        }
        case "Clinical PMHS Entered": {
            url = '/Client/PrintPMH1?EpisodeId=' + EpisodeID;
            break;
        }
        case "Clinical PMHS Removed": {
            url = '/Client/PrintPMH2?EpisodeId=' + EpisodeID;
            break;
        }
        case "Appointment Note": {
            url = '/Appointment/PrintNotice?EventId=' + EpisodeID;
            break;
        }
        case "Client Evaluation": {
            url = '/Client/PrintEval?EpisodeId=' + EpisodeID + '&' + "EvaluationID=" + id;
            break;
        }
        case "Staff Appointment List": {
            url = '/Appointment/PrintStaffAppts?StaffID=' + EpisodeID + '&' + "StartDT=" + id;
            break;
        }
        case "Parolee Appointment List": {
            url = '/Appointment/PrintParoleeAppts?EpisodeID=' + EpisodeID + '&' + "StartDT=" + id;
            break;
        }
        case "Medication Management Asessment": {
            url = '/Client/PrintAMST?EpisodeId=' + EpisodeID + '&' + "SelectASMTID=" + id;
            break;
        }
    }
    var path = window.location.protocol + "//" + window.location.host + url;
    window.open(path, '_blank')
    
    //var object = "<object id='pdfbox' name='pdfbox' style='width: 100%; height: 100%; overflow: hidden' type='application/pdf' data=" + url + "></object>";

    //$("#pdfdialog").html(object)
    //    .dialog({
    //        modal: true,
    //        width: '80vw',
    //        height: ($(window).height() * 0.8),
    //        title: Title,
    //        dialogClass: cls,
    //        buttons: btn, 
    //    });
    //return url;
}

