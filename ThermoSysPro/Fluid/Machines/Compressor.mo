within ThermoSysPro.Fluid.Machines;
model Compressor "Gas compressor"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;

  parameter Integer mass_flow_rate_comp=1 "Ways for computing the mass flow rate - 1: Q = rho*Qv - 2: Q = rho*f(T)";
  parameter Units.SI.Temperature Tmax=284.16
    "Air transition temperature between f1 = a*x + b and f2 = c*x + d for the computation of Q (active if mass_flow_rate_comp == 2)";
  parameter Real coef1_1=0.1164 "Coefficient a for f1 = a*x + b";
   parameter Real coef2_1=38.643 "Coefficient b for f1 = a*x + b";
  parameter Real coef1_2=-0.2324 "Coefficient c for f2 = c*x + d";
  parameter Real coef2_2=137.49 "Coefficient d for f2 = c*x + d";
  parameter Real A4=-1.2362 "Coefficient of X^4 for the computation of the isentropic efficiency";
  parameter Real A3=3.6721 "Coefficient of X^3 for the computation of the isentropic efficiency";
  parameter Real A2=-4.2434 "Coefficient of X^2 for the computation of the isentropic efficiency";
  parameter Real A1=2.3957 "Coefficient of X^1 for the computation of the isentropic efficiency";
  parameter Real A0=0.4118 "Coefficient of X^0 for the computation of the isentropic efficiency";
  parameter Real tau_n=14.149 "Nominal compression rate";
  parameter Real is_eff_n=0.84752 "Nominal isentropic efficiency";
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";

protected
  Units.SI.VolumeFlowRate Qv_cal(start=500)
    "Intermediate variable for the computation of Qv";

public
  Real tau(start=15) "Compression rate";
  Real is_eff(start=0.85) "Isentropic efficiency";
  Units.SI.Power Wcp(start=1e9) "Compressor power";
  Units.SI.AbsolutePressure Pe(start=1e5) "Air pressure at the inlet";
  Units.SI.AbsolutePressure Ps(start=15e5) "Air pressure at the outlet";
  Real Xtau( start=1) "Normal and nominal compression rates ratio";
  Units.SI.MassFlowRate Q(start=500) "Air mass flow rate";
  Units.SI.VolumeFlowRate Qv(start=500) "Air volume flow rate";
  Units.SI.Temperature Te(start=300) "Air temperature at the inlet";
  Units.SI.Temperature Ts(start=750) "Air temperature at the outlet";
  Units.SI.Temperature Tis(start=750)
    "Isentropic air temperature at the outlet";
  Units.SI.SpecificEnthalpy He(start=80e3) "Air specific enthalpy at the inlet";
  Units.SI.SpecificEnthalpy Hs(start=500e3)
    "Air specific enthalpy at the outlet";
  Units.SI.SpecificEnthalpy His(start=450e3)
    "Air specific enthalpy after the isentropic compression";
  Units.SI.SpecificEntropy Se "Air specific entropy at the inlet";
  Units.SI.Density rho_e(start=1) "Air density at the inlet";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";

public
  Interfaces.Connectors.FluidInlet Ce annotation (Placement(transformation(
          extent={{-100,-10},{-80,10}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Cs annotation (Placement(transformation(
          extent={{80,-10},{100,10}}, rotation=0)));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Power
    annotation (Placement(transformation(extent={{80,-40},{100,-20}}, rotation=
            0)));
equation
  /* Check that the fluid type is flue gases */
  assert(ftype == FluidType.FlueGases, "Compressor: the fluid type must be flue gases");

  Ce.Q = Cs.Q;

  Ce.h_vol_1 = Cs.h_vol_1;
  Ce.h_vol_2 = Cs.h_vol_2;

  Cs.diff_on_1 = if (gamma_diff > 0) then Ce.diff_on_1 else false;
  Ce.diff_on_2 = if (gamma_diff > 0) then Cs.diff_on_2 else false;

  Cs.diff_res_1 = Ce.diff_res_1 + (if (gamma_diff > 0) then 1/gamma_diff else 0);
  Ce.diff_res_2 = Cs.diff_res_2 + (if (gamma_diff > 0) then 1/gamma_diff else 0);

  Ce.ftype = Cs.ftype;

  Ce.Xco2 = Cs.Xco2;
  Ce.Xh2o = Cs.Xh2o;
  Ce.Xo2  = Cs.Xo2;
  Ce.Xso2 = Cs.Xso2;

  Q = Ce.Q;

  Pe = Ce.P;
  Ps = Cs.P;

  He = Ce.h;
  Hs = Cs.h;

  ftype = Ce.ftype;

  /* Compression rate */
  tau = Ps/Pe;

  /* Compression rates ratio */
  Xtau = tau/tau_n;

  /* Isentropic efficiency */
  is_eff = (A4*Xtau^4 + A3*Xtau^3 + A2*Xtau^2 + A1*Xtau + A0)*is_eff_n;

  /* Compressor power */
  Wcp = Q*(He - Hs);
  Power.signal = Wcp;

  /* Volume flow rate at the inlet */
  Qv_cal = if (Te < Tmax) then coef1_1*Te + coef2_1 else coef1_2*Te + coef2_2;
  Q = if (mass_flow_rate_comp == 1) then Qv*rho_e else Qv_cal*rho_e;

  /* Specific enthalpy at the inlet */
  //Te = ThermoSysPro.Properties.Fluid.Temperature_Ph(Pe, He, fluid, 0, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  // Call implicitly to avoid function that cannot be differentiated.
  He = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Specific entropy at the inlet */
  Se = ThermoSysPro.Properties.FlueGases.FlueGases_s(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Specific enthalpy after the isentropic compression */
  Se = ThermoSysPro.Properties.FlueGases.FlueGases_s(Ps, Tis, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  His = ThermoSysPro.Properties.FlueGases.FlueGases_h(Ps, Tis, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Fluid density at the inlet */
  //rho_e = ThermoSysPro.Properties.Fluid.Density_Ph(Pe, He, fluid, 0, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  rho_e = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pe, Te, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  /* Specific enthalpy at the outlet */
  Hs = (His - He + is_eff*He)/is_eff;

  /* Temperature at the outlet */
  // Ts = ThermoSysPro.Properties.Fluid.Temperature_Ph(Ps, Hs, fluid, 0, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  // Call implicitly to avoid function that cannot be differentiated.
  Hs = ThermoSysPro.Properties.FlueGases.FlueGases_h(Ps, Ts, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{
            120,100}}), graphics={Polygon(
          points={{-80,80},{-80,-80},{80,-40},{80,40},{-80,80}},
          lineColor={0,0,0},
          fillColor={0,255,0},
          fillPattern=FillPattern.Backward)}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,
            100}}), graphics={Polygon(
          points={{-80,80},{-80,-80},{80,-40},{80,40},{-80,80}},
          lineColor={0,0,0},
          fillColor=DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Backward)}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 11.3 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>"));
end Compressor;
