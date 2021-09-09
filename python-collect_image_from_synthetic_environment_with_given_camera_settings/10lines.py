# This is a 10 lines python example to show how to generate an image dataset with image, depth and object_mask.
# Read https://unrealcv.github.io/tutorial/getting_started.html before trying this script
# Note: if you need high-accuracy depth, please use `vget /camera/0/depth depth.exr`
import json; 
#camera_trajectory = json.load(open('camera_traj.json'))
#camera_trajectory = json.load(open('C.json'))
camera_trajectory = json.load(open(r'C:\Users\rchen328\OneDrive - The University of Western Ontario\research\IOT\report\3D_reconstruction\simulation_new\C.json'))
from unrealcv import client
import time
client.connect()
# Get object information
obj_info = client.request('vget /objects')
for [loc, rot] in camera_trajectory:
    # Set position of the first camera
    client.request('vset /camera/0/location {x} {y} {z}'.format(**loc))
    time.sleep(2)
    client.request('vset /camera/0/rotation {pitch} {yaw} {roll}'.format(**rot))
    time.sleep(2)
    # Get image and ground truth
    filename = client.request('vget /camera/0/lit')
    time.sleep(2)
print("over")
