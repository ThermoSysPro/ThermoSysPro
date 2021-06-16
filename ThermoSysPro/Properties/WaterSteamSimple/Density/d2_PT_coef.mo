within ThermoSysPro.Properties.WaterSteamSimple.Density;
record d2_PT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=8.573340e+01,
    c10=2.032089e-05,
    c01=-3.131904e-01,
    c20=9.742006e-15,
    c11=-2.602836e-08,
    c02=3.165324e-04,
    c30=-1.477236e-22,
    c21=7.411890e-18,
    c12=8.461200e-12,
    c03=-9.503033e-08);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end d2_PT_coef;
