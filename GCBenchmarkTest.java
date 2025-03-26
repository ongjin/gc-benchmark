import java.lang.management.ManagementFactory;
import java.lang.management.GarbageCollectorMXBean;
import java.util.ArrayList;
import java.util.List;

public class GCBenchmarkTest {

    public static void main(String[] args) {
        System.out.println("GC 벤치마크 실행 시작");

        long startTime = System.currentTimeMillis();

        List<byte[]> memoryHog = new ArrayList<>();
        for (int i = 0; i < 1_000_000; i++) {
            memoryHog.add(new byte[1024]);
            if (i % 10000 == 0)
                memoryHog.clear();
        }

        long elapsed = System.currentTimeMillis() - startTime;

        System.out.println("실행 시간: " + elapsed + " ms");

        System.out.println("GC 정보:");
        for (GarbageCollectorMXBean gcBean : ManagementFactory.getGarbageCollectorMXBeans()) {
            System.out.printf("▶ GC 이름: %s | 횟수: %d | 시간: %d ms\n",
                    gcBean.getName(),
                    gcBean.getCollectionCount(),
                    gcBean.getCollectionTime());
        }
    }
}
