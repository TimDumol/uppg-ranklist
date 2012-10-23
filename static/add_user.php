<?php
require_once 'config.php';

session_start();

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'POST' || $method === 'GET') {
?>
<html>
    <head>
        <meta charset="utf-8">

        <!-- Use the .htaccess and remove these lines to avoid edge case issues.
        More info: h5bp.com/b/378 -->
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

        <title>Add a User | UP Programming Guild Rankings</title>
        <meta name="description" content="">
        <meta name="author" content="Tim Joseph Dumol">

        <!-- Mobile viewport optimized: j.mp/bplateviewport -->
        <meta name="viewport" content="width=device-width,initial-scale=1">

        <link rel="stylesheet" href="css/bootstrap.css">
    </head>
    <body>
        <header class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="brand" href="#">UP Programming Guild Rankings</a>
            </div>
        </div>
        </header>
        <div id="main" role="main" class="container">
            <div class="content">
                <div class="row">
<?php
    if ($method === 'POST') {
        if (!isset($_SESSION['ranklist_logged_in']) ||
            !$_SESSION['ranklist_logged_in']) {
                if ($_POST['admin_password'] === $ranklist_pwd) {
                    $_SESSION['ranklist_logged_in'] = true;   
                } else {
                    echo '<p>Error: Admin password does not match configuration.</p>';
                }
        }
        if ($_SESSION['ranklist_logged_in']) {
            $dbh = new PDO($db_info, $db_user, $db_password, array(
                PDO::ATTR_PERSISTENT => true
            ));
            $stmt = $dbh->prepare("INSERT INTO ranks (name, uva_id, euler_id, retired, probie) VALUES (:name, :uva_id, :euler_id, :retired, :probie)");
            $name = $_POST['name'];
            $uva_id = $_POST['uva_id'];
            $euler_id = $_POST['euler_id'];
            $retired = isset($_POST['retired']) && $_POST['retired'] === 'on';
            $probie = isset($POST['probie']) && $_POST['probie'] === 'on';
            $stmt->bindParam('name', $name);
            $stmt->bindParam('uva_id', $uva_id);
            $stmt->bindParam('euler_id', $euler_id);
            $stmt->bindParam('retired', $retired);
            $stmt->bindParam('probie', $probie);
            if ($stmt->execute()) {
                echo '<p>Successfully added user</p>';
            } else {
                echo '<p>Failed to add user:</p>';
                echo '<p>' . $dbh->errorInfo()[1] . '</p>';
            }
        }
    }
?>
                    <form method="POST" action".">
                        <div>
                            <label>Name</label>
                            <input name="name">
                        </div>
                        <div>
                            <label>UVa ID</label>
                            <input name="uva_id">
                        </div>
                        <div>
                            <label>Euler ID</label>
                            <input name="euler_id">
                        </div>
                        <div>
                            <input type="checkbox" name="retired"><label>Retired</label>
                        </div>
                        <div>
                            <input type="checkbox" name="probie"><label>Probie</label>
                        </div>
<?php
    if (!isset($_SESSION['ranklist_logged_in']) ||
        !$_SESSION['ranklist_logged_in']) { ?>
                        <div>
                            <label>Admin Password:</label>
                            <input type="password" name="admin_password">
                        </div>
<?php } ?>
                        <div>
                            <button type="submit">Add User</button>
                        </div>
                    </form>
                </div>
            </div>
            <footer>
            <p>&copy; Copyright 2012 UP Programming Guild</p>
            </footer>
        </div>

        <!-- Prompt IE 6 users to install Chrome Frame. Remove this if you want to support IE 6.
        chromium.org/developers/how-tos/chrome-frame-getting-started -->
        <!--[if lt IE 7 ]>
        <script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>
        <script>window.attachEvent('onload',function(){CFInstall.check({mode:'overlay'})})</script>
        <![endif]-->
    </body>
</html>
<?php
} else {
    header('HTTP/1.1 405 Method Not Allowed');
}
