within ThermoSysPro.Fluid.Junctions;
model Mixer8 "Mixer with eight inlets"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.AbsolutePressure P(start=10e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  Units.SI.Temperature T "Fluid temperature";
  FluidType fluids[10] "Fluids mixing in volume";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H20 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Units.SI.Power Je1 "Thermal power diffusion from inlet e1";
  Units.SI.Power Je2 "Thermal power diffusion from inlet e2";
  Units.SI.Power Je3 "Thermal power diffusion from inlet e3";
  Units.SI.Power Je4 "Thermal power diffusion from inlet e4";
  Units.SI.Power Je5 "Thermal power diffusion from inlet e5";
  Units.SI.Power Je6 "Thermal power diffusion from inlet e6";
  Units.SI.Power Je7 "Thermal power diffusion from inlet e7";
  Units.SI.Power Je8 "Thermal power diffusion from inlet e8";
  Units.SI.Power Js "Thermal power diffusion from outlet s";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_e1 "Diffusion conductance for inlet e1";
  Units.SI.MassFlowRate gamma_e2 "Diffusion conductance for inlet e2";
  Units.SI.MassFlowRate gamma_e3 "Diffusion conductance for inlet e3";
  Units.SI.MassFlowRate gamma_e4 "Diffusion conductance for inlet e4";
  Units.SI.MassFlowRate gamma_e5 "Diffusion conductance for inlet e5";
  Units.SI.MassFlowRate gamma_e6 "Diffusion conductance for inlet e6";
  Units.SI.MassFlowRate gamma_e7 "Diffusion conductance for inlet e7";
  Units.SI.MassFlowRate gamma_e8 "Diffusion conductance for inlet e8";
  Units.SI.MassFlowRate gamma_s "Diffusion conductance for outlet s";
  Real re1 "Value of r(Q/gamma) for inlet e1";
  Real re2 "Value of r(Q/gamma) for inlet e2";
  Real re3 "Value of r(Q/gamma) for inlet e3";
  Real re4 "Value of r(Q/gamma) for inlet e4";
  Real re5 "Value of r(Q/gamma) for inlet e5";
  Real re6 "Value of r(Q/gamma) for inlet e6";
  Real re7 "Value of r(Q/gamma) for inlet e7";
  Real re8 "Value of r(Q/gamma) for inlet e8";
  Real rs
         "Value of r(Q/gamma) for outlet s";

  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce5 annotation (layer=
        "icon", Placement(transformation(extent={{-110,-50},{-90,-30}},
          rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce6 annotation (layer=
        "icon", Placement(transformation(extent={{-112,-109},{-92,-89}},
          rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce7 annotation (layer=
        "icon", Placement(transformation(extent={{-40,-109},{-20,-89}},
          rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce3 annotation (layer=
        "icon", Placement(transformation(extent={{-112,90},{-92,110}}, rotation=
           0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce2 annotation (layer=
        "icon", Placement(transformation(extent={{-40,90},{-20,110}}, rotation=
            0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce1 annotation (layer=
        "icon", Placement(transformation(extent={{20,92},{40,112}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs annotation (layer=
        "icon", Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce8 annotation (layer=
        "icon", Placement(transformation(extent={{20,-109},{40,-89}}, rotation=
            0)));

  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce4 annotation (layer=
        "icon", Placement(transformation(extent={{-112,30},{-92,50}}, rotation=
            0)));
equation
  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce1.ftype;
  fluids[3] = Ce2.ftype;
  fluids[4] = Ce3.ftype;
  fluids[5] = Ce4.ftype;
  fluids[6] = Ce5.ftype;
  fluids[7] = Ce6.ftype;
  fluids[8] = Ce7.ftype;
  fluids[9] = Ce8.ftype;
  fluids[10] = Cs.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "Mixer8: fluids mixing in volume are not compatible with each other");

  /* Unconnected connectors */
  if (cardinality(Ce1) == 0) then
    Ce1.Q = 0;
    Ce1.h = 1.e5;
    Ce1.h_vol_1 = 1.e5;
    Ce1.diff_res_1 = 0;
    Ce1.diff_on_1 = false;
    Ce1.ftype = ftype;
    Ce1.Xco2 = 0;
    Ce1.Xh2o = 0;
    Ce1.Xo2 = 0;
    Ce1.Xso2 = 0;
  end if;

  if (cardinality(Ce2) == 0) then
    Ce2.Q = 0;
    Ce2.h = 1.e5;
    Ce2.h_vol_1 = 1.e5;
    Ce2.diff_res_1 = 0;
    Ce2.diff_on_1 = false;
    Ce2.ftype = ftype;
    Ce2.Xco2 = 0;
    Ce2.Xh2o = 0;
    Ce2.Xo2 = 0;
    Ce2.Xso2 = 0;
  end if;

  if (cardinality(Ce3) == 0) then
    Ce3.Q = 0;
    Ce3.h = 1.e5;
    Ce3.h_vol_1 = 1.e5;
    Ce3.diff_res_1 = 0;
    Ce3.diff_on_1 = false;
    Ce3.ftype = ftype;
    Ce3.Xco2 = 0;
    Ce3.Xh2o = 0;
    Ce3.Xo2 = 0;
    Ce3.Xso2 = 0;
  end if;

  if (cardinality(Ce4) == 0) then
    Ce4.Q = 0;
    Ce4.h = 1.e5;
    Ce4.h_vol_1 = 1.e5;
    Ce4.diff_res_1 = 0;
    Ce4.diff_on_1 = false;
    Ce4.ftype = ftype;
    Ce4.Xco2 = 0;
    Ce4.Xh2o = 0;
    Ce4.Xo2 = 0;
    Ce4.Xso2 = 0;
  end if;

  if (cardinality(Ce5) == 0) then
    Ce5.Q = 0;
    Ce5.h = 1.e5;
    Ce5.h_vol_1 = 1.e5;
    Ce5.diff_res_1 = 0;
    Ce5.diff_on_1 = false;
    Ce5.ftype = ftype;
    Ce5.Xco2 = 0;
    Ce5.Xh2o = 0;
    Ce5.Xo2 = 0;
    Ce5.Xso2 = 0;
  end if;

  if (cardinality(Ce6) == 0) then
    Ce6.Q = 0;
    Ce6.h = 1.e5;
    Ce6.h_vol_1 = 1.e5;
    Ce6.diff_res_1 = 0;
    Ce6.diff_on_1 = false;
    Ce6.ftype = ftype;
    Ce6.Xco2 = 0;
    Ce6.Xh2o = 0;
    Ce6.Xo2 = 0;
    Ce6.Xso2 = 0;
  end if;

  if (cardinality(Ce7) == 0) then
    Ce7.Q = 0;
    Ce7.h = 1.e5;
    Ce7.h_vol_1 = 1.e5;
    Ce7.diff_res_1 = 0;
    Ce7.diff_on_1 = false;
    Ce7.ftype = ftype;
    Ce7.Xco2 = 0;
    Ce7.Xh2o = 0;
    Ce7.Xo2 = 0;
    Ce7.Xso2 = 0;
  end if;

  if (cardinality(Ce8) == 0) then
    Ce8.Q = 0;
    Ce8.h = 1.e5;
    Ce8.h_vol_1 = 1.e5;
    Ce8.diff_res_1 = 0;
    Ce8.diff_on_1 = false;
    Ce8.ftype = ftype;
    Ce8.Xco2 = 0;
    Ce8.Xh2o = 0;
    Ce8.Xo2 = 0;
    Ce8.Xso2 = 0;
  end if;

  if (cardinality(Cs) == 0) then
    Cs.Q = 0;
    Cs.h_vol_2 = 1.e5;
    Cs.diff_res_2 = 0;
    Cs.diff_on_2 = false;
  end if;

  /* Mass balance equation */
  0 = Ce1.Q + Ce2.Q + Ce3.Q + Ce4.Q + Ce5.Q + Ce6.Q + Ce7.Q + Ce8.Q - Cs.Q;

  P = Ce1.P;
  P = Ce2.P;
  P = Ce3.P;
  P = Ce4.P;
  P = Ce5.P;
  P = Ce6.P;
  P = Ce7.P;
  P = Ce8.P;
  P = Cs.P;

  /* Energy balance equation */
  0 = Ce1.Q*Ce1.h + Ce2.Q*Ce2.h + Ce3.Q*Ce3.h + Ce4.Q*Ce4.h + Ce5.Q*Ce5.h + Ce6.Q*Ce6.h + Ce7.Q*Ce7.h + Ce8.Q*Ce8.h - Cs.Q*Cs.h + J;

  Ce1.h_vol_2 = h;
  Ce2.h_vol_2 = h;
  Ce3.h_vol_2 = h;
  Ce4.h_vol_2 = h;
  Ce5.h_vol_2 = h;
  Ce6.h_vol_2 = h;
  Ce7.h_vol_2 = h;
  Ce8.h_vol_2 = h;
  Cs.h_vol_1 = h;

  /* Fluid composition balance equations */
  0 = Ce1.Xco2*Ce1.Q + Ce2.Xco2*Ce2.Q + Ce3.Xco2*Ce3.Q + Ce4.Xco2*Ce4.Q  + Ce5.Xco2*Ce5.Q  + Ce6.Xco2*Ce6.Q  + Ce7.Xco2*Ce7.Q  + Ce8.Xco2*Ce8.Q  - Cs.Xco2*Cs.Q;
  0 = Ce1.Xh2o*Ce1.Q + Ce2.Xh2o*Ce2.Q + Ce3.Xh2o*Ce3.Q + Ce4.Xh2o*Ce4.Q   + Ce5.Xh2o*Ce5.Q   + Ce6.Xh2o*Ce6.Q   + Ce7.Xh2o*Ce7.Q   + Ce8.Xh2o*Ce8.Q    - Cs.Xh2o*Cs.Q;
  0 = Ce1.Xo2*Ce1.Q + Ce2.Xo2*Ce2.Q + Ce3.Xo2*Ce3.Q + Ce4.Xo2*Ce4.Q  + Ce5.Xo2*Ce5.Q  + Ce6.Xo2*Ce6.Q  + Ce7.Xo2*Ce7.Q  + Ce8.Xo2*Ce8.Q   - Cs.Xo2*Cs.Q;
  0 = Ce1.Xso2*Ce1.Q + Ce2.Xso2*Ce2.Q + Ce3.Xso2*Ce3.Q + Ce4.Xso2*Ce4.Q  + Ce5.Xso2*Ce5.Q  + Ce6.Xso2*Ce6.Q  + Ce7.Xso2*Ce7.Q  + Ce8.Xso2*Ce8.Q   - Cs.Xso2*Cs.Q;

  Cs.ftype = ftype;

  Cs.Xco2 = Xco2;
  Cs.Xh2o = Xh2o;
  Cs.Xo2  = Xo2;
  Cs.Xso2 = Xso2;

  /* Flow reversal */
  if continuous_flow_reversal then
    Cs.h = ThermoSysPro.Functions.SmoothCond(Cs.Q/gamma_s, Cs.h_vol_1, Cs.h_vol_2, 1);
  else
    Cs.h = if (Cs.Q > 0) then Cs.h_vol_1 else Cs.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    re1 = if Ce1.diff_on_1 then exp(-0.033*(Ce1.Q*Ce1.diff_res_1)^2) else 0;
    re2 = if Ce2.diff_on_1 then exp(-0.033*(Ce2.Q*Ce2.diff_res_1)^2) else 0;
    re3 = if Ce3.diff_on_1 then exp(-0.033*(Ce3.Q*Ce3.diff_res_1)^2) else 0;
    re4 = if Ce4.diff_on_1 then exp(-0.033*(Ce4.Q*Ce4.diff_res_1)^2) else 0;
    re5 = if Ce5.diff_on_1 then exp(-0.033*(Ce5.Q*Ce5.diff_res_1)^2) else 0;
    re6 = if Ce6.diff_on_1 then exp(-0.033*(Ce6.Q*Ce6.diff_res_1)^2) else 0;
    re7 = if Ce7.diff_on_1 then exp(-0.033*(Ce7.Q*Ce7.diff_res_1)^2) else 0;
    re8 = if Ce8.diff_on_1 then exp(-0.033*(Ce8.Q*Ce8.diff_res_1)^2) else 0;
    rs = if Cs.diff_on_2 then exp(-0.033*(Cs.Q*Cs.diff_res_2)^2) else 0;

    gamma_e1 = if Ce1.diff_on_1 then 1/Ce1.diff_res_1 else gamma0;
    gamma_e2 = if Ce2.diff_on_1 then 1/Ce2.diff_res_1 else gamma0;
    gamma_e3 = if Ce3.diff_on_1 then 1/Ce3.diff_res_1 else gamma0;
    gamma_e4 = if Ce4.diff_on_1 then 1/Ce4.diff_res_1 else gamma0;
    gamma_e5 = if Ce5.diff_on_1 then 1/Ce5.diff_res_1 else gamma0;
    gamma_e6 = if Ce6.diff_on_1 then 1/Ce6.diff_res_1 else gamma0;
    gamma_e7 = if Ce7.diff_on_1 then 1/Ce7.diff_res_1 else gamma0;
    gamma_e8 = if Ce8.diff_on_1 then 1/Ce8.diff_res_1 else gamma0;
    gamma_s = if Cs.diff_on_2 then 1/Cs.diff_res_2 else gamma0;

    Je1 = if Ce1.diff_on_1 then re1*gamma_e1*(Ce1.h_vol_1 - Ce1.h_vol_2) else 0;
    Je2 = if Ce2.diff_on_1 then re2*gamma_e2*(Ce2.h_vol_1 - Ce2.h_vol_2) else 0;
    Je3 = if Ce3.diff_on_1 then re3*gamma_e3*(Ce3.h_vol_1 - Ce3.h_vol_2) else 0;
    Je4 = if Ce4.diff_on_1 then re4*gamma_e4*(Ce4.h_vol_1 - Ce4.h_vol_2) else 0;
    Je5 = if Ce5.diff_on_1 then re5*gamma_e5*(Ce5.h_vol_1 - Ce5.h_vol_2) else 0;
    Je6 = if Ce6.diff_on_1 then re6*gamma_e6*(Ce6.h_vol_1 - Ce6.h_vol_2) else 0;
    Je7 = if Ce7.diff_on_1 then re7*gamma_e7*(Ce7.h_vol_1 - Ce7.h_vol_2) else 0;
    Je8 = if Ce8.diff_on_1 then re8*gamma_e8*(Ce8.h_vol_1 - Ce8.h_vol_2) else 0;
    Js = if Cs.diff_on_2 then rs*gamma_s*(Cs.h_vol_2 - Cs.h_vol_1) else 0;
  else
    re1 = 0;
    re2 = 0;
    re3 = 0;
    re4 = 0;
    re5 = 0;
    re6 = 0;
    re7 = 0;
    re8 = 0;
    rs = 0;

    gamma_e1 = gamma0;
    gamma_e2 = gamma0;
    gamma_e3 = gamma0;
    gamma_e4 = gamma0;
    gamma_e5 = gamma0;
    gamma_e6 = gamma0;
    gamma_e7 = gamma0;
    gamma_e8 = gamma0;
    gamma_s = gamma0;

    Je1 = 0;
    Je2 = 0;
    Je3 = 0;
    Je4 = 0;
    Je5 = 0;
    Je6 = 0;
    Je7 = 0;
    Je8 = 0;
    Js = 0;
  end if;

  J = Je1 + Je2 + Je3 + Je4 + Je5 + Je6 + Je7 + Je8 + Js;

  Ce1.diff_res_2 = 0;
  Ce2.diff_res_2 = 0;
  Ce3.diff_res_2 = 0;
  Ce4.diff_res_2 = 0;
  Ce5.diff_res_2 = 0;
  Ce6.diff_res_2 = 0;
  Ce7.diff_res_2 = 0;
  Ce8.diff_res_2 = 0;
  Cs.diff_res_1 = 0;

  Ce1.diff_on_2 = diffusion;
  Ce2.diff_on_2 = diffusion;
  Ce3.diff_on_2 = diffusion;
  Ce4.diff_on_2 = diffusion;
  Ce5.diff_on_2 = diffusion;
  Ce6.diff_on_2 = diffusion;
  Ce7.diff_on_2 = diffusion;
  Ce8.diff_on_2 = diffusion;
  Cs.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties */
  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(P, h, fluid, mode, Cs.Xco2, Cs.Xh2o, Cs.Xo2, Cs.Xso2);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,80},{40,0}},
          lineColor={28,108,200},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,0},{40,-80}},
          lineColor={28,108,200},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={28,108,200},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{40,0},{92,0}}),
        Line(points={{-92,-40},{-40,-40}}),
        Line(points={{-30,90},{-30,66}}, color={0,0,255}),
        Line(points={{30,92},{30,66}}, color={0,0,255}),
        Line(points={{-30,-66},{-30,-90}}, color={0,0,255}),
        Line(points={{30,-66},{30,-90}}, color={0,0,255}),
        Line(points={{-92,40},{-40,40}}),
        Line(points={{-38,-52},{-92,-90}}, color={0,0,255}),
        Line(points={{-38,54},{-92,90}}, color={0,0,255}),
        Polygon(points={{-40,40},{-38,54},{-34,60},{-24,72},{-8,80},{6,80},{18,
              76},{26,70},{34,62},{38,52},{40,46},{40,40},{40,38},{40,34},{40,
              -40},{40,-46},{36,-58},{30,-66},{24,-72},{16,-76},{6,-80},{0,-80},
              {-4,-80},{-8,-80},{-18,-76},{-28,-70},{-34,-60},{-36,-58},{-38,
              -54},{-38,-52},{-40,-46},{-40,-40},{-40,0},{-40,40}}, lineColor={
              28,108,200})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,80},{40,0}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,0},{40,-80}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Line(points={{-30,90},{-30,66}}, color={0,0,255}),
        Line(points={{-30,-66},{-30,-90}}, color={0,0,255}),
        Line(points={{30,92},{30,66}}, color={0,0,255}),
        Line(points={{30,-66},{30,-90}}, color={0,0,255}),
        Line(points={{-92,40},{-40,40}}),
        Line(points={{-92,-40},{-40,-40}}),
        Line(points={{40,0},{92,0}}),
        Line(points={{-38,-52},{-92,-90}}, color={0,0,255}),
        Line(points={{-38,54},{-92,90}}, color={0,0,255})}),
    Window(
      x=0.05,
      y=0.07,
      width=0.74,
      height=0.85),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 14.7 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end Mixer8;
