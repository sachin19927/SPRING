<%@include file="/WEB-INF/decorators/taglibs.jsp"%>
<script type="text/javascript" src="./resources/js/mfs100-9.0.2.6.js"></script>
<script type="text/javascript" src="./resources/layout_3/assets/js/plugins/tables/datatables/datatables.min.js"></script>
<%@ page import = "java.util.ResourceBundle" %>
<% ResourceBundle resource = ResourceBundle.getBundle("application");
  String message=resource.getString("application.billcorrection");
 %> 
<script>
 var des= {desc1:"<%= message %>"};
</script>

<script>

var fingerPrintValidated='';
$(window).load(function() {

	/* if(window.IsDuplicate())
	{
		alert("duplicate");
		window.top.close();
		
	} */
	if ('${designationID}'!='41' && '${designationID}'!='21') 
	{  
			$('#showBillC').show();
			if('${accessKey}' == 'TEST' || '${userName}' == 'rajesh')
			{
				$('#billC').show();
		        $('#netmeteringData').show();
		        $('#showBillC').hide();
			}
	} else if('${accessKey}' == 'LIVE')
	{
		$('#billC').show();
        $('#netmeteringData').show();
	}  
	
	var tabInfo = sessionStorage.getItem("key");
	if (tabInfo !== "Authorised" ){
	window.location.href = "./logoutpage";
	}
	});

		$(document).ready(function(){   
			
			
			var FPTime='${FPTime}';
			var FPstartTime='${difftime}';
		if(FPTime !='')
		{
			
			if(FPstartTime > 0)
			{
				fingerPrintValidated='validated';
			}
			else
			{
				fingerPrintValidated='notValidated';
			}
		}
			
			$('#billingScreens').show();
			$('#billingModule').addClass('active');
			var todayDate = new Date();
			$('.daterange-single123').daterangepicker({
				singleDatePicker : true,
				minDate: new Date(),
				maxDate: new Date(todayDate.getFullYear(), todayDate.getMonth()+1, 0),
				//maxDate: new Date(),
				locale : {
					format : 'DD/MM/YYYY'
				},
			}); 
			
				$('.daterange-single1235').daterangepicker({
					singleDatePicker : true,
					//maxDate: new Date(new Date().setMonth(todayDate)),
					minDate: new Date(),
					maxDate: new Date(),
					locale : {
						format : 'DD/MM/YYYY'
					},
				}); 
			
		
		}); 
</script>

<style>
.form-horizontal .form-group {
	margin-left: 0px !important;
	margin-right: 0px !important;
}

select {
	width: 100%;
	border: 1px solid #DDD;
	border-radius: 3px;
	height: 36px;
}

legend {
	text-transform: none;
	font-size: 16px;
	border-color: skyblue;
}

.datatable-header,.datatable-footer {
	padding: 8px 0px 0 0px;
}
</style>




