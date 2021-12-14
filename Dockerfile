FROM openjdk:17-bullseye

RUN apt-get install git

RUN mkdir /app

WORKDIR /app

ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar /app/

RUN git config --global --unset core.autocrlf || true

RUN java -jar BuildTools.jar

RUN mv spigot-*.jar spigot.jar

# adding plugins for bedrock
ADD https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/target/floodgate-spigot.jar /app/plugins/
ADD https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar /app/plugins/

# expose java ports
EXPOSE 25565:25565/tcp 25565:25565/udp

# also expose the rcon ports
EXPOSE 25575:25575/tcp 25575:25575/udp

# expose bedrock ports 
EXPOSE 19132:19132/udp

CMD [ "java", "-Xms3G", "-Xmx3G", "-XX:+UseG1GC", "-Dcom.mojang.eula.agree=true", "-jar", "spigot.jar", "nogui" ]
