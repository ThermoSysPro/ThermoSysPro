within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
record lambda2_Ph_coef
  extends Modelica.Icons.Record;

   extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00=4.685560e-01,
    c10=1.002884e-08,
    c01=-3.807181e-07,
    c20=-1.441261e-17,
    c11=-3.045428e-15,
    c02=1.024663e-13,
    c30=-5.492118e-26,
    c21=4.957386e-24,
    c12=2.051417e-22,
    c03=-7.708932e-21);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end lambda2_Ph_coef;