<div class="panel panel-flat" hidden="true" id="billC">
	<div class="panel-body">

		
			<c:if test = "${not empty msg}"> 			        
		        <script>		        
		            var msg = "${msg}";
		            swal({
		                title: msg,
		                text: "",
		                confirmButtonColor: "#2196F3",
		            });
		            
		        </script>
		        <c:remove var="msg" scope="session" />
 </c:if>


		<!-- <form class="form-horizontal" action="#">-->
		<form action="" 
			 method="POST" id=""
			role="form" class="form-horizontal form-validate-jquery">
			<fieldset class="content-group">
				<legend class="text-bold"
					style="margin: auto; text-align: left; font-size: 18px;">Bill Correction</legend>
				<br>


				<div class="row">
				
				 
					<div class="col-md-3">
					   <div class="form-group">
							<label>Account No<font color="red">*</font></label>
								<div class="input-group">
									 <input id="accountno" name="accountno" class="form-control" placeholder="Account No" onchange="getAccountDetails();"
									type="text" ></input>
							</div>
						</div>
					</div>
                    <div class="col-md-3">
						<div class="form-group">
							<label>BillMonth</label>
							<input id="billmonth" name="billmonth" class="form-control"  onchange="getAccountDetails();"
									type="text" readonly="readonly"></input>
						</div>
					</div> 
					<div class="col-md-3">
						<div class="form-group">
							<label for=" SDOCode "> SDO Code <font color="red">*</font></label>
							<input id="sdocode" class="form-control"
								type="text"  placeholder="SDO Code" name="sdocode" value="${sdocode}" readonly="readonly">
						</div>
						
					</div>
					
					<div class="col-md-3">
						<div class="form-group">
							<label for=" SDOName "> SDO Name <font color="red">*</font></label>
							<input id="sdoname" class="form-control"
								type="text"  placeholder="SDO Name" name="sdoname" value="${sdoName}" readonly="readonly">
						</div>
					</div>
					
					<div class="col-md-3" hidden="true">
						<div class="form-group">
							<label>BILLING_CYCLE<font color="red">*</font></label> <input
								id="billing_cycle" class="form-control" type="text" 
								name="billing_cycle" value="${BILLING_CYCLE}"  readonly="readonly">
						</div>
					</div>
					 
					
				</div>
				
              
				<div class="row" >
					<div class="form-group"   >
					     
						<div class="col-md-3" >
						<div id="NRM">
						<label class="radio-inline" > <input type="radio"
							id="normal" name="radio-inline-left" class="styled"
							checked="checked" value="1" onclick="diableReadig(this);"><p style="color: blue;"  > Normal</p>
						</label>
						</div>
						</div>
						
						<div class="col-md-3" >
						<div id="DL">
						 <label class="radio-inline" > <input type="radio"
							id="drlock" name="radio-inline-left" class="styled"
							value="2" onclick="diableReadig(this);"> <p style="color: #b821f3;" >Door Lock</p>
						</label> 
						</div>
						</div>
						
						<div class="col-md-3" >
						<div id="MD">
						<label class="radio-inline"> <input type="radio"
							id="mtrdef" name="radio-inline-left" class="styled"
							value="3" onclick="diableReadig(this);"><p style="color:  #d35400;"> Meter Defective</p>
						</label> 
						</div>
						</div>
						
						<div class="col-md-3"  >
						<div id="DC">
						<label class="radio-inline"> <input type="radio"
							id="discon" name="radio-inline-left" class="styled"
							value="4" onclick="diableReadig(this);"> <p style="color: red;">DisConnected</p>
						</label>
						</div>
						</div>
						

					</div>
				</div>
				
			
			
			  <div class="row">
				
					<div class="col-md-3">
						<div class="form-group">
							<label>Tariff Code</label> <input id="tariffcode" type="text"
								class="form-control" placeholder="Tariff" readonly="readonly"></input>
						</div>
					</div>
					
				   <div class="col-md-3">
						<div class="form-group">
							<label>Bill Date<font color="red">*</font></label>
							<div class="input-group">
								<span class="input-group-addon"><i
									class="icon-calendar3"></i></span> <input id="billdate" 
									name="billdate" class="form-control daterange-single1235"  readonly="readonly" 
								 type="text"></input>
							</div>
						</div>
					</div> 
					
					
					<div class="col-md-3">
						<div class="form-group">
							<label>Due Date<font color="red">*</font></label>
								<div class="input-group">
								<span class="input-group-addon"><i
									class="icon-calendar3"></i></span>
									 <input id="duedate" name="duedate"  class="form-control daterange-single123" 
									type="text" autocomplete="off"></input>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="form-group">
							<label>Previous Reading.</label> <input id="prevrdng" type="text"
								class="form-control" placeholder="Previous Reading..." value="0" readonly="readonly"></input>
						</div>
					</div>
					
					


				</div>
			
			
			
			 <div class="row">
			 
			 		<div class="col-md-3">
						<div class="form-group">
							<label>Present Reading.</label> <input id="prsrdng" type="text"
								class="form-control" placeholder="Present Reading..." value="0" onchange="unitsConsumed(this.value)"></input>
						</div>
					</div>

					<div class="col-md-3">
						<div class="form-group">
							<label>Consumption.</label> <input id="consumption" type="text"
								class="form-control" placeholder="Consumption..." readonly="readonly"></input>
						</div>
					</div>



					<div class="col-md-3">
						<div class="form-group">
							<label>Arrears</label> <input id="arrears" type="text"
								class="form-control" placeholder="Arrears..." value="0"></input>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<label>Net Amount Due.</label> <input id="netdue" type="text"
								class="form-control" placeholder="Net Amount Due..." value="0"></input>
						</div>
					</div>
					<div class="col-md-3" hidden="true">
						<div class="form-group">
							<label>SYSDATEBILLMONTH</label> <input id="sysdatebillmonth" name="sysdatebillmonth" type="text"
								class="form-control"  value="${sysdatebillmonth}"></input>
						</div>
					</div>


				</div>

			
			  <div class="row">

				<div class="col-md-4">
					<div class="form-group">
						<label>Remarks1&nbsp;</label>
						<textarea class="form-control"  name="remarksStatus" id="remarksStatus" readonly="readonly"> </textarea>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label>Remarks&nbsp;<font color="red">*</font></label>
						<textarea placeholder="Enter your Remarks here"
							class="form-control" cols="1" rows="1" name="remarks"
							id="remarks" ></textarea>
					</div>
				</div>
				 <div class="col-md-4" id="reasonRemarksselect">
						<div class="form-group">
							<label>Reason for BillCorrection&nbsp;<font color="red">*</font></label>
							<select id="reasonbill" name="reasonbill" name="reasonbill" >
									<option value="">SELECT</option> 
									<option value="Arrears Wrong">Arrears Wrong</option> 
									<option value="Sundry not Adjusted">Sundry not Adjusted</option> 
									<option value="Abnormal Consumption">Abnormal Consumption</option> 
									<option value="Reading Entry Wrong">Reading Entry Wrong</option> 
									<option value="Provisional Amount Not Adjusted">Provisional Amount Not Adjusted</option> 
									<option value="Bill Not Generated By Spotbill">Bill Not Generated By Spotbill</option> 
									<option value="Wrong Ec">Wrong Ec</option> 
									<option value="Wrong Fc">Wrong Fc</option> 
							</select>
						</div>
					</div> 
				   <div class="col-md-4" hidden="true" id="dialovercaseId">
						<div class="form-group">
							<label>Reason for BillCorrection&nbsp;<font color="red">*</font></label>
							<input id="dialovercase" name="dialovercase" value="0" class="form-control" readonly="readonly"></input>
						</div>
					</div> 
					
					<div class="col-md-4" style="display: none;">
					<div class="form-group">
						<label>Solar Flag&nbsp;<font color="red">*</font></label>
						<input type="text" id="solarflag"  name="solarflag" value="0"/>
					</div>
				</div>
				<div class="col-md-4" style="display: none;">
					<div class="form-group">
						<label>indexed&nbsp;<font color="red">*</font></label>
						<input type="text" id="indexed"  name="indexed" value="0"/>
					</div>
				</div>
			</div>
                    <div class="row" id="consumerindexId">
					<div class="col-md-3">
					<div class="form-group">
					<label>Substation Name<font style="color: red;">*</font></label>
					<select class="select" name="substation_name" id="substation_name" onchange="getFeederListByFeederModify(this.value)">
					 <option value="">SELECT</option>
                     <c:forEach var="app" items="${mipsubstation}"> 
		             <option value="${app[0]}">${app[0]}-${app[1]}</option>
	                 </c:forEach> 
					</select>
					</div>
					</div>
					<div class="col-md-3">
					<label>Substation Code</label>
					<input type="text" name="substation_code" class="form-control" id="substation_code"  readonly="readonly"/>
					</div>
					<div class="col-md-3">
					<div class="form-group">
					<label>Feeder Name<font style="color: red;">*</font></label>
					<select class="select" name="feedername" id="feedername" onchange="getDTCListByFeederModify(this.value)">
					
					</select>
					</div>
					</div>
					<div class="col-md-3">
					<div class="form-group">
					<label>Feeder Code <font style="color: red;">*</font></label>
					<input type="text" name="feedercode" id="feedercode" class="form-control"  readonly="readonly"/>
					</div>
					</div>
					</div>
					
					<div class="row" id="dtcdivid">
					<div class="col-md-3">
					<div class="form-group">
					<label>DTC Name<font style="color: red;">*</font></label>
					<select class="select" name="dtcname" id="dtcname" onchange="getDTCDetails(this.value)">
					
					</select>
					</div>
					</div>
					<div class="col-md-3">
					<div class="form-group">
					<label>DTC Code<font style="color: red;">*</font></label>
					<input type="text" name="dtccode" id="dtccode"  class="form-control"  readonly="readonly"/>
					</div>
					</div>
					
					<div class="col-md-3">
					<div class="form-group">
					<label>Meter Type<font style="color: red;">*</font></label>
					<select class="select" name="mtrtype" id="mtrtype" >
					
					</select>
					</div>
					</div>
					</div>
					
					
				<div class="row">
					 <div class="col-md-3">
					     <div class="form-group">
						   <label>CCR No <font style="color: red;">*</font></label> 
						   <input id="ccrno" type="text" class="form-control" 
							   placeholder="CCR No..." value="0"></input>
					     </div>
					 </div>
					
					 <div class="col-md-3">
					     <div class="form-group">
						   <label>PageNo Entry<font style="color: red;">*</font></label> 
						   <input id="pagenoentry" type="text" class="form-control" 
							   placeholder="PageNo Entry..." value="0"></input>
					     </div>
					 </div>
					 
					 <div class="col-md-3">
						<div class="form-group">
							<label>CCR_Date<font color="red">*</font></label>
							<div class="input-group">
								<span class="input-group-addon"><i
									class="icon-calendar3"></i></span> <input id="ccrdate" 
									name="ccrdate" class="form-control daterange-single1235" 
								 type="text"></input>
							</div>
						</div>
					</div>	
				</div>
					
					
					
					
				<c:if test = "${userType ne 'Guest'}">
				<div class="row">
				
				
				<div class="text-center">
				  <c:if test = "${accessKey ne 'TEST' && userName ne 'rajesh'}">
				  <%--  <c:if test = "${accessKey ne 'TEST' }">  --%>
					<button type="button" class="btn btn-primary"
						onclick="return validateFP()" id="calculateId" >
						Generate
					</button>
					</c:if>
					<c:if test = "${userName eq 'rajesh' || accessKey eq 'TEST'}">
					<button type="button" class="btn btn-primary"
						onclick="return finalSubmit(1)" id="calculateId">
						Generate
					</button>
					</c:if>
					<button type="button" class="btn btn-success"
						onclick="return viewBill()" id="printBill">
						Print Bill
					</button>
					<button type="button" class="btn btn-primary"
						onclick="clearButtion();" id="clearButton">
						Clear
					</button>
                   <c:if test = "${userName eq 'rajesh'}">
					<button type="button" class="btn btn-primary" data-style="expand-right" data-spinner-size="20" data-toggle="modal" data-target="#modal_form_verticalbulk"
						 id="addOptionbulk" onclick="getMaxBillmonthForBulk()">
						<span class="ladda-label">Bulk Bill Generation</span>
					</button>
					</c:if>
				</div> </div>
					</c:if>

			</fieldset>
		</form>
		<br></br>

	
	</div>
