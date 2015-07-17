FROM ubuntu:14.04

#3.4.3
ENV PYTHON_VERSION 2.7
ENV NUM_CORES 4

# Install OpenCV 3.0
RUN apt-get -y update
RUN apt-get -y install python$PYTHON_VERSION-dev wget \
                       build-essential cmake git pkg-config libatlas-base-dev gfortran \
                       libjasper-dev libgtk2.0-dev libavcodec-dev libavformat-dev \
                       libswscale-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libv4l-dev
RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install numpy

RUN git clone https://github.com/Itseez/opencv.git
RUN git clone https://github.com/Itseez/opencv_contrib.git
RUN cd /opencv && git checkout 3.0.0
RUN cd /opencv_contrib && git checkout 3.0.0
RUN mkdir /opencv/build
WORKDIR /opencv/build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D BUILD_PYTHON_SUPPORT=ON \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON \
	-D BUILD_NEW_PYTHON_SUPPORT=ON \
	-D WITH_IPP=OFF \
	-D WITH_V4L=ON ..
RUN make -j$NUM_CORES
RUN make install
RUN ldconfig
# Define default command.
CMD ["bash"]
