<%@page import="com.dto.CartDTO"%>
<%@page import="com.dto.GoodsDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
/*  $("input[class=check]").each(function () { 
$(this).attr("checked",$("#allCheck").attr('checked'));   */
$(document).ready(function(){
	$("#allCheck").on("click",function(){
		var result = this.checked;
				$(".check").each(function(idx,data){
					this.checked=result;
				});
			}); 
	$(".delBtn").on("click",function(){
		var num = $(this).attr("data-xxx");
		location.href="CartDelServlet?num="+num;
		}); 
	$(".updateBtn").on("click",function(){ 
		var num = $(this).attr("data-xxx"); 
		var gAmount = $("#cartAmount"+num).val();
		var gPrice =$(this).attr("data-price");
		
		 console.log(num)
		  $.ajax({  
		       type:"get", 
		       url:"CartUpdateServlet", 
		       data:{ 
		          num:num,
		          gAmount:gAmount
		          }, 
		       dataType:"text", 
		       success:function(data,status,xhr){
		    	   var sum=gAmount*gPrice;
		          $("#sum"+num).text(gAmount*gPrice); 
		       }, 
		       error:function(xhr,status,error){ 
		       
		       } 
		    }); //end ajax
		});//end updateBtn
	//전체 cart 삭제
	$("#delAllCart").on("click",function(){
	var num = []
	$("input:checkbox[name='check']:checked").each(function(idx,ele){
		num[idx]=$(this).val();	
		});
		console.log(num);
		location.href="CartDelAllServlet?data="+num;
	});//end delAllCart2
	
	//전체 cart 삭제
	$("#delAllCart2").on("click",function(){
		$("form").attr("action","CartDelAllServlet2");
		$("form").submit(); //triger
	});//end delAllCart2
	
	//주문버튼
	$(".orderBtn").on("click",function(){
		var num = $(this).attr("data-xxx");
		location.href="CartOrderConfirmServlet?num="+num;
	}); 
	
	});
</script>
<table width="90%" cellspacing="0" cellpadding="0" border="0">

	<tr>
		<td height="30">
	</tr>

	<tr>
		<td colspan="5" class="td_default">&nbsp;&nbsp;&nbsp; <font
			size="5"><b>- 장바구니-</b></font> &nbsp;
		</td>
	</tr>

	<tr>
		<td height="15">
	</tr>

	<tr>
		<td colspan="10">
			<hr size="1" color="CCCCCC">
		</td>
	</tr>
	
	<tr>
		<td height="7">
	</tr>

	<tr>
		<td class="td_default" align="center">
		<input type="checkbox" name="allCheck" id="allCheck"> <strong>전체선택</strong></td>
		<td class="td_default" align="center"><strong>주문번호</strong></td>
		<td class="td_default" align="center" colspan="2"><strong>상품정보</strong></td>
		<td class="td_default" align="center"><strong>판매가</strong></td>
		<td class="td_default" align="center" colspan="2"><strong>수량</strong></td>
		<td class="td_default" align="center"><strong>합계</strong></td>
		<td></td>
	</tr>

	<tr>
		<td height="7">
	</tr>
	
	
	
	<tr>
		<td colspan="10">
			<hr size="1" color="CCCCCC">
		</td>
	</tr>


	<form name="myForm">	    
<%
   List<CartDTO> list = (List<CartDTO>)request.getAttribute("cartList");
	//System.out.println(list);
   for(int i=0 ; i<list.size();i++){
	CartDTO dto = list.get(i);//주문정보 1개 얻기 
	int num = dto.getNum();
	String userid = dto.getUserid();
	String gCode = dto.getgCode();
	String gName = dto.getgName();
	int gPrice = dto.getgPrice();
	String gSize = dto.getgSize();
	String gColor = dto.getgColor();
	int gAmount = dto.getgAmount();
	String gImage = dto.getgImage();
   
%>	    
	  		
		<tr>
			<td class="td_default" width="80">
			<!-- checkbox는 체크된 값만 서블릿으로 넘어간다. 따라서 value에 삭제할 num값을 설정한다. -->
			<input type="checkbox"
				name="check" id="check81" class="check" value="<%=num%>"></td> <!-- valued에 번호를 넣어준다 -->
			<td class="td_default" width="80"><%=num %></td>
			<td class="td_default" width="80"><img
				src="images/items/<%=gImage %>.gif" border="0" align="center"
				width="80" /></td>
			<td class="td_default" width="300" style='padding-left: 30px'>
			<%= gName %>
				<br> <font size="2" color="#665b5f">[옵션 : 사이즈(<%= gSize %>)
					, 색상(<%= gColor %>)]
			</font></td>
			<td class="td_default" align="center" width="110">
			<%= gPrice %>
			</td>
			<td class="td_default" align="center" width="90"><input
				class="input_default" type="text" name="cartAmount"
				id="cartAmount<%=num %>" style="text-align: right" maxlength="3"
				size="2" value=<%= gAmount %>></input></td>
			<td><input type="button" value="수정"
				class="updateBtn"
				data-xxx="<%=num %>" 
				data-price="<%=gPrice %>">
				<!-- data-xxx :이 조건은 사용자 임의의 속성(?)
	원래는 HTML에 없으나 사용자정의속성이라 해서 이 조건문을 jQuery에
	넣을 수 있음, 몇번인지, 업데이트할 때 쓸 번호 
	수정을 누르는 순간 num을가지고 DB에 찾아가서 gAmount(수량)
	jQuery로 num,price,gAmount찍어 볼 수 있게-->
				</td>
			<td class="td_default" align="center" width="80"
				style='padding-left: 5px'><span id="sum<%=num%>"> <!-- id sum이 달라진다 -->
				<%= gPrice*gAmount %>
				</span></td>
			<td><input type="button" value="주문" class="orderBtn"
				data-xxx="<%=num %>"></td> <!-- 장바구니의 번호를 얻어옴 -->
			<td class="td_default" align="center" width="30"
				style='padding-left: 10px'><input type="button" value="삭제"
				id="xx<%=i %>"
				class="delBtn" data-xxx="<%=num %>"></td>
			<td height="10"></td>
		</tr>

<%
   }//end for
%>

	</form>
	<tr>
		<td colspan="10">
			<hr size="1" color="CCCCCC">
		</td>
	</tr>
	<tr>
		<td height="30">
	</tr>

	<tr>
		<td align="center" colspan="5"><a class="a_black"
			href="javascript:orderAllConfirm(myForm)">  전체 주문하기 </a>&nbsp;&nbsp;&nbsp;&nbsp; 
			<a class="a_black" href="#" id="delAllCart"> 전체 삭제하기 </a>&nbsp;&nbsp;&nbsp;&nbsp; <!-- href는 위에 jQuery단에서 연결할것임 -->
			<a class="a_black" href="#" id="delAllCart2"> 전체 삭제하기2 </a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="a_black" href="main"> 계속 쇼핑하기 </a>&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td height="20">
	</tr>

</table>
    