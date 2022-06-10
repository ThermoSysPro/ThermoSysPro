within ThermoSysPro.Fluid.HeatExchangers;
model StaticCondenser "Static condenser"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.Area SCO=10000 "Heat exchange surface";
  parameter Real CPCE=0.02 "Pressure loss coefficient for the water side (Pa.s²/(kg.m**3))";
  parameter Units.SI.Height z=0.5 "Water level in the condenser";
  parameter Units.SI.CoefficientOfHeatTransfer KCO=1
    "Reference heat exchange coefficient";
  parameter Units.SI.MassFlowRate QC0=100 "Reference mass flow rate";
  parameter Units.SI.Temperature Tref=293 "Reference temperature";
  parameter Real COPR=1 "Reference fouling coefficient";
  parameter Real COP=1 "Actual fouling coefficient";
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Air diffusion conductance (active if diffusion=true in neighbouring volumes)";
  parameter Boolean continuous_flow_reversal=false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region_ee=IF97Region.All_regions "IF97 region at the water inlet (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_se=IF97Region.All_regions "IF97 region at the water outlet (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_ex=IF97Region.All_regions "IF97 region at the extraction point (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  parameter Integer fluid=Integer(ftype) "Water fluid number";
  parameter Integer mode_ee=Integer(region_ee) - 1 "IF97 region at the water inlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_se=Integer(region_se) - 1 "IF97 region at the water outlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_ex=Integer(region_ex) - 1 "IF97 region at the extraction point. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";

public
  Units.SI.MassFlowRate Qee(start=10)
    "Cooling water mass flow rate at the inlet";
  Units.SI.SpecificEnthalpy Hee(start=250000)
    "Cooling water specific anthalpy at the inlet";
  Units.SI.AbsolutePressure Pee(start=1.e5)
    "Cooling water pressure at the inlet";
  Units.SI.MassFlowRate Qep(start=10) "Drain mass flow rate at the inlet";
  Units.SI.SpecificEnthalpy Hep(start=1000000)
    "Drain specific enthalpy at the inlet";
  Units.SI.MassFlowRate Qev(start=10) "Vapor mass flow rate at the inlet";
  Units.SI.SpecificEnthalpy Hev(start=2500000)
    "Vapor specific enthalpy at the inlet";
  Units.SI.MassFlowRate Qvt(start=10)
    "Vapor mass flow rate leaving the turbine";
  Units.SI.SpecificEnthalpy Hvt(start=2500000)
    "Vapor specific enthalpy leaving the turbine";
  Units.SI.MassFlowRate Qse(start=10)
    "Cooling water mass flow rate at the outlet";
  Units.SI.SpecificEnthalpy Hse(start=500000)
    "Cooling water specific enthalpy at the outlet";
  Units.SI.AbsolutePressure Pse(start=1.e5)
    "Cooling water pressure at the outlet";
  Units.SI.MassFlowRate Qex(start=10) "Drain mass flow rate at the outlet";
  Units.SI.SpecificEnthalpy Hex(start=500000)
    "Drain specific enthalpy at the outlet";
  Units.SI.AbsolutePressure Pex(start=1.e5) "Drain pressure at the outlet";
  Units.SI.SpecificEnthalpy Hsate(start=200000)
    "Water specific enthalpy at the saturation point";
  Units.SI.AbsolutePressure Pcond(start=17000)
    "Vapor pressure inside the condenser";
  Units.SI.Temperature Tsat(start=500)
    "Water temperature at the saturation point";
  Units.SI.Temperature Tee(start=300) "Cooling water temperature at the inlet";
  Units.SI.Temperature Tse(start=400) "Cooling water temperature at the outlet";
  Units.SI.Density rho_ee(start=900) "Cooling water density at the inlet";
  Units.SI.Density rho_ex(start=900) "Water density at the extraction point";
  Units.SI.CoefficientOfHeatTransfer KT1(start=50)
    "First reference value for the exchange coefficient";
  Units.SI.CoefficientOfHeatTransfer KT2(start=50)
    "Second reference value for the exchange coefficient";
  Units.SI.CoefficientOfHeatTransfer XKCO(start=200)
    "Heat transfer coefficient";
  Units.SI.SpecificEnthalpy Hml(start=250000)
    "Extraction water average specific enthalpy";
  Units.SI.Power W "Heat power released to the cold source";
  FluidType fluids[5] "Fluids mixing in volume";
  Units.SI.Power Jvt "Thermal power diffusion from inlet Cvt";
  Units.SI.Power Jev "Thermal power diffusion from inlet Cev";
  Units.SI.Power Jep "Thermal power diffusion from inlet Cep";
  Units.SI.Power Jex "Thermal power diffusion from outlet Cex";
  Units.SI.Power J "Total thermal power diffusion for the liquid in the cavity";
  Units.SI.MassFlowRate gamma_vt "Diffusion conductance for inlet Cvt";
  Units.SI.MassFlowRate gamma_ev "Diffusion conductance for inlet Cev";
  Units.SI.MassFlowRate gamma_ep "Diffusion conductance for inlet Cep";
  Units.SI.MassFlowRate gamma_ex "Diffusion conductance for outlet Cex";
  Real rvt "Value of r(Q/gamma) for inlet Cvt";
  Real rev "Value of r(Q/gamma) for inlet Cev";
  Real rep "Value of r(Q/gamma) for inlet Cep";
  Real rex "Value of r(Q/gamma) for outlet Cex";
  FluidType ftype_p "Cooling pipe fluid type";
  Integer fluid_p=Integer(ftype_p) "Cooling pipe fluid number";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Cee "Cooling water inlet"
    annotation (Placement(transformation(extent={{-112,-72},{-88,-50}},
          rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cse
    "Cooling water outlet" annotation (Placement(transformation(extent={{90,-72},
            {114,-50}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cex "Extraction water"
    annotation (Placement(transformation(extent={{-12,-112},{14,-88}}, rotation=
           0), iconTransformation(extent={{-12,-112},{14,-88}})));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Cvt "Turbine outlet"
    annotation (Placement(transformation(extent={{-13,88},{13,114}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proex
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{60,80},{80,100}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proee
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{20,80},{40,100}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prose
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat1
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat1
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Cep "Drain inlet"
    annotation (Placement(transformation(extent={{-112,8},{-88,30}}, rotation=0)));
public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Cev "Vapor inlet"
    annotation (Placement(transformation(extent={{-112,50},{-88,72}}, rotation=
            0)));
equation

  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Cvt.ftype;
  fluids[3] = Cev.ftype;
  fluids[4] = Cep.ftype;
  fluids[5] = Cex.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids), "StaticCondenser: fluids mixing in condenser volume are not compatible with each other");

  /* Check that the fluid type for the cooling pipe is water/steam */
  assert((ftype_p == FluidType.WaterSteam) or (ftype_p == FluidType.WaterSteamSimple), "StaticCondenser: the fluid type for the cooling pipe must be water/steam");

  /* Unconnected connectors */
  if (cardinality(Cev) == 0) then
    Cev.Q = 0;
    Cev.h = 1.e5;
    Cev.h_vol_1 = 1.e5;
    Cev.diff_res_1 = 0;
    Cev.diff_on_1 = false;
    Cev.ftype = ftype;
    Cev.Xco2 = 0;
    Cev.Xh2o = 1;
    Cev.Xo2 = 0;
    Cev.Xso2 = 0;
  end if;

  if (cardinality(Cep) == 0) then
    Cep.Q = 0;
    Cep.h = 1.e5;
    Cep.h_vol_1 = 1.e5;
    Cep.diff_res_1 = 0;
    Cep.diff_on_1 = false;
    Cep.ftype = ftype;
    Cep.Xco2 = 0;
    Cep.Xh2o = 1;
    Cep.Xo2 = 0;
    Cep.Xso2 = 0;
  end if;

  // Water/steam cavity
  //-------------------

  /* Mass balance equation */
  0 = Cvt.Q + Cev.Q + Cep.Q - Cex.Q;

  Qvt = Cvt.Q;
  Qev = Cev.Q;
  Qep = Cep.Q;
  Qex = Cex.Q;

  /* Extraction water pressure */
  Pex = Pcond + rho_ex*g*z;

  /* Fluid pressure */
  Pcond = Cvt.P;
  Pcond = Cev.P;
  Pcond = Cep.P;
  Pex = Cex.P;

  /* Energy balance equation */
  0 = Cvt.Q* Cvt.h + Cev.Q*Cev.h + Cep.Q*Cep.h - Cex.Q*Cex.h - W + J;
  // 0 = Qvt*(Hvt - Hsate) + Qev*(Hev - Hsate) + Qep*(Hep - Hsate) - W + J;

  /* Extraction water average specific enthalpy */
  Hml = Hsate;
  // Hml = (Hsate + Hex)/2;

  Cvt.h_vol_2 = Hml;
  Cev.h_vol_2 = Hml;
  Cep.h_vol_2 = Hml;
  Cex.h_vol_1 = Hml;

  /* Fluid specific enthalpies */
  Hvt = Cvt.h;
  Hev = Cev.h;
  Hep = Cep.h;
  Hex = Cex.h;
  // Hex = noEvent(if (rho_ex > 0) then Hsate + ((Pex - Pcond)/rho_ex) else Hsate);

  /* First reference value for the exchange coefficient */
  KT1 = -0.05*(Tref - 273.16)^2 + 3.3*(Tref - 273.16) + 52;

  /* Second reference value for the exchange coefficient */
  KT2 = -0.05*(Tee - 273.16)^2 + 3.3*(Tee - 273.16) + 52;

  /* Heat exchange coefficient */
  XKCO = KCO*(COP/COPR)*(KT2/KT1)*ThermoSysPro.Functions.ThermoRoot(Qee/QC0, Modelica.Constants.eps);

  /* Fluid saturation temperature */
  0 = Tsat - Tse - (Tsat - Tee)*exp(XKCO*SCO*((Tee - Tse)/W));

  /* Fluid composition in the cavity (no balance equations) */
  Cex.ftype = ftype;

  Cex.Xco2 = 0;
  Cex.Xh2o = 1;
  Cex.Xo2  = 0;
  Cex.Xso2 = 0;

  /* Flow reversal */
  if continuous_flow_reversal then
    Cex.h = ThermoSysPro.Functions.SmoothCond(Cex.Q/gamma_ex, Cex.h_vol_1, Cex.h_vol_2, 1);
  else
    Cex.h = if (Cex.Q > 0) then Cex.h_vol_1 else Cex.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    rvt = if Cvt.diff_on_1 then exp(-0.033*(Cvt.Q*Cvt.diff_res_1)^2) else 0;
    rev = if Cev.diff_on_1 then exp(-0.033*(Cev.Q*Cev.diff_res_1)^2) else 0;
    rep = if Cep.diff_on_1 then exp(-0.033*(Cep.Q*Cep.diff_res_1)^2) else 0;
    rex = if Cex.diff_on_2 then exp(-0.033*(Cex.Q*Cex.diff_res_2)^2) else 0;

    gamma_vt = if Cvt.diff_on_1 then 1/Cvt.diff_res_1 else gamma0;
    gamma_ev = if Cev.diff_on_1 then 1/Cev.diff_res_1 else gamma0;
    gamma_ep = if Cep.diff_on_1 then 1/Cep.diff_res_1 else gamma0;
    gamma_ex = if Cex.diff_on_2 then 1/Cex.diff_res_2 else gamma0;

    Jvt = if Cvt.diff_on_1 then rvt*gamma_vt*(Cvt.h_vol_1 - Cvt.h_vol_2) else 0;
    Jev = if Cev.diff_on_1 then rev*gamma_ev*(Cev.h_vol_1 - Cev.h_vol_2) else 0;
    Jep = if Cep.diff_on_1 then rep*gamma_ep*(Cep.h_vol_1 - Cep.h_vol_2) else 0;
    Jex = if Cex.diff_on_2 then rex*gamma_ex*(Cex.h_vol_2 - Cex.h_vol_1) else 0;
  else
    rvt = 0;
    rev = 0;
    rep = 0;
    rex = 0;

    gamma_vt = gamma0;
    gamma_ev = gamma0;
    gamma_ep = gamma0;
    gamma_ex = gamma0;

    Jvt = 0;
    Jev = 0;
    Jep = 0;
    Jex = 0;
   end if;

  J = Jvt + Jev + Jep + Jex;

  Cvt.diff_res_2 = 0;
  Cev.diff_res_2 = 0;
  Cep.diff_res_2 = 0;
  Cex.diff_res_1 = 0;

  Cvt.diff_on_2 = diffusion;
  Cev.diff_on_2 = diffusion;
  Cep.diff_on_2 = diffusion;
  Cex.diff_on_1 = diffusion;

  // Cooling pipe
  //-------------

  /* Cooling pipe inlet and outlet */
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

  Qee = Cee.Q;
  Qse = Cse.Q;

  Pee = Cee.P;
  Pse = Cse.P;

  Hee = Cee.h;
  Hse = Cse.h;

  /* Pressure loss equation in the water pipe */
  Pse = noEvent(if (rho_ee > 0) then Pee - (CPCE * ThermoSysPro.Functions.ThermoSquare(Qee, eps)/ rho_ee) else Pee);

  /* Heating power released to the cooling pipe */
  W = Qee*(Hse - Hee);

  /* Fluid thermodynamic properties */
  proee = ThermoSysPro.Properties.Fluid.Ph(Pee, Hee, mode_ee, fluid_p);
  proex = ThermoSysPro.Properties.Fluid.Ph(Pex, Hex, mode_ex, fluid);
  prose = ThermoSysPro.Properties.Fluid.Ph(Pse, Hse, mode_se, fluid_p);

  rho_ee = proee.d;
  rho_ex = proex.d;

  Tee = proee.T;
  Tse = prose.T;

  /* Vapor pressure inside the condenser */
  Pcond = ThermoSysPro.Properties.Fluid.P_sat(Tsat, fluid);

  /* Fluid thermodynamic properties at the saturation point */
  (lsat1,vsat1) = ThermoSysPro.Properties.Fluid.Water_sat_P(Pcond, fluid);

  Hsate = lsat1.h;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{100,-82},{100,80},{-100,80},{-100,-82},{100,-82}},
          lineColor={28,108,200},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,88},{20,70}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Turbine outlet"),
        Text(
          extent={{-82,24},{-52,16}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Drain inlet"),
        Text(
          extent={{-24,-52},{26,-72}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Extraction water"),
        Text(
          extent={{38,-58},{86,-66}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Cooling water outlet"),
        Text(
          extent={{-86,-52},{-32,-74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Cooling water inlet"),
        Text(
          extent={{-86,66},{-50,54}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Vapor inlet"),
        Line(
          points={{0,8},{0,-70}},
          color={0,0,0},
          thickness=0),
        Polygon(
          points={{0,-90},{-11,-70},{11,-70},{0,-90}},
          lineColor={0,0,0},
          lineThickness=0,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0}),
        Line(
          points={{-100,8},{100,8}},
          color={0,0,255},
          thickness=0),
        Line(
          points={{-100,-14},{80,-14},{80,-20},{-90,-20},{-90,-26},{80,-26},{80,
              -32},{-90,-32},{-90,-38},{100,-38}},
          color={28,108,200},
          thickness=0)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{100,-86},{100,100},{-100,100},{-100,-86},{100,-86}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid,
                    lineThickness=0),
        Text(
          extent={{20,122},{48,94}},
          lineColor={238,46,47},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Steam inlet"),
        Text(
          extent={{-128,-36},{-104,-46}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Water inlet"),
        Text(
          extent={{106,-36},{132,-52}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Water outlet"),
        Text(
          extent={{-104,44},{-74,36}},
          lineColor={0,0,0},
          lineThickness=0,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Drain inlet"),
        Text(
          extent={{-18,92},{24,74}},
          lineColor={0,0,0},
          lineThickness=0,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0},
          textString=
               "Turbine outlet"),
        Line(
          points={{0,8},{0,-66}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-100,8},{100,8}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-100,-14},{80,-14},{80,-20},{-90,-20},{-90,-26},{80,-26},{80,
              -32},{-90,-32},{-90,-38},{100,-38}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{0,-86},{-11,-66},{11,-66},{0,-86}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Sphere,
          fillColor={191,0,0})}),
    Window(
      x=0.09,
      y=0.08,
      width=0.76,
      height=0.76),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 9.7.1 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end StaticCondenser;
