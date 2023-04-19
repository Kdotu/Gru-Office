<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page session="false" %>
<link rel="stylesheet" href="/resources/css/mention.css">
<script src="/resources/js/mention.js"></script>
<html>
  <style>
         html, body{
            padding:0px;
            margin:0px;
            background:#222;
            font-family: 'Karla', sans-serif;
            color:#FFF;
         }
         h3{ text-align:center; }
         .demo{
            display:flex;
            max-width:600px;
            margin:0px auto;
         }

         #optionsZone {
            position:relative;
            top:0px;
         }

         #data {
            background:transparent;
            border:none;
            display:block;
            width:100%;
            height:400px;
            color:#FFF;
            flex:1;
            padding:20px;
            overflow:auto;
            white-space:nowrap;
            tab-size: 16px;
            flex:1;
            padding:10px;
				margin:0px;

         }
         .mention-wrapper {
            width:50%;
         }
         #textarea{
            border-radius:4px;
            height:100px;
            flex:1;
            box-sizing:border-box;
            background:#FFF;
            display:block;
            margin:0;
            resize:none;
            padding:10px;
            outline:none;
            color:#333;
            font-size:16px;
				font-family: 'Karla', sans-serif;
            border:3px solid transparent;
            font-weight:400;

         }
         #textarea:focus{
            border:3px solid #999;
         }

         .mention-options {
            border:3px solid #999;
            margin-top:-3px;
         }

         .mention-option {
            padding:5px 10px;
         }
      </style>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
  <h3>@ Input</h3>
      <div id="optionsZone"></div>
      <div class="demo">
         <textarea id="textarea"></textarea>
         <textarea id="data"></textarea>
      </div>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
<script>
         var myMention = new Mention({
            input: document.querySelector('#textarea'),
            /* 주소록 보고 내용 채워넣기!! */
            options: [
               { id: 2, name: '정대만', description: '서비스플랫폼팀 대리' },
               { id: 100, name: '양호열', description: '어디어디팀 어떤거' },
               { id: 10, name: '강백호', description: '오디오디팀 어떤' }
            ],
            update: function() {
            	console.log(JSON.stringify(this.findMatches(), null, '\t'));
               document.querySelector('#data').innerHTML = JSON.stringify(this.findMatches(), null, '\t')
               console.log("click...?");
               // input type hindden 엘리멘드요소의 value값에 얻어진 @양호열대리와 같은 텍스트를 넣으면 되겠구나!
               
            },
            match: function(word, option) {
               return option.name.startsWith(word)
                  || option.description.toLowerCase().indexOf(word.toLowerCase()) >= 0
            },
            template: function(option) {
               return '@' + option.name + ' [' + option.description + ']'
            },
            
         })

      </script>