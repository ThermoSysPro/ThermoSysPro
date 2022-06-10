within ThermoSysPro.Fluid.Boilers;
model BoilerSystem "Boiler"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FlueGasesFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.Temperature Tsf=423.16
    "Flue gases temperature at the outlet";
  parameter Integer Boiler_efficiency_type = 1 "1: Taking into account LHV only - 2: Using the total incoming power";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient Kf=0.05
    "Flue gases pressure loss coefficient";
  parameter ThermoSysPro.Units.xSI.PressureLossCoefficient Ke=1e4
    "Water/steam pressure loss coefficient";
  parameter Real etacomb=1 "Combustion efficiency (between 0 and 1)";
  parameter Units.SI.Power Wloss=1e5 "Thermal losses";
  parameter Units.SI.MassFlowRate gamma_diff_ws=1e-4
    "Diffusion conductance for the water/steam side (active if diffusion=true in neighbouring volumes)";
  parameter Boolean continuous_flow_reversal=false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

  ThermoSysPro.Fluid.Combustion.BoundaryConditions.FuelSourcePQ Fuel(
    Xashes=0.011,
    rho=1000,
    Hum=0.50,
    Xc=0.2479,
    Xh=0.0297,
    Xo=0.2088,
    Xn=0.0017,
    Xs=0.0003,
    LHV=1.5e7,
    Q0=0.0407331,
    T0=294.45)
    annotation (Placement(transformation(extent={{-56,-10},{-36,10}}, rotation=
            0)));
  ThermoSysPro.Fluid.Boilers.FossilFuelBoiler Boiler(
    Qsf(start=45.8744, fixed=false),
    Pee(fixed=false),
    Qe(fixed=false, start=6),
    Hee(fixed=false, start=293.1e3),
    Hse(fixed=false, start=377e3),
    Tsf=Tsf,
    exc_air(fixed=false, start=10),
    Wloss=Wloss,
    Wboil(start=1600e3, fixed=false),
    gamma_diff_ws=gamma_diff_ws,
    continuous_flow_reversal=continuous_flow_reversal,
    diffusion=diffusion,
    Boiler_efficiency_type=Boiler_efficiency_type,
    Kf=Kf,
    Ke=Ke,
    etacomb=etacomb,
    Pse(fixed=false, start=200000),
    Tse(fixed=false, start=363.16),
    Tf(fixed=false, start=1600))
    annotation (Placement(transformation(
        origin={-10,0},
        extent={{20,-20},{-20,20}},
        rotation=270)));
  Interfaces.Connectors.FluidInlet InletWaterSteam "Water inlet" annotation (
      Placement(transformation(extent={{40,-110},{60,-90}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet OutletWaterSteam "Water/steam outlet"
    annotation (Placement(transformation(extent={{40,90},{60,110}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet OutletFlueGases "Flue gases outlet"
                                                    annotation (Placement(
        transformation(extent={{-80,90},{-60,110}}, rotation=0),
        iconTransformation(extent={{-80,90},{-60,110}})));
  Interfaces.Connectors.FluidInlet InletFlueGases "Flue gases inlet"
                                                  annotation (Placement(
        transformation(extent={{-80,-110},{-60,-90}}, rotation=0)));
equation
  connect(OutletWaterSteam, Boiler.Cws2) annotation (Line(points={{50,100},{50,100},
          {2,100},{2,20}}, color={255,0,0}));
  connect(Boiler.Cws1, InletWaterSteam)
    annotation (Line(points={{2,-20},{2,-100},{50,-100}}));
  connect(Boiler.Cfuel, Fuel.C) annotation (Line(points={{-26,9.79685e-016},{
          -32,9.79685e-016},{-32,0},{-36,0}}, color={0,0,0}));
  connect(Boiler.Cfg, OutletFlueGases) annotation (Line(points={{-22.4,20},{-22,
          20},{-22,100},{-70,100}},
                               color={255,0,0}));
  connect(Boiler.Cair, InletFlueGases) annotation (Line(points={{-22.4,-20},{
          -22,-20},{-22,-100},{-70,-100}}, color={0,0,0}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-80,-100},{60,100}},
        initialScale=0.3)),
                          Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-80,-100},{60,100}},
        initialScale=0.3), graphics={
        Rectangle(
          extent={{-80,100},{60,-100}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0),
        Rectangle(
          extent={{-60,80},{40,-80}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,-46},{0,-50},{10,-38},{14,-24},{12,-10},{10,-2},{6,8},{2,
              18},{0,26},{-2,32},{-6,50},{-10,40},{-14,32},{-18,20},{-18,16},{
              -20,12},{-22,20},{-24,22},{-26,18},{-30,10},{-32,4},{-36,-4},{-38,
              -14},{-40,-24},{-40,-32},{-34,-40},{-30,-46},{-20,-52},{-12,-46}},
          lineColor={255,0,128},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,-28},{-18,-24},{-14,-22},{-10,-22},{-6,-24},{-4,-26},{-2,
              -32},{-2,-36},{-4,-34},{-6,-30},{-8,-26},{-14,-26},{-16,-28},{-20,
              -32},{-22,-34},{-22,-34},{-20,-28}},
          lineColor={127,0,0},
          fillColor={127,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-109,-90},{-88,-106}},
          lineColor={28,108,200},
          textString="Air"),
        Text(
          extent={{-116,110},{-84,88}},
          lineColor={238,46,47},
          textString="FlueGases"),
        Text(
          extent={{65,-88},{95,-108}},
          lineColor={28,108,200},
          textString="WaterSteam"),
        Text(
          extent={{65,112},{95,92}},
          lineColor={238,46,47},
          textString="WaterSteam"),
        Line(
          points={{-100,-90},{-100,90}},
          color={255,0,0},
          arrow={Arrow.None,Arrow.Open}),
        Line(
          points={{80,-86},{80,94}},
          color={28,108,200},
          arrow={Arrow.None,Arrow.Open})}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end BoilerSystem;
