within ThermoSysPro.Properties.WaterSteamSimple.Temperature;
record T1_Ph_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=2.717696e+02,
    c10=-2.672714e-07,
    c01=2.545454e-04,
    c20=-4.619256e-16,
    c11=2.760164e-13,
    c02=-2.374125e-11);
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end T1_Ph_coef;
