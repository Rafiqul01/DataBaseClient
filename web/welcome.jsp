
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.java.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="model.DbWithTable"%>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="css/addons/datatables.min.css" rel="stylesheet">
        <script href="js/addons/datatables.min.js" rel="stylesheet"></script>
        <link href="css/addons/datatables-select.min.css" rel="stylesheet">
        <script href="js/addons/datatables-select.min.js" rel="stylesheet"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>







        <script src="bootstrap.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
        <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">

        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">

        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>


        
           <%
//            HttpSession sess = request.getSession();
//            if(sess==null){
//                System.out.println("Session is NULL");
//            }else{
//                System.out.println("Session is not NULL");
//            }
//            
            %>
           
        
        
        
        
        <style>
            .vido{
                position: fixed;
                right: 0;
                bottom: 0;
                min-width: 100%; 
                min-height: 100%;
                background: rgba(0, 0, 0, 0.9);
            }

            .content {
                position: relative;
                bottom: 0;
                background: rgba(0, 0, 0, 0.9);
                color: #f1f1f1;
                width: 100%;
                height:100%;
                padding: 70px;

            }

        </style>

        <script>
            function myFunction() {
                var query = "create database " + prompt("Enter Database name.");
                //alert(query);
                $.get("QueryFire", {
                    sql: query
                }, function (data, status) {
                    location.reload(true);
                });
            }
            function myFunction2() {
                var query = "drop database " + prompt("Enter Database name.");
                //alert(query);
                $.get("QueryFire", {
                    sql: query
                }, function (data, status) {
                    location.reload(true);
                });
            }




            $(document).ready(function () {



                $("#create_tbl").click(function () {
                    $(".textArea").hide();


                });



                $("#sqlLink").click(function () {
                    $('#htbl').hide();
                    $(".textArea").toggle();
                    $('#colNo').hide();
                    $('#inputdiv').hide();
                });

                $("#run_button").click(function () {

                    var query = $.trim($("#comment").val());
                    //alert(query);

                    $.get("QueryFire", {
                        sql: query
                    },
                    function (data, status) {



                        dataTbl = JSON.stringify(data);

                        if (dataTbl.startsWith("{")) {

                            displayTable(data);
                            //$("#head").html("<u>Table</u>");
                        } else {

                            alert(data);
                            location.reload(true);
                        }

                    });

                });
            });

            function forDB(v)
            {
                var s = $("#" + v).attr("value");
                //alert(s);
                var txt = "selected database " + s + ".";
                document.getElementById("demo").innerHTML = txt;
                $("#" + v).children("ul").toggle(100);
                var sql = "use " + $("#" + v).attr("value");


                $.get("QueryFire", {
                    sql: sql
                }, function (data, status) {


                });

                $("#tbl_structure").hide();
                $("#insert_tbl").hide();

                dataTbl = null;
                dataTblhd = null;
                $("#thd").empty();
                $("#tbd").empty();
                $("#head").empty();
                $("#htbl").hide();
                $("#txt").hide();

                $("#create_tbl").show();
                $("#del_tbl").show();
                $("#colNo").hide();
                $("#inputdiv").hide();


            }



            function forTbl(v)
            {


                $("#tbl_structure").show();
                $("#insert_tbl").show();
                dataTbl = null;

                dbtbl_name = $("#" + v).attr("value");
                tbl_name = dbtbl_name.split(",")[1];
                $("#head").html("<center>Table_name : " + tbl_name + "</center>");

                $.get("GetTableData", {
                    dbtbl_name: dbtbl_name,
                    sql: 'select *  from ' + tbl_name
                },
                function (data, status) {
                    displayTable(data);
                });
                // alert("Value : "+ );
            }



            function showStructure() {

                //alert("ok");
                $("#head").html("<center>Table_Structure : " + tbl_name + "</center>");
                $.get("GetTableData", {
                    dbtbl_name: dbtbl_name,
                    sql: "select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='" + tbl_name + "'"
                },
                function (data, status) {
                    displayTable(data);
                });

            }

            function showCreate_table()
            {
                $("#htbl").hide();
                $("#insertDiv").empty();
                $("#inputdiv").hide();
                $("#colNo").toggle();


            }

            function columnNo() {

                //alert(tblName);
                var col = $.trim($("#col").val());
                if (col > 0) {
                    $("#inputdiv").html('<br><br><label class="col-sm-2">Column_name</label><label class="col-sm-2">Data_Type</label><label class="col-sm-2">Size</label><label class="col-sm-2">Primary_key</label><label class="col-sm-2">Unique</label><label class="col-sm-2">Not Null</label>');
                    for (i = 0; i < col; i++)
                    {
                        $("#inputdiv").append('<input class = " col-sm-2 form-control"  id="cl' + i + '"  type = "text" name = "column_Name" placeholder = "Enter column name" required>' + '<input type = "text" id="dt' + i + '" class = "col-sm-2 form-control"name = "dataType" placeholder = "Enter Data Type" required>' + '<input type = "text" id="sz' + i + '" class = "col-sm-2 form-control "name = "size" placeholder = "Enter size" required>' + '<input type = "checkbox" id="pk' + i + '" class = "col-sm-2 form-control "name = "primary">' + '<input type = "checkbox" id="uk' + i + '" class = "col-sm-2 form-control "name = "unique">' + '<input type = "checkbox" id="nn' + i + '" class = "col-sm-2 form-control "name = "notNull"> <br>');
                    }
                    $("#inputdiv").append('<button type="button" id="crtbtn" class="btn btn-primary" onclick="CreateTable()">Create</button>');
                    $("#inputdiv").show();


                }
                else
                {
                    $("#inputdiv").empty();
                }


            }


            function CreateTable()
            {
                //alert("okay");
                //var i = 0;
                //alert("cl"+i);
                var tblName = $.trim($("#tblName").val());

                //alert($.trim($("#sz0").val()));

                var sql = "create table " + "" + tblName + "(" + $.trim($("#cl0").val()) + " " + $.trim($("#dt0").val()) + "(" + $.trim($("#sz0").val()) + ")";

                //alert(sql);
                //var checkbox = document.getElementById("pk0");
                if (document.getElementById("pk0").checked === true)
                {
                    //alert("success");
                    sql += " PRIMARY KEY";
                }
                //alert(sql);
                if (document.getElementById("uk0").checked === true)
                {
                    sql += " UNIQUE";
                }

                if (document.getElementById("nn0").checked === true)
                {
                    sql += " NOT NULL";
                }

                //alert(sql);
                //var i = 0;
                //alert($.trim($("#cl"+i).val()));
                col = $.trim($("#col").val());
                for (i = 1; i < col; i++)
                {
                    sql += "," + $.trim($("#cl" + i).val()) + " " + $.trim($("#dt" + i).val()) + "(" + $.trim($("#sz" + i).val()) + ")";
                    if (document.getElementById("pk" + i).checked === true)
                    {
                        //alert("success");
                        sql += " PRIMARY KEY";
                    }
                    //alert(sql);
                    if (document.getElementById("uk" + i).checked === true)
                    {
                        sql += " UNIQUE";
                    }

                    if (document.getElementById("nn" + i).checked === true)
                    {
                        sql += " NOT NULL";
                    }


                }
                sql += ")";
                //alert(sql);
                $.get("QueryFire", {
                    sql: sql
                }, function (data, status) {
                    alert(data);
                    location.reload(true);

                });
            }




            function displayTable(data)
            {

                //location.reload(true);
                $("#insertDiv").empty();
                $("#htbl").show();

                kara = Object.keys(data);

                //alert(kara);
                katr = Object.keys(Object.values(data)[0]);
                //alert(katr);
                dataTblhd = "";
                dataTblhd += "<tr>";
                for (k = 0; k < katr.length; k++) {
                    dataTblhd += "<th>" + katr[k] + "</th>";
                }

                dataTblhd += "<th>Delete</th></tr>";

                //alert(dataTblhd);
                $("#thd").empty();
                $("#thd").append(dataTblhd);

                dataTbl = "";

                for (i = 0; i < kara.length; i++) {
                    //alert(kara[i]);
                    katr = Object.keys(Object.values(data)[i]);
                    //alert(katr);
                    dataTbl += "<tr onclick = 'deleteRow(this)'>";
                    for (j = 0; j < katr.length; j++) {
                        dataTbl += "<td>" + Object.values(Object.values(data)[i])[j] + "</td>";
                    }
                    dataTbl += "<td><button type = 'button' class = 'btn btn-primary' >delete</button></td>";
                    dataTbl += "</tr>";


                }


                $("#tbd").empty();
                $("#tbd").append(dataTbl);



                $("#myTable").DataTable();

                /*
                 $(document).ready(function () {
                 $("#myTable").DataTable();
                 });
                 */

            }
            function showDelete_table() {

                $("#colNo").hide();
                $("#inputdiv").hide();



                var query = "drop table " + prompt("Enter Table name.");
                //alert(query);

                $.get("QueryFire", {
                    sql: query
                }, function (data, status) {
                    alert(data);
                    location.reload(true);
                });

            }










            function deleteRow(v)
            {
                document.getElementById('info').innerHTML = "";
                // alert(v.rowIndex);
                var row = v.rowIndex;
                var tab = document.getElementById('myTable');
                var header = tab.rows.item(0).cells;
                var obj = tab.rows.item(row).cells;
                var sql = 'delete from ' + tbl_name + ' where ';
                //alert(tbl_name);
                if (obj.length === 2) {
                    for (var i = 0; i < obj.length - 1; i++)
                    {
                        //info.innerHTML = info.innerHTML + ' ' + obj.item(i).innerHTML;

                        sql += header.item(i).innerHTML + "='" + obj.item(i).innerHTML + "'";

                        //info.innerHTML = info.innerHTML + '<br />';
                    }
                }
                else {
                    for (var i = 0; i < obj.length - 2; i++)
                    {
                        //info.innerHTML = info.innerHTML + ' ' + obj.item(i).innerHTML;

                        sql += header.item(i).innerHTML + "='" + obj.item(i).innerHTML + "' and ";

                        //info.innerHTML = info.innerHTML + '<br />';
                    }
                    sql += header.item(obj.length - 2).innerHTML + "='" + obj.item(obj.length - 2).innerHTML + "'";
                }
                $.get("QueryFire",
                        {
                            sql: sql
                        }, function (data, status)
                {
                    alert(data);
                    location.reload(true);
                });




            }

            function showInsert_table()
            {
                $("#htbl").hide();
                $("#colNo").hide();
                $("#inputdiv").hide();
                $("#insertDiv").empty();
                var tab = document.getElementById('myTable');
                var header = tab.rows.item(0).cells;
                for (var i = 0; i < header.length - 1; i++)
                {
                    $("#insertDiv").append('<label >' + header.item(i).innerHTML + ' :</label><input type = "text"  id = "i' + i + '" placeholder = "Enter ' + header.item(i).innerHTML + '" required>');
                    // $("#insertDiv").append('<input type = "text" class = "col-sm-3 form-control" id = "i'+i+'" placeholder = "Enter"><br>');
                }
                $("#insertDiv").append('<button type = "button" class = "btn btn-primary" id = "insertBtn" onclick = "insert()">Insert</button>');


            }
            function insert()
            {
                //alert($.trim($("#i" + 0).val()));
                var tab = document.getElementById('myTable');
                var header = tab.rows.item(0).cells;
                var sql = "insert into " + tbl_name + " (";

                for (var i = 0; i < header.length - 2; i++)
                {
                    sql += header.item(i).innerHTML + ",";
                }
                sql += header.item(header.length - 2).innerHTML + ")";

                sql += " values(";
                for (var i = 0; i < header.length - 2; i++)
                {
                    sql += "'" + $.trim($('#i' + i).val()) + "', ";
                }
                sql += "'" + $.trim($('#i' + (header.length - 2)).val()) + "')";
                //alert(sql);
                $.get("QueryFire",
                        {
                            sql: sql
                        }, function (data, status)
                {
                    alert(data);
                    location.reload(true);
                });
            }


        </script>



    </head>
    <body>
        
        
       

