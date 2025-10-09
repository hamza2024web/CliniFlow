# Partir de l'image officielle de WildFly
FROM quay.io/wildfly/wildfly:26.1.3.Final-jdk17

# Créer un utilisateur pour la console d'administration
RUN /opt/jboss/wildfly/bin/add-user.sh admin password123 --silent

# Copier le JAR du driver PostgreSQL
COPY postgresql-42.7.3.jar /tmp/

# Installer le module PostgreSQL avec les bonnes dépendances
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --command="module add --name=org.postgresql --resources=/tmp/postgresql-42.7.3.jar --dependencies=javax.api,javax.transaction.api,javax.xml.bind.api"

# Copier le fichier de configuration standalone.xml
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml

# Exposer les ports
EXPOSE 8080 9990