</div>


<div id="loading" hidden="true" style="text-align: center;">
	<h3 id="loadingText">Loading..... Please wait.</h3>
	<img alt="image" src="./resources/images/loading.gif"
		style="width: 3%; height: 3%;">
</div>

<div class="col-lg-12" hidden="true" id="showBillC">
	<div class="row col-lg-12 panel panel-flat">
		<div class="panel-body" style="padding: 200px;">
			<center><h1 style="font-size: 45px;color: red;"><b>You are not authorized to access this module!!!</b></h1></center>
		</div>
	</div>
</div>
<div class="panel panel-flat" id="netmeteringData" hidden="true"  style="margin-top: -44px;">
				<div class="panel-body" style="margin-top: -3px; padding: 6px;"  style="overflow: scroll !important;">
				<form action="">
				 <legend class="text-bold" style="color: sienna;">Solar Reading Details</legend>
				<div class="table-responsive">
 				<table class="table datatable-basic table-bordered" id="dataPopTable">
 				<!-- <table class="standard-grid1 full-width content-scrollable" id="PeopleIndexTable"> -->
						<thead>
							<tr class="bg-blue-800">
								<th style="width: 10px;">K NO</th>
								<th style="width: 10px;">Account No</th>
								<th style="width: 10px;">current Reading</th>
								<th style="width: 10px;">Previous Reading</th>
								<th style="width: 10px;">MF</th>
								<th style="width: 10px;">Consumption</th>
								<th style="width: 10px;">Bill Month</th>
								<th style="width: 10px;">solarAdjAmt</th>
								<th style="width: 10px;">solarExcessAmt</th>
								<th style="width: 10px;">solar bill date</th>
								
							</tr>
						</thead >
						<tbody id=netMeteringBody>
							
						</tbody>
					</table>
					</div></form>
				</div></div>
				
				
				<div id="makeandmodel"  hidden="true">
    <label style="font-size:25px;">Make:</label> <label style="font-size:25px;"></label>
     <input type="text" id="tdMake" name="tdMake" >
    <label style="font-size:25px;">Model:</label> <label style="font-size:25px;"></label>
      <input type="text" id="tdModel" name="tdModel" >
	<label>Key:</label><input type="text" value="" id="txtKey" class="form-control" />
</div>	

<div id="modal_form_vertical" class="modal fade">
	<div class="modal-dialog">
				<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" align="center" text="bold">Finger Print
					Authentication</h4>
			</div>
			<div class="modal-body">

				<div>
					<p colspan="3" align="center"
						style="color: #428BCA; font-size: 20px; font-weight: bold;">
						MANTRA-MFS100</p>
				</div>

				<div>
					<p colspan="3" align="center" style="color: red; font-size: 14px;">
						Please check that your bowser is asking for enable script or not.
						If yes then enable it.
						<!--<br />-->
						If you are using Internet Explorer then it will ask for "Allow
						Blocked Content". <br /> First call may take some time, so wait
						after click any button
					</p>
				</div>


				<div class="row">
					<div class="col-md-12">
	        			<div class="row" align="center">
							<button type="button" id="btnCaptureAndMatch" class="btn btn-lg btn-primary" 
							onclick="return Match()">Capture and Match</button>
						</div>
						
						<div class="row"></br></div>
       
						  
					</div>

				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>
</div>	

<div id="modal_form_verticalbulk" class="modal fade" tabindex="-1" role="dialog" >
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-success">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h5 class="modal-title" id="myModalLabel">Bulk Bill Generation</h5>
							</div>

							<form action="#" >
								<div class="modal-body" >
										<div class="row">
								<div class="col-md-4">

									<label>BillMonth<font color="red"></font></label>
									<div>
											<input id="bulkbillmonth"
											name="bulkbillmonth" class="form-control" 
											 type="text" readonly="readonly" ></input>
									</div>
								</div>
								<div class="col-md-4">
									<label>SECURITY pwd<font style="color: red;">*</font></label>
							       <input id="password" name="password" type="password" autocomplete="off"
								class="form-control" placeholder="Please Enter pwd..."></input>
								</div>
                                <div class="col-md-4" style="margin-top: 26px;/*! max-width: 97px; */">
                                <button type="button" class="btn btn-primary" onclick="return bulkbillgeneration()">Generate</button>
                                </div>

							</div>
								
								</div>
							 
							</form>
						</div>
					</div>
				</div>	
