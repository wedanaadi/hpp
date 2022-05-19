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
      <td colspan="2" align="center" style="font-size:18px;"> <strong> LAPORAN NERACA </strong> </td>
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
      <td colspan="5"><strong>AKTIVA</strong></td>
    </tr>
    <tr>
      <td>101</td>
      <td>Kas</td>
      <td class="text-right">{{
        number_format($konten['body']['kas'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>102</td>
      <td>Persediaan Barang Baku</td>
      <td class="text-right">{{
        number_format($konten['body']['baku'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>103</td>
      <td>Persediaan dalam proses</td>
      <td class="text-right">{{
        number_format($konten['body']['proses'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>501</td>
      <td>Harga Pokok Produksi</td>
      <td class="text-right">{{
        number_format($konten['body']['hpp'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td colspan="4" class="text-right"><strong>Total Aktiva</strong></td>
      <td class="text-right">{{
        number_format($konten['body']['kas']+$konten['body']['baku']+$konten['body']['proses']+$konten['body']['hpp'],'0',',','.')}}
      </td>
    </tr>
    <tr>
      <td colspan="5"><strong>PASSIVA</strong></td>
    </tr>
    <tr>
      <td colspan="5">Kewajiban</td>
    </tr>
    <tr>
      <td colspan="3">Total Kewajiban</td>
      <td class="text-right">{{
        number_format($konten['body']['kewajiban'],'0',',','.')}}
      </td>
      <td></td>
    </tr>
    <tr>
      <td colspan="5">Ekuitas</td>
    </tr>
    <tr>
      <td>301</td>
      <td>Modal CV</td>
      <td></td>
      <td class="text-right">{{
        number_format($konten['body']['modal'],'0',',','.')}}
      </td>
      <td></td>
    </tr>
    <tr>
      <td></td>
      <td>Laba Rugi
      <td></td>
      <td class="text-right">{{
        number_format($konten['body']['lb'],'0',',','.')}}
      </td>
      <td></td>
    </tr>
    <tr>
      <td colspan="3">Total Ekuitas</td>
      <td class="text-right">{{
        number_format($konten['body']['kewajiban']+$konten['body']['lb']+$konten['body']['modal'],'0',',','.')}}
      </td>
      <td></td>
    </tr>
    <tr>
      <td colspan="4" class="text-center"><strong>Total Passiva</strong></td>
      <td class="text-right">{{
        number_format($konten['body']['kewajiban']+$konten['body']['lb']+$konten['body']['modal'],'0',',','.')}}
      </td>
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