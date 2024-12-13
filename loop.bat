@echo off
set /a counter=0
set /a log_number=1
set /a max_time=43200   :: 30 hari dalam menit (30 * 24 * 60)
set /a interval=300     :: Interval waktu untuk log (300 menit = 5 jam)
set /a time_interval=0

:loop
:: Menampilkan status log setiap interval waktu
if %time_interval% GEQ %interval% (
    echo Logs %log_number% Active
    echo Logs %log_number% Status: Active
    echo Logs %log_number% Complete
    set /a log_number+=1
    set /a time_interval=0
)

:: Menampilkan status aktif
echo HEN RDP ACTIVE!!
set /a counter+=1

:: Jika waktu mencapai batas (30 hari), keluar dari loop
if %counter% GEQ %max_time% (
    echo Maksimum waktu tercapai. Keluar dari loop.
    exit
)

:: Menunggu 60 detik sebelum melanjutkan iterasi berikutnya
timeout /t 60 >nul

:: Meningkatkan waktu interval setelah setiap iterasi
set /a time_interval+=1

goto loop