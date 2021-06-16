within ThermoSysPro.Properties.WaterSteamSimple.Temperature;
record Tsat_P_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order7(
    c7=6.068643e-47,
    c6=-4.883642e-39,
    c5=1.566811e-31,
    c4=-2.555574e-24,
    c3=2.238987e-17,
    c2=-1.025730e-10,
    c1=2.309995e-04,
    c0=3.137379e+02);
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end Tsat_P_coef;
