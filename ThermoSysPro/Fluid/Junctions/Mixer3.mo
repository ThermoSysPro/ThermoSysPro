within ThermoSysPro.Fluid.Junctions;
model Mixer3 "Mixer with three inlets"
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
  Real alpha1 "Extraction coefficient for inlet 1 (<=1)";
  Real alpha2 "Extraction coefficient for inlet 2 (<=1)";
  Units.SI.AbsolutePressure P(start=10e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  Units.SI.Temperature T "Fluid temperature";
  FluidType fluids[5] "Fluids mixing in volume";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H20 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Units.SI.Power Je1 "Thermal power diffusion from inlet e1";
  Units.SI.Power Je2 "Thermal power diffusion from inlet e2";
  Units.SI.Power Je3 "Thermal power diffusion from inlet e3";
  Units.SI.Power Js "Thermal power diffusion from outlet s";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_e1 "Diffusion conductance for inlet e1";
  Units.SI.MassFlowRate gamma_e2 "Diffusion conductance for inlet e2";
  Units.SI.MassFlowRate gamma_e3 "Diffusion conductance for inlet e3";
  Units.SI.MassFlowRate gamma_s "Diffusion conductance for outlet s";
  Real re1 "Value of r(Q/gamma) for inlet e1";
  Real re2 "Value of r(Q/gamma) for inlet e2";
  Real re3 "Value of r(Q/gamma) for inlet e3";
  Real rs "Value of r(Q/gamma) for outlet s";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce2 annotation (Placement(
        transformation(extent={{-50,-110},{-30,-90}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs annotation (Placement(
        transformation(extent={{90,-10},{110,10}}, rotation=0)));
public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce1 annotation (Placement(
        transformation(extent={{-50,90},{-30,110}}, rotation=0)));
  InstrumentationAndControl.Connectors.InputReal Ialpha1
    "Extraction coefficient for inlet 1 (<=1)"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}}, rotation=0)));
  InstrumentationAndControl.Connectors.OutputReal Oalpha1
    annotation (Placement(transformation(extent={{-20,50},{0,70}}, rotation=0)));
public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce3 annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  InstrumentationAndControl.Connectors.InputReal Ialpha2
    "Extraction coefficient for inlet 2 (<=1)"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}}, rotation=
           0)));
  InstrumentationAndControl.Connectors.OutputReal Oalpha2
    annotation (Placement(transformation(extent={{-20,-70},{0,-50}}, rotation=0)));
