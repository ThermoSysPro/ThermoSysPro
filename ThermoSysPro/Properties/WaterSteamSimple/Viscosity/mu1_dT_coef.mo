within ThermoSysPro.Properties.WaterSteamSimple.Viscosity;
record mu1_dT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order7(
   c0=3.29092297E-01,
   c1=-4.27172409E-03,
   c2=2.29860442E-05,
   c3=-6.54673011E-08,
   c4=1.03964666E-10,
   c5=-8.72289050E-14,
   c6=3.02014260E-17,
   c7=0);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end mu1_dT_coef;
