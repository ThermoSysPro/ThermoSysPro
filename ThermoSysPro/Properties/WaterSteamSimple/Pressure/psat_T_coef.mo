within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
record psat_T_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order7(
    c7=7.677448367806697e-11,
    c6=-2.327974895639335e-07,
    c5=2.984399245658974e-04,
    c4=-2.081210501212062e-01,
    c3=8.527291155079814e+01,
    c2=-2.055993982138471e+04,
    c1=2.704822454027627e+06,
    c0=-1.499284498173245e+08);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end psat_T_coef;
