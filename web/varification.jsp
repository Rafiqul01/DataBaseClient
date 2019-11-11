<%-- 
    Document   : varification
    Created on : Jul 1, 2019, 2:01:20 AM
    Author     : Rafiqul Islam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            body {font-family: Arial, Helvetica, sans-serif;}
form {border: 3px solid #f1f1f1;}
  button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 320px;
  border: none;
  cursor: pointer;
  width: 50%;
  }
  input[type=text] {
  width: 50%;
  padding: 12px 20px;
  margin: 8px 320px;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}
label[for = code]
{
    margin: 0 320px;
}
.container {
  padding: 16px;
}

        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h1 align = center><u>Verification</u></h1>
        <form action="Verificate">
            <div class ="container">
           <label for="code"><b>Verification Code</b></label>
           
           <input type="text" placeholder="Enter verification Code" name="code" required><br>
           
           
           <button type="submit">Submit</button><br>
            </div>
           
        </form>
    </body>
</html>
