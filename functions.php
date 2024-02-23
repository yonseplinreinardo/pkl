<?php

$conn = mysqli_connect("localhost", "root", "", "db_penyewaan");

function query($query)
{
  global $conn;
  $result = mysqli_query($conn, $query);
  $rows = [];
  while ($row = mysqli_fetch_assoc($result)) {
    $rows[] = $row;
  }
  return $rows;
}

function hapusUser($id)
{
  global $conn;
  mysqli_query($conn, "DELETE FROM user WHERE id_user = $id");

  return mysqli_affected_rows($conn);
}

function hapusProduk($id)
{
  global $conn;
  mysqli_query($conn, "DELETE FROM tb_produk WHERE id_produk = $id");

  return mysqli_affected_rows($conn);
}

function hapusAdmin($id)
{
  global $conn;
  mysqli_query($conn, "DELETE FROM tb_admin WHERE id_admin = $id");

  return mysqli_affected_rows($conn);
}

function hapusPesan($id)
{
  global $conn;
  mysqli_query($conn, "DELETE FROM tb_sewa WHERE id_sewa = $id");

  return mysqli_affected_rows($conn);
}

function daftar($data)
{
  global $conn;

  $username = strtolower(stripslashes($data["email_user"]));
  $password = $data["password_user"];
  $nama = $data["nama_user"];
  $nohp_user = $data["nohp_user"];
  //Upload Gambar
  $upload = upload();
  if (!$upload) {
    return false;
  }

  $result = mysqli_query($conn, "SELECT email_user FROM user WHERE email_user = '$username'");

  if (mysqli_fetch_assoc($result)) {
    echo "<script>
            alert('Username sudah terdaftar!');
        </script>";
    return false;
  }
  mysqli_query($conn, "INSERT INTO user (email_user,password_user,nama_user,nohp_user,foto_user) VALUES ('$username','$password','$nama','$nohp_user','$upload')");
  return mysqli_affected_rows($conn);
}

function edit($data)
{
  global $conn;

  $userid = $_SESSION["id_user"];
  $username = strtolower(stripslashes($data["email_user"]));
  $nama = $data["nama_user"];
  $nohp_user = $data["nohp_user"];
  $gambar = $data["foto_user"];
  $gambarLama = $data["fotoLama"];

  // Cek apakah User pilih gambar baru
  if ($_FILES["foto_user"]["error"] === 4) {
    $gambar = $gambarLama;
  } else {
    $gambar = upload();
  }

  $query = "UPDATE user SET email_user = '$username', 
  nama_user = '$nama',
  nohp_user = '$nohp_user',
  foto_user = '$gambar'
  WHERE id_user = '$userid'
  ";

  mysqli_query($conn, $query);
  return mysqli_affected_rows($conn);
}

function pesan($data)
{
  global $conn;

  $userid = $_SESSION["id_user"];
  $id_produk = $data["id_produk"];
  $tanggal =  $data["tanggal"];
  $harga = $data["harga"];

  mysqli_query($conn, "INSERT INTO tb_sewa (id_user, id_produk,tanggal_pesan,harga) VALUES ('$userid','$id_produk','$tanggal','$harga') ");

  return mysqli_affected_rows($conn);
}

function bayar($data)
{
  global $conn;
  $id_sewa = $data["id_sewa"];

  //Upload Gambar
  $upload = upload();
  if (!$upload) {
    return false;
  }

  mysqli_query($conn, "INSERT INTO tb_bayar (id_sewa,bukti,konfirmasi) VALUES ('$id_sewa','$upload','Sudah Bayar')");

  return mysqli_affected_rows($conn);
}

