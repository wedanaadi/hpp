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
            <td colspan="2" align="center" style="font-size:18px;"> <strong> LAPORAN PENJUALAN </strong> </td>
        </tr>
        <tr>
            <td colspan="2" align="center" style="font-size:14px;"> Bulan : {{ $konten['bulan'] }}
        </tr>
    </table>
</div>
<br>

<table id="TabelKonten" border="1" style="border-collapse: collapse; border-color: #000; margin-bottom : 10px;"
    width="100%">
    <thead class="text-center">
        <tr>
            <th class="align-middle">No</th>
            <th class="align-middle">Tanggal</th>
            <th class="align-middle">Article Description</th>
            {{-- <th class="align-middle">Unit</th> --}}
            <th class="align-middle">P-Price</th>
            <th class="align-middle">Qty</th>
            <th class="align-middle">Avrg Price</th>
            <th class="align-middle">Grand Total</th>
        </tr>
    </thead>
    <tbody>
        @php
        $i = 1;
        $total = 0;
        @endphp
        @foreach ($konten['body'] as $r)
        <tr>
            <td>{{ $i }}</td>
            <td class="text-center">{{$r->date}}</td>
            <td class="text-center">{{$r->kode}} {{$r->nama_barang}}</td>
            {{-- <td class="text-center">{{$r->nama_satuan}}</td> --}}
            <td class="text-right">{{number_format($r->harga,0,',','.')}}</td>
            <td class="text-center">{{$r->qty}}</td>
            <td class="text-right">{{number_format($r->actual_harga,0,',','.')}}</td>
            <td class="text-right">{{number_format($r->total,0,',','.')}}</td>
        </tr>
        @php
        $i++;
        $total+=$r->total;
        @endphp
        @endforeach
        <tr>
            <td></td>
            <td><strong>Total</strong></td>
            <td></td>
            {{-- <td></td> --}}
            <td></td>
            <td></td>
            <td></td>
            <td class="text-right"><strong>{{number_format($total,0,',','.')}}</strong></td>
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
