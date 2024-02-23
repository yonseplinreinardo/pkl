<!-- cek apakah sudah login -->
<?php

if (!isset($_SESSION['role'])) {
  header("location:login.php");
} else {
  $role = $_SESSION['role'];
}
date_default_timezone_set("Asia/Singapore");
if (mysqli_connect_errno()) {
  echo 'Gagal melakukan koneksi ke Database : ' . mysqli_connect_error();
}
?>