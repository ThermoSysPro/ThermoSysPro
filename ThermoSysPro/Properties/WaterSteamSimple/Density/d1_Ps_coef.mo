within ThermoSysPro.Properties.WaterSteamSimple.Density;
record d1_Ps_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=9.980313e+02,
    c10=3.263070e-07,
    c01=6.573635e-03,
    c20=-4.169014e-16,
    c11=9.483072e-11,
    c02=-2.791938e-05);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end d1_Ps_coef;
