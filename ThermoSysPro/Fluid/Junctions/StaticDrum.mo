within ThermoSysPro.Fluid.Junctions;
model StaticDrum "Static drum"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Real x=1 "Vapor separation efficiency at the outlet";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";

protected
  constant Units.SI.SpecificEnthalpy hr=2501569
    "Water/steam reference specific enthalpy at 0.01°C";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Integer fluid=Integer(ftype) "Fluid number";

public
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure P(start=10.e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy hl(start=100000) "Liquid phase specific enthalpy";
  Units.SI.SpecificEnthalpy hv(start=2800000) "Gas phase specific enthalpy";
  FluidType fluids[9] "Fluids mixing in volume";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H20 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Units.SI.Power Je_steam "Thermal power diffusion from inlet e_steam";
  Units.SI.Power Je_sup "Thermal power diffusion from inlet e_sup";
  Units.SI.Power Je_eva "Thermal power diffusion from inlet e_eva";
  Units.SI.Power Je_eco "Thermal power diffusion from inlet e_eco";
  Units.SI.Power Js_eva "Thermal power diffusion from outlet s_eva";
  Units.SI.Power Js_purg "Thermal power diffusion from outlet s_purg";
  Units.SI.Power Js_sup "Thermal power diffusion from outlet s_sup";
  Units.SI.Power Js_sur "Thermal power diffusion from outlet s_sur";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_e_steam "Diffusion conductance for inlet e_steam";
  Units.SI.MassFlowRate gamma_e_sup "Diffusion conductance for inlet e_sup";
  Units.SI.MassFlowRate gamma_e_eva "Diffusion conductance for inlet e_eva";
  Units.SI.MassFlowRate gamma_e_eco "Diffusion conductance for inlet e_eco";
  Units.SI.MassFlowRate gamma_s_eva "Diffusion conductance for outlet s_eva";
  Units.SI.MassFlowRate gamma_s_purg "Diffusion conductance for outlet s_purg";
  Units.SI.MassFlowRate gamma_s_sup "Diffusion conductance for outlet s_sup";
  Units.SI.MassFlowRate gamma_s_sur "Diffusion conductance for outlet s_sur";
  Real re_steam "Value of r(Q/gamma) for inlet e_steam";
  Real re_sup "Value of r(Q/gamma) for inlet e_sup";
  Real re_eva "Value of r(Q/gamma) for inlet e_eva";
  Real re_eco "Value of r(Q/gamma) for inlet e_eco";
  Real rs_eva "Value of r(Q/gamma) for outlet s_eva";
  Real rs_purg "Value of r(Q/gamma) for outlet s_purg";
  Real rs_sup "Value of r(Q/gamma) for outlet s_sup";
  Real rs_sur "Value of r(Q/gamma) for outlet s_sur";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce_eva annotation (
      Placement(transformation(extent={{-104,-44},{-84,-24}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce_eco annotation (
      Placement(transformation(extent={{-50,-104},{-30,-84}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs_sup annotation (
      Placement(transformation(extent={{84,24},{104,44}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs_eva annotation (
      Placement(transformation(extent={{30,-104},{50,-84}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs_sur annotation (
      Placement(transformation(extent={{28,84},{48,104}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs_purg annotation (
      Placement(transformation(extent={{84,-44},{104,-24}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce_steam annotation (
      Placement(transformation(extent={{-48,84},{-28,104}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce_sup annotation (
      Placement(transformation(extent={{-104,26},{-84,46}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-104,66},{-78,98}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
    annotation (Placement(transformation(extent={{72,68},{100,100}}, rotation=0)));
  Thermal.Connectors.ThermalPort Cth annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, rotation=0)));
equation

  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce_steam.ftype;
  fluids[3] = Ce_sup.ftype;
  fluids[4] = Ce_eva.ftype;
  fluids[5] = Ce_eco.ftype;
  fluids[6] = Cs_eva.ftype;
  fluids[7] = Cs_purg.ftype;
  fluids[8] = Cs_sup.ftype;
  fluids[9] = Cs_sur.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids), "StaticDrum: fluids mixing in volume are not compatible with each other");

  /* Unconnected connectors */
  /* Steam input */
  if (cardinality(Ce_steam) == 0) then
    Ce_steam.Q = 0;
    Ce_steam.h = 1.e5;
    Ce_steam.h_vol_1 = 1.e5;
    Ce_steam.diff_res_1 = 0;
    Ce_steam.diff_on_1 = false;
    Ce_steam.ftype = ftype;
    Ce_steam.Xco2 = 0;
    Ce_steam.Xh2o = 0;
    Ce_steam.Xo2  = 0;
    Ce_steam.Xso2 = 0;
  end if;

  /* Extra input */
  if (cardinality(Ce_sup) == 0) then
    Ce_sup.Q = 0;
    Ce_sup.h = 1.e5;
    Ce_sup.h_vol_1 = 1.e5;
    Ce_sup.diff_res_1 = 0;
    Ce_sup.diff_on_1 = false;
    Ce_sup.ftype = ftype;
    Ce_sup.Xco2 = 0;
    Ce_sup.Xh2o = 0;
    Ce_sup.Xo2  = 0;
    Ce_sup.Xso2 = 0;
  end if;

  /* Input from evaporator */
  if (cardinality(Ce_eva) == 0) then
    Ce_eva.Q = 0;
    Ce_eva.h = 1.e5;
    Ce_eva.h_vol_1 = 1.e5;
    Ce_eva.diff_res_1 = 0;
    Ce_eva.diff_on_1 = false;
    Ce_eva.ftype = ftype;
    Ce_eva.Xco2 = 0;
    Ce_eva.Xh2o = 0;
    Ce_eva.Xo2  = 0;
    Ce_eva.Xso2 = 0;
  end if;

  /* Input from the economizer */
  if (cardinality(Ce_eco) == 0) then
    Ce_eco.Q = 0;
    Ce_eco.h = 1.e5;
    Ce_eco.h_vol_1 = 1.e5;
    Ce_eco.diff_res_1 = 0;
    Ce_eco.diff_on_1 = false;
    Ce_eco.ftype = ftype;
    Ce_eco.Xco2 = 0;
    Ce_eco.Xh2o = 0;
    Ce_eco.Xo2  = 0;
    Ce_eco.Xso2 = 0;
  end if;

  /* Output to the evaporator */
  if (cardinality(Cs_eva) == 0) then
    Cs_eva.Q = 0;
    Cs_eva.h_vol_2 = 1.e5;
    Cs_eva.diff_res_2 = 0;
    Cs_eva.diff_on_2 = false;
  end if;

  /* Drain outlet */
  if (cardinality(Cs_purg) == 0) then
    Cs_purg.Q = 0;
    Cs_purg.h_vol_2 = 1.e5;
    Cs_purg.diff_res_2 = 0;
    Cs_purg.diff_on_2 = false;
  end if;

  /* Extra output  */
  if (cardinality(Cs_sup) == 0) then
    Cs_sup.Q = 0;
    Cs_sup.h_vol_2 = 1.e5;
    Cs_sup.diff_res_2 = 0;
    Cs_sup.diff_on_2 = false;
  end if;

  /* Output to reheater */
  if (cardinality(Cs_sur) == 0) then
    Cs_sur.Q = 0;
    Cs_sur.h_vol_2 = 1.e5;
    Cs_sur.diff_res_2 = 0;
    Cs_sur.diff_on_2 = false;
  end if;

  /* Mass balance equation */
  Ce_eco.Q + Ce_steam.Q + Ce_sup.Q + Ce_eva.Q - Cs_eva.Q - Cs_sur.Q - Cs_purg.Q - Cs_sup.Q = 0;

  P = Ce_steam.P;
  P = Ce_sup.P;
  P = Ce_eva.P;
  P = Ce_eco.P;

  P = Cs_eva.P;
  P = Cs_purg.P;
  P = Cs_sup.P;
  P = Cs_sur.P;

  /* Energy balance equation */
  Ce_eco.Q*Ce_eco.h + Ce_steam.Q*Ce_steam.h + Ce_sup.Q*Ce_sup.h + Ce_eva.Q*Ce_eva.h - Cs_eva.Q*Cs_eva.h - Cs_sur.Q*Cs_sur.h - Cs_purg.Q*Cs_purg.h - Cs_sup.Q*Cs_sup.h + Cth.W + J = 0;

  Ce_steam.h_vol_2 = hv;
  Ce_sup.h_vol_2 = hl;
  Ce_eva.h_vol_2 = hl;
  Ce_eco.h_vol_2 = hl;

  Cs_eva.h_vol_1 = hl;
  Cs_purg.h_vol_1 = hl;
  Cs_sup.h_vol_1 = hl;
  Cs_sur.h_vol_1 = (1 - x)*hl + x*hv;

  /* Fluid composition balance equations */
  0 = Ce_steam.Xco2*Ce_steam.Q + Ce_sup.Xco2*Ce_sup.Q + Ce_eva.Xco2*Ce_eva.Q + Ce_eco.Xco2*Ce_eco.Q - Cs_sur.Xco2*Cs_sur.Q - Cs_sup.Xco2*Cs_sup.Q - Cs_purg.Xco2*Cs_purg.Q - Cs_eva.Xco2*Cs_eva.Q;
  0 = Ce_steam.Xh2o*Ce_steam.Q + Ce_sup.Xh2o*Ce_sup.Q + Ce_eva.Xh2o*Ce_eva.Q + Ce_eco.Xh2o*Ce_eco.Q - Cs_sur.Xh2o*Cs_sur.Q - Cs_sup.Xh2o*Cs_sup.Q - Cs_purg.Xh2o*Cs_purg.Q - Cs_eva.Xh2o*Cs_eva.Q;
  0 = Ce_steam.Xo2*Ce_steam.Q + Ce_sup.Xo2*Ce_sup.Q + Ce_eva.Xo2*Ce_eva.Q + Ce_eco.Xo2*Ce_eco.Q - Cs_sur.Xo2*Cs_sur.Q - Cs_sup.Xo2*Cs_sup.Q - Cs_purg.Xo2*Cs_purg.Q - Cs_eva.Xo2*Cs_eva.Q;
  0 = Ce_steam.Xso2*Ce_steam.Q + Ce_sup.Xso2*Ce_sup.Q + Ce_eva.Xso2*Ce_eva.Q + Ce_eco.Xso2*Ce_eco.Q - Cs_sur.Xso2*Cs_sur.Q - Cs_sup.Xso2*Cs_sup.Q - Cs_purg.Xso2*Cs_purg.Q - Cs_eva.Xso2*Cs_eva.Q;

  Cs_eva.ftype = ftype;
  Cs_purg.ftype = ftype;
  Cs_sup.ftype = ftype;
  Cs_sur.ftype = ftype;

  Xco2 = Cs_eva.Xco2;
  Xh2o = Cs_eva.Xh2o;
  Xo2  = Cs_eva.Xo2;
  Xso2 = Cs_eva.Xso2;

  Xco2 = Cs_purg.Xco2;
  Xh2o = Cs_purg.Xh2o;
  Xo2  = Cs_purg.Xo2;
  Xso2 = Cs_purg.Xso2;

  Xco2 = Cs_sup.Xco2;
  Xh2o = Cs_sup.Xh2o;
  Xo2  = Cs_sup.Xo2;
  Xso2 = Cs_sup.Xso2;

  Xco2 = Cs_sur.Xco2;
  Xh2o = Cs_sur.Xh2o;
  Xo2  = Cs_sur.Xo2;
  Xso2 = Cs_sur.Xso2;

  /* Flow reversal */
  if continuous_flow_reversal then
    Cs_eva.h = ThermoSysPro.Functions.SmoothCond(Cs_eva.Q/gamma_s_eva, Cs_eva.h_vol_1, Cs_eva.h_vol_2, 1);
    Cs_purg.h = ThermoSysPro.Functions.SmoothCond(Cs_purg.Q/gamma_s_purg, Cs_purg.h_vol_1, Cs_purg.h_vol_2, 1);
    Cs_sup.h = ThermoSysPro.Functions.SmoothCond(Cs_sup.Q/gamma_s_sup, Cs_sup.h_vol_1, Cs_sup.h_vol_2, 1);
    Cs_sur.h = ThermoSysPro.Functions.SmoothCond(Cs_sur.Q/gamma_s_sur, Cs_sur.h_vol_1, Cs_sur.h_vol_2, 1);
  else
    Cs_eva.h = if (Cs_eva.Q > 0) then Cs_eva.h_vol_1 else Cs_eva.h_vol_2;
    Cs_purg.h = if (Cs_purg.Q > 0) then Cs_purg.h_vol_1 else Cs_purg.h_vol_2;
    Cs_sup.h = if (Cs_sup.Q > 0) then Cs_sup.h_vol_1 else Cs_sup.h_vol_2;
    Cs_sur.h = if (Cs_sur.Q > 0) then Cs_sur.h_vol_1 else Cs_sur.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    re_steam = if Ce_steam.diff_on_1 then exp(-0.033*(Ce_steam.Q*Ce_steam.diff_res_1)^2) else 0;
    re_sup = if Ce_sup.diff_on_1 then exp(-0.033*(Ce_sup.Q*Ce_sup.diff_res_1)^2) else 0;
    re_eva = if Ce_eva.diff_on_1 then exp(-0.033*(Ce_eva.Q*Ce_eva.diff_res_1)^2) else 0;
    re_eco = if Ce_eco.diff_on_1 then exp(-0.033*(Ce_eco.Q*Ce_eco.diff_res_1)^2) else 0;
    rs_eva = if Cs_eva.diff_on_2 then exp(-0.033*(Cs_eva.Q*Cs_eva.diff_res_2)^2) else 0;
    rs_purg = if Cs_purg.diff_on_2 then exp(-0.033*(Cs_purg.Q*Cs_purg.diff_res_2)^2) else 0;
    rs_sup = if Cs_sup.diff_on_2 then exp(-0.033*(Cs_sup.Q*Cs_sup.diff_res_2)^2) else 0;
    rs_sur = if Cs_sur.diff_on_2 then exp(-0.033*(Cs_sur.Q*Cs_sur.diff_res_2)^2) else 0;

    gamma_e_steam = if Ce_steam.diff_on_1 then 1/Ce_steam.diff_res_1 else gamma0;
    gamma_e_sup = if Ce_sup.diff_on_1 then 1/Ce_sup.diff_res_1 else gamma0;
    gamma_e_eva = if Ce_eva.diff_on_1 then 1/Ce_eva.diff_res_1 else gamma0;
    gamma_e_eco = if Ce_eco.diff_on_1 then 1/Ce_eco.diff_res_1 else gamma0;
    gamma_s_eva = if Cs_eva.diff_on_2 then 1/Cs_eva.diff_res_2 else gamma0;
    gamma_s_purg = if Cs_purg.diff_on_2 then 1/Cs_purg.diff_res_2 else gamma0;
    gamma_s_sup = if Cs_sup.diff_on_2 then 1/Cs_sup.diff_res_2 else gamma0;
    gamma_s_sur = if Cs_sur.diff_on_2 then 1/Cs_sur.diff_res_2 else gamma0;

    Je_steam = if Ce_steam.diff_on_1 then re_steam*gamma_e_steam*(Ce_steam.h_vol_1 - Ce_steam.h_vol_2) else 0;
    Je_sup = if Ce_sup.diff_on_1 then re_sup*gamma_e_sup*(Ce_sup.h_vol_1 - Ce_sup.h_vol_2) else 0;
    Je_eva = if Ce_eva.diff_on_1 then re_eva*gamma_e_eva*(Ce_eva.h_vol_1 - Ce_eva.h_vol_2) else 0;
    Je_eco = if Ce_eco.diff_on_1 then re_eco*gamma_e_eco*(Ce_eco.h_vol_1 - Ce_eco.h_vol_2) else 0;
    Js_eva =  if Cs_eva.diff_on_2 then rs_eva*gamma_s_eva*(Cs_eva.h_vol_2 - Cs_eva.h_vol_1) else 0;
    Js_purg = if Cs_purg.diff_on_2 then rs_purg*gamma_s_purg*(Cs_purg.h_vol_2 - Cs_purg.h_vol_1) else 0;
    Js_sup = if Cs_sup.diff_on_2 then rs_sup*gamma_s_sup*(Cs_sup.h_vol_2 - Cs_sup.h_vol_1) else 0;
    Js_sur = if Cs_sur.diff_on_2 then rs_sur*gamma_s_sur*(Cs_sur.h_vol_2 - Cs_sur.h_vol_1) else 0;
  else
    re_steam = 0;
    re_sup = 0;
    re_eva = 0;
    re_eco = 0;
    rs_eva = 0;
    rs_purg = 0;
    rs_sup = 0;
    rs_sur = 0;

    gamma_e_steam = gamma0;
    gamma_e_sup = gamma0;
    gamma_e_eva = gamma0;
    gamma_e_eco = gamma0;
    gamma_s_eva = gamma0;
    gamma_s_purg = gamma0;
    gamma_s_sup = gamma0;
    gamma_s_sur = gamma0;

    Je_steam = 0;
    Je_sup = 0;
    Je_eva = 0;
    Je_eco = 0;
    Js_eva = 0;
    Js_purg = 0;
    Js_sup = 0;
    Js_sur = 0;
  end if;

  J = Je_steam + Je_sup + Je_eva + Je_eco + Js_eva + Js_purg + Js_sup + Js_sur;

  Ce_steam.diff_res_2 = 0;
  Ce_sup.diff_res_2 = 0;
  Ce_eva.diff_res_2 = 0;
  Ce_eco.diff_res_2 = 0;
  Cs_eva.diff_res_1 = 0;
  Cs_purg.diff_res_1 = 0;
  Cs_sup.diff_res_1 = 0;
  Cs_sur.diff_res_1 = 0;

  Ce_steam.diff_on_2 = diffusion;
  Ce_sup.diff_on_2 = diffusion;
  Ce_eva.diff_on_2 = diffusion;
  Ce_eco.diff_on_2 = diffusion;
  Cs_eva.diff_on_1 = diffusion;
  Cs_purg.diff_on_1 = diffusion;
  Cs_sup.diff_on_1 = diffusion;
  Cs_sur.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties */
  (lsat,vsat) = ThermoSysPro.Properties.Fluid.Water_sat_P(P, fluid);

  hl = lsat.h;
  hv = vsat.h;
  T = lsat.T;

  Cth.T = T;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{0,90},{0,-100}}),
        Ellipse(
          extent={{-98,96},{98,-96}},
          lineColor={28,108,200},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-86,-44},{86,-44}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{-44,-86},{44,-86}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{-64,-72},{64,-72}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{-78,-58},{76,-58}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Text(extent={{-56,94},{-56,92}}, textString=
                                             "Esteam")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{0,90},{0,-100}}),
        Ellipse(
          extent={{-98,96},{98,-96}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({255,255,0},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Line(
          points={{-86,-44},{86,-44}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{-44,-86},{44,-86}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{-64,-72},{64,-72}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{-78,-58},{76,-58}},
          color={28,108,200},
          pattern=LinePattern.Dash)}),
    Window(
      x=0.33,
      y=0.08,
      width=0.66,
      height=0.69),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 14.6 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end StaticDrum;
