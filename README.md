# Skrypt .bat korzystający z TCC

Krótki skrypt wykrywający odpalającą go powłokę tekstową oraz korzystający z poleceń TCC.  
[Treść zadania](Ćwiczenie_3_SO.pdf)

## Najważniejsze funkcje
* Wbudowana pomoc
* Wykrywanie powłoki
* Wypisywanie wersji powłoki
* Sprawdzanie parametrów uruchomienia
* Wykorzystanie funkcji [_@CRC32_](https://jpsoft.com/help/f_crc32.htm) z TCC

## Użycie
* Skrypt.bat (- ^| /)(h ^| help ^| ?) - wyświetla pomoc
* Skrypt.bat -(crc ^| CRC) ciągZnaków - liczy sumę kontrolna CRC32 z podanego ciągu
* Skrypt.bat -(crcf ^| CRCF) ścieżkaDoPliku - liczy sumę kontrolna CRC32 z wskazanego pliku
* Skrypt.bat -(sha ^| SHA) ciągZnaków - liczy sumę kontrolna SHA256 z podanego ciągu
* Skrypt.bat -(md5 ^| MD5) ciągZnaków - liczy sumę kontrolna MD5 z podanego ciągu
* Skrypt.bat -(md5f ^| MD5F) ścieżkaDoPliku - liczy sumę kontrolna MD5 z wskazanego pliku

## Przykłady użycia
* Skrypt.bat -md5f "C:\windows\explorer.exe"
* Skrypt.bat -crc Ludwik
* Skrypt.bat -CRC "Ala ma kota."

--------------------------

Skrypt został napisany w celu realizacji 3 laboratoriów z Systemów Operacyjnych.