function tambahProduk($data)
{
  global $conn;

  $produk = $data["produk"];
  $harga = $data["harga"];
  $deskripsi = $data["deskripsi"];

  //Upload Gambar
  $upload = upload();
  if (!$upload) {
    return false;
  }


  $query = "INSERT INTO tb_produk (nama_produk,deskripsi,harga,foto) VALUES ('$produk','$deskripsi','$harga','$upload')";

  $tambah_produk = mysqli_query($conn, $query);
  if ($tambah_produk) {
    echo "<script>
      alert('Data berhasil ditambah...!');
      document.location.href = 'produk.php';
  </script>";
  } else {
    echo "<script>
      alert('Data GAGAL ditambah...!');
      history.go(-1);
  </script>";
  }
}

function upload()
{
  $namaFile = $_FILES['foto']['name'];
  $ukuranFile = $_FILES['foto']['size'];
  $error = $_FILES['foto']['error'];
  $tmpName = $_FILES['foto']['tmp_name'];

  // Cek apakah tidak ada gambar yang di upload
  if ($error === 4) {
    echo "<script>
    alert('Pilih gambar terlebih dahulu');
    </script>";
    return false;
  }

  // Cek apakah gambar
  $extensiValid = ['jpg', 'png', 'jpeg'];
  $extensiGambar = explode('.', $namaFile);
  $extensiGambar = strtolower(end($extensiGambar));

  if (!in_array($extensiGambar, $extensiValid)) {
    echo "<script>
    alert('Yang anda upload bukan gambar!');
    </script>";
    return false;
  }

  if ($ukuranFile > 1000000) {
    echo "<script>
    alert('Ukuran Gambar Terlalu Besar!');
    </script>";
    return false;
  }

  $namaFileBaru = uniqid();
  $namaFileBaru .= '.';
  $namaFileBaru .= $extensiGambar;
  // Move File
  move_uploaded_file($tmpName, '../img/' . $namaFileBaru);
  return $namaFileBaru;
}

function editLpg($data)
{
  global $conn;

  $id = $data["id_produk"];
  $produk = $data["produk"];
  $deskripsi = $data["deskripsi"];
  $harga = $data["harga"];
  $gambarLama =  $data["fotoLama"];

  // Cek apakah User pilih gambar baru
  if ($_FILES["foto"]["error"] === 4) {
    $gambar = $gambarLama;
  } else {
    $gambar = upload();
  }


  $query = "UPDATE tb_produk SET 
  nama_produk = '$produk',
  harga = '$harga',
  deskripsi = '$deskripsi',
  foto = '$gambar' WHERE id_produk = '$id'
  ";

  mysqli_query($conn, $query);
  return mysqli_affected_rows($conn);
}


function tambahAdmin($data)
{
  global $conn;

  $username = $data["username"];
  $password = $data["password"];
  $nama = $data["nama"];
  $email = $data["email"];
  $no_handphone = $data["hp"];

  $query = "INSERT INTO tb_admin (username,password_admin,nama_admin,email_admin,nohp_admin) VALUES ('$username','$password','$nama','$email','$no_handphone')";

  $tambah = mysqli_query($conn, $query);
  if ($tambah) {
    echo "<script>
        alert('Data berhasil ditambah...!');
        document.location.href = 'admin.php';
    </script>";
  } else {
    echo "<script>
        alert('Data GAGAL ditambah...!');
        history.go(-1);
    </script>";
  }
}

function editAdmin($data)
{
  global $conn;

  $id = $data["id"];
  $username = $data["username"];
  $password = $data["password"];
  $nama = $data["nama"];
  $email = $data["email"];
  $no_handphone = $data["hp"];

  $query = "UPDATE tb_Admin SET 
  username = '$username',
  password_admin = '$password',
  nama_admin = '$nama',
  email_admin = '$email',
  nohp_admin  = '$no_handphone' WHERE id_admin = '$id'
  
  ";

  mysqli_query($conn, $query);
  return mysqli_affected_rows($conn);
}

function konfirmasi($id_sewa)
{
  global $conn;

  $id = $id_sewa;

  mysqli_query($conn, "UPDATE tb_bayar set konfirmasi = ('Terkonfirmasi') WHERE id_sewa = '$id'");
  return mysqli_affected_rows($conn);
}
