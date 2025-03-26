@echo off
setlocal

del /q logs\*.log >nul 2>&1

javac GCPauseBenchmark.java

echo �� G1GC �׽�Ʈ ��...
java -cp . -Xms1g -Xmx1g -Xlog:gc*:file=logs\g1gc.log -XX:+UseG1GC GCBenchmarkTest

echo �� ZGC �׽�Ʈ ��...
java -cp . -Xms1g -Xmx1g -Xlog:gc*:file=logs\zgc.log -XX:+UseZGC GCBenchmarkTest

echo �� GenZGC �׽�Ʈ ��...
java -cp . -Xms1g -Xmx1g -Xlog:gc*:file=logs\genzgc.log -XX:+UseZGC -XX:+ZGenerational GCBenchmarkTest

echo ��� �׽�Ʈ �Ϸ�. �α״� logs ���� Ȯ��
