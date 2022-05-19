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
      <td colspan="2" align="center" style="font-size:18px;"> <strong> LAPORAN HARGA POKOK PRODUKSI </strong> </td>
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
      <td><strong>Persediaan Barang dalam Proses (Awal) </strong></td>
      <td></td>
      <td></td>
      <td class="text-right">{{
        number_format($konten['body']['stockawal'],'0',',','.')}}
      </td>
    </tr>
    <tr>
      <td><strong>Pemakaian Bahan Baku</strong></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>Persediaan Bahan Baku Awal</td>
      <td class="text-right">{{
        number_format($konten['body']['stockawal'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>Pembelian Bahan Baku (+)</td>
      <td class="text-right">{{
        number_format($konten['body']['pembelian'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>Bahan Baku Tersedia (+)</td>
      <td class="text-right">{{
        number_format($konten['body']['tersedia'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>Persediaan Bahan Baku Akhir</td>
      <td class="text-right">{{
        number_format($konten['body']['sisabahan'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Pemakaian Bahan Baku</strong></td>
      <td></td>
      <td class="text-right">{{
        number_format($konten['body']['pemakain'],'0',',','.')}}
      </td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Biaya-biaya</strong></td>
      <td></td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>Gaji Pegawai</td>
      <td class="text-right">{{
        number_format($konten['body']['gaji'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>Biaya Overhad</td>
      <td class="text-right">{{
        number_format($konten['body']['overhead'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>Biaya Produksi</td>
      <td class="text-right">{{
        number_format($konten['body']['produksi'],'0',',','.')}}
      </td>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Total Biaya</strong></td>
      <td></td>
      <td class="text-right">{{
        number_format($konten['body']['totalbiaya'],'0',',','.')}}
      </td>
      <td></td>
    </tr>
    <tr>
      <td><strong>Biaya Produksi</strong></td>
      <td></td>
      <td></td>
      <td class="text-right">{{
        number_format($konten['body']['biayaproduksi'],'0',',','.')}}
      </td>
    </tr>
    <tr>
      <td><strong>Barang Siap Digunakan</strong></td>
      <td></td>
      <td></td>
      <td class="text-right">{{
        number_format($konten['body']['biayaproduksi'],'0',',','.')}}
      </td>
    </tr>
    <tr>
      <td><strong>Persediaan Barang dalam proses Akhir</strong></td>
      <td></td>
      <td></td>
      <td class="text-right">{{
        number_format(-1*$konten['body']['sisabahan'],'0',',','.')}}
      </td>
    </tr>
    <tr>
      <td><strong>Harga Pokok Produksi</strong></td>
      <td></td>
      <td></td>
      <td class="text-right">{{
        number_format($konten['body']['biayaproduksi']-(-1*$konten['body']['sisabahan']),'0',',','.')}}
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