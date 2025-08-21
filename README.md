1. **静态编译构建**

```
sh build.sh
```

```
loongarch64-linux-gnu-g++ -O3 -std=c++11 -static -fopenmp -std=c++11 -O3 -Wall -fopenmp src/bc.cc -o output/bc
loongarch64-linux-gnu-g++ -O3 -std=c++11 -static -fopenmp -std=c++11 -O3 -Wall -fopenmp src/bfs.cc -o output/bfs
loongarch64-linux-gnu-g++ -O3 -std=c++11 -static -fopenmp -std=c++11 -O3 -Wall -fopenmp src/cc.cc -o output/cc
loongarch64-linux-gnu-g++ -O3 -std=c++11 -static -fopenmp -std=c++11 -O3 -Wall -fopenmp src/cc_sv.cc -o output/cc_sv
loongarch64-linux-gnu-g++ -O3 -std=c++11 -static -fopenmp -std=c++11 -O3 -Wall -fopenmp src/pr.cc -o output/pr
loongarch64-linux-gnu-g++ -O3 -std=c++11 -static -fopenmp -std=c++11 -O3 -Wall -fopenmp src/pr_spmv.cc -o output/pr_spmv
loongarch64-linux-gnu-g++ -O3 -std=c++11 -static -fopenmp -std=c++11 -O3 -Wall -fopenmp src/sssp.cc -o output/sssp
loongarch64-linux-gnu-g++ -O3 -std=c++11 -static -fopenmp -std=c++11 -O3 -Wall -fopenmp src/tc.cc -o output/tc
loongarch64-linux-gnu-g++ -O3 -std=c++11 -static -fopenmp -std=c++11 -O3 -Wall -fopenmp src/converter.cc -o output/converter
```



2. **测试文件位置**

```
output
├── bc
├── bfs
├── cc
├── cc_sv
├── converter
├── pr
├── pr_spmv
├── sssp
└── tc
```



