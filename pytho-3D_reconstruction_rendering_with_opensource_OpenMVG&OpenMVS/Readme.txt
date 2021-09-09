We use opensource platforms openMVG and openMVS for reconstruction and rendering.
To use these two platforms, we have to get the code by git command from the website and build the software in our local PC (in Linux operating system).
Here is the website of two platforms:
openMVG: https://github.com/openMVG/openMVG
openMVS: https://github.com/cdcseacave/openMVS

After successfully building two software, we could use them with the multi-view images that we have obtained from the synthetic environment or realist environment.
The way to use it is detailed in the tutorial of two platforms:

*openMVG: https://github.com/openMVG/openMVG/wiki/OpenMVG-on-your-image-dataset
 command:
   $ cd openMVG_Build/software/SfM/
   $ python SfM_SequentialPipeline.py [full path image directory] [resulting directory]
   $ python SfM_SequentialPipeline.py ~/home/user/data/ImageDataset_SceauxCastle/images ~/home/user/data/ImageDataset_SceauxCastle/Castle_Incremental_Reconstruction

*openMVS: https://github.com/cdcseacave/openMVS/wiki/Usage
 steps and commands:
  1.Convert SfM scene from OpenMVG:
    openMVG_main_openMVG2openMVS -i sfm_data.bin -o scene.mvs -d scene_undistorted_images
  2.Dense Point-Cloud Reconstruction
    DensifyPointCloud scene.mvs
  3.Rough Mesh Reconstruction
    ReconstructMesh scene_dense.mvs
  4.Mesh Refinement
    RefineMesh scene_dense_mesh.mvs --max-face-area 16
  5.Mesh Texturing
    TextureMesh scene_dense_mesh_refine.mvs
The result is in a .ply file, which can be viewed by 3D visualization tools, such as Meshlab.