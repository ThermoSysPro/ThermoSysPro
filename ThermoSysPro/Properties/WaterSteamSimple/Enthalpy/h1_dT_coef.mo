within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
record h1_dT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=-2.252639e+09,
    c10=8.489281e+06,
    c01=8.778907e+06,
    c20=-1.271348e+04,
    c11=-2.742816e+04,
    c02=-1.297164e+04,
    c30=9.555032e+00,
    c21=3.138232e+01,
    c12=3.210542e+01,
    c03=8.942146e+00,
    c40=-3.644105e-03,
    c31=-1.572657e-02,
    c22=-2.548579e-02,
    c13=-1.576212e-02,
    c04=-2.891150e-03,
    c50=5.701269e-07,
    c41=2.941663e-06,
    c32=6.548900e-06,
    c23=6.610104e-06,
    c14=2.703402e-06,
    c05=3.809620e-07);

   annotation (Icon(graphics,
                    coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end h1_dT_coef;