<script>
function getMaxBillmonthForBulk()
{
	$.ajax({
		type:'POST',
		url:'./getMaxBillmonthForBulk',
		dataType:'text',
		async : false,
		success:function(response)
		{
			$("#bulkbillmonth").val(response);
		},
	});
			
}
function getFeederListByFeederModify(stationCode)
{
	$("#substation_code").val(stationCode);
	  $("#feedername").empty();
	$.ajax({
		type:'POST',
		url:'./getFeederCodeByStationCode',
		dataType:'json',
		data:{
			"stationCode" :stationCode,
		     },
		async : false,
		success:function(response)
		{
		 if(response !=null)
		 {
			  var html="<option value=>SELECT</option>";
			 for(var i=0;i<response.length;i++)
			 {
				 var data=response[i];
				 html+="<option value="+data[0]+">"+data[0]+"_"+data[1]+"</option>";
				 
			 }
			  $("#feedername").empty();
			 $("#feedername").html(html);  
		 }
		}
		});
}
function getDTCListByFeederModify(FeederCode)
{
	$("#feedercode").val(FeederCode);
	$("#dtcname").empty();
	var StationCode=$("#substation_name").val();

	$.ajax({
		type:'POST',
		url:'./getDTCListByFeederAndStation',
		dataType:'json',
		data:{
			   "FeederCode" :FeederCode,
			   "StationCode" :StationCode,
		     },
		async : false,
		success:function(response)
		{
		 if(response.length == 0)
		 {
			 $("#calculateId").hide();
		 }
		 if(response !=null)
		 {
			 var html="<option value=>SELECT</option>";
			 for(var i=0;i<response.length;i++)
			 {
				 var data=response[i];
				 html+="<option value="+data[0]+">"+data[1]+"_"+data[0]+"</option>";
			 }
			 $("#dtcname").empty();
			 $("#dtcname").html(html);  
		 }
		}
		});
}
function getDTCDetails(dtc_code)
{
	$("#dtccode").val(dtc_code);
	if(dtc_code!="null" || dtc_code!=null || dtc_code!="")
	{
	  $("#calculateId").show();
	}
}
function viewBill() 
{
	var accountNo = $('#accountno').val();
	var bill_month=$('#billmonth').val();
	var solarflag=$('#solarflag').val();
	if(solarflag == "YES" || solarflag !="0")
	 {
		 solarflag="0";
	 }else
	 {
		 solarflag="1";	 
	 }
	if(accountNo=="" || accountNo==""){
		alert("Account Number is Empty");
	}
	if(bill_month=="" || bill_month==""){
		alert("Bill Month is Empty");
	}
	window.open("./billPrintByAccountNo/download/"+accountNo+"/"+bill_month+"/"+solarflag);
}
 
	var bmonth="";
	var sdocode="${branchcode}";
 	
	function unitsConsumed(value)
	{
 		var prevrdng=$('#prevrdng').val();
 		var tariff=$('#tariffcode').val();
 		//$('#consumption').val(value-prevrdng);
 		var meterStatus = $("input:radio[name=radio-inline-left]:checked").val();
 		var Lreading_value_float=0;
 		var creading=value;
 		if(meterStatus=='1')
 		{
 			 if (parseFloat(prevrdng)>parseFloat(creading))
 			 {
 				 var flag=confirm("Present Reading is less than previous reading. Has Meter Rotated? ");
 				 if(flag)
 				 {
	 				var max_meter_reading = 1;
	 				var length = (parseInt(prevrdng)+"").length;
	 				for (var i = 0; i < length; i++) 
	 				{
	 					max_meter_reading =parseInt(max_meter_reading)*10;
	 				}
	 				Lreading_value_float += max_meter_reading;
	 				creading=parseFloat(creading)+parseFloat(Lreading_value_float);
	 				Lreading_value_float=parseFloat(creading-prevrdng).toFixed(2);
	 				if (Lreading_value_float > 1000) 
	 				{
	 					validate_reading1(Lreading_value_float,tariff,creading,prevrdng,"1");
	 					$("#reasonRemarksselect").hide();
	 					$("#dialovercaseId").show();
	 					$("#dialovercase").val("DIALOVERCASE");
	 				} else 
	 				{
	 					$('#consumption').val(parseFloat(creading-prevrdng).toFixed(2));
	 					$("#reasonRemarksselect").hide();
	 					$("#dialovercaseId").show();
	 					$("#dialovercase").val("DIALOVERCASE");
	 					return true;
	 				}
 				
 				 }else
 				 {
 					 $("#prsrdng").focus();
 					 $("#prsrdng").val("0");
 					 return false;
 				 }
 			
 	         }else
 	         {
 	        	    $('#consumption').val(parseFloat(creading-prevrdng).toFixed(2));
 	        	    $("#reasonRemarksselect").show();
					$("#dialovercaseId").hide();
					$("#dialovercase").val("0");
 	        	   /*Lreading_value_float=parseInt(creading)-parseInt(prevrdng);
 					 if (Lreading_value_float > (3 * Laverage_consumption_long)	|| Lreading_value_float > 20000) 
 					{
 						var flag=confirm("Reading abnormal.do you want to continue?1");
 						if(flag){
 						validate_reading1(Lreading_value_float,tariff,creading,prevrdng,"1",param);// on alert yes
 						abflag=1;
 						}else{
 							temp=1;
 							return false;
 						}
 			
 					}else if (Lreading_value_float > (Laverage_consumption_long)) 
 					{
 						var flag=confirm("Reading subnormal.do you want to continue?2");
 						if(flag){
 						validate_reading1(Lreading_value_float,tariff,creading,prevrdng,"2",param);// on alert yes
 						abflag=2;
 						}else{
 							temp=1;
 							return false;
 						}
 			
 					} else 
 					{
 						consumption=parseInt(creading)-parseInt(prevrdng);
 						return true;
 					} */
 		     } 
 		}
 		
 	}

   var radiomt="";
   
   function diableReadig(myradio) {
	
	var accountNo = $('#accountno').val();	
	var billmonth = $('#billmonth').val();
	if(billmonth.trim() == null || billmonth.trim() == "")
	{
		 alert("billMonth Is Wrong");
		 return false;
	}
    var currentValue = myradio.value;
	radiomtr = currentValue;
	if (currentValue != '1') {
		
		document.getElementById("prsrdng").disabled = true;
		
		$.ajax({

			type : "POST",
			url : "./customer/metermaster/"+accountNo+"/"+billmonth+"/"+sdocode,
			dataType : "json",
			async : false,
			cache : false,
			
			success : function(response) {

				var data = response;
				
				$('#prevrdng').val(data.prevrdng);
				$('#prsrdng').val(data.prevrdng);
				/* var consumption=(data.currdng==null?0:data.currdng)-(data.prevrdng==null?0:data.prevrdng); */
				$('#consumption').val(data.consumption);

			}
		});
	
	} else {
		document.getElementById("prsrdng").disabled = false;

	}

}
   
   function changeDate(id)
   {
  	
   	 var oldDate = $('#'+id).val();
   	 var dateValues = oldDate.split('/');
   	 var newDate = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2];
   	 
   	 $("#"+id).val(newDate); 
   	
   	}
