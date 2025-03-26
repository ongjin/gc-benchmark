@echo off
setlocal

del /q logs\*.log >nul 2>&1

javac GCPauseBenchmark.java

echo ▶ G1GC 테스트 중...
java -cp . -Xms1g -Xmx1g -Xlog:gc*:file=logs\g1gc.log -XX:+UseG1GC GCBenchmarkTest

echo ▶ ZGC 테스트 중...
java -cp . -Xms1g -Xmx1g -Xlog:gc*:file=logs\zgc.log -XX:+UseZGC GCBenchmarkTest

echo ▶ GenZGC 테스트 중...
java -cp . -Xms1g -Xmx1g -Xlog:gc*:file=logs\genzgc.log -XX:+UseZGC -XX:+ZGenerational GCBenchmarkTest

echo 모든 테스트 완료. 로그는 logs 폴더 확인
