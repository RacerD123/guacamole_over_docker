### Prerequisites
- Docker
- Docker Compose

### Use
1. run `docker compose up` (First run will take an hour or two)
2. connect (using your web browser) to localhost:8080/guacamole
3. Log-in with Username (`guacadmin`) and Password (`guacadmin` by default)
4. Click on the Machine you want to connect to.

### To Add Connections:
- Go to the top left corner, click username and then settings. Then go to the connections tab and add a connection!
- Alternatively, to have connections happen even on re-building the docker container, add entries to the end of the initdb.sql file. Entries are based on the properties in https://guacamole.apache.org/doc/gug/configuring-guacamole.html#configuring-connections. 