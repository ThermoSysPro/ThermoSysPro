within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
record lambda1_dT_coef
  extends Modelica.Icons.Record;

  extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=5.205361e+03,
    c10=-1.772777e+01,
    c01=-1.564808e+01,
    c20=2.329584e-02,
    c11=4.996610e-02,
    c02=9.785300e-03,
    c30=-1.527146e-05,
    c21=-5.470372e-05,
    c12=-3.927909e-05,
    c03=1.027220e-05,
    c40=5.321984e-09,
    c31=2.481199e-08,
    c22=3.743489e-08,
    c13=6.013180e-10,
    c04=-1.296152e-08,
    c50=-8.543528e-13,
    c41=-4.008923e-12,
    c32=-1.016585e-11,
    c23=-5.064400e-12,
    c14=5.631431e-12,
    c05=3.515174e-12);
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end lambda1_dT_coef;