var defectiveFlag="";
 function getAccountDetails() {
	 
	 defectiveFlag="";
	 bmonth="";
	var sysdatebillmonth=$("#sysdatebillmonth").val();
	var accountNo = $('#accountno').val();
	
	if (accountNo == null || accountNo == "") {
		alert("Please Enter Account No");
		document.forms[0].accountno.focus();
		return false;

	} else if (isNaN(accountNo)) {
		alert("Account no should Numeric");
		document.forms[0].accountno.focus();
		return false;

	} else if (accountNo.length < 8) {
		alert('Account no should Eight digit');
		document.forms[0].accountno.focus();
		return false;
	} else {

		$.ajax({

			type : "POST",
			url : "./getBillCorrectionAccountDetailsByAcNo",
			dataType : "json",
			async : false,
			cache : false,
			data : {
				'accountNo' : accountNo,
			},
			success : function(response) {
				var data = response;
                    
				if (data == null) {

					alert("Account No. is not Valid");
					return false;

				} else {
					
					var billmonth=data.billmonth+"";
					//alert("sysdatebillmonth "+sysdatebillmonth);
					//alert("billmonth "+billmonth);
					if(billmonth == null || billmonth.length<6)
					{
						 alert("billMonth Is Wrong");
						 return false;
					}else if(parseInt(billmonth)<parseInt(sysdatebillmonth))
					{
						 alert("For Selected Accno Current or Previous Month Data Not Avaiable");
						 $('#accountno').val("");
						 return false;
					} 
					
					
					
					$.ajax({

						type : "POST",
						url : "./getMeterStatus",
						dataType : "text",
						async : false,
						cache : false,
						data : {
							'accountNo' : accountNo,
							'billmonth' : billmonth,
						},
						success : function(response)
						{
							if(response.trim() =='0')
							{
							alert("Current Month MeterData Does Not Exits");
							$('#accountno').val("");
							return false;
							}
							if(response.trim()=="D")
							{
								$('#NRM').hide();  
								$('#DL').hide();  
								$('#DC').hide(); 
								$("#prsrdng").attr("readonly", "readonly");
								defectiveFlag="D";
							}
						}
					});
					if ($('#accountno').val() == null || $('#accountno').val() == "") {}
					
					else
					{
						alert("Account No. is Valid.You can do the Bill Correction");
					      
					}
					document.getElementById("accountno").readOnly = true;
					bmonth=data.billmonth;
					
					var billing_cycle =$("#billing_cycle").val();
					 if(billing_cycle == '2')
					 { 
						 var bmyear=billmonth.substr(0,4);
						 var bmmonth=billmonth.substr(4,billmonth.length);
						 //var billtodayDate = new Date(moment(bmyear+"-"+bmmonth+"-01").format("YYYY-MM-DD")).getMonth();
						 //var duetodayDate = new Date(moment(bmyear+"-"+bmmonth+"-01").format("YYYY-MM-DD"));
						 var billtodayDate = new Date().getMonth();
						 var duetodayDate = new Date();
						 var maxbilldate="";
						 var minbilldate="";
						 var maxduedate="";
						 var minduedate="";
						 var accseries=accountNo.substr(0,1);
						
						    minbilldate=new Date(duetodayDate.getFullYear(), duetodayDate.getMonth(), 1);
							maxbilldate= new Date();
							if(accseries == '0')
							{
								minduedate=new Date();
						    	maxduedate=new Date(duetodayDate.getFullYear(), duetodayDate.getMonth()+1, 0);
						    }else
						    {
								minduedate=new Date(new Date().setMonth(billtodayDate));
						    	maxduedate=new Date(new Date().setMonth(billtodayDate+1));
						    }
						 $("#billdate").attr("readonly",false);
						 
						 $('.daterange-single1235').daterangepicker({
								singleDatePicker : true,
								minDate: minbilldate,
								maxDate: maxbilldate,
								//maxDate: new Date(),
								locale : {
									format : 'DD/MM/YYYY'
								},
							});
						 
						 $('.daterange-single123').daterangepicker({
								singleDatePicker : true,
								minDate: minduedate,
								maxDate: maxduedate,
								//maxDate: new Date(),
								locale : {
									format : 'DD/MM/YYYY'
								},
							}); 
						 
					 }
					
					var arrears=data.boarddues +data.eddues +data.wccdues + data.ucdues;
					var netdue=data.netboard +data.neted +data.netwcc + data.netuc;
					$('#billmonth').val(data.billmonth);
					if(data.billissuedate == "null" || data.billissuedate == "" || data.billissuedate == null)
					{
						$('#reasonbill').val("Bill Not Generated By Spotbill");
						$('#reasonbill').attr("disabled", true); 
					}
					
					$('#arrears').val(parseFloat(arrears).toFixed(2));
					
					$('#netdue').val(parseFloat(netdue).toFixed(2));
					
					
					$('#ccrno').val(data.hcxbd);
					$('#pagenoentry').val(data.hpxbd);
					
				}

			}
		});
		
		var mtrphase=0;
		
		$.ajax({

			type : "POST",
			url : "./customer/metermaster/"+accountNo+"/"+bmonth+"/"+sdocode,
			dataType : "json",
			async : false,
			cache : false,
			
			success : function(response) 
			{
				var data = response;
				
				$('#prevrdng').val(data.prevrdng);
				$('#prsrdng').val(data.currdng);
				$('#remarksStatus').val(data.remarks);
				var consumption=(data.currdng==null?0:data.currdng)-(data.prevrdng==null?0:data.prevrdng);
				$('#consumption').val(consumption);
				mtrphase=data.phase;
				//alert(consumption +"currdng "+data.currdng);

			}
		});
		
		var solarmflag=0;
		
		$.ajax({
			type : "GET",
			url : "./customer/consumermaster/"+accountNo+"/"+sdocode,
			dataType : "json",
			cache : false,
			async : false,
			success : function(response)
			{	
				
					var data = response;
			    	
			    	$('#tariffcode').val(data.tariffCode);
			    	solarmflag=data.solar;
			    	if(data.indexed == "1")
					{
					    $('#indexed').val(data.indexed);
						$("#consumerindexId").hide();
						$("#dtcdivid").hide();
					}
			}
		});
		
		$.ajax({
			type : "GET",
			url : "./solar/netmeteringDetails?accountNo="+accountNo+"&billmonth="+bmonth,
			dataType : "json",
			cache : false,
			async : false,
			success : function(response)
			{	
				
				if(response.length>0)
			    {
					$("#solarflag").val("YES");
					
		    		var html1; 
		    		for(var k=0;k<response.length;k++) 
		    		{
		    		  if(parseInt(bmonth) == parseInt(response[k].billmonth))	
		    		 { 
		    			  var mf=parseInt(response[k].ctrn)/parseInt(response[k].ctrd);
		    			  var billdate=moment(response[k].s_effected_date).format("DD/MM/YYYY");
		    		 html1+='<tr style="text-align: center;">'+
				    	'<td>'+response[k].kno+'</td>'+
				    	'<td>'+response[k].accno+'</td>'+
				    	'<td>'+response[k].export_currdng+'</td>'+
				    	'<td>'+response[k].export_prevrdng+'</td>'+
				    	'<td>'+response[k].export_mf+'</td>'+
				    	'<td>'+response[k].export_consumption+'</td>'+
				    	'<td>'+response[k].billmonth+'</td>'+
				    	'<td>'+response[k].adjamt+'</td>'+
				    	'<td>'+response[k].solar_excess_amt+'</td>'+
				    	'<td>'+billdate+'</td>'+
						'</tr>';
                          if(response[k].typeofmeter == '1')
                          {
                              if(!(billdate == 'Invalid date' || billdate == null))
                              {
                            	  $('#billdate').val(billdate);
                            	  $("#billdate").attr("disabled",true);
                              }
                        	  
                          }  
		    		 
		    		 }
		    		}
		    		
		    		 $("#netMeteringBody").append(html1);
			    	 loadSearchFilter1('dataPopTable',html1,'netMeteringBody');
			    }
			}
		});
		
		if(($('#indexed').val() == '1' && $("#solarflag").val()=='YES') || $("#solarflag").val()!='YES')
		{
			$("#consumerindexId").hide();
			$("#dtcdivid").hide();
			
		}
		if(($("#solarflag").val()=='YES' || solarmflag == '1') && $('#indexed').val() == '0')
		{
			$("#consumerindexId").show();
			$("#dtcdivid").show();
			displaymeterTypes(mtrphase,$('#tariffcode').val());
		}
	}

}
 function displaymeterTypes(mtrphase,tariff)
 {
 	$("#mtrtype").empty();
 	var tariffcode=tariff.substr(0,4);
 	var html='<option value="">SELECT</option>'
 	if(mtrphase == '1')
 	{
 		html+='<option value="1">Mechanical Meter</option>'+
 		      '<option value="2">Electromechanical Meter</option>'+
 		      '<option value="3">Static Meter</option>'+
 			  '<option value="4">Prepaid Meter</option>'+
 			  '<option value="5">Meter with Optical Port</option>'+
 			  '<option value="6">Meter with IR Port</option>'+
 			  '<option value="7">Meter with Optical Port and LPR Port</option>';
 		
 	}else if(mtrphase == '3')
 	{
 		html+='<option value="1">Mechanical Meter</option>'+
 	      '<option value="2">Electromechanical Meter</option>'+
 	      '<option value="3">Static Meterr</option>'+
 		  '<option value="4">Prepaid Meter</option>'+
 		  '<option value="5">Meter with Optical Port</option>'+
 		  '<option value="6">Meter with Optical Port and LPR Port</option>'+
 		  '<option value="7">Meter with Box and Optical Port and RS232 Port</option>';
 	}else if(tariffcode == '4100')
 	{
 		html+='<option value="1">Flat Rate</option>';
 	}
 	$("#mtrtype").html(html);
 }
 function loadSearchFilter1(param,tableData,temp)
 {
     $('#'+param).dataTable().fnClearTable();
     $('#'+param).dataTable().fnDestroy();
     $('#'+temp).html(tableData);
     $('#'+param).dataTable();

 }  
 var flagFP = 0;
 function validateFP()
 {
	 flagFP = 0;
	 if(fingerPrintValidated=='validated')
	 {
		 flagFP=1;
		 finalSubmit(0);
	 }
	 else{
   $.ajax({
 		 type:"POST",
 	     url:"./users/getUserFingerPrintOfLoginUser",
 		 dataType:"text",
 		 success:function(response){
 			 if(response!==null && response!=="")
 			 {
 				 var result = GetInfo();
 	             if(result==="success")
 	             {
 				    isotemplateFromDB = response;
 				    $('#modal_form_vertical').modal('show');
 	             }
 	             else
 	             {
 	            	 $('#modal_form_vertical').modal('hide');
 	         	     alert("Finger Print Device Not Connected");
 	         	     return false;
 	             } 
 			 }
 			 else
 		     {
 				$('#modal_form_vertical').modal('hide');
 				alert("User Not Registered Finger Print"); 
 				return false;
 			 }
 		 }
     });
	 }
 }
 
 var quality = 60; //(1 to 100) (recommanded minimum 55)
 var timeout = 10; // seconds (minimum=10(recommanded), maximum=60, unlimited=0 )


 var isotemplateFromDB = "";	
 
 function GetInfo() {
		
	 document.getElementById("tdMake").innerHTML = "";
	 document.getElementById("tdModel").innerHTML = ""; 

	var key = document.getElementById("txtKey").value;
	var res;
	if (key.length == 0) {
		res = GetMFS100Info();
	} else {
		res = GetMFS100KeyInfo(key);
	}
	if (res.httpStaus) {
		//     document.getElementById("txtStatus").value = "ErrorCode: " + res.data.ErrorCode + " ErrorDescription: " + res.data.ErrorDescription;
		if (res.data.ErrorCode == "0") {
			document.getElementById("tdMake").innerHTML = res.data.DeviceInfo.Make;
			document.getElementById("tdModel").innerHTML = res.data.DeviceInfo.Model;
			return "success";
		}
		
	} else {
		return "failure";
	}
	
}
	 
	 function Match()
	 {
		 flagFP = 0;
	 	 try {
	 		   // document.getElementById("imgFinger").src = "data:image/bmp;base64,";
	 	       // var isotemplate = document.getElementById('txtIsoTemplate').value;
	 	        var res = MatchFinger(quality, timeout, isotemplateFromDB);

	 	        if (res.httpStaus) 
	 	        {
	 	             if (res.data.Status)
	 	             {
	 	                alert("Finger matched");
	 	               $.ajax({
	 	     	 		 type:"POST",
	 	     	 	     url:"./setStartTime",
	 	     	 		 dataType:"text",
	 	     	 		 success:function(response)
	 	     	 		 {
	 	     	 		 }
	 	               });
	 	               
	 	                $('#modal_form_vertical').modal('hide');
	 	               flagFP = 1;
	 	              finalSubmit(0);
	 	             }
	 	             else 
	 	             {
	 	                if (res.data.ErrorCode != "0") 
	 	                {
	 	                   alert(res.data.ErrorDescription);
	 	                   return false;
	 	                }
	 	                else 
	 	                {
	 	                   alert("Finger not matched");
	 	                   return false;
	 	                }
	 	             }
	 	       }
	 	       else
	 	       {
	 	          alert(res.err);
	 	          return false;
	 	       }
	 	    }
	 	    catch (e) 
	 	    {
	 	       alert(e);
	 	    }
	 	 return false;
	 } 
	function bulkbillgeneration()
	{
		var billmonth = $('#bulkbillmonth').val();
		var password = $('#password').val();
		if(billmonth=="" || billmonth == "0")
		{
			  alert("Bill month is Required.");
			  return false;	
		}
		if(password == "")
		{
		  alert("please enter valid password .");
		  return false;
		}
		var agree = confirm("Are You Sure To Generate");
		
		if (agree) {
			
			$("#loading").show();
			
			$.ajax({

				type : "POST",
				url : "./bulkBillCorrection",
				dataType : "text",
				async : false,
				cache : false,
				data : {
					'billmonth' : billmonth,
					 'password':password,
					 'flag':'0',
				},
				success : function(response)
				{
					   $("#modal_form_verticalbulk").modal('hide');
						alert(response);
						window.location.reload();
				}
			});
	    }
		
		else {
			return false;
		}

	$("#loading").hide();
	
}
	function finalSubmit(param)
	{
		
		if('${accessKey}' == 'TEST')
		{
			
		}else
		{	
			if(flagFP === 0 && param == 0)
			{
	            alert("Finger Print Not Matched");
				return false;
			}
		}
		
		var meterStatus = $("input:radio[name=radio-inline-left]:checked").val();
		
		if(defectiveFlag ==='D' && meterStatus ==='1')
		{
		  alert("Check radio Button");
		  return false;
			
		}
		
		
		
		var accountNo = $('#accountno').val();
		var billmonth = $('#billmonth').val();
		var billdate   = $('#billdate').val();
		var duedate   = $('#duedate').val();
		var remarks   = $('#remarks').val();
		var reasonbill   = $('#reasonbill').val();
		var dialovercase   = $('#dialovercase').val();
		if(dialovercase!="0")
		{
			reasonbill=dialovercase;
		}
		
		if(reasonbill == "")
		{
		   alert("Please Select Reason For BillCorrection");
		   return false;
		}
		
		var prevrdng= $('#prevrdng').val();
		var prsrdng= $('#prsrdng').val();
		var cons=$('#consumption').val();
		var substationcode=$('#substation_name').val();
		var feedercode=$('#feedername').val();
		var dtc_code=$('#dtcname').val();
		var indexed=$('#indexed').val();
		var mtrtype=$('#mtrtype').val();
		var ccrno=$('#ccrno').val();
		var pagenoentry=$('#pagenoentry').val();
		var ccrdate=$('#ccrdate').val();
		
		var solarflag=$('#solarflag').val();
		if(solarflag == "YES")
		{
			 if((substationcode == "null" || substationcode == null || substationcode == "") && indexed == '0')
			{
			    alert("Substation Code is Null or Please Select Substation");
			    return false;
			}else if((feedercode == "null" || feedercode == null || feedercode == "") && indexed == '0')
			{
			    alert("Feeder Code is Null or Please Select Feeder");
			    return false;
			}else if((dtc_code == "null" || dtc_code == null || dtc_code == "") && indexed == '0')
			{
			    alert("DTC Code is Null or Please Select DTC");
			    return false;
			}else if((mtrtype == "null" || mtrtype == null || mtrtype == "") && indexed == '0')
			{
			    alert("Meter Type is Required");
			    return false;
			}
		}
		 /* if(meterStatus ==='1')
		{
           if(parseInt(prevrdng) == parseInt(prsrdng))
            {
        	  if(confirm("Present & Previous Reading Should Not be Same For Narmal .are you sure want to Continue"))
        		 {
        		  
        		 }else{
     		  return false;
        			 
        		 }
            }
		} */
        
		if(cons<0)
		{
      	  alert("Consumption Is Negative");
   		  return false;
		}
		if (accountNo == null || accountNo == "") 
		{
			alert("Please Enter Account No");
			document.forms[0].accountno.focus();
			return false;

		} if (isNaN(accountNo)) 
		{
			alert("Account no should be Number");
			document.forms[0].accountno.focus();
			return false;

		} if (accountNo.length < 8) 
		{
			alert('Account no should be Eight digits');
			document.forms[0].accountno.focus();
			return false;
		}
		
		
		if(prsrdng=='')
		{
			alert('Please Enter Present Reading');
    		return false;
		}
		 if(isNaN(prsrdng))
		{
			alert('Please Enter Valid Reading');
    		return false;
		}
		
		 if(meterStatus == 1)
    	{
	    	if(prsrdng <= 0)
	    	{
	    		alert('Present Reading should be greater than Zero');
	    		return false;
	    	}
    	} if(duedate=='')
    	{
			alert('Due Date is Empty');
    		return false;
		}
		
    	var d1=billdate.split("/");
    	var d2=duedate.split("/");

    	var date1 = new Date(d1[1]+"/"+d1[0]+"/"+d1[2]);
    	var date2 = new Date(d2[1]+"/"+d2[0]+"/"+d2[2]);
    	if (Date.parse(date1)==Date.parse(date2)) 
        {
    	    alert("Due Date & Bill Date Should not be Same");
	    	return false;

    	} 
    	if (Date.parse(date2)<=Date.parse(date1)) 
    	{
		    alert("Due Date  Should  be Greater then Bill Date");
	    	return false;

	    }
    	if(remarks==null || remarks=='')
    	{
    		alert("Please Enter Remarks");
	    	return false;
    	}

    	if(parseFloat(cons)>25000)
        {
           if(confirm("Consumption is Abnormal.Do You Want Continue!"))
           {
               //return true; 
           }else
           {
               return false;
           }
            
        }
    	
    	if(ccrno=='')
    	{
    		alert("Please Enter CcrNo");
	    	return false;
    	}
    	if(pagenoentry=='')
    	{
    		alert("Please Enter PageNo Entry");
	    	return false;
    	}
    	if(ccrdate=='' || ccrdate==null)
    	{
			alert("CCR Date is Empty");
    		return false;
		}	
    	
    	
			var agree = confirm("Are You Sure To Generate");
			
			if (agree) {
				
				$("#loading").show();
				
				$.ajax({

					type : "POST",
					url : "./doBillCorrection",
					dataType : "text",
					async : false,
					cache : false,
					data : {
						'accountNo' : accountNo,
						'billmonth' : billmonth,
						'meterStatus' : meterStatus,
						'prevrdng' : prevrdng,
						'prsrdng' : prsrdng,
						'remarks' : remarks,
						'duedate' : duedate,
						'reasonbill':reasonbill,
						'billdate':billdate,
						'substationcode':substationcode,
						'feedercode':feedercode,
						'dtc_code':dtc_code,
						'indexed':indexed,
						'mtrtype':mtrtype,
						'ccrno':ccrno,
						'pagenoentry':pagenoentry,
						'ccrdate':ccrdate,
					},
					success : function(response) {

						if(response ==='1')
						{
							alert("Bill is Corrected");
							viewBill();
							window.location.reload();
						}
						else
						{
							if(response=='logout')
							{
								alert("Session has Expired Please Do Logout and Login");
								window.location.href="./login";
							}else
							{
								alert(response);
							}
						  
						}
						
					}
				});
		    }
			
			else {
				return false;
			}

		$("#loading").hide();
	}
	function clearButtion() {

		window.location.href = "./billCorrection";
	}
	
	 function description(){
//			$("#maincontent").html('The period for which the bill is issued is corrected as requested by consumer.');
			//$("#stackmainheader").modal("toggle");
			 $("#contentset").attr('title', des['desc1']);
			//document.getElementById('pageDescription').style.visibility="visible";
		}
	 
 function validate_reading1(Lreading_value_float,tariff,creading,preading,pflag)
 {

 	var tpr =Lreading_value_float;
 	if (tpr <Lreading_value_float)
 	{
 		Lreading_value_float = tpr + 1;
 	}else
 	{
 		Lreading_value_float = tpr;
 	}
 	if (tpr > 10000) 
 	{
 		if (tariff.substr(0,1)=="1") 
 		{
 			var flag=confirm("Reading abnormal.do you want to continue?2");
 			if(flag)
 			{
 				consumption=parseFloat(creading)-parseFloat(preading);
 				$('#consumption').val(parseFloat(consumption).toFixed(2));
 				return true;
 			}else
 			{
 				$("#prsrdng").focus();
 				$("#prsrdng").val("0");
 				return false;
 			}
 		} else if ((tariff.substr(0,1)=="2") && tpr > 20000) 
 		{
 			var flag=confirm("Reading abnormal.do you want to continue?");
 			if(flag)
 			{
 				consumption=parseFloat(creading)-parseFloat(preading);
 				$('#consumption').val(parseFloat(consumption).toFixed(2));
 				return true;
 			}else
 			{
 				$("#prsrdng").focus();
 				$("#prsrdng").val("0");
 				return false;
 			}
 			

 		} else if ((tariff.substr(0,1)=="3") && tpr > 20000)
 		{
 			var flag=confirm("Reading abnormal.do you want to continue?");
 			if(flag)
 			{
 				consumption=parseFloat(creading)-parseFloat(preading);
 				$('#consumption').val(parseFloat(consumption).toFixed(2));
 				return true;
 			}else
 			{
 				$("#prsrdng").focus();
 				$("#prsrdng").val("0");
 				return false;
 			}

 		} else 
 		{
 			consumption=parseFloat(creading)-parseFloat(preading);
			$('#consumption').val(parseFloat(consumption).toFixed(2));
 			return true;
 		}

 	} else if (tpr > 30000) 
 	{

 		if ((tariff.substr(0,1)=="4") || (tariff.substr(0,1)=="5")|| 
 				(tariff.substr(0,1)=="6") || (tariff.substr(0,1)=="7") ) 
 		{
 			var flag=confirm("Reading abnormal.do you want to continue?");
 			if(flag)
 			{
 				consumption=parseFloat(creading)-parseFloat(preading);
 				$('#consumption').val(parseFloat(consumption).toFixed(2));
 				return true;
 			}else
 			{
 				$("#prsrdng").focus();
 				$("#prsrdng").val("0");
 				return false;
 			}

 		} else 
 		{
 			consumption=parseFloat(creading)-parseFloat(preading);
			$('#consumption').val(parseFloat(consumption).toFixed(2));
 			return true;
 		}

 	} else if (tpr > 50000) 
 	{

 		var flag=confirm("Reading abnormal.do you want to continue?");
 		if(flag)
 		{
 			consumption=parseFloat(creading)-parseFloat(preading);
			$('#consumption').val(parseFloat(consumption).toFixed(2));
 			return true;
 		}else
 		{
 			$("#prsrdng").focus();
 			$("#prsrdng").val("0");
 			return false;
 		}
 	} else 
 	{
 		consumption=parseFloat(creading)-parseFloat(preading);
		$('#consumption').val(parseFloat(consumption).toFixed(2));
 		return true;		
 	}
 } 
</script>

<style>
.dataTables_filter {
    display: none;
    float: left;
    margin: 0 0 20px 20px;
    position: relative;
}
.dataTables_length {
    display: none;
    
}
</style>