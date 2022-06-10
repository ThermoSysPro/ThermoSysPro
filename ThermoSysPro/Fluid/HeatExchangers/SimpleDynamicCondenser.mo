within ThermoSysPro.Fluid.HeatExchangers;
model SimpleDynamicCondenser "Simple dynamic condenser"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.Volume V=1 "Cavity volume";
  parameter Units.SI.Area A=1 "Cavity cross-sectional area";
  parameter Real Ccond=0.01 "Condensation coefficient";
  parameter Real Cevap=0.09 "Evaporation coefficient";
  parameter Real Xlo=0.0025 "Vapor mass fraction in the liquid phase from which the liquid starts to evaporate";
  parameter Real Xvo=0.9975 "Vapor mass fraction in the gas phase from which the liquid starts to condensate";
  parameter Units.SI.Area Avl=A
    "Heat exchange surface between the liquid and gas phases";
  parameter Real Kvl=1000 "Heat exchange coefficient between the liquid and gas phases";
  parameter Units.SI.Length L=10. "Pipe length";
  parameter Units.SI.Diameter D=0.02 "Pipe internal diameter";
  parameter Units.SI.Length e=2.e-3 "Wall thickness";
  parameter Units.SI.Position z1=0 "Inlet altitude";
  parameter Units.SI.Position z2=0 "Outlet altitude";
  parameter Units.SI.Length rugosrel=0.0007 "Pipe roughness";
  parameter Real lambda= 0.03 "Friction pressure loss coefficient (active if lambda_fixed=true)";
  parameter Integer ntubes=1 "Number of pipes in parallel";
  parameter Units.SI.Area At=ntubes*pi*D^2/4
    "Internal pipe cross-section area (cooling fluid)";
  parameter Boolean gravity_pressure=false "true: fluid pressure at the bottom of the cavity includes gravity term - false: without gravity term";
  parameter Boolean dynamic_energy_balance=true "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Boolean steady_state=true "true: start from steady state - false: start from (P0, Vf0) (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Real Vf0=0.5 "Fraction of initial water volume in the drum (active if dynamic_energy_balance=true and steady_state=false)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance and not steady_state));
  parameter Units.SI.AbsolutePressure P0=0.1e5
    "Fluid initial pressure (active if dynamic_energy_balance=true and steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance and not
          steady_state));
  parameter Boolean continuous_flow_reversal=false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region=IF97Region.All_regions "IF97 region for the pipes (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Integer fluid_c=Integer(ftype) "Fluid number in the cavity";
  parameter Integer mode=Integer(region) - 1 "IF97 region for the pipes. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";

