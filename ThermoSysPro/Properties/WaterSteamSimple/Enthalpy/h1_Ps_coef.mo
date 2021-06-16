within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
record h1_Ps_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3(
    c00 =  1.171467e+04,
    c10 =  9.332002e-04,
    c01 =  2.457972e+02,
    c20 =  -3.775739e-13,
    c11 =  1.102563e-07,
    c02 =  4.913871e-02);

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end h1_Ps_coef;
