// STEP: Import required packages
import java.sql.*;
import java.io.FileWriter;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.File;

public class Lab_7 {
    private Connection c = null;
    private String dbName;
    private boolean isConnected = false;

    private void openConnection(String _dbName) {
        dbName = _dbName;

        if (false == isConnected) {
            System.out.println("++++++++++++++++++++++++++++++++++");
            System.out.println("Open database: " + _dbName);

            try {
                String connStr = new String("jdbc:sqlite:");
                connStr = connStr + _dbName;

                // STEP: Register JDBC driver
                Class.forName("org.sqlite.JDBC");

                // STEP: Open a connection
                c = DriverManager.getConnection(connStr);

                // STEP: Diable auto transactions
                c.setAutoCommit(false);

                isConnected = true;
                System.out.println("success");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }

            System.out.println("++++++++++++++++++++++++++++++++++");
        }
    }

    private void closeConnection() {
        if (true == isConnected) {
            System.out.println("++++++++++++++++++++++++++++++++++");
            System.out.println("Close database: " + dbName);

            try {
                // STEP: Close connection
                c.close();

                isConnected = false;
                dbName = "";
                System.out.println("success");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }

            System.out.println("++++++++++++++++++++++++++++++++++");
        }
    }

    private void createTable() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create table");

        Statement stmt = null;
        try {
            stmt = c.createStatement();
            String sql = "CREATE TABLE warehouse (" +
                        "w_warehousekey DECIMAL(9,0) NOT NULL PRIMARY KEY, " +
                        "w_name CHAR(100) NOT NULL, " +
                        "w_capacity DECIMAL(6,0) NOT NULL, " +
                        "w_suppkey DECIMAL(9,0) NOT NULL, " +
                        "w_nationkey DECIMAL(2,0) NOT NULL)";
            stmt.executeUpdate(sql);
            c.commit();
            System.out.println("Table created successfully");
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void populateTable() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Populate table");

        Statement stmt = null;
        try {
            stmt = c.createStatement();

            // Step 1: Retrieve Supplier Data
            String supplierSql = "SELECT s_suppkey FROM supplier";
            ResultSet suppliers = stmt.executeQuery(supplierSql);

            while (suppliers.next()) {
                int suppkey = suppliers.getInt("s_suppkey");

                // Step 2: Determine Top Three Nations for Each Supplier
                String topNationsSql = "SELECT n.n_nationkey, n.n_name, COUNT(*) as numOrders " +
                                    "FROM nation n JOIN customer c ON n.n_nationkey = c.c_nationkey " +
                                    "JOIN orders o ON c.c_custkey = o.o_custkey " +
                                    "JOIN lineitem l ON o.o_orderkey = l.l_orderkey " +
                                    "WHERE l.l_suppkey = " + suppkey + " " +
                                    "GROUP BY n.n_nationkey " +
                                    "ORDER BY numOrders DESC, n.n_name " +
                                    "LIMIT 3";
                ResultSet topNations = stmt.executeQuery(topNationsSql);

                // Step 3: Calculate Warehouse Capacity
                String capacitySql = "SELECT MAX(totalSize) as maxCapacity " +
                                    "FROM (SELECT SUM(p.p_size) as totalSize " +
                                    "FROM part p JOIN lineitem l ON p.p_partkey = l.l_partkey " +
                                    "WHERE l.l_suppkey = " + suppkey + " " +
                                    "GROUP BY l.l_orderkey)";
                ResultSet capacityResult = stmt.executeQuery(capacitySql);
                int capacity = 0;
                if (capacityResult.next()) {
                    capacity = capacityResult.getInt("maxCapacity") * 3; // Triple the max total part size
                }

                // Step 4 & 5: Generate Warehouse Data and Insert into Table
                int warehouseKey = 1; // Initialize warehouse key (should be unique across tuples)
                while (topNations.next()) {
                    String nationName = topNations.getString("n_name");
                    String warehouseName = "Warehouse " + suppkey + " " + nationName;

                    String insertSql = "INSERT INTO warehouse (w_warehousekey, w_name, w_capacity, w_suppkey, w_nationkey) " +
                                    "VALUES (" + warehouseKey + ", '" + warehouseName + "', " + capacity + ", " + suppkey + ", " + topNations.getInt("n_nationkey") + ")";
                    stmt.executeUpdate(insertSql);
                    warehouseKey++;
                }
            }

            c.commit();
            System.out.println("Table populated successfully");
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void dropTable() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Drop table");

        Statement stmt = null;
        try {
            stmt = c.createStatement();
            String sql = "DROP TABLE IF EXISTS warehouse";
            stmt.executeUpdate(sql);
            c.commit();
            System.out.println("Table dropped successfully");
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q1() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q1");

        Statement stmt = null;
        try {
            stmt = c.createStatement();
            String sql = "SELECT * FROM warehouse ORDER BY w_warehousekey";
            ResultSet rs = stmt.executeQuery(sql);

            FileWriter writer = new FileWriter("output/1.out", false);
            PrintWriter printer = new PrintWriter(writer);

            printer.printf("%10s %-40s %10s %10s %10s\n", "wId", "wName", "wCap", "sId", "nId");

            while (rs.next()) {
                // Extract data from result set
                String wId = rs.getString("w_warehousekey");
                String wName = rs.getString("w_name");
                String wCap = rs.getString("w_capacity");
                String sId = rs.getString("w_suppkey");
                String nId = rs.getString("w_nationkey");

                // Display values
                printer.printf("%10s %-40s %10s %10s %10s\n", wId, wName, wCap, sId, nId);
            }

            printer.close();
            writer.close();
            rs.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q2() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q2");

        Statement stmt = null;
        try {
            stmt = c.createStatement();
            String sql = "SELECT w_nationkey, COUNT(*) as numW, SUM(w_capacity) as totCap " +
                        "FROM warehouse GROUP BY w_nationkey " +
                        "ORDER BY numW DESC, totCap DESC, w_nationkey ASC";
            ResultSet rs = stmt.executeQuery(sql);

            FileWriter writer = new FileWriter("output/2.out", false);
            PrintWriter printer = new PrintWriter(writer);

            printer.printf("%-40s %10s %10s\n", "nation", "numW", "totCap");

            while (rs.next()) {
                // Extract data from result set
                String nation = rs.getString("w_nationkey");
                String numW = rs.getString("numW");
                String totCap = rs.getString("totCap");

                // Display values
                printer.printf("%-40s %10s %10s\n", nation, numW, totCap);
            }

            printer.close();
            writer.close();
            rs.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q3() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q3");

        Statement stmt = null;
        try {
            File fn = new File("input/3.in");
            FileReader reader = new FileReader(fn);
            BufferedReader in = new BufferedReader(reader);
            String nation = in.readLine();
            in.close();

            stmt = c.createStatement();
            String sql = "SELECT s_name, n_name, w_name " +
                        "FROM warehouse w JOIN supplier s ON w.w_suppkey = s.s_suppkey " +
                        "JOIN nation n ON s.s_nationkey = n.n_nationkey " +
                        "WHERE w.w_nationkey = " + nation +
                        " ORDER BY s_name";
            ResultSet rs = stmt.executeQuery(sql);

            FileWriter writer = new FileWriter("output/3.out", false);
            PrintWriter printer = new PrintWriter(writer);

            printer.printf("%-20s %-20s %-40s\n", "supplier", "nation", "warehouse");

            while (rs.next()) {
                // Extract data from result set
                String supplier = rs.getString("s_name");
                String supplierNation = rs.getString("n_name");
                String warehouse = rs.getString("w_name");

                // Display values
                printer.printf("%-20s %-20s %-40s\n", supplier, supplierNation, warehouse);
            }

            printer.close();
            writer.close();
            rs.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q4() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q4");

        Statement stmt = null;
        try {
            File fn = new File("input/4.in");
            FileReader reader = new FileReader(fn);
            BufferedReader in = new BufferedReader(reader);
            String region = in.readLine();
            int cap = Integer.parseInt(in.readLine());
            in.close();

            stmt = c.createStatement();
            String sql = "SELECT w_name, w_capacity " +
                        "FROM warehouse w JOIN nation n ON w.w_nationkey = n.n_nationkey " +
                        "JOIN region r ON n.n_regionkey = r.r_regionkey " +
                        "WHERE r.r_name = '" + region + "' AND w.w_capacity > " + cap +
                        " ORDER BY w_capacity DESC";
            ResultSet rs = stmt.executeQuery(sql);

            FileWriter writer = new FileWriter("output/4.out", false);
            PrintWriter printer = new PrintWriter(writer);

            printer.printf("%-40s %10s\n", "warehouse", "capacity");

            while (rs.next()) {
                // Extract data from result set
                String warehouse = rs.getString("w_name");
                String capacity = rs.getString("w_capacity");

                // Display values
                printer.printf("%-40s %10s\n", warehouse, capacity);
            }

            printer.close();
            writer.close();
            rs.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q5() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q5");

        Statement stmt = null;
        try {
            File fn = new File("input/5.in");
            FileReader reader = new FileReader(fn);
            BufferedReader in = new BufferedReader(reader);
            String nation = in.readLine();
            in.close();

            stmt = c.createStatement();
            String sql = "SELECT r_name, SUM(w_capacity) as total_capacity " +
                        "FROM warehouse w JOIN supplier s ON w.w_suppkey = s.s_suppkey " +
                        "JOIN nation n ON s.s_nationkey = n.n_nationkey " +
                        "JOIN region r ON n.n_regionkey = r.r_regionkey " +
                        "WHERE s.s_nationkey = " + nation +
                        " GROUP BY r_name ORDER BY r_name";
            ResultSet rs = stmt.executeQuery(sql);

            FileWriter writer = new FileWriter("output/5.out", false);
            PrintWriter printer = new PrintWriter(writer);

            printer.printf("%-20s %20s\n", "region", "capacity");

            while (rs.next()) {
                // Extract data from result set
                String region = rs.getString("r_name");
                String capacity = rs.getString("total_capacity");

                // Display values
                printer.printf("%-20s %20s\n", region, capacity);
            }

            printer.close();
            writer.close();
            rs.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
            }
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }


    public static void main(String args[]) {
        Lab_7 sj = new Lab_7();
        
        sj.openConnection("tpch.sqlite");

        sj.dropTable();
        sj.createTable();
        sj.populateTable();

        sj.Q1();
        sj.Q2();
        sj.Q3();
        sj.Q4();
        sj.Q5();

        sj.closeConnection();
    }
}
