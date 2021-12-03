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

RUN apt install -y libpython3-dev python3-pip
RUN pip install -U pytest colcon-common-extensions

RUN locale && apt update \
    && apt install locales  \
    && locale-gen en_US en_US.UTF-8  \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
    && export LANG=en_US.UTF-8  \
    && locale  # verify settings
RUN apt-cache policy | grep universe
RUN apt-get install -y software-properties-common && add-apt-repository universe
RUN wget -O /usr/share/keyrings/ros-archive-keyring.gpg https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt-get update && apt-get upgrade -y \
    && apt install -y ros-galactic-desktop \
    && apt install -y ros-galactic-gazebo-ros-pkgs  \
    && apt install -y ros-galactic-xacro \
    && apt install -y ros-galactic-rqt* \
    && apt install -y ros-galactic-joint-state-publisher-gui

RUN echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc

RUN ["/bin/bash", "-c", "source /opt/ros/galactic/setup.bash && env > .env"]
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/my_sshd_config"]