<!--              <video autoplay loop class="vido">
                    <source src="https://ak2.picdn.net/shutterstock/videos/1023172072/preview/stock-footage-connecting-people-on-the-internet-nodes-transforming-flight-of-the-camera-in-the-technological.mp4" type="video/mp4">
                </video>-->


        <div class="">

            <div class="container-fluid " >

                <div class="container-fluid" >
                    <div class="row " >

                        <div class="col-sm-3"  style = "overflow-y:scroll;">
                            <div class=""  style = "min-height: 650px; max-height: 700px;">
                                <label for="left"><u><b><font size = 5px>Databases</font></b></u></label><br>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" onclick="myFunction()">Create</button>
                                    <button type="button" class="btn btn-primary" onclick="myFunction2()">Drop</button>
                                </div>
                                <ul type = "square">

                                    <%
                                        List<DbWithTable> dataList = (List<DbWithTable>) request.getAttribute("dataList");
                                        for (int i = 0; i < dataList.size(); i++) {
                                            DbWithTable data = dataList.get(i);

                                            String dbName = data.getDbName();
                                            List<String> tblList = data.getTblList();

                                    %>

                                    <li cursor="hand" class="clk" id="id<%=i%>" value="<%=dbName%>"> <a href="#" onclick="forDB('id<%=i%>')">  <%=dbName%> </a> 
                                        <%
                                            for (int j = 0; j < tblList.size(); j++) {
                                                String tblName = tblList.get(j);
                                        %>
                                        <ul class="id<%=i%>" type = "circle" style="display: none;">
                                            <li class="tblclk" id="id<%=i%><%=j%>" value="<%=dbName%>,<%=tblName%>"> <a  href="#" onclick="forTbl('id<%=i%><%=j%>')"> <%=tblName%> </a> </li>
                                        </ul>
                                        <%
                                            }
                                        %>

                                        <%
                                            }
                                        %>

                                    </li>
                                </ul>

                            </div>
                        </div>
                        <div class="col-sm-9"  style = "overflow-y:scroll;">
                            <div class="col-sm-12"  style="min-height: 650px; max-height: 700px;">
                                <nav class="navbar navbar-inverse">
                                    <div class="container-fluid">

                                        <div style="display:flex; width: 100%">
                                            
                                            <div style="float:left; width:93%">
                                                
                                                <ul class="nav" style="float:left" >
                                                    <li><a id="sqlLink" href="#" style="float:left; display: block" >SQL</a></li>
                                                    <li><a id="tbl_structure" href="#" onclick="showStructure()" style="float:left; display: none">Structure</a></li>
                                                    <li><a id="create_tbl" href="#" onclick="showCreate_table()" style="float:left; display: none">Create_table</a></li>
                                                    <li><a id="del_tbl" href ="#" onclick = "showDelete_table()" style="float:left; display: none">Delete_table</a></li>
                                                    <li><a id ='insert_tbl' href ='#' onclick ='showInsert_table()' style ='float:left; display:none'>Insert_table</a></li>
                                                </ul>
                                            </div>
                                            
                                            <div style="float:right; width: 7%">
                                                <form action="Logout" method="post">
                                                    <input type="submit"  class="btn btn-primary" value="Logout">
                                                </form>
                                                
                                            </div>
                                            
                                            
                                        </div>



                                        


                                    </div>
                                </nav>
                                <p id="demo"></p>
                                <div id="colNo" style ="display: none;">
                                    <label>Table_name: </label>
                                    <input type="text" id="tblName" placeholder="Enter table name" required>
                                    <label>Column_number: </label>
                                    <input type="number" id = "col" name="colInput" placeholder="Enter column number" required>
                                    <button type="button" class="btn btn-primary" onclick="columnNo()">Enter</button>
                                </div>
                                <div id ="inputdiv"></div>
                                <div class="textArea" id="txt" style="display: none">

                                    <textarea id="comment" rows="15" cols="133"></textarea>
                                    <p><button id="run_button" type="button">Run</button></p>
                                </div>
                                <div id="htbl">
                                    <h2 id="head" style="color:green;"></h2>
                                    <table id = "myTable" class="display">
                                        <thead id="thd"></thead>
                                        <tbody id="tbd"></tbody>
                                    </table>
                                    <p id="info"></p>
                                </div>
                                <div id='insertDiv'></div>


                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </body>
</html>