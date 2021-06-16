within ThermoSysPro.Properties.WaterSteamSimple.Temperature;
record T2_Ph_coef
  extends Modelica.Icons.Record;

   extends ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5(
    c00=-388.7,
    c10=0.0001269,
    c01=-3.105e-05,
    c20=-2.383e-12,
    c11=-5.914e-11,
    c02=1.593e-10,
    c30=1.476e-20,
    c21=1.103e-18,
    c12=7.178e-18,
    c03=-1.012e-17,
    c40=-3.495e-29,
    c31=-4.88e-27,
    c22=-1.604e-25,
    c13=1.829e-25,
    c04=-2.691e-24,
    c50=1.04e-38,
    c41=6.524e-36,
    c32=3.839e-34,
    c23=7.204e-33,
    c14=-5.351e-32,
    c05=2.963e-31);

  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false)), Diagram(graphics,
        coordinateSystem(preserveAspectRatio=false)));
end T2_Ph_coef;