public
  Units.SI.MassFlowRate Q(start=100) "Mass flow rate in the pipes";
  Units.SI.AbsolutePressure Pm "Fluid average pressure in the pipes";
  Units.SI.SpecificEnthalpy hm "Fluid average specific enthalpy in the pipes";
  Units.SI.SpecificHeatCapacity cp(start=4200)
    "Fluid specific heat capacity in the pipes";
  Units.SI.ThermalConductivity k(start=0.05)
    "Fluid thermal conductivity in the pipes";
  Units.SI.Density rhom(start=998) "Liquid phase density in the pipes";
  ThermoSysPro.Units.SI.PressureDifference deltaP
    "Total pressure loss in the pipes";
  ThermoSysPro.Units.SI.PressureDifference dpf
    "Friction pressure loss in the pipes";
  ThermoSysPro.Units.SI.PressureDifference dpg
    "Gravity pressure loss in the pipes";
  Real khi "Hydraulic pressure loss coefficient";
  Units.SI.AbsolutePressure P "Fluid average pressure in the cavity";
  Units.SI.AbsolutePressure Pfond "Fluid pressure at the bottom of the cavity";
  Units.SI.SpecificEnthalpy hl "Liquid phase spepcific enthalpy in the cavity";
  Units.SI.SpecificEnthalpy hv "Gas phase spepcific enthalpy in the cavity";
  Units.SI.Temperature Tl "Liquid phase temperature in the cavity";
  Units.SI.Temperature Tv "Gas phase temperature in the cavity";
  Units.SI.Volume Vl "Liquid phase volume in the cavity";
  Units.SI.Volume Vv "Gas phase volume in the cavity";
  Real xl(start=0.0) "Mass vapor fraction in the liquid phase of the cavity";
  Real xv(start=1) "Mass vapor fraction in the gas phase if the cavity";
  Units.SI.Density rhol(start=996) "Liquid phase density in the cavity";
  Units.SI.Density rhov(start=1.5) "Gas phase density in the cavity";
  Units.SI.MassFlowRate BQl
    "Right hand side of the mass balance equation of the liquid phase in the cavity";
  Units.SI.MassFlowRate BQv
    "Right hand side of the mass balance equation of the gas phase in the cavity";
  Units.SI.Power BHl
    "Right hand side of the energy balance equation of the liquid phase in the cavity";
  Units.SI.Power BHv
    "Right hand side of the energy balance equation of the gas phase in the cavity";
  Units.SI.MassFlowRate Qcond
    "Condensation mass flow rate from the vapor phase in the cavity";
  Units.SI.MassFlowRate Qevap
    "Evaporation mass flow rate from the liquid phase in the cavity";
  Units.SI.Power Wvl
    "Thermal power exchanged from the gas phase to the liquid phase in the cavity";
  Units.SI.Power Wout
    "Thermal power exchanged from the steam in the cavity to the pipes";
  Units.SI.Power Jv "Thermal power diffusion from inlet Cv";
  Units.SI.Power Jl "Thermal power diffusion from outlet Cl";
  Units.SI.Power Jt_l
    "Total thermal power diffusion for the liquid in the cavity";
  Units.SI.Power Jt_v
    "Total thermal power diffusion for the vapor in the cavity";
  Units.SI.MassFlowRate gamma_v "Diffusion conductance for inlet Cv";
  Units.SI.MassFlowRate gamma_l "Diffusion conductance for outlet Cl";
  Real rv "Value of r(Q/gamma) for inlet Cv";
  Real rl "Value of r(Q/gamma) for outlet Cl";
  Units.SI.MassFlowRate gamma_diff(start=1.e-4)
    "Diffusion conductance in the pipes";
  FluidType ftype_p "Fluid type in the pipes";
  Integer fluid_p=Integer(ftype_p) "Fluid number in the pipes";

  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prol
    "Propriétés de l'eau dans le ballon" annotation (Placement(transformation(
          extent={{-100,80},{-80,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prov
    "Propriétés de la vapeur dans le ballon" annotation (Placement(
        transformation(extent={{80,80},{100,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-30,40},{-10,60}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
                                           annotation (Placement(transformation(
          extent={{10,40},{30,60}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Cv annotation (Placement(transformation(
          extent={{-10,90},{10,110}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Cl annotation (Placement(transformation(
          extent={{-8,-110},{12,-90}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yNiveau          annotation (Placement(
        transformation(extent={{100,-82},{120,-62}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prod
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
public
  Interfaces.Connectors.FluidInlet Cee annotation (Placement(transformation(
          extent={{-110,-32},{-90,-12}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Cse annotation (Placement(transformation(
          extent={{90,-30},{110,-10}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    "Propriétés de l'eau "                   annotation (Placement(
        transformation(extent={{40,20},{60,40}}, rotation=0)));
initial equation
  if dynamic_energy_balance then
    if steady_state then
      der(hl) = 0;
      der(hv) = 0;
      der(Vl) = 0;
      der(P) = 0;
    else
      hl = lsat.h;
      hv = vsat.h;
      Vl = Vf0*V;
      P = P0;
    end if;
  end if;

equation

  /* Check that the fluid type for the cooling pipe is water/steam */
  assert((ftype_p == FluidType.WaterSteam) or (ftype_p == FluidType.WaterSteamSimple), "SimpleDynamicCondenser: the fluid type for the cooling pipe must be water/steam");

  /* Unconnected connectors */
  if (cardinality(Cv) == 0) then
    Cv.Q = 0;
    Cv.h = 1.e5;
    Cv.h_vol_1 = 1.e5;
    Cv.diff_res_1 = 0;
    Cv.diff_on_1 = false;
    Cv.ftype = ftype;
    Cv.Xco2 = 0;
    Cv.Xh2o = 1;
    Cv.Xo2 = 0;
    Cv.Xso2 = 0;
  end if;

  if (cardinality(Cee) == 0) then
    Cee.Q = 0;
    Cee.h = 1.e5;
    Cee.h_vol_1 = 1.e5;
    Cee.diff_res_1 = 0;
    Cee.diff_on_1 = false;
    Cee.ftype = ftype;
    Cee.Xco2 = 0;
    Cee.Xh2o = 1;
    Cee.Xo2 = 0;
    Cee.Xso2 = 0;
  end if;

  if (cardinality(Cl) == 0) then
    Cl.Q = 0;
    Cl.h_vol_2 = 1.e5;
    Cl.diff_res_2 = 0;
    Cl.diff_on_2 = false;
  end if;

  if (cardinality(Cse) == 0) then
    Cse.Q = 0;
    Cse.h_vol_2 = 1.e5;
    Cse.diff_res_2 = 0;
    Cse.diff_on_2 = false;
  end if;

  /* Drum volume */
  V = Vl + Vv;

  /* Water level */
  yNiveau.signal = Vl/A;

  /* Pressure at the bottom of the condenser */
  Pfond = if gravity_pressure then P + prod.d*g*Vl/A else P;

  /* Liquid phase mass balance equation in the cavity */
  BQl = -Cl.Q + Qcond - Qevap;

  if dynamic_energy_balance then
    rhol*der(Vl) + Vl*(prol.ddph*der(P) + prol.ddhp*der(hl)) = BQl;
  else
    0 = BQl;
  end if;

  /* Vapor phase mass balance equation in the cavity */
  BQv = Cv.Q + Qevap - Qcond;

  if dynamic_energy_balance then
    rhov*der(Vv) + Vv*(prov.ddph*der(P) + prov.ddhp*der(hv)) = BQv;
  else
    0 = BQv;
  end if;

  /* Condensation and evaporation mass flow rates */
  Qcond = if noEvent(xv < Xvo) then Ccond*rhov*Vv*(Xvo - xv) else 0;
  Qevap = if noEvent(xl > Xlo) then Cevap*rhol*Vl*(xl - Xlo) else 0;

  Cv.P = P;
  Cl.P = Pfond;

  /* Liquid phase energy balance equation in the cavity */
  BHl = -Cl.Q*(Cl.h - (hl - P/rhol)) + Qcond*(lsat.h - (hl - P/rhol)) - Qevap*(vsat.h - (hl - P/rhol)) + Wvl + Jt_l;

  if dynamic_energy_balance then
    Vl*((P/rhol*prol.ddph - 1)*der(P) + (P/rhol*prol.ddhp + rhol)*der(hl)) = BHl;
  else
    0 = BHl;
  end if;

  /* Vapor phase energy balance equation in the cavity */
  BHv = Cv.Q*(Cv.h - (hv - P/rhov)) + Qevap*(vsat.h - (hv - P/rhov)) - Qcond*(lsat.h - (hv - P/rhov)) - Wvl + Wout + Jt_v;

  if dynamic_energy_balance then
    Vv*((P/rhov*prov.ddph - 1)*der(P) + (P/rhov*prov.ddhp + rhov)*der(hv)) = BHv;
  else
    0 = BHv;
  end if;

  Cv.h_vol_2 = hv;
  Cl.h_vol_1 = hl;

  /* Heat transfer between the liquid and the vapor */
  Wvl = Kvl*Avl*(Tv - Tl);

  /* Thermal power exchanged from the steam to the pipes */
  Wout = -Cv.Q*(Cv.h - hl);
  Wout = -Cee.Q*(Cse.h - Cee.h);

  /* Fluid composition in the cavity (no balance equations) */
  Cl.ftype = ftype;

  Cl.Xco2 = 0;
  Cl.Xh2o = 1;
  Cl.Xo2  = 0;
  Cl.Xso2 = 0;

  /* Pipes inlet and outlet */
  Cee.Q = Cse.Q;

  Cee.h_vol_1 = Cse.h_vol_1;
  Cee.h_vol_2 = Cse.h_vol_2;

  Cse.diff_on_1 = Cee.diff_on_1;
  Cee.diff_on_2 = Cse.diff_on_2;

  Cse.diff_res_1 = Cee.diff_res_1 + 1/gamma_diff;
  Cee.diff_res_2 = Cse.diff_res_2 + 1/gamma_diff;

  Cee.ftype = Cse.ftype;

  Cee.Xco2 = Cse.Xco2;
  Cee.Xh2o = Cse.Xh2o;
  Cee.Xo2  = Cse.Xo2;
  Cee.Xso2 = Cse.Xso2;

  ftype_p = Cee.ftype;

  Q = Cee.Q;
  deltaP = Cee.P - Cse.P;

  /* Pressure losses in the pipes */
  dpf = khi*ThermoSysPro.Functions.ThermoSquare(Cee.Q,eps)/(2*At^2*rhom);
  dpg = rhom*g*(z2 - z1);
  deltaP = dpf + dpg;

  khi = lambda*L/D;

  /* Diffusion resistance in the pipes */
  gamma_diff = A*k/cp/L;

  /* Flow reversal */
  if continuous_flow_reversal then
    Cl.h = ThermoSysPro.Functions.SmoothCond(Cl.Q/gamma_l, Cl.h_vol_1, Cl.h_vol_2, 1);
  else
    Cl.h = if (Cl.Q > 0) then Cl.h_vol_1 else Cl.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    rv = if Cv.diff_on_1 then exp(-0.033*(Cv.Q*Cv.diff_res_1)^2) else 0;
    rl = if Cl.diff_on_2 then exp(-0.033*(Cl.Q*Cl.diff_res_2)^2) else 0;

    gamma_v = if Cv.diff_on_1 then 1/Cv.diff_res_1 else gamma0;
    gamma_l = if Cl.diff_on_2 then 1/Cl.diff_res_2 else gamma0;

    Jv = if Cv.diff_on_1 then rv*gamma_v*(Cv.h_vol_1 - Cv.h_vol_2) else 0;
    Jl = if Cl.diff_on_2 then rl*gamma_l*(Cl.h_vol_2 - Cl.h_vol_1) else 0;
  else
    rv = 0;
    rl = 0;

    gamma_v = gamma0;
    gamma_l = gamma0;

    Jv = 0;
    Jl = 0;
   end if;

  Jt_l = Jl;
  Jt_v = Jv;

  Cv.diff_res_2 = 0;
  Cl.diff_res_1 = 0;

  Cv.diff_on_2 = diffusion;
  Cl.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties */
  Pm = (Cee.P + Cse.P)/2;
  hm = (Cee.h + Cse.h)/2;

  prol = ThermoSysPro.Properties.Fluid.Ph(P, hl,0, fluid_c);
  prov = ThermoSysPro.Properties.Fluid.Ph(P, hv,0, fluid_c);
  prod = ThermoSysPro.Properties.Fluid.Ph(Pfond, Cl.h, 0, fluid_c);
  proe = ThermoSysPro.Properties.Fluid.Ph(Pm, hm, mode, fluid_p);

  (lsat,vsat) = ThermoSysPro.Properties.Fluid.Water_sat_P(P, fluid_c);

  rhom = proe.d;

  Tl = prol.T;
  rhol = prol.d;
  xl = prol.x;

  Tv = prov.T;
  rhov = prov.d;
  xv = prov.x;

  k =  ThermoSysPro.Properties.Fluid.ThermalConductivity_Ph(Pm, hm, fluid_p, mode, Cee.Xco2, Cee.Xh2o,Cee.Xo2, Cee.Xso2);
  cp = ThermoSysPro.Properties.Fluid.SpecificHeatCapacityCp_Ph(Pm, hm, fluid_p, mode, Cee.Xco2, Cee.Xh2o, Cee.Xo2, Cee.Xso2);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{100,20},{80,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,20},{-80,-60}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,6},{-80,0}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-18},{-80,-24}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-40},{-80,-46}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,6},{20,0}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-40},{20,-46}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-18},{20,-24}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-18},{-30,-24}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-40},{-30,-46}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,6},{-30,0}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-72},{100,-100}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-20,100},{20,100},{100,20},{100,-100},{-100,-100},{-100,20},
              {-20,100}},
          color={0,0,255},
          thickness=0.5)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-20,100},{20,100},{100,20},{100,-100},{-100,-100},{-100,20},
              {-20,100}},
          color={0,0,255},
          thickness=0),
        Rectangle(
          extent={{100,20},{80,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,20},{-80,-60}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,6},{-80,0}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-18},{-80,-24}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-40},{-80,-46}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,6},{20,0}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-40},{20,-46}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-18},{20,-24}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-18},{-30,-24}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-40},{-30,-46}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,6},{-30,0}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-72},{100,-100}},
          lineColor={0,0,255},
          lineThickness=0,
          fillColor= DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,102},{-22,100},{-42,94},{-62,82},{-82,62},{-94,42},{-100,
              22},{-100,20},{-98,20},{100,20},{100,20},{96,28},{90,42},{78,62},
              {58,82},{38,94},{18,100},{-2,102}},
          lineColor={28,108,200},
          fillColor= DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static),
          lineThickness=0,
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-66,66},{72,22}},
          lineColor={0,0,255},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString=
               "Simple"),
        Text(
          extent={{-130,4},{-104,-12}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Water inlet"),
        Text(
          extent={{108,4},{136,-10}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Water outlet"),
        Text(
          extent={{-18,92},{24,74}},
          lineColor={0,0,0},
          lineThickness=0,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Turbine outlet"),
        Text(
          extent={{12,132},{40,104}},
          lineColor={238,46,47},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Steam inlet")}),
    Window(
      x=0.11,
      y=0.06,
      width=0.78,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 9.5.3 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni</li>
</ul>
</html>"));
end SimpleDynamicCondenser;
