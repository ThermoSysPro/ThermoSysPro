within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
record s2_Ph_coef
  extends Modelica.Icons.Record;

  constant Real a =   -988.3;
  constant Real c0 =    3065;
  constant Real c1 =  0.0045;
  constant Real c2 =  -4.101e-10;

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end s2_Ph_coef;
