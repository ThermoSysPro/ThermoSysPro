within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
record lambda2_dT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=1.972922e-02,
    c10=5.074409e-03,
    c01=-8.056885e-05,
    c20=-7.940187e-06,
    c11=-1.746871e-05,
    c02=3.351452e-07,
    c30=6.366310e-09,
    c21=2.130434e-08,
    c12=2.262123e-08,
    c03=-2.777033e-10,
    c40=-2.696194e-12,
    c31=-1.132599e-11,
    c22=-1.496962e-11,
    c13=-1.236448e-11,
    c04=1.220489e-13,
    c50=-2.635185e-15,
    c41=1.145604e-14,
    c32=-3.134673e-15,
    c23=4.288593e-15,
    c14=2.343478e-15,
    c05=-2.147268e-17);
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end lambda2_dT_coef;
