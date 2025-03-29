@echo off
setlocal

:: 로그 디렉토리 생성
if not exist logs mkdir logs

:: 로그 디렉토리 정리
del /q logs\*.log >nul 2>&1
del /q logs\*.out >nul 2>&1

:: 컴파일
javac GCBenchmark.java

:: G1GC 테스트
echo ▶ G1GC 테스트 중...
echo [G1GC 실행 결과] > logs\zgc.out
java -cp . -Xms4g -Xmx4g -Xlog:gc*:file=logs\g1gc.log -XX:+UseG1GC GCBenchmark >> logs\zgc.out
echo. >> logs\zgc.out

:: ZGC 테스트
echo ▶ ZGC 테스트 중...
echo [ZGC 실행 결과] >> logs\zgc.out
java -cp . -Xms4g -Xmx4g -Xlog:gc*:file=logs\zgc.log -XX:+UseZGC GCBenchmark >> logs\zgc.out
echo. >> logs\zgc.out

:: GenZGC 테스트
echo ▶ GenZGC 테스트 중...
echo [GenZGC 실행 결과] >> logs\zgc.out
java -cp . -Xms4g -Xmx4g -Xlog:gc*:file=logs\genzgc.log -XX:+UseZGC -XX:+ZGenerational GCBenchmark >> logs\zgc.out
echo. >> logs\zgc.out

echo.
echo 모든 테스트 완료. 로그는 logs 폴더 확인
pause