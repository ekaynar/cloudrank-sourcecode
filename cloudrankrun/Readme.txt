
CloudRank-D Version 1.0

This is a brief introduction of usage for users. 
For more details, please refer to "User Manual of CloudRank-D".
configuration/
:record configuration of CloudRank-D, please modify associated 
 parameters according to your own situations.
associationrulemining/
folders like this place scripts respectively.
under these directories:
prepare-*.sh: prepare dataset, and upload it to HDFS.
delete-*.sh: delete the dataset on HDFS users specify.
run-*.sh: run workloads with dataset users specify.
file.include: record all datasets for this application on HDFS.

For different applications, the parameter are different, here,
we give some examples to show the usage.
Basic operation/sort/    ./prepare-sort.sh 10g(10GB)
                         ./run-sort.sh 10g(can't be omitted)
Classifier/Naive Bayes   ./prepare-bayes.sh 2
                          (4GB, 2 a multiple,original data size is 2GB)
                         ./run-bayes.sh 2(detele the dataset with 4GB)
Cluster/kmeans           ./prepare-kmeans.sh low|mid|high
                         ./run-kmeans.sh low|mid|high
                          (three dataset with different size)
Recommendation/item based collaboration filtering(ibcf)
                         ./prepare-ibcf.sh 2
                         ./run-ibcf.sh 2
                          (2 is a multiple)
Association rule mining/frequent pattern-growth(fpg)
                         ./prepare-fpg.sh low|mid|high
                         ./run-fpg.sh low|mid|high
Sequence learning/hidden markov model(hmm)
                         ./prepare-hmm.sh 2
                         ./run-hmm.sh 2
Data warehouse operation/
                         datagen/htmlgen/  ./generateData.py
                         datagen/teragen/  ./teragen.pl
                         ./benchmark_gs.sh
                         ./benchmark_rs.sh
                         ./benchmark_us.sh
                         ./benchmark_ruj.sh
                         
