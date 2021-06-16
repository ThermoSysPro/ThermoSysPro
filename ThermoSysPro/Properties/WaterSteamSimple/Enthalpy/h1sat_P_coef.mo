within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
record h1sat_P_coef
  extends Modelica.Icons.Record;

   constant Real a0 =  -5.551e+04;
   constant Real a =   2.111e+04;
   constant Real b =      0.2643;

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end h1sat_P_coef;
