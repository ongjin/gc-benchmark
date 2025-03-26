@echo off
setlocal

del /q logs\*.log >nul 2>&1

javac GCBenchmark.java

echo ▶ G1GC 테스트 중...
java -cp . -Xms2g -Xmx2g -Xlog:gc*:file=logs\g1gc.log -XX:+UseG1GC GCBenchmark

echo ▶ ZGC 테스트 중...
java -cp . -Xms2g -Xmx2g -Xlog:gc*:file=logs\zgc.log -XX:+UseZGC GCBenchmark

echo ▶ GenZGC 테스트 중...
java -cp . -Xms2g -Xmx2g -Xlog:gc*:file=logs\genzgc.log -XX:+UseZGC -XX:+ZGenerational GCBenchmark

echo 모든 테스트 완료. 로그는 logs 폴더 확인
