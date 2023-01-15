<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="ja_JP" />
<%!
    private static Map eventMap = new HashMap();
  static {
    eventMap.put("20190101", "お正月");
    eventMap.put("20191225", "クリスマス");
    eventMap.put("20191231", "大晦日");
    eventMap.put("20200101", "お正月");
    eventMap.put("20200223", "天皇誕生日");
    eventMap.put("20200401", "エイプリルフール");
    eventMap.put("20200429", "昭和の日");
    eventMap.put("20200503", "憲法記念日");
    eventMap.put("20200504", "みどりの日");
    eventMap.put("20200505", "こどもの日");
    eventMap.put("20200707", "七夕");
    eventMap.put("20201225", "クリスマス");
    eventMap.put("20201231", "大晦日");
    eventMap.put("20210101", "お正月");
    eventMap.put("20210223", "天皇誕生日");
    eventMap.put("20210401", "エイプリルフール");
    eventMap.put("20210503", "憲法記念日");
    eventMap.put("20210504", "みどりの日");
    eventMap.put("20210505", "こどもの日");
    eventMap.put("20210707", "七夕");
  }
%>
<%
  // リクエストのパラメーターから日付を取り出す
  String year = (String)request.getParameter("year");
  String month = (String)request.getParameter("month");
  String day = (String)request.getParameter("day");
  LocalDate localDate = null;
  if (year == null || month == null || day == null) {
    // 日付が送信されていないので、現在時刻を元に日付の設定を行う
    localDate = LocalDate.now();
    year = String.valueOf(localDate.getYear());
    month = String.valueOf(localDate.getMonthValue());
    day = String.valueOf(localDate.getDayOfMonth());
  } else {
    // 送信された日付を元に、LocalDateのインスタンスを生成する
    localDate = LocalDate.of(Integer.valueOf(year), Integer.valueOf(month), Integer.valueOf(day));
  }
  String[] dates = { year, month, day };

  // 画面で利用するための日付、イベント情報を保存
  session.setAttribute("dates", dates);  
  session.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
  
  String event = (String)eventMap.get(year + month + day);
  session.setAttribute("event", event);
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<style>
ul {
  list-style: none;
}
</style>
</head>
<body>
  <form method="POST" action="/jsp/calendar.jsp">
    <ul>
      <li><input type="text" name="year" value="${param['year']}" /><label for="year">年</label><input type="text" name="month" value="${param['month']}" /><label for="month">月</label><input type="text" name="day" value="${param['day']}" /><label for="day">日</label></li>
      <li><input type="submit" value="送信" />
      <li><c:out value="${fn:join(dates, '/')}" /> (<fmt:formatDate value="${date}" pattern="E" />)</li>
      <li><c:out value="${event}" /></li>
    </ul>
  </form>
</body>
</html>
