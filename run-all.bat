@echo off
setlocal

del /q logs\*.log >nul 2>&1

javac GCBenchmark.java

echo �� G1GC �׽�Ʈ ��...
java -cp . -Xms2g -Xmx2g -Xlog:gc*:file=logs\g1gc.log -XX:+UseG1GC GCBenchmark

echo �� ZGC �׽�Ʈ ��...
java -cp . -Xms2g -Xmx2g -Xlog:gc*:file=logs\zgc.log -XX:+UseZGC GCBenchmark

echo �� GenZGC �׽�Ʈ ��...
java -cp . -Xms2g -Xmx2g -Xlog:gc*:file=logs\genzgc.log -XX:+UseZGC -XX:+ZGenerational GCBenchmark

echo ��� �׽�Ʈ �Ϸ�. �α״� logs ���� Ȯ��
