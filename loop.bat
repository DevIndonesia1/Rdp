@echo off
set /a counter=0
set /a log_number=1
set /a max_time=43200  # 30 hari dalam menit (30 * 24 * 60)
set /a interval=300    # Setiap 5 jam (300 menit)
set /a time_interval=0

:loop
rem Menampilkan status aktif RDP setiap interval waktu
if %time_interval% GEQ %interval% (
    echo Logs %log_number% Active
    echo Logs %log_number% Status: Active
    echo Logs %log_number% Complete
    set /a log_number+=1
    set /a time_interval=0
)

rem Melakukan ping untuk menjaga agar sistem tetap aktif
echo HEN RDP ACTIVE!!
set /a counter+=1

rem Jika waktu mencapai batas (30 hari atau lebih), keluar dari loop
if %counter% GEQ %max_time% exit

rem Menunggu 60 detik sebelum melanjutkan ke iterasi berikutnya
ping 127.0.0.1 > Nul
timeout /t 60 >nul  # Menunggu 60 detik (1 menit)

rem Meningkatkan waktu interval setelah setiap iterasi
set /a time_interval+=1

goto loop
