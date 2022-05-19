<?php

namespace App\Libraries;

class Fungsi
{
  public static function KodeGenerate($lastKode, $lenght, $start, $awalKode = NULL, $split = NULL)
  {
    $kode = substr($lastKode, $start);
    $angka = (int)$kode;
    $angka_baru = $awalKode . $split . str_repeat("0", $lenght - strlen($angka + 1)) . ($angka + 1);
    return $angka_baru;
  }

  public static function numberToRoman($number)
  {
    $map = array('M' => 1000, 'CM' => 900, 'D' => 500, 'CD' => 400, 'C' => 100, 'XC' => 90, 'L' => 50, 'XL' => 40, 'X' => 10, 'IX' => 9, 'V' => 5, 'IV' => 4, 'I' => 1);
    $returnValue = '';
    while ($number > 0) {
      foreach ($map as $roman => $int) {
        if ($number >= $int) {
          $number -= $int;
          $returnValue .= $roman;
          break;
        }
      }
    }
    return $returnValue;
  }

  public static function numberDash($lastKode, $lenght, $start, $awalKode = NULL, $split = NULL)
  {
    $kode = substr($lastKode, $start);
    $angka = (int)$kode;
    $angka_baru = $awalKode . $split . str_repeat("0", $lenght - strlen($angka + 1)) . ($angka + 1);
    return $angka_baru;
  }

  public static function BuktiGenerate($lastKode, $lenght, $start, $awalKode = NULL, $split = NULL)
  {
    $kode = substr($lastKode, $start);
    $angka = (int)$kode;
    $angka_baru = str_repeat("0", $lenght - strlen($angka + 1)) . ($angka + 1) . '/' . $awalKode . '/' . $split;
    return $angka_baru;
  }

  public static function bulan($index)
  {
    $bulan_arr = [
      '01' => 'Januari',
      '02' => 'Februari',
      '03' => 'Maret',
      '04' => 'April',
      '05' => 'Mei',
      '06' => 'Juni',
      '07' => 'Juli',
      '08' => 'Agustus',
      '09' => 'September',
      '10' => 'Oktober',
      '11' => 'November',
      '12' => 'Desember'
    ];
    return $bulan_arr[$index];
  }
}
