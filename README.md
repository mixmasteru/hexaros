# hexaros

```bash
colcon build --symlink-install --packages-select hexapod_desc
. install/local_setup.bash
ros2 launch hexapod_desc display.launch.py model:=`ros2 pkg prefix --share hexapod_desc`/urdf/hexapod.urdf
```