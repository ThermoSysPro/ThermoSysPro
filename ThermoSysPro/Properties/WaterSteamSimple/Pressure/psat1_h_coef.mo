within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
record psat1_h_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order5(
    c5=-3.796712e-24,
    c4=1.178722e-17,
    c3=-5.695964e-12,
    c2=-3.306483e-07,
    c1=1.014721e+00,
    c0=-1.181642e+05);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end psat1_h_coef;
