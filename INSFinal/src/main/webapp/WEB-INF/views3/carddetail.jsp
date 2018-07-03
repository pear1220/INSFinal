<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
.collapsible {

    background-color: #f5f5f5;
    color: #333333;
    cursor: pointer;
    padding: 10px 15px;
    width: 100%;
    border: 1px solid transparent;
    text-align: left;
    outline: none;
    font-size: 15px;
}

.content {
    padding: 0 18px;
    display: 1px soild gray;
    overflow: hidden;
    background-color: #fff;
}

</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".content").hide();
});

</script>
<body>
    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
              <a class="navbar-brand" href="index.html"><i class="fa fa-columns"></i></span> SB Admin v2.0</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-pencil-square-o"></i>
                    </a>
                </li>
            </ul>
            <!-- /.navbar-top-links -->

        </nav>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default" style="margin-top: 2%">
                        <div class="panel-heading">
                           <i class="fa fa-list-ul"></i> 
                           Description
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form role="form">
                                        <div class="form-group">
                                            <textarea class="form-control" rows="3"></textarea>
                                        </div>
                                         <button type="submit" class="btn btn-default" style="font-weight: bold;">Save</button>        
                                    </form>
                                </div>
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /Description panel-body -->
                    </div>
                    <!-- /Description panel -->
                    
                     
                    <div class="panel panel-default" style="margin-top: 5%">
                        <div class="panel-heading">
                           <i class="fa fa-paperclip"></i>
                           Attachment
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form role="form">
                                          <div class="form-group">
                                            <label>File Uplode</label>
                                            <input type="file">
                                        </div>        
                                    </form>
                                </div>
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /Attachment panel-body -->        
                    </div>
                    <!-- /Attachment panel -->
                    
                    
                    <div class="panel panel-default" style="margin-top: 5%">
                        <div class="panel-heading">
                           <i class="fa fa-commenting"></i>
                           Comment
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form role="form">
                                        <div class="form-group">
                                            <textarea class="form-control" rows="3"></textarea>
                                        </div>
                                         <button type="submit" class="btn btn-default" style="font-weight: bold;">Save</button>        
                                    </form>
                                </div>
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /Comment panel-body -->        
                    </div>
                    <!-- /Comment panel -->
                    
  					<!-- /Activity button -->
					<button class="collapsible"> <i class="fa fa-list-alt"></i>
                           Activity</button>
					
					<div class="content">
					  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
					</div>
									
					<script>
					var coll = document.getElementsByClassName("collapsible");
					var i;
					
					for (i = 0; i < coll.length; i++) {
					    coll[i].addEventListener("click", function() {
					        this.classList.toggle("active");
					        var content = this.nextElementSibling;
					        if (content.style.display === "block") {
					           content.style.display = "none";
					           // content.style.display = "block";
					        } else {
					            content.style.display = "block";
					        }
					    });
					}
					</script>
					<!-- /Activity button -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="<%=request.getContextPath() %>/resources/card/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<%=request.getContextPath() %>/resources/card/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="<%=request.getContextPath() %>/resources/card/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="<%=request.getContextPath() %>/resources/card/dist/js/sb-admin-2.js"></script>

</body>

</html>