equation

  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce1.ftype;
  fluids[3] = Ce2.ftype;
  fluids[4] = Ce3.ftype;
  fluids[5] = Cs.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "Mixer3: fluids mixing in volume are not compatible with each other");

  /* Unconnected connectors */
  if (cardinality(Ialpha1) == 0) then
    Ialpha1.signal = 0.3;
  end if;

  if (cardinality(Ialpha2) == 0) then
    Ialpha2.signal = 0.3;
  end if;

  /* Mass balance equation */
  0 = Ce1.Q + Ce2.Q + Ce3.Q - Cs.Q;

  P = Ce1.P;
  P = Ce2.P;
  P = Ce3.P;
  P = Cs.P;

  /* Energy balance equation */
  0 = Ce1.Q*Ce1.h + Ce2.Q*Ce2.h + Ce3.Q*Ce3.h - Cs.Q*Cs.h + J;

  Ce1.h_vol_2 = h;
  Ce2.h_vol_2 = h;
  Ce3.h_vol_2 = h;
  Cs.h_vol_1 = h;

  /* Mass flow at the outlet */
  if (cardinality(Ialpha1) <> 0) then
    Ce1.Q = Ialpha1.signal*Cs.Q;
  end if;

  if (cardinality(Ialpha2) <> 0) then
    Ce2.Q = Ialpha2.signal*Cs.Q;
  end if;

  alpha1 = if noEvent(abs(Cs.Q) > 0) then Ce1.Q/Cs.Q else Modelica.Constants.inf;
  Oalpha1.signal = alpha1;

  alpha2 = if noEvent(abs(Cs.Q) > 0) then Ce2.Q/Cs.Q else Modelica.Constants.inf;
  Oalpha2.signal = alpha2;

  /* Fluid composition balance equations */
  0 = Ce1.Xco2*Ce1.Q + Ce2.Xco2*Ce2.Q + Ce3.Xco2*Ce3.Q - Cs.Xco2*Cs.Q;
  0 = Ce1.Xh2o*Ce1.Q + Ce2.Xh2o*Ce2.Q + Ce3.Xh2o*Ce3.Q  - Cs.Xh2o*Cs.Q;
  0 = Ce1.Xo2*Ce1.Q + Ce2.Xo2*Ce2.Q + Ce3.Xo2*Ce3.Q  - Cs.Xo2*Cs.Q;
  0 = Ce1.Xso2*Ce1.Q + Ce2.Xso2*Ce2.Q + Ce3.Xso2*Ce3.Q  - Cs.Xso2*Cs.Q;

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
    rs = if Cs.diff_on_2 then exp(-0.033*(Cs.Q*Cs.diff_res_2)^2) else 0;

    gamma_e1 = if Ce1.diff_on_1 then 1/Ce1.diff_res_1 else gamma0;
    gamma_e2 = if Ce2.diff_on_1 then 1/Ce2.diff_res_1 else gamma0;
    gamma_e3 = if Ce3.diff_on_1 then 1/Ce3.diff_res_1 else gamma0;
    gamma_s = if Cs.diff_on_2 then 1/Cs.diff_res_2 else gamma0;

    Je1 = if Ce1.diff_on_1 then re1*gamma_e1*(Ce1.h_vol_1 - Ce1.h_vol_2) else 0;
    Je2 = if Ce2.diff_on_1 then re2*gamma_e2*(Ce2.h_vol_1 - Ce2.h_vol_2) else 0;
    Je3 = if Ce3.diff_on_1 then re3*gamma_e3*(Ce3.h_vol_1 - Ce3.h_vol_2) else 0;
    Js = if Cs.diff_on_2 then rs*gamma_s*(Cs.h_vol_2 - Cs.h_vol_1) else 0;
  else
    re1 = 0;
    re2 = 0;
    re3 = 0;
    rs = 0;

    gamma_e1 = gamma0;
    gamma_e2 = gamma0;
    gamma_e3 = gamma0;
    gamma_s = gamma0;

    Je1 = 0;
    Je2 = 0;
    Je3 = 0;
    Js = 0;
  end if;

  J = Je1 + Je2 + Je3 + Js;

  Ce1.diff_res_2 = 0;
  Ce2.diff_res_2 = 0;
  Ce3.diff_res_2 = 0;
  Cs.diff_res_1 = 0;

  Ce1.diff_on_2 = diffusion;
  Ce2.diff_on_2 = diffusion;
  Ce3.diff_on_2 = diffusion;
  Cs.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties */
  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(P, h, fluid, mode, Cs.Xco2, Cs.Xh2o, Cs.Xo2, Cs.Xso2);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-60,100},{-20,100},{-20,20},{100,20},{100,-20},{-20,-20},{
              -20,-100},{-60,-100},{-60,-20},{-100,-20},{-100,20},{-60,20},{-60,
              100}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{-60,80},{-20,40}}, textString=
                                     "1"),
        Text(extent={{-60,-40},{-20,-80}}, textString=
                             "2")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-60,100},{-20,100},{-20,20},{100,20},{100,-20},{-20,-20},{
              -20,-100},{-60,-100},{-60,-20},{-100,-20},{-100,20},{-60,20},{-60,
              100}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Text(extent={{-50,88},{-32,72}}, textString=
                                     "1"),
        Text(extent={{-54,-72},{-26,-88}}, textString=
                             "2")}),
    Window(
      x=0.33,
      y=0.09,
      width=0.71,
      height=0.88),
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
end Mixer3;
