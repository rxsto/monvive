import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;

class Database {
  
  MySQL mysql;
  
  Database(PApplet applet, String host, String database, String user, String password) {
    mysql = new MySQL(applet, host, database, user, password);
    mysql.connect();
  }
}
