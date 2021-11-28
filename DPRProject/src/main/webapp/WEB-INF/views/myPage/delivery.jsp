<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ֹ�/��� ���� : DAPARA</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/logo.png" >
</head>
<style>
#tekbeCompnayList, #invoiceNumberText {
    width: 500px;
    height: 30px;
    padding-left: 10px;
    font-size: 18px;
    color: #0000ff;
    border: 1px solid #006fff;
    border-radius: 3px;
}

#tekbeCompnayName, #invoiceNumber{
  color:black; 
  font-weight: bold; 
  margin-right: 20px;
  font-size: 18px;
}

#myButton1 {
  background: #6893b0;
  background-image: -webkit-linear-gradient(top, #6893b0, #2980b9);
  background-image: -moz-linear-gradient(top, #6893b0, #2980b9);
  background-image: -ms-linear-gradient(top, #6893b0, #2980b9);
  background-image: -o-linear-gradient(top, #6893b0, #2980b9);
  background-image: linear-gradient(to bottom, #6893b0, #2980b9);
  -webkit-border-radius: 0;
  -moz-border-radius: 0;
  border-radius: 0px;
  font-family: Arial;
  color: #ffffff;
  font-size: 20px;
  padding: 10px 10px 10px 10px;
  text-decoration: none;
}

#myButton1:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}

table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}

</style>
<script
  src="https://code.jquery.com/jquery-3.2.1.min.js"
  integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
  crossorigin="anonymous"></script>
  
<script>

$(document).ready(function(){
	var myKey = "JUI5lF7RHlbZHdNPCjhfYw"; // sweet tracker���� �߱޹��� �ڽ��� Ű �ִ´�.
	
		// �ù�� ��� ��ȸ company-api
        $.ajax({
            type:"GET",
            dataType : "json",
            url:"http://info.sweettracker.co.kr/api/v1/companylist?t_key="+myKey,
            success:function(data){
            		
            		// ��� 1. JSON.parse �̿��ϱ�
            		var parseData = JSON.parse(JSON.stringify(data));
             		console.log(parseData.Company); // ���� Json Array�� �����ϱ� ���� Array�� Company �Է�
            		
            		// ��� 2. Json���� ������ �����Ϳ� Array�� �ٷ� �����ϱ�
            		var CompanyArray = data.Company; // Json Array�� �����ϱ� ���� Array�� Company �Է�
            		console.log(CompanyArray); 
            		
            		var myData="";
            		$.each(CompanyArray,function(key,value) {
	            			myData += ('<option value='+value.Code+'>' +'key:'+key+', Code:'+value.Code+',Name:'+value.Name + '</option>');        				
            		});
            		$("#tekbeCompnayList").html(myData);
            }
        });

		// ��������� ������� tracking-api
        $("#myButton1").click(function() {
        	var t_code = $('#tekbeCompnayList option:selected').attr('value');
        	var t_invoice = $('#invoiceNumberText').val();
            $.ajax({
                type:"GET",
                dataType : "json",
                url:"http://info.sweettracker.co.kr/api/v1/trackingInfo?t_key="+myKey+"&t_code="+t_code+"&t_invoice="+t_invoice,
                success:function(data){
                	console.log(data);
                	var myInvoiceData = "";
                	if(data.status == false){
                		myInvoiceData += ('<p>'+data.msg+'<p>');
                	}else{
	            		myInvoiceData += ('<tr>');            	
	            		myInvoiceData += ('<th>'+"�����»��"+'</td>');     				
	            		myInvoiceData += ('<th>'+data.senderName+'</td>');     				
	            		myInvoiceData += ('</tr>');     
	            		myInvoiceData += ('<tr>');            	
	            		myInvoiceData += ('<th>'+"��ǰ����"+'</td>');     				
	            		myInvoiceData += ('<th>'+data.itemName+'</td>');     				
	            		myInvoiceData += ('</tr>');     
	            		myInvoiceData += ('<tr>');            	
	            		myInvoiceData += ('<th>'+"�����ȣ"+'</td>');     				
	            		myInvoiceData += ('<th>'+data.invoiceNo+'</td>');     				
	            		myInvoiceData += ('</tr>');     
	            		myInvoiceData += ('<tr>');            	
	            		myInvoiceData += ('<th>'+"�����ȣ"+'</td>');     				
	            		myInvoiceData += ('<th>'+data.receiverAddr+'</td>');     				
	            		myInvoiceData += ('</tr>');           	                		
                	}
        			
                	
                	$("#myPtag").html(myInvoiceData)
                	
                	var trackingDetails = data.trackingDetails;
                	
                	
            		var myTracking="";
            		var header ="";
            		header += ('<tr>');            	
            		header += ('<th>'+"�ð�"+'</th>');
            		header += ('<th>'+"���"+'</th>');
            		header += ('<th>'+"����"+'</th>');
            		header += ('<th>'+"��ȭ��ȣ"+'</th>');     				
        			header += ('</tr>');     
            		
            		$.each(trackingDetails,function(key,value) {
	            		myTracking += ('<tr>');            	
            			myTracking += ('<td>'+value.timeString+'</td>');
            			myTracking += ('<td>'+value.where+'</td>');
            			myTracking += ('<td>'+value.kind+'</td>');
            			myTracking += ('<td>'+value.telno+'</td>');     				
	            		myTracking += ('</tr>');        			            	
            		});
            		
            		$("#myPtag2").html(header+myTracking);
                	
                }
            });
        });
		
});




</script>
<body>
<form action="http://info.sweettracker.co.kr/tracking/5" method="post">
            <div class="form-group">
              <label for="t_key">3SlDxD7VoJflx2sI2jOO1Q</label>
              <input type="text" class="form-control" id="t_key" name="t_key" placeholder="�������� APIKEY">
            </div>
            <div class="form-group">
              <label for="t_code">04</label>
              <input type="text" class="form-control" name="t_code" id="t_code" placeholder="�ù�� �ڵ�">
            </div>
            <div class="form-group">
              <label for="t_invoice">557908993816 </label>
              <input type="text" class="form-control" name="t_invoice" id="t_invoice" placeholder="����� ��ȣ">
            </div>
            <button type="submit" class="btn btn-default">��ȸ�ϱ�</button>
        </form>
                    
</body>
</html>
