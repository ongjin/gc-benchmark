@echo off
setlocal

:: �α� ���丮 ����
if not exist logs mkdir logs

:: �α� ���丮 ����
del /q logs\*.log >nul 2>&1
del /q logs\*.out >nul 2>&1

:: ������
javac GCBenchmark.java

:: G1GC �׽�Ʈ
echo �� G1GC �׽�Ʈ ��...
echo [G1GC ���� ���] > logs\zgc.out
java -cp . -Xms4g -Xmx4g -Xlog:gc*:file=logs\g1gc.log -XX:+UseG1GC GCBenchmark >> logs\zgc.out
echo. >> logs\zgc.out

:: ZGC �׽�Ʈ
echo �� ZGC �׽�Ʈ ��...
echo [ZGC ���� ���] >> logs\zgc.out
java -cp . -Xms4g -Xmx4g -Xlog:gc*:file=logs\zgc.log -XX:+UseZGC GCBenchmark >> logs\zgc.out
echo. >> logs\zgc.out

:: GenZGC �׽�Ʈ
echo �� GenZGC �׽�Ʈ ��...
echo [GenZGC ���� ���] >> logs\zgc.out
java -cp . -Xms4g -Xmx4g -Xlog:gc*:file=logs\genzgc.log -XX:+UseZGC -XX:+ZGenerational GCBenchmark >> logs\zgc.out
echo. >> logs\zgc.out

echo.
echo ��� �׽�Ʈ �Ϸ�. �α״� logs ���� Ȯ��
pause