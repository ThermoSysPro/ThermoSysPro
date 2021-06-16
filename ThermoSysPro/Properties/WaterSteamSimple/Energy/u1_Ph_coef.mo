within ThermoSysPro.Properties.WaterSteamSimple.Energy;
record u1_Ph_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=-8.183623e+02,
    c10=-9.814738e-04,
    c01=1.006746e+00,
    c20=7.668813e-13,
    c11=-2.138554e-10,
    c02=-6.488963e-09);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end u1_Ph_coef;
