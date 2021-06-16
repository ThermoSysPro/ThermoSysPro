within ThermoSysPro.Properties.WaterSteamSimple.Density;
record d1_Ph_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=1.005457e+03,
    c10=4.112059e-07,
    c01=-7.025326e-05,
    c20=-1.685565e-15,
    c11=6.942597e-13,
    c02=-1.146613e-10);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end d1_Ph_coef;
