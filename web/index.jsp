
<!DOCTYPE html>
<html>
<head>
 <style>
body {font-family: Arial, Helvetica, sans-serif;}
form {border: 3px solid #f1f1f1;}

input[type=text], input[type=password] {
  width: 50%;
  padding: 12px 20px;
  margin: 8px 320px;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 320px;
  border: none;
  cursor: pointer;
  width: 50%;
}

button:hover {
  opacity: 0.8;
}
label[for=uname], label[for=psw]{
 margin: 0 3200px;
}

.container {
  padding: 16px;
}

span.psw {
  margin: 0 320px;
  padding-top: 16px;
}


/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .cancelbtn {
     width: 100%;
  }
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

    <h2 align="center"><u>Login Form</u></h2>

    <form action="First" method="post">
  

  <div class="container">
    <label for="uname"><b>Username</b></label>
    <input type="text" placeholder="Enter Username" name="uname" required>

    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" required>
        
    <button type="submit">Login</button><br>

  </div>

  <div class="container" style="background-color:#f1f1f1">
    
    <span class="psw"><a href="createAcc.jsp">create account</a></span>
  </div>
</form>

</body>
</html>
