within ThermoSysPro.Fluid.Examples.Book.SimpleExamples.HeatExchanger;
model TestDynamicPlateHeatExchanger

  ThermoSysPro.Fluid.HeatExchangers.DynamicPlateHeatExchanger
    echangeurAPlaques1D1(
    Ns=5,
    Sc(Q(fixed=true, start=1036)),
    region_c=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1,
    region_f=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1,
    Qc(start={39464.19306563736,39464.19140625,39464.19140625,39464.19140625,39464.19140625,
          39464.19140625}),
    hc(start={280049.6746505721,280050.4252984669,280051.8112565058,280040.0015809256,
          280303.05286784086,275103.35213299847,70825.9016030344}),
    hf(start={100000.0,280103.55213273736,280154.0094354263,279724.06541591545,289300.73217909626,
          100000.0,100000.0}),
    Pf(start={300190.97994125,300159.55033252,300128.12100957,300096.69221392,300065.25892599,
          300033.92449902,300000}),
    hbf(start={280076.2239838133,280103.55213273736,280154.0094354263,279724.06541591545,
          289300.73217909626,100000.0}),
    muc2(start={0.0004220110175304796,0.00042196254388820765,0.0004219131741885822,
          0.00042188258281012253,0.0004214613445406211,0.0004289079959529233}),
    muf2(start={0.0004219971888386315,0.00042195825821082143,0.00042188643245605134,
          0.0004224986924487388,0.00040920745505383134,0.0009148967539000273}))
         annotation (Placement(transformation(extent={{-14,6},{6,26}},
          rotation=0)));

  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP2(T0=340, region=
        ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
    annotation (Placement(transformation(extent={{-74,6},{-54,26}},   rotation=
            0)));
  BoundaryConditions.SourceP                    sourcePQ(region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1,
      Q(start=1084))                        annotation (Placement(
        transformation(extent={{-54,-14},{-34,6}},   rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP puitsP2(P0(fixed=false)=
      100000, region=
        ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
                                         annotation (Placement(transformation(
          extent={{46,6},{66,26}},   rotation=0)));
  BoundaryConditions.SinkP                    puitsP3(region=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region.Region_1)
                                          annotation (Placement(transformation(
          extent={{26,-14},{46,6}},   rotation=0)));
equation
  connect(sourceP2.C, echangeurAPlaques1D1.Ec)
    annotation (Line(points={{-54,16},{-14,16}},   color={0,0,255}));
  connect(sourcePQ.C, echangeurAPlaques1D1.Ef)
                                              annotation (Line(points={{-34,-4},
          {-9,-4},{-9,10}},     color={0,0,255}));
  connect(echangeurAPlaques1D1.Sc, puitsP2.C)
                                            annotation (Line(points={{6,16},{46,
          16}},     color={0,0,255}));
  connect(echangeurAPlaques1D1.Sf, puitsP3.C)
                                             annotation (Line(points={{1,10},{0,
          10},{0,-4},{26,-4}},         color={0,0,255}));
  annotation (Diagram(graphics={Text(
          extent={{72,24},{92,6}},
          lineColor={0,0,255},
          textString=
               "Qc=true")}), Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
    Documentation(info="<html>
<h4>Copyright &copy; EDF 2002 - 2021 </h4>
<h4>ThermoSysPro Version 4.0 </h4>
<p>This model is documented in Sect. 9.6.1.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
<p>The results reported in the ThermoSysPro book were computed using Dymola. </p>
</html>"));
end TestDynamicPlateHeatExchanger;
