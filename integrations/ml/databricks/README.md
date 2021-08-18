# Use Intel Optimized ML libraries on Azure Databricks cloud with Databricks Runtime 
This document is used to guide the steps of creating clusters with Intel Optimized ML libraries on Databricks.  The current init scripts works for Databricks Runtime version higher than 7.5. 

We provided two init script options which are different on scikit-learn usage. Both options are the same as to TensorFlow. Before you go, please read below information and decide which opiton is most suitable for you and undersand the impacts each option may have.

**Option A: init_intel_optimized_ml.sh** For this init script option, an [Intel optimized or "static patched" scikit-learn](https://anaconda.org/intel/scikit-learn) is installed and replace this existing scikit-learn library. All the user program will use the optimized scikit-learn without any code change. The optimized scikit-learn optimizes the algorithm by calling to daal4py implementations of the same algorithm which may lead different results comparing with the stock version scikit-learn. This option works for *Runtime:7.6 ML* only. 

**Optionn B: init_intel_optimized_ml_ex.sh**  For this init scirpt opiton, [scikit-learn-intelex](https://github.com/intel/scikit-learn-intelex#%EF%B8%8F-get-started) is installed and the existing scikit-learn library will kept unchanged at the installation time. The user program need to explicitly patch the existing scikit-learn library with scikit-learn-intelex by calling patch_sklearn like below at the beginning:

from sklearnex import patch_sklearn <br/>
patch_sklearn()

Because of this, you can choose which program to use the optimized implemention by calling the patch_sklearn() method. This option works for *Runtime:7.6*, and *Runtime 8.x". 

## 1. Upload init script

Upload the init script **[init_intel_optimized_ml.sh](./init_intel_optimized_ml.sh)**(Or **[init_intel_optimized_ml_ex.sh](./init_intel_optimized_ml_ex.sh)** according to your choice. But in the following steps, we only take one as an example.) to Databricks DBFS:

1. Download **[init_intel_optimized_ml.sh](./init_intel_optimized_ml.sh)** to a local folder.
2. Click **Data** icon in the left sidebar.
3. Click the **DBFS** button and then **Upload** button at the top.
4. Select a target directory, for example, FileStore, in the **Upload Data to DBFS** dialog.
5. Browse to the file **[init_intel_optimized_ml.sh](./init_intel_optimized_ml.sh)** in the local folder to upload in the Files box.

![upload_init_script](./imgs/upload_init_script.png)


## 2. Create a new cluster using the init script
To create a new cluster using the uploaded init script, follow the following steps:

1. Click the  **Clusters** icon in the left sidebar.
2. Choose the Cluster Mode and Databricks Runtim Version, such as **Runtime:7.6 ML**.
3. Click the **Advanced Options** toggle on the cluster configuration page,
4. Click the **Init Scripts** tab at the bottom of the page.
5. Select the "DBFS" destination type in the **Destination** drop-down.
6. Specify a path to the init script. In the example in the preceding section, the path is **dbfs:/FileStore/init_intel_optimized_ml.sh**. The path must begin with dbfs:/.
7. Click **Add**. 

![create_cluster](./imgs/create_cluster.png)


## 3. Run benchmark notebooks for performance comparisons

Please refer to the [Benchmark Guide](./benchmark/README.md) to learn how to use notebooks to easily run performance comparisons.
