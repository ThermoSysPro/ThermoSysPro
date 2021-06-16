within ThermoSysPro.Properties.WaterSteamSimple.Energy;
record u2_Ph_coef
  extends Modelica.Icons.Record;

   extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=4.060030e+05,
    c10=-1.900410e-03,
    c01=8.048624e-01,
    c20=-1.701173e-11,
    c11=1.148079e-09,
    c02=-1.321884e-08,
    c30=3.221281e-20,
    c21=2.194292e-18,
    c12=-1.550691e-16,
    c03=1.945920e-15);
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end u2_Ph_coef;
