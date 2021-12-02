FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Dependencies for glvnd and X11.
RUN apt-get update \
  && apt-get install -y -qq --no-install-recommends \
    libglvnd0 \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6 \
  && rm -rf /var/lib/apt/lists/*# Env vars for the nvidia-container-runtime.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

RUN apt-get update && apt-get upgrade -y && apt-get install -y libgl1-mesa-glx libgl1-mesa-dri && rm -rf /var/lib/apt/lists/*
RUN apt-get update \
  && apt-get install -y ssh \
      build-essential \
      gcc \
      g++ \
      gdb \
      clang \
      cmake \
      rsync \
      tar \
      python \
  && apt-get clean

RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/my_sshd_config \
  && mkdir /run/sshd

RUN echo "root:root" | chpasswd
RUN apt-get install -y software-properties-common && add-apt-repository universe
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN mkdir -p ~/ros2_galactic && cd ~/ros2_galactic \
    && wget "https://github.com/ros2/ros2/releases/download/release-foxy-20211013/ros2-foxy-20211013-linux-focal-amd64.tar.bz2" \
    && tar xf ros2-foxy-20211013-linux-focal-amd64.tar.bz2

RUN wget -O /usr/share/keyrings/ros-archive-keyring.gpg https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  \
    && apt update && apt install -y python3-rosdep && rosdep init && rosdep update

RUN rosdep install --from-paths ~/ros2_galactic/ros2-linux/share --ignore-src -y --skip-keys "cyclonedds fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers"
RUN apt install -y libpython3-dev python3-pip
RUN echo ". ~/ros2_galactic/ros2-linux/setup.bash" >> ~/.bashrc

RUN apt-get update && apt-get upgrade -y \
    && apt install -y ros-galactic-gazebo-ros-pkgs && apt install -y ros-galactic-xacro \
    && apt install -y ros-galactic-rqt*

RUN ["/bin/bash", "-c", "source /root/ros2_galactic/ros2-linux/setup.bash && env > .env"]
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/my_sshd_config"]
#RUN ["/bin/bash", "-c", "source /root/ros2_galactic/ros2-linux/setup.bash"]
#CMD /bin/bash -c "/usr/sbin/sshd -D -e -f /etc/ssh/my_sshd_config"