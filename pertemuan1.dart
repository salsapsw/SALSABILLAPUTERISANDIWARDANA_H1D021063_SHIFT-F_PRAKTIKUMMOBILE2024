import 'dart:io';

class ItemBelanjaan {
  String kode;
  String nama;
  double hargaPerUnit;

  ItemBelanjaan(this.kode, this.nama, this.hargaPerUnit);
}

class Kasir {
  List<ItemBelanjaan> daftarBarang = [];
  List<ItemBelanjaan> daftarBelanja = [];
  Map<String, int> jumlahBelanja = {};

  void tambahBarang(ItemBelanjaan item) {
    daftarBarang.add(item);
  }

  void tambahItemBelanjaan(String kode, int jumlah) {
    ItemBelanjaan? item = daftarBarang.firstWhere((item) => item.kode == kode,
        orElse: () => ItemBelanjaan('', '', 0));

    if (item.kode.isNotEmpty) {
      if (jumlahBelanja.containsKey(kode)) {
        jumlahBelanja[kode] = jumlahBelanja[kode]! + jumlah;
      } else {
        jumlahBelanja[kode] = jumlah;
      }
      print('${item.nama} sebanyak $jumlah telah ditambahkan.');
    } else {
      print('Kode barang tidak ditemukan.');
    }
  }

  double hitungTotalHarga() {
    double total = 0;
    for (var kode in jumlahBelanja.keys) {
      ItemBelanjaan item = daftarBarang.firstWhere((item) => item.kode == kode);
      total += item.hargaPerUnit * jumlahBelanja[kode]!;
    }
    return total;
  }

  double hitungDiskon(double total) {
    if (total > 100000) {
      return total *
          0.1; //ini untuk dikasih diskon 10% pas udah diatas 100k total belanja
    } else {
      return 0;
    }
  }

  void tampilkanTotal() {
    double total = hitungTotalHarga();
    double diskon = hitungDiskon(total);
    double totalSetelahDiskon = total - diskon;

    print('\n--------------------------------------');
    print('Salsa Shop\nMadiun');
    print('Kasir: Salsa');
    print('--------------------------------------');
    print('Daftar Belanjaan:');
    for (var kode in jumlahBelanja.keys) {
      ItemBelanjaan item = daftarBarang.firstWhere((item) => item.kode == kode);
      print(
          '${item.nama}  x${jumlahBelanja[kode]}  -  Rp ${(item.hargaPerUnit * jumlahBelanja[kode]!).toStringAsFixed(2)}');
    }

    print('--------------------------------------');
    print('Total belanja: Rp ${total.toStringAsFixed(2)}');
    if (diskon > 0) {
      print('Diskon 10%: Rp ${diskon.toStringAsFixed(2)}');
    } else {
      print('Tidak ada diskon.');
    }
    print('Total setelah diskon: Rp ${totalSetelahDiskon.toStringAsFixed(2)}');
    print('--------------------------------------');
    print('Terima kasih telah berbelanja di Salsa Shop!');
    print('--------------------------------------');
  }

  void tampilkanDaftarBarang() {
    print('Daftar Barang:');
    for (var item in daftarBarang) {
      print(
          '${item.kode}: ${item.nama} - Rp ${item.hargaPerUnit.toStringAsFixed(2)}');
    }
  }
}

void main() {
  Kasir kasir = Kasir();

  // Menambahkan barang ke daftar
  kasir.tambahBarang(ItemBelanjaan('1', 'Beras', 50000));
  kasir.tambahBarang(ItemBelanjaan('2', 'Minyak Goreng', 20000));
  kasir.tambahBarang(ItemBelanjaan('3', 'Gula Pasir', 15000));
  kasir.tambahBarang(ItemBelanjaan('4', 'Garam', 3000));
  kasir.tambahBarang(ItemBelanjaan('5', 'Lada', 1000));
  kasir.tambahBarang(ItemBelanjaan('6', 'Kecap', 5000));

  print('Salsa Shop\n Madiun \n ------------------------ \n ');

  // Menampilkan daftar barang
  kasir.tampilkanDaftarBarang();

  bool selesai = false;

  while (!selesai) {
    print('\nMasukkan kode barang (ketik "selesai" untuk menghitung total): ');
    String? kode = stdin.readLineSync();

    if (kode?.toLowerCase() == 'selesai') {
      selesai = true;
      kasir.tampilkanTotal();
    } else {
      print('Masukkan jumlah: ');
      String? jumlahInput = stdin.readLineSync();
      int jumlah = int.parse(jumlahInput!);

      kasir.tambahItemBelanjaan(kode!, jumlah);
    }
  }
}
