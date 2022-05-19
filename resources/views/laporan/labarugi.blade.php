{!! $header !!}

<style type="text/css">
  #TabelKonten tr td {
    padding-right: 7px;
    padding-left: 7px;
    font-size: 15px;
  }

  .tbminicell {
    padding: 0.1rem;
    font-size: 10px !important;
  }

  .text-right {
    text-align: right;
  }

  .text-center {
    text-align: center;
  }

  .font-bold {
    font-weight: bold;
  }
</style>

<div style="margin-buttom : 15px;">
  <table width="100%" border="0">
    <tr>
      <td colspan="2" align="center" style="font-size:18px;"> <strong> LAPORAN LABA RUGI </strong> </td>
    </tr>
    <tr>
      <td colspan="2" align="center" style="font-size:14px;"> Bulan : {{ $konten['bulan'] }}
    </tr>
  </table>
</div>
<br>

<table id="TabelKonten" border="1" style="border-collapse: collapse; border-color: #000; margin-bottom : 10px;"
  width="100%">
  <tbody>
    <tr>
      <td><strong>Penjualan</strong></td>
      <td class="text-right">{{ number_format($konten['body']['pj'],'0',',','.') }}</td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Beban Pokok Penjualan</strong></td>
      <td class="text-right">{{ number_format($konten['body']['pb'],'0',',','.') }}</td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Laba Kotor</strong></td>
      <td></td>
      <td class="text-right">{{ number_format($konten['body']['pj']-$konten['body']['pb'],'0',',','.') }}</td>
    </tr>
    <tr>
      <td><strong>Biaya-Biaya :</strong></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>Gaji Pegawai</td>
      <td class="text-right">{{ number_format($konten['body']['gaji'],'0',',','.') }}</td>
      <td></td>
    </tr>
    <tr>
      <td>Biaya Overhead</td>
      <td class="text-right">{{ number_format($konten['body']['produksi']->overhead,'0',',','.') }}</td>
      <td></td>
    </tr>
    <tr>
      <td>Biaya Produksi</td>
      <td class="text-right">{{ number_format($konten['body']['produksi']->produksi,'0',',','.') }}</td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Total Biaya :</strong></td>
      <td></td>
      <td class="text-right">{{
        number_format(($konten['body']['gaji']+$konten['body']['produksi']->overhead+$konten['body']['produksi']->produksi),'0',',','.')
        }}</td>
    </tr>
    <tr>
      <td><strong>Laba Rugi :</strong></td>
      <td></td>
      <td class="text-right">{{
        number_format(($konten['body']['pj']-$konten['body']['pb'])-($konten['body']['gaji']+$konten['body']['produksi']->overhead+$konten['body']['produksi']->produksi),'0',',','.')
        }}</td>
    </tr>
  </tbody>
</table>

<table width="100%" border="0" style="font-size:11px; ">
  <tr>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
    <td class="text-center">Badung, {{date('t').' '.$konten['bulan']}}</td>
  </tr>
  <tr>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
  </tr>

  <tr>
    <td align="center"><strong>&nbsp;</strong> </td>
    <td align="center"><strong>&nbsp;</strong></td>
    <td align="center"><strong>Pembuku</strong></td>
  </tr>
  <tr>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
  </tr>
  <tr>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
  </tr>
  <tr>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
  </tr>
  <tr>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
    <td>&nbsp; </td>
  </tr>
  <tr>
    <td align="center">&nbsp;</td>
    <td align="center"></td>
    <td align="center" style="width: 30%">__________________</td>
  </tr>)
</table>