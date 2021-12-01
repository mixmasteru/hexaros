FROM osrf/ros:foxy-desktop

ARG DEBIAN_FRONTEND=noninteractive

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
RUN apt-get update && apt-get upgrade -y && apt install -y ros-foxy-gazebo-ros-pkgs && apt install -y ros-foxy-xacro
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
RUN mkdir -p ~/.local/lib/python3.8/ && ln -s /opt/ros/foxy/lib/python3.8/site-packages ~/.local/lib/python3.8/

CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/my_sshd_config"]
