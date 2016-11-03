docker build -t opencv3 .
docker run -ti --rm \
       -e DISPLAY \
       -e QT_GRAPHICSSYSTEM=gtk
       -v /tmp/.X11-unix:/tmp/.X11-unix:ro  -v /home/alex/Devel:/Devel \
-u  $(id -u)  opencv3
