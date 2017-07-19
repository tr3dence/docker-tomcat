docker-tomcat
=============
[![](https://images.microbadger.com/badges/version/tredence/java_tomcat.svg)](https://microbadger.com/images/tredence/java_tomcat "Get your own version badge on microbadger.com")

[![](https://images.microbadger.com/badges/image/tredence/java_tomcat.svg)](https://microbadger.com/images/tredence/java_tomcat "Get your own image badge on microbadger.com")

[![dockeri.co](http://dockeri.co/image/tredence/java_tomcat)](https://registry.hub.docker.com/t/tredence/java_tomcat/)


Ubuntu 14.04, Oracle JDK 8 and Tomcat 8 based docker container.

# Description
You should run this container on the background and mount the volume with your web app inside.

Includes:

 - Oracle JDK 1.8.111
 - Tomcat 8.0.39
 -  wget, curl, build-essential, nettools

USAGE
----
The first time that you run your container, a new user `admin` with all privileges
will be created in Tomcat with a random password. To get the password, check the logs
of the container by running:

    docker logs <CONTAINER_ID>

You will see an output like the following:

    ========================================================================
    You can now connect to this Tomcat server using:

        admin:b1uKcRK3r6SF

    Please remember to change the above password as soon as possible!
    ========================================================================

In this case, `b1uKcRK3r6SF` is the password allocated to the `admin` user.

You can now login to you admin console to configure your tomcat server:

    http://127.0.0.1:8080/manager/html
    http://127.0.0.1:8080/host-manager/html


Setting a specific password for the admin account
-------------------------------------------------

If you want to use a preset password instead of a random generated one, you can
set the environment variable `TOMCAT_PASS` to your specific password when running the container:

    docker run -d -p 8080:8080 -e TOMCAT_PASS="mypass" cloudesire/tomcat

You can now test your deployment:

    http://127.0.0.1:8080/

Done!

Environment variables
---------------------

* `JAVA_OPTS`: set additionals java options (default empty, e.g. `JAVA_OPTS=-Xmx2048m`)
* `TOMCAT_BIND_ON_INIT`: change bindOnInit parameter on the HTTP connector (default `TOMCAT_BIND_ON_INIT=true`)
