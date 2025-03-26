import java.lang.management.GarbageCollectorMXBean;
import java.lang.management.ManagementFactory;
import java.util.ArrayList;
import java.util.List;

public class GCBenchmark {

    public static void main(String[] args) {
        long startApp = System.currentTimeMillis();
        long startGcTime = totalGcTime();
        long startGcCount = totalGcCount();

        System.out.println("GC 스트레스 테스트 시작");

        // 4GB 가까이 점유하도록 객체 생성
        List<byte[]> memoryLoad = new ArrayList<>();
        final int iterations = 1_000_000; // 충분한 반복
        final int chunkSize = 512 * 1024; // 512KB

        for (int i = 0; i < iterations; i++) {
            memoryLoad.add(new byte[chunkSize]);

            // 일정 주기마다 메모리 해제 → GC 유도
            if (i % 5000 == 0) {
                memoryLoad.clear();
                try {
                    Thread.sleep(10); // GC가 개입할 여유 줌
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
            }
        }

        long endApp = System.currentTimeMillis();
        long endGcTime = totalGcTime();
        long endGcCount = totalGcCount();

        System.out.println("총 실행 시간: " + (endApp - startApp) / 1000.0 + " 초");
        System.out.println("GC 횟수: " + (endGcCount - startGcCount));
        System.out.println("GC 지연(Pause) 시간: " + (endGcTime - startGcTime) + " ms");

        System.out.println("사용된 GC 목록:");
        for (GarbageCollectorMXBean gc : ManagementFactory.getGarbageCollectorMXBeans()) {
            System.out.printf(" - %s%n", gc.getName());
        }
    }

    static long totalGcTime() {
        return ManagementFactory.getGarbageCollectorMXBeans().stream()
                .mapToLong(GarbageCollectorMXBean::getCollectionTime)
                .sum();
    }

    static long totalGcCount() {
        return ManagementFactory.getGarbageCollectorMXBeans().stream()
                .mapToLong(GarbageCollectorMXBean::getCollectionCount)
                .sum();
    }
}
