import java.lang.management.GarbageCollectorMXBean;
import java.lang.management.ManagementFactory;
import java.util.ArrayList;
import java.util.List;

public class GCPauseBenchmark {

    public static void main(String[] args) {
        long startApp = System.currentTimeMillis();
        long startGcTime = totalGcTime();
        long startGcCount = totalGcCount();

        System.out.println("GC 벤치마크 시작");

        // 메모리를 반복적으로 할당하고 해제하여 GC 유도
        List<byte[]> list = new ArrayList<>();
        for (int i = 0; i < 2_000_000; i++) {
            list.add(new byte[1024]); // 2GB 이상 할당 유도
            if (i % 10000 == 0)
                list.clear();
        }

        long endApp = System.currentTimeMillis();
        long endGcTime = totalGcTime();
        long endGcCount = totalGcCount();

        System.out.println("총 실행 시간: " + (endApp - startApp) + " ms");
        System.out.println("GC 횟수: " + (endGcCount - startGcCount));
        System.out.println("GC 지연(Pause) 시간: " + (endGcTime - startGcTime) + " ms");

        System.out.println("사용된 GC 목록:");
        for (GarbageCollectorMXBean gc : ManagementFactory.getGarbageCollectorMXBeans()) {
            System.out.printf(" - %s\n", gc.getName());
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
