within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
record h2_Ps_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00 =  6.132959e+08,
c10 =  -2.090378e+08,
c01 =  -2.096829e+05,
c20 =  2.789470e+07,
c11 =  5.782221e+04,
c02 =  2.838398e+01,
c30 =  -1.784663e+06,
c21 =  -5.859196e+03,
c12 =  -5.896443e+00,
c03 =  -1.893956e-03,
c40 =  4.926275e+04,
c31 =  2.623248e+02,
c22 =  3.947919e-01,
c13 =  2.640003e-04,
c04 =  6.193561e-08,
c50 =  -2.859106e+02,
c41 =  -4.148007e+00,
c32 =  -8.852846e-03,
c23 =  -8.588732e-06,
c14 =  -4.362390e-09,
c05 =  -7.815188e-13);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end h2_Ps_coef;
