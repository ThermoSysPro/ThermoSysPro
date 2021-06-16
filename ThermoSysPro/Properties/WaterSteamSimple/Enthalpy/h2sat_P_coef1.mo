within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
record h2sat_P_coef1
  extends Modelica.Icons.Record;

  constant Real a0 =   2.242e+06;
  constant Real a =   1.381e+05;
  constant Real b =     0.09867;

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end h2sat_P_coef1;
