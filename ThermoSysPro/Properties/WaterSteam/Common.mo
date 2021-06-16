within ThermoSysPro.Properties.WaterSteam;
package Common
  import SI = Modelica.SIunits;

  record HelmholtzData
    Modelica.SIunits.Density d;
    Modelica.SIunits.Temperature T;
    Modelica.SIunits.SpecificHeatCapacity R;
    annotation (
      Window(
        x=0.16,
        y=0.26,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,50},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid),
          Text(extent={{-127,115},{127,55}}, textString=
                                                 "%name"),
          Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Line(points={{0,50},{0,-100}}, color={0,0,0})}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end HelmholtzData;

  record GibbsData
    Modelica.SIunits.AbsolutePressure p;
    Modelica.SIunits.Temperature T;
    Modelica.SIunits.SpecificHeatCapacity R;
    annotation (
      Window(
        x=0.16,
        y=0.26,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,50},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid),
          Text(extent={{-127,115},{127,55}}, textString=
                                                 "%name"),
          Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Line(points={{0,50},{0,-100}}, color={0,0,0})}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end GibbsData;

  record GibbsDerivs
    "derivatives of dimensionless Gibbs-function w.r.t dimensionless pressure and temperature"
    extends Modelica.Icons.Record;
    Modelica.SIunits.Pressure p "pressure";
    Modelica.SIunits.Temperature T "temperature";
    Modelica.SIunits.SpecificHeatCapacity R "specific heat capacity";
    Real pi(unit="1") "dimensionless pressure";
    Real tau(unit="1") "dimensionless temperature";
    Real g(unit="1") "dimensionless Gibbs-function";
    Real gpi(unit="1") "derivative of g w.r.t. pi";
    Real gpipi(unit="1") "2nd derivative of g w.r.t. pi";
    Real gtau(unit="1") "derivative of g w.r.t. tau";
    Real gtautau(unit="1") "2nd derivative of g w.r.t tau";
    Real gtaupi(unit="1") "mixed derivative of g w.r.t. pi and tau";
  end GibbsDerivs;

  record HelmholtzDerivs
    "derivatives of dimensionless Helmholtz-function w.r.t dimensionless pressuredensity and temperature"
    extends Modelica.Icons.Record;
    Modelica.SIunits.Density d "density";
    Modelica.SIunits.Temperature T "temperature";
    Modelica.SIunits.SpecificHeatCapacity R "specific heat capacity";
    Real delta(unit="1") "dimensionless density";
    Real tau(unit="1") "dimensionless temperature";
    Real f(unit="1") "dimensionless Helmholtz-function";
    Real fdelta(unit="1") "derivative of f w.r.t. delta";
    Real fdeltadelta(unit="1") "2nd derivative of f w.r.t. delta";
    Real ftau(unit="1") "derivative of f w.r.t. tau";
    Real ftautau(unit="1") "2nd derivative of f w.r.t. tau";
    Real fdeltatau(unit="1") "mixed derivative of f w.r.t. delta and tau";
  end HelmholtzDerivs;

  record ThermoProperties_ph
    Modelica.SIunits.Temperature T(
      min=InitLimits.TMIN,
      max=InitLimits.TMAX,
      nominal=InitLimits.TNOM) "Temperature";
    Modelica.SIunits.Density d(
      min=InitLimits.DMIN,
      max=InitLimits.DMAX,
      nominal=InitLimits.DNOM) "Density";
    Modelica.SIunits.SpecificEnergy u(
      min=InitLimits.SEMIN,
      max=InitLimits.SEMAX,
      nominal=InitLimits.SENOM) "Specific inner energy";
    Modelica.SIunits.SpecificEntropy s(
      min=InitLimits.SSMIN,
      max=InitLimits.SSMAX,
      nominal=InitLimits.SSNOM) "Specific entropy";
    Modelica.SIunits.SpecificHeatCapacity cp(
      min=InitLimits.CPMIN,
      max=InitLimits.CPMAX,
      nominal=InitLimits.CPNOM) "Specific heat capacity at constant presure";
    Modelica.SIunits.DerDensityByEnthalpy ddhp
      "Derivative of density wrt. specific enthalpy at constant pressure";
    Modelica.SIunits.DerDensityByPressure ddph
      "Derivative of density wrt. pressure at constant specific enthalpy";
    Real duph(unit="m3/kg")
      "Derivative of specific inner energy wrt. pressure at constant specific enthalpy";
    Real duhp(unit = "1")
      "Derivative of specific inner energy wrt. specific enthalpy at constant pressure";
    ThermoSysPro.Units.MassFraction x "Vapor mass fraction";
    annotation (
      Window(
        x=0.21,
        y=0.32,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,50},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid),
          Text(extent={{-127,115},{127,55}}, textString=
                                                 "%name"),
          Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Line(points={{0,50},{0,-100}}, color={0,0,0})}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end ThermoProperties_ph;

  function gibbsToProps_ph
    input GibbsDerivs g "dimensionless derivatives of the Gibbs function";
    output ThermoProperties_ph pro;
  protected
    Real vt;
    Real vp;
  algorithm
    pro.T := min(max(g.T, InitLimits.TMIN), InitLimits.TMAX);
    pro.d := max(g.p,ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.ptriple)/(g.R*pro.T*g.pi*g.gpi);
    pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    pro.s := g.R*(g.tau*g.gtau - g.g);
    pro.cp := -g.R*g.tau*g.tau*g.gtautau;
    vt := g.R/max(g.p,ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.ptriple)*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(max(g.p,ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.ptriple)
          *max(g.p,ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.ptriple))*g.pi*g.pi*g.gpipi;
    pro.ddhp := -pro.d*pro.d*vt/(pro.cp);
    pro.ddph := -pro.d*pro.d*(vp*pro.cp - vt/pro.d + g.T*vt*vt)/pro.cp;
    pro.duph := -1/pro.d + g.p/(pro.d*pro.d)*pro.ddph;
    pro.duhp := 1 + g.p/(pro.d*pro.d)*pro.ddhp;
    annotation (
      Window(
        x=0.05,
        y=0.05,
        width=0.54,
        height=0.72),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-132,102},{144,42}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"),   DymolaStoredErrors,
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
  end gibbsToProps_ph;

  record NewtonDerivatives_ph
    Modelica.SIunits.AbsolutePressure p;
    Modelica.SIunits.SpecificEnthalpy h;
    Real pd;
    Real pt;
    Real hd;
    Real ht;
    annotation (
      Window(
        x=0.25,
        y=0.33,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,50},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid),
          Text(extent={{-127,115},{127,55}}, textString=
                                                 "%name"),
          Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Line(points={{0,50},{0,-100}}, color={0,0,0})}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end NewtonDerivatives_ph;

  function helmholtzToProps_ph
    input HelmholtzDerivs f
      "dimensionless derivatives of the Helmholtz function";
    output ThermoProperties_ph pro;
  protected
    Real pd;
    Real pt;
  protected
   Real cv "Heat capacity at constant volume";
  algorithm
    pro.d := f.d;
    pro.T := f.T;
    pro.s := f.R*(f.tau*f.ftau - f.f);
    pro.u := f.R*f.T*f.tau*f.ftau;
    cv := f.R*(-f.tau*f.tau*f.ftautau);
    // calculating cp near the critical point may be troublesome (cp -> inf).
    pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
              *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    pro.ddph := (f.d*(cv*f.d + pt))/(f.d*f.d*pd*cv + f.T*pt*pt);
    pro.ddhp := -f.d*f.d*pt/(f.d*f.d*pd*cv + f.T*pt*pt);
    annotation (
      Icon(graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"),   Diagram(graphics));
  end helmholtzToProps_ph;

  record PhaseBoundaryProperties
    "thermodynamic base properties on the phase boundary"
    extends Modelica.Icons.Record;
    Modelica.SIunits.Density d "density";
    Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
    Modelica.SIunits.SpecificEnergy u "inner energy";
    Modelica.SIunits.SpecificEntropy s "specific entropy";
    Modelica.SIunits.SpecificHeatCapacity cp
      "heat capacity at constant pressure";
    Modelica.SIunits.SpecificHeatCapacity cv "heat capacity at constant volume";
    ThermoSysPro.Units.DerPressureByTemperature pt
      "derivative of pressure wrt temperature";
    ThermoSysPro.Units.DerPressureByDensity pd
      "derivative of pressure wrt density";
  end PhaseBoundaryProperties;

  function gibbsToBoundaryProps
    "calulate phase boundary property record from dimensionless Gibbs function"

    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output PhaseBoundaryProperties sat "phase boundary properties";
  protected
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
  algorithm
    sat.d := g.p/(g.R*g.T*g.pi*g.gpi);
    sat.h := g.R*g.T*g.tau*g.gtau;
    sat.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    sat.s := g.R*(g.tau*g.gtau - g.g);
    sat.cp := -g.R*g.tau*g.tau*g.gtautau;
    sat.cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.
       tau*g.gtaupi)/(g.gpipi));
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
    sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
    sat.pd := -g.R*g.T*g.gpi*g.gpi/(g.gpipi);
  end gibbsToBoundaryProps;

  function helmholtzToBoundaryProps
    "calulate phase boundary property record from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output PhaseBoundaryProperties sat "phase boundary property record";
  protected
    SI.Pressure p "pressure";
  algorithm
    p := f.R*f.d*f.T*f.delta*f.fdelta;
    sat.d := f.d;
    sat.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    sat.s := f.R*(f.tau*f.ftau - f.f);
    sat.u := f.R*f.T*f.tau*f.ftau;
    sat.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.
       fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    sat.cv := f.R*(-f.tau*f.tau*f.ftautau);
    sat.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    sat.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  end helmholtzToBoundaryProps;

  function HelmholtzOfph

  protected
    Modelica.SIunits.SpecificHeatCapacity cv;
  public
    input HelmholtzDerivs f
      "Dérivées adimensionnelles de la fonction de Helmholtz"
      annotation (Placement(transformation(extent={{-85,15},{-15,85}}, rotation=
             0)));
    input HelmholtzData dTR annotation (Placement(transformation(extent={{15,15},
              {85,85}}, rotation=0)));
    output NewtonDerivatives_ph nderivs annotation (Placement(transformation(
            extent={{-85,-85},{-15,-15}}, rotation=0)));
  algorithm
    cv := -dTR.R*(f.tau*f.tau*f.ftautau);
    nderivs.p := dTR.d*dTR.R*dTR.T*f.delta*f.fdelta;
    nderivs.h := dTR.R*dTR.T*(f.tau*f.ftau + f.delta*f.fdelta);
    nderivs.pd := dTR.R*dTR.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    nderivs.pt := dTR.R*dTR.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    nderivs.ht := cv + nderivs.pt/dTR.d;
    nderivs.hd := (nderivs.pd - dTR.T*nderivs.pt/dTR.d)/dTR.d;
    annotation (
      Window(
        x=0.09,
        y=0.21,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end HelmholtzOfph;

  function cv2Phase
    input PhaseBoundaryProperties liq;
    input PhaseBoundaryProperties vap;
    input Real x "Vapor mass fraction";
    input Modelica.SIunits.Temperature T;
    input Modelica.SIunits.AbsolutePressure p;
    output Modelica.SIunits.SpecificHeatCapacity cv;

  protected
    Real dpT;
    Real dxv;
    Real dvT;
    Real dvTl;
    Real dvTv;
    Real duTl;
    Real duTv;
    Real dxt;
  algorithm
    dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
    dpT := (vap.s - liq.s)*dxv;
    // wrong at critical point
    dvTl := (liq.pt - dpT)/liq.pd/liq.d/liq.d;
    dvTv := (vap.pt - dpT)/vap.pd/vap.d/vap.d;
    dxt := -dxv*(dvTl + x*(dvTv - dvTl));
    duTl := liq.cv + (T*liq.pt - p)*dvTl;
    duTv := vap.cv + (T*vap.pt - p)*dvTv;
    cv := duTl + x*(duTv - duTl) + dxt*(vap.u - liq.u);
    annotation (
      Window(
        x=0.08,
        y=0.14,
        width=0.6,
        height=0.61),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end cv2Phase;

  record NewtonDerivatives_ps
    Modelica.SIunits.AbsolutePressure p;
    Modelica.SIunits.SpecificEntropy s;
    Real pd;
    Real pt;
    Real sd;
    Real st;
    annotation (
      Window(
        x=0.15,
        y=0.3,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end NewtonDerivatives_ps;

  function HelmholtzOfps

  protected
    Modelica.SIunits.SpecificHeatCapacity cv;
  public
    input HelmholtzDerivs f
      "Dérivées adimensionnelles de la fonction de Helmholtz"
      annotation (Placement(transformation(extent={{-85,15},{-15,85}}, rotation=
             0)));
    input HelmholtzData dTR annotation (Placement(transformation(extent={{15,15},
              {85,85}}, rotation=0)));
    output NewtonDerivatives_ps nderivs annotation (Placement(transformation(
            extent={{-85,-85},{-15,-15}}, rotation=0)));
  algorithm

    cv := -dTR.R*(f.tau*f.tau*f.ftautau);
    nderivs.p := dTR.d*dTR.R*dTR.T*f.delta*f.fdelta;
    nderivs.s := dTR.R*(f.tau*f.ftau - f.f);
    nderivs.pd := dTR.R*dTR.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    nderivs.pt := dTR.R*dTR.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    nderivs.st := cv/dTR.T;
    nderivs.sd := -nderivs.pt/(dTR.d*dTR.d);
    annotation (
      Window(
        x=0.03,
        y=0.14,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end HelmholtzOfps;

  record PropThermoSat
    Modelica.SIunits.AbsolutePressure P "Pressure";
    Modelica.SIunits.Temperature T "Temperature";
    Modelica.SIunits.Density rho "Density";
    Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
    Modelica.SIunits.SpecificHeatCapacity cp
      "Specific heat capacity at constant pressure";
    Real pt "Derivative of pressure wrt. temperature";
    Modelica.SIunits.SpecificHeatCapacity cv
      "Specific heat capacity at constant volume";
    /*
  Modelica.SIunits.SpecificEnergy u "Specific inner energy";
  Modelica.SIunits.SpecificEntropy s "Specific entropy";
  Real pd "Derivative of pressure wrt. density";
  */
    annotation (
      Window(
        x=0.15,
        y=0.32,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,50},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid),
          Text(extent={{-127,115},{127,55}}, textString=
                                                 "%name"),
          Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Line(points={{0,50},{0,-100}}, color={0,0,0})}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end PropThermoSat;

  function gibbsRho
    input Modelica.SIunits.AbsolutePressure P "Pressure";
    input Modelica.SIunits.Temperature T "Temperature";

    output Modelica.SIunits.Density rho "density";
    input GibbsDerivs g "Dérivées de la fonction de Gibbs"
      annotation (Placement(transformation(extent={{-70,-70},{70,70}}, rotation=
             0)));
  algorithm

    rho := max(P, ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.ptriple)/(ThermoSysPro.Properties.WaterSteam.BaseIF97.data.RH2O
           *max(T, ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.Ttriple)*g.pi*g.gpi);
    annotation (
      Window(
        x=0.2,
        y=0.26,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end gibbsRho;

  function gibbsPropsSat
    input Modelica.SIunits.AbsolutePressure P "Pressure";
    input Modelica.SIunits.Temperature T "Temperature";

    input GibbsDerivs g "Dérivées de la fonction de Gibbs"
      annotation (Placement(transformation(extent={{-85,15},{-15,85}}, rotation=
             0)));
    output PropThermoSat sat annotation (Placement(transformation(extent={{15,
              15},{85,85}}, rotation=0)));
  algorithm

    sat.P := max(P,ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.ptriple);
    sat.T := max(T,ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.Ttriple);
    sat.rho := sat.P/(ThermoSysPro.Properties.WaterSteam.BaseIF97.data.RH2O*sat.T*g.pi*g.gpi);
    sat.h := ThermoSysPro.Properties.WaterSteam.BaseIF97.data.RH2O*sat.T*g.tau*g.gtau;
    /*
  sat.u := sat.T*ThermoSysPro.Properties.WaterSteam.BaseIF97.data.RH2O*(g.tau*g.gtau - g.pi*g.gpi);
  sat.s := ThermoSysPro.Properties.WaterSteam.BaseIF97.data.RH2O*(g.tau*g.gtau - g.g);
  */
    sat.cp := -ThermoSysPro.Properties.WaterSteam.BaseIF97.data.RH2O*g.tau*g.tau*g.gtautau;
    /*
  sat.cv :=ThermoSysPro.Properties.WaterSteam.BaseIF97.data.RH2O
           *(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau*g.gtaupi)/(g.gpipi));
  sat.pt := -sat.P/sat.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
  sat.pd := -ThermoSysPro.Properties.WaterSteam.BaseIF97.data.RH2O*sat.T*g.gpi*g.gpi/(g.gpipi);
  */
    annotation (
      Window(
        x=0.25,
        y=0.27,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end gibbsPropsSat;

  function gibbsToProps_pT
    input GibbsDerivs g "dimensionless derivatives of the Gibbs funciton";
    output ThermoProperties_pT pro;
  protected
    Real vt;
    Real vp;

  algorithm
    pro.d := max(g.p,ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.ptriple)
             /(g.R*g.T*g.pi*g.gpi);
    pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    pro.h := g.R*g.T*g.tau*g.gtau;
    pro.s := g.R*(g.tau*g.gtau - g.g);
    pro.cp := -g.R*g.tau*g.tau*g.gtautau;
    vt := g.R/max(g.p,ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.ptriple)
          *(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(max(g.p,ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.ptriple)
          *max(g.p,ThermoSysPro.Properties.WaterSteam.BaseIF97.triple.ptriple))*g.pi*g.pi*g.gpipi;
    pro.ddpT := -(pro.d*pro.d)*vp;
    pro.ddTp := -(pro.d*pro.d)*vt;
    pro.duTp := pro.cp - g.p*vt;
    pro.dupT := -g.T*vt - g.p*vp;
    annotation (
      Window(
        x=0.06,
        y=0.13,
        width=0.73,
        height=0.76),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end gibbsToProps_pT;

  record ThermoProperties_pT
    Modelica.SIunits.Density d(
      min=InitLimits.DMIN,
      max=InitLimits.DMAX,
      nominal=InitLimits.DNOM) "Density";
    Modelica.SIunits.SpecificEnthalpy h(
      min=InitLimits.SHMIN,
      max=InitLimits.SHMAX,
      nominal=InitLimits.SHNOM) "Specific enthalpy";
    Modelica.SIunits.SpecificEnergy u(
      min=InitLimits.SEMIN,
      max=InitLimits.SEMAX,
      nominal=InitLimits.SENOM) "Specific inner energy";
    Modelica.SIunits.SpecificEntropy s(
      min=InitLimits.SSMIN,
      max=InitLimits.SSMAX,
      nominal=InitLimits.SSNOM) "Specific entropy";
    Modelica.SIunits.SpecificHeatCapacity cp(
      min=InitLimits.CPMIN,
      max=InitLimits.CPMAX,
      nominal=InitLimits.CPNOM) "Specific heat capacity at constant presure";
    Modelica.SIunits.DerDensityByTemperature ddTp
      "Derivative of the density wrt. temperature at constant pressure";
    Modelica.SIunits.DerDensityByPressure ddpT
      "Derivative of the density wrt. presure at constant temperature";
    Modelica.SIunits.DerEnergyByPressure dupT
      "Derivative of the inner energy wrt. pressure at constant temperature";
    Modelica.SIunits.SpecificHeatCapacity duTp
      "Derivative of the inner energy wrt. temperature at constant pressure";
    ThermoSysPro.Units.MassFraction x "Vapor mass fraction";
    annotation (
      Window(
        x=0.23,
        y=0.19,
        width=0.68,
        height=0.71),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,50},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid),
          Text(extent={{-127,115},{127,55}}, textString=
                                                 "%name"),
          Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Line(points={{0,50},{0,-100}}, color={0,0,0})}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end ThermoProperties_pT;

  function gibbsToProps_ps
    input GibbsDerivs g "dimensionless derivatives of the Gibbs function";
    output ThermoProperties_ps pro;
  protected
    Real vt;
    Real vp;
  algorithm

    pro.T := g.T;
    pro.d := g.p/(g.R*pro.T*g.pi*g.gpi);
    pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    pro.h := g.R*g.T*g.tau*g.gtau;
    pro.cp := -g.R*g.tau*g.tau*g.gtautau;
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    pro.ddsp := -pro.d*pro.d*vt*g.T/(pro.cp);
    pro.ddps := -pro.d*pro.d*(vp + g.T*vt*vt/pro.cp);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Window(
        x=0.13,
        y=0.26,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end gibbsToProps_ps;

  record ThermoProperties_ps
    Modelica.SIunits.Temperature T(
      min=InitLimits.TMIN,
      max=InitLimits.TMAX,
      nominal=InitLimits.TNOM) "Temperature";
    Modelica.SIunits.Density d(
      min=InitLimits.DMIN,
      max=InitLimits.DMAX,
      nominal=InitLimits.DNOM) "Density";
    Modelica.SIunits.SpecificEnergy u(
      min=InitLimits.SEMIN,
      max=InitLimits.SEMAX,
      nominal=InitLimits.SENOM) "Specific inner energy";
    Modelica.SIunits.SpecificEnthalpy h(
      min=InitLimits.SHMIN,
      max=InitLimits.SHMAX,
      nominal=InitLimits.SHNOM) "Specific enthalpy";
    Modelica.SIunits.SpecificHeatCapacity cp(
      min=InitLimits.CPMIN,
      max=InitLimits.CPMAX,
      nominal=InitLimits.CPNOM) "Specific heat capacity at constant pressure";
    ThermoSysPro.Units.DerDensityByEntropy ddsp
      "Derivative of the density wrt. specific entropy at constant pressure";
    Modelica.SIunits.DerDensityByPressure ddps
      "Derivative of the density wrt. pressure at constant specific entropy";
    ThermoSysPro.Units.MassFraction x "Vapor mass fraction";
    annotation (
      Window(
        x=0.31,
        y=0.2,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,50},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid),
          Text(extent={{-127,115},{127,55}}, textString=
                                                 "%name"),
          Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Line(points={{0,50},{0,-100}}, color={0,0,0})}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.5</b></p>
</HTML>
"));
  end ThermoProperties_ps;

  function helmholtzToProps_ps
    input HelmholtzDerivs f
      "dimensionless derivatives of the Helmholtz function";
    output ThermoProperties_ps pro;
  protected
    Real pd;
    Real pt;
  protected
    Real cv "Heat capacity at constant volume";
  algorithm

    pro.d := f.d;
    pro.T := f.T;
    pro.u := f.R*f.T*f.tau*f.ftau;
    pro.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);

    // calculating cp near the critical point may be troublesome (cp -> inf).
    pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
      *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    cv := f.R*(-f.tau*f.tau*f.ftautau);
    pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    pro.ddps := f.d*f.d*cv/(pd*f.d*f.d*cv + pt*pt*f.T);
    pro.ddsp := -f.d*f.d*pt*f.T/(f.d*f.d*pd*cv + f.T*pt*pt);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Window(
        x=0.13,
        y=0.25,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end helmholtzToProps_ps;

  function gibbsToProps_dT
    input GibbsDerivs g;
    output ThermoProperties_dT pro;
  protected
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
  algorithm
    pro.p := g.p;
    pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    pro.h := g.R*g.T*g.tau*g.gtau;
    pro.s := g.R*(g.tau*g.gtau - g.g);
    pro.cp := -g.R*g.tau*g.tau*g.gtautau;
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    pro.dudT := pro.cp + g.T*vt*vt/vp;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Window(
        x=0.08,
        y=0.23,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end gibbsToProps_dT;

  record ThermoProperties_dT
    Modelica.SIunits.AbsolutePressure p(
      min=InitLimits.PMIN,
      max=InitLimits.PMAX,
      nominal=InitLimits.PNOM) "Pressure";
    Modelica.SIunits.SpecificEnthalpy h(
      min=InitLimits.SHMIN,
      max=InitLimits.SHMAX,
      nominal=InitLimits.SHNOM) "Specific enthalpy";
    Modelica.SIunits.SpecificEnergy u(
      min=InitLimits.SEMIN,
      max=InitLimits.SEMAX,
      nominal=InitLimits.SENOM) "Specific inner energy";
    Modelica.SIunits.SpecificEntropy s(
      min=InitLimits.SSMIN,
      max=InitLimits.SSMAX,
      nominal=InitLimits.SSNOM) "Specific entropy";
    Modelica.SIunits.SpecificHeatCapacity cp(
      min=InitLimits.CPMIN,
      max=InitLimits.CPMAX,
      nominal=InitLimits.CPNOM) "Specific heat capacity at constant pressure";
    Real dudT
      "Derivative of the inner energy wrt. density at constant temperature";
    ThermoSysPro.Units.MassFraction x "Vapor mas fraction";
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,50},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Line(points={{0,50},{0,-100}}, color={0,0,0}),
          Text(extent={{-127,115},{127,55}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end ThermoProperties_dT;

  function helmholtzToProps_dT
    input HelmholtzDerivs f;
    output ThermoProperties_dT pro;
  protected
    Real pt "derivative of presure w.r.t. temperature";
    Real pv "derivative of pressure w.r.t. specific volume";

  algorithm
    pro.p := f.R*f.d*f.T*f.delta*f.fdelta;
    pro.s := f.R*(f.tau*f.ftau - f.f);
    pro.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    pro.u := f.R*f.T*f.tau*f.ftau;
    pv := -1/(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.
      fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    // calculating cp near the critical point may be troublesome (cp -> inf).
    pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
      *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    pro.dudT := (pro.p - f.T*pt)/(f.d*f.d);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Window(
        x=0.09,
        y=0.22,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end helmholtzToProps_dT;

  record NewtonDerivatives_pT
    Modelica.SIunits.AbsolutePressure p "Pressure";
    ThermoSysPro.Units.DerPressureByDensity pd
      "derivative of pressure wrt. density";
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-100,50},{100,-100}},
            lineColor={0,0,255},
            fillColor={255,255,127},
            fillPattern=FillPattern.Solid),
          Line(points={{-100,-50},{100,-50}}, color={0,0,0}),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Line(points={{0,50},{0,-100}}, color={0,0,0}),
          Text(extent={{-127,115},{127,55}}, textString=
                                                 "%name")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end NewtonDerivatives_pT;

  function HelmholtzOfpT

    input HelmholtzDerivs f;
    output NewtonDerivatives_pT nderivs annotation (Placement(transformation(
            extent={{-85,-85},{-15,-15}}, rotation=0)));
  algorithm

    nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
    nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Window(
        x=0.11,
        y=0.25,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end HelmholtzOfpT;

  function helmholtzToProps_pT
    input HelmholtzDerivs f;
    output ThermoProperties_pT pro;
  protected
    Real pd "derivative of pressure wrt. density";
    Real pt "derivative of pressure wrt. temperature";
    Real pv "derivative of pressure wrt. specific volume";
  protected
   Real cv "Heat capacity at constant volume";
  algorithm

    pro.d := f.d;
    pro.s := f.R*(f.tau*f.ftau - f.f);
    pro.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    pro.u := f.R*f.T*f.tau*f.ftau;
    pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    cv := f.R*(-f.tau*f.tau*f.ftautau);
    pv := -1/(f.d*f.d)*pd;
    // calculating cp near the critical point may be troublesome (cp -> inf).
    pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
      *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    pro.ddTp := -pt/pd;
    pro.ddpT := 1/pd;
    pro.dupT := (f.d - f.T*pt)/(f.d*f.d*pd);
    pro.duTp := (-cv*f.d*f.d*pd + pt*f.d - f.T*pt*pt)/(f.d*f.d*
      pd);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction"),
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name")}),
      Window(
        x=0.32,
        y=0.14,
        width=0.6,
        height=0.6),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end helmholtzToProps_pT;

  record miniProp "Test record for derivatives"
    Modelica.SIunits.Temperature T "Temperature";
    Modelica.SIunits.Density d "Density";
  end miniProp;

  record IF97PhaseBoundaryProperties
    "thermodynamic base properties on the phase boundary for IF97 steam tables"
    extends Modelica.Icons.Record;
    Modelica.SIunits.SpecificHeatCapacity R "specific heat capacity";
    Modelica.SIunits.Temperature T "temperature";
    Modelica.SIunits.Density d "density";
    Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
    Modelica.SIunits.SpecificEntropy s "specific entropy";
    Modelica.SIunits.SpecificHeatCapacity cp
      "heat capacity at constant pressure";
    Modelica.SIunits.SpecificHeatCapacity cv "heat capacity at constant volume";
    ThermoSysPro.Units.DerPressureByTemperature dpT
      "dp/dT derivative of saturation curve";
    ThermoSysPro.Units.DerPressureByTemperature pt
      "derivative of pressure wrt temperature";
    ThermoSysPro.Units.DerPressureByDensity pd
      "derivative of pressure wrt density";
    Real vt(unit="m3/(kg.K)")
      "derivative of specific volume w.r.t. temperature";
    Real vp(unit="m3/(kg.Pa)") "derivative of specific volume w.r.t. pressure";
  end IF97PhaseBoundaryProperties;

  function water_ph_r4
    input Modelica.SIunits.AbsolutePressure p;
    input Modelica.SIunits.SpecificEnthalpy h;

  protected
    Real x;
    Real dpT;
  public
    output ThermoProperties_ph pro;
  protected
    PhaseBoundaryProperties liq;
    PhaseBoundaryProperties vap;
    GibbsDerivs gl;
    GibbsDerivs gv;
    HelmholtzDerivs fl;
    HelmholtzDerivs fv;
    Modelica.SIunits.Density dl;
    Modelica.SIunits.Density dv;
    Real cv "Heat capacity at constant volume";
  algorithm
    pro.T := BaseIF97.Basic.tsat(p);
    dpT := BaseIF97.Basic.dptofT(pro.T);
    dl := BaseIF97.Regions.rhol_p_R4b(p);
    dv := BaseIF97.Regions.rhov_p_R4b(p);
    if p < BaseIF97.data.PLIMIT4A then
      gl := BaseIF97.Basic.g1(p, pro.T);
      gv := BaseIF97.Basic.g2(p, pro.T);
      liq := gibbsToBoundaryProps(gl);
      vap := gibbsToBoundaryProps(gv);
    else
      fl := BaseIF97.Basic.f3(dl, pro.T);
      fv := BaseIF97.Basic.f3(dv, pro.T);
      liq := helmholtzToBoundaryProps(fl);
      vap := helmholtzToBoundaryProps(fv);
    end if;
    x := if (vap.h <> liq.h) then (h - liq.h)/(vap.h - liq.h) else 1.0;
    cv := cv2Phase(
        liq=liq,
        vap=vap,
        x=x,
        p=p,
        T=pro.T);
    pro.d := liq.d*vap.d/(vap.d + x*(liq.d - vap.d));
    pro.x := x;
    pro.u := x*vap.u + (1 - x)*liq.u;
    pro.s := x*vap.s + (1 - x)*liq.s;
    pro.cp := x*vap.cp + (1 - x)*liq.cp;
    pro.ddph := pro.d*(pro.d*cv/dpT + 1.0)/(dpT*pro.T);
    pro.ddhp := -pro.d*pro.d/(dpT*pro.T);
    annotation (
      Icon(graphics={
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name"),
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.2</b></p>
</HTML>
"));
  end water_ph_r4;

  function water_ps_r4
    input Modelica.SIunits.AbsolutePressure p "pressure";
    input Modelica.SIunits.SpecificEntropy s "specific entropy";

  protected
    Real x;
    Real dpT;
  public
    output ThermoProperties_ps pro;
  protected
    PhaseBoundaryProperties liq;
    PhaseBoundaryProperties vap;
    GibbsDerivs gl
      "dimensionless Gibbs function and derivatives wrt dimensionless presure and temperature";
    GibbsDerivs gv
      "dimensionless Gibbs function and derivatives wrt dimensionless presure and temperature";
    HelmholtzDerivs fl
      "dimensionless Helmholtz function and derivatives wrt dimensionless presure and temperature";
    HelmholtzDerivs fv
      "dimensionless Helmholtz function and derivatives wrt dimensionless presure and temperature";
    Real cv "Heat capacity at constant volume";
    Modelica.SIunits.Density dl;
    Modelica.SIunits.Density dv;
  algorithm

    pro.T := BaseIF97.Basic.tsat(p);
    dpT := BaseIF97.Basic.dptofT(pro.T);

    dl := BaseIF97.Regions.rhol_p_R4b(p);
    dv := BaseIF97.Regions.rhov_p_R4b(p);
    if p < BaseIF97.data.PLIMIT4A then
      gl := BaseIF97.Basic.g1(p, pro.T);
      gv := BaseIF97.Basic.g2(p, pro.T);
      liq := gibbsToBoundaryProps(gl);
      vap := gibbsToBoundaryProps(gv);
    else
      fl := BaseIF97.Basic.f3(dl, pro.T);
      fv := BaseIF97.Basic.f3(dv, pro.T);
      liq := helmholtzToBoundaryProps(fl);
      vap := helmholtzToBoundaryProps(fv);
    end if;
    x := if (vap.s <> liq.s) then (s - liq.s)/(vap.s - liq.s) else 1.0;
    pro.x := x;
    pro.d := liq.d*vap.d/(vap.d + x*(liq.d - vap.d));
    pro.u := x*vap.u + (1 - x)*liq.u;
    pro.h := x*vap.h + (1 - x)*liq.h;
    pro.cp := Modelica.Constants.inf;
    cv := cv2Phase(
        liq,
        vap,
        x,
        pro.T,
        p);
    pro.ddps := cv*pro.d*pro.d/(dpT*dpT*pro.T);
    pro.ddsp := -pro.d*pro.d/dpT;
    annotation (
      Icon(graphics={
          Text(extent={{-134,104},{142,44}}, textString=
                                                 "%name"),
          Ellipse(
            extent={{-100,40},{100,-100}},
            lineColor={255,127,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-84,-4},{84,-52}},
            lineColor={255,127,0},
            textString=
                 "fonction")}),
      Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
  end water_ps_r4;

  record IF97TwoPhaseAnalytic
    "Intermediate property data record for IF97, analytic Jacobian version"
    extends Modelica.Icons.Record;
    Integer phase "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    Integer region(min=1, max=5) "IF 97 region";
    SI.Pressure p "pressure";
    SI.Temperature T "temperature";
    SI.SpecificEnthalpy h "specific enthalpy";
    SI.SpecificHeatCapacity R "gas constant";
    SI.SpecificHeatCapacity cp "specific heat capacity";
    Real cpt "derivative of cp w.r.t. temperature";
    SI.SpecificHeatCapacity cv "specific heat capacity";
    Real cvt "derivative of cv w.r.t. temperature";
    SI.Density rho "density";
    SI.SpecificEntropy s "specific entropy";
    ThermoSysPro.Units.DerPressureByTemperature pt
      "derivative of pressure wrt temperature";
    ThermoSysPro.Units.DerPressureByDensity pd
      "derivative of pressure wrt density";
    Real ptt "2nd derivative of pressure wrt temperature";
    Real pdd "2nd derivative of pressure wrt density";
    Real ptd "mixed derivative of pressure w.r.t. density and temperature";
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
    Real vtt "2nd derivative of specific volume w.r.t. temperature";
    Real vpp "2nd derivative of specific volume w.r.t. pressure";
    Real vtp
      "mixed derivative of specific volume w.r.t. pressure and temperature";
    Real x "dryness fraction";
    Real dpT "dp/dT derivative of saturation curve";
  end IF97TwoPhaseAnalytic;

  record IF97BaseTwoPhase "Intermediate property data record for IF 97"
    extends Modelica.Icons.Record;
    Integer phase "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    Integer region(min=1, max=5) "IF 97 region";
    SI.Pressure p "pressure";
    SI.Temperature T "temperature";
    SI.SpecificEnthalpy h "specific enthalpy";
    SI.SpecificHeatCapacity R "gas constant";
    SI.SpecificHeatCapacity cp "specific heat capacity";
    SI.SpecificHeatCapacity cv "specific heat capacity";
    SI.Density rho "density";
    SI.SpecificEntropy s "specific entropy";
    ThermoSysPro.Units.DerPressureByTemperature pt
      "derivative of pressure wrt temperature";
    ThermoSysPro.Units.DerPressureByDensity pd
      "derivative of pressure wrt density";
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
    Real x "dryness fraction";
    Real dpT "dp/dT derivative of saturation curve";
  end IF97BaseTwoPhase;

  record GibbsDerivs3rd
    "derivatives of dimensionless Gibbs-function w.r.t dimensionless pressure and temperature, including 3rd derivatives"
    extends Modelica.Icons.Record;
    Modelica.SIunits.Pressure p "pressure";
    Modelica.SIunits.Temperature T "temperature";
    Modelica.SIunits.SpecificHeatCapacity R "specific heat capacity";
    Real pi(unit="1") "dimensionless pressure";
    Real tau(unit="1") "dimensionless temperature";
    Real g(unit="1") "dimensionless Gibbs-function";
    Real gpi(unit="1") "derivative of g w.r.t. pi";
    Real gpipi(unit="1") "2nd derivative of g w.r.t. pi";
    Real gpipipi(unit="1") "3rd derivative of g w.r.t. pi";
    Real gtau(unit="1") "derivative of g w.r.t. tau";
    Real gtautau(unit="1") "2nd derivative of g w.r.t tau";
    Real gtautautau(unit="1") "3rd derivative of g w.r.t tau";
    Real gpitau(unit="1") "mixed derivative of g w.r.t. pi and tau";
    Real gpitautau(unit="1") "mixed derivative of g w.r.t. pi and tau (2nd)";
    Real gpipitau(unit="1") "mixed derivative of g w.r.t. pi (2nd) and tau";
  end GibbsDerivs3rd;

  function gibbsToBoundaryProps3rd
    "calulate phase boundary property record from dimensionless Gibbs function"
    extends Modelica.Icons.Function;
    input ThermoSysPro.Properties.WaterSteam.Common.GibbsDerivs3rd g
      "dimensionless derivatives of Gibbs function";
    output ThermoSysPro.Properties.WaterSteam.Common.PhaseBoundaryProperties3rd
      sat "phase boundary properties";
  protected
    Real v "specific volume";
    Real vp3 "Third power of vp";
    Real ivp3 "Inverse of third power of vp";
  algorithm
    sat.d := g.p/(g.R*g.T*g.pi*g.gpi);
    sat.h := g.R*g.T*g.tau*g.gtau;
    sat.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    sat.s := g.R*(g.tau*g.gtau - g.g);
    sat.cp := -g.R*g.tau*g.tau*g.gtautau;
    sat.cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gpitau)*(g.gpi - g.
       tau*g.gpitau)/(g.gpipi));
    sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gpitau)/(g.gpipi*g.pi);
    sat.pd := -g.R*g.T*g.gpi*g.gpi/(g.gpipi);
    v := 1/sat.d;
    sat.vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gpitau);
    sat.vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    sat.vtt := g.R*g.pi/g.p*g.tau/g.T*g.tau*g.gpitautau;
    sat.vtp := g.R*g.pi*g.pi/(g.p*g.p)*(g.gpipi - g.tau*g.gpipitau);
    sat.vpp := g.R*g.T*g.pi*g.pi*g.pi/(g.p*g.p*g.p)*g.gpipipi;
    sat.cpt := g.R*g.tau*g.tau/g.T*(2*g.gtautau + g.tau*g.gtautautau);
    vp3 := sat.vp*sat.vp*sat.vp;
    ivp3 := 1/vp3;
    sat.ptt := -(sat.vtt*sat.vp*sat.vp -2.0*sat.vt*sat.vtp*sat.vp + sat.vt*sat.vt*sat.vpp)*ivp3;
    sat.pdd := -sat.vpp*ivp3*v*v*v*v - 2*v*sat.pd "= pvv/d^4";
    sat.ptd := (sat.vtp*sat.vp-sat.vt*sat.vpp)*ivp3/(sat.d*sat.d) "= -ptv/d^2";
    sat.cvt := (vp3*sat.cpt + sat.vp*sat.vp*sat.vt*sat.vt + 3.0*sat.vp*sat.vp*g.T*sat.vt*sat.vtt - 3.0*sat.vtp*sat.vp*g.T*sat.vt*sat.vt + g.T*sat.vt*sat.vt*sat.vt*sat.vpp)*ivp3;
  end gibbsToBoundaryProps3rd;

  record HelmholtzDerivs3rd
    "derivatives of dimensionless Helmholtz-function w.r.t dimensionless pressuredensity and temperature, including 3rd derivatives"
    extends Modelica.Icons.Record;
    Modelica.SIunits.Density d "density";
    Modelica.SIunits.Temperature T "temperature";
    Modelica.SIunits.SpecificHeatCapacity R "specific heat capacity";
    Real delta(unit="1") "dimensionless density";
    Real tau(unit="1") "dimensionless temperature";
    Real f(unit="1") "dimensionless Helmholtz-function";
    Real fdelta(unit="1") "derivative of f w.r.t. delta";
    Real fdeltadelta(unit="1") "2nd derivative of f w.r.t. delta";
    Real fdeltadeltadelta(unit="1") "3rd derivative of f w.r.t. delta";
    Real ftau(unit="1") "derivative of f w.r.t. tau";
    Real ftautau(unit="1") "2nd derivative of f w.r.t. tau";
    Real ftautautau(unit="1") "3rd derivative of f w.r.t. tau";
    Real fdeltatau(unit="1") "mixed derivative of f w.r.t. delta and tau";
    Real fdeltadeltatau(unit="1")
      "mixed derivative of f w.r.t. delta (2nd) and tau";
    Real fdeltatautau(unit="1")
      "mixed derivative of f w.r.t. delta and tau (2nd) ";
  end HelmholtzDerivs3rd;

  function helmholtzToBoundaryProps3rd
    "calulate phase boundary property record from dimensionless Helmholtz function"

    extends Modelica.Icons.Function;
    input ThermoSysPro.Properties.WaterSteam.Common.HelmholtzDerivs3rd f
      "dimensionless derivatives of Helmholtz function";
    output ThermoSysPro.Properties.WaterSteam.Common.PhaseBoundaryProperties3rd
      sat "phase boundary property record";
  protected
    Modelica.SIunits.Pressure p "pressure";
  algorithm
    p := f.R*f.d*f.T*f.delta*f.fdelta;
    sat.d := f.d;
    sat.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    sat.s := f.R*(f.tau*f.ftau - f.f);
    sat.u := f.R*f.T*f.tau*f.ftau;
    sat.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.
       fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    sat.cv := f.R*(-f.tau*f.tau*f.ftautau);
    sat.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    sat.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    sat.pdd := f.R*f.T*f.delta/f.d*(2.0*f.fdelta + 4.0*f.delta*f.fdeltadelta +
             f.delta*f.delta*f.fdeltadeltadelta);
    sat.ptt := f.R*f.d*f.delta*f.tau*f.tau/f.T*f.fdeltatautau;
    sat.ptd := f.R*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta - 2.0*f.tau*f.fdeltatau
               -f.delta*f.tau*f.fdeltadeltatau);
    sat.cvt := f.R*f.tau*f.tau/f.T*(2.0*f.ftautau + f.tau*f.ftautautau);

    annotation (Icon(graphics));
  end helmholtzToBoundaryProps3rd;

  record IF97PhaseBoundaryProperties3rd
    "Thermodynamic base properties on the phase boundary, Analytic Jacobian verModelica.SIunitson"
    extends Modelica.Icons.Record;
    Modelica.SIunits.SpecificHeatCapacity R "specific heat capacity";
    Modelica.SIunits.Temperature T "temperature";
    Modelica.SIunits.Density d "denModelica.SIunitsty";
    Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
    Modelica.SIunits.SpecificEntropy s "specific entropy";
    Modelica.SIunits.SpecificHeatCapacity cp
      "heat capacity at constant pressure";
    Modelica.SIunits.SpecificHeatCapacity cv "heat capacity at constant volume";
    ThermoSysPro.Units.DerPressureByTemperature dpT
      "dp/dT derivative of saturation curve";
    Real dpTT(unit = "Pa/(K.K)") "Second derivative of saturation curve";
    ThermoSysPro.Units.DerPressureByTemperature pt
      "derivative of pressure wrt temperature";
    ThermoSysPro.Units.DerPressureByDensity pd
      "derivative of pressure wrt denModelica.SIunitsty";
    Real vt(unit="m3/(kg.K)")
      "derivative of specific volume w.r.t. temperature";
    Real vp(unit="m3/(kg.Pa)") "derivative of specific volume w.r.t. pressure";
    Real cvt "Derivative of cv w.r.t. temperature";
    Real cpt "Derivative of cp w.r.t. temperature";
    Real ptt "2nd derivative of pressure wrt temperature";
    Real pdd "2nd derivative of pressure wrt denModelica.SIunitsty";
    Real ptd
      "Mixed derivative of pressure w.r.t. denModelica.SIunitsty and temperature";
    Real vtt "2nd derivative of specific volume w.r.t. temperature";
    Real vpp "2nd derivative of specific volume w.r.t. pressure";
    Real vtp
      "Mixed derivative of specific volume w.r.t. pressure and temperature";
  end IF97PhaseBoundaryProperties3rd;

  record PhaseBoundaryProperties3rd
    "thermodynamic base properties on the phase boundary"
    extends Modelica.Icons.Record;
    Modelica.SIunits.Temperature T "Temperature";
    ThermoSysPro.Units.DerPressureByTemperature dpT
      "dp/dT derivative of saturation curve";
    Modelica.SIunits.Density d "Density";
    Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
    Modelica.SIunits.SpecificEnergy u "Inner energy";
    Modelica.SIunits.SpecificEntropy s "Specific entropy";
    Modelica.SIunits.SpecificHeatCapacity cp
      "Heat capacity at constant pressure";
    Modelica.SIunits.SpecificHeatCapacity cv "Heat capacity at constant volume";
    ThermoSysPro.Units.DerPressureByTemperature pt
      "Derivative of pressure wrt temperature";
    ThermoSysPro.Units.DerPressureByDensity pd
      "Derivative of pressure wrt density";
    Real cvt "Derivative of cv w.r.t. temperature";
    Real cpt "Derivative of cp w.r.t. temperature";
    Real ptt "2nd derivative of pressure wrt temperature";
    Real pdd "2nd derivative of pressure wrt density";
    Real ptd "Mixed derivative of pressure w.r.t. density and temperature";
    Real vt "Derivative of specific volume w.r.t. temperature";
    Real vp "Derivative of specific volume w.r.t. pressure";
    Real vtt "2nd derivative of specific volume w.r.t. temperature";
    Real vpp "2nd derivative of specific volume w.r.t. pressure";
    Real vtp
      "Mixed derivative of specific volume w.r.t. pressure and temperature";
  end PhaseBoundaryProperties3rd;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.1), graphics={
        Text(
          extent={{-102,0},{24,-26}},
          lineColor={242,148,0},
          textString=
               "Thermo"),
        Text(
          extent={{-4,8},{68,-34}},
          lineColor={46,170,220},
          textString=
               "SysPro"),
        Polygon(
          points={{-62,2},{-58,4},{-48,8},{-32,12},{-16,14},{6,14},{26,12},{42,
              8},{52,2},{42,6},{28,10},{6,12},{-12,12},{-16,12},{-34,10},{-50,6},
              {-62,2}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-44,38},{-24,38},{-26,30},{-26,22},{-24,14},{-24,12},{-46,8},
              {-42,22},{-42,30},{-44,38}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-26,20},{-20,20},{-20,22},{-14,22},{-14,20},{-12,20},{-12,12},
              {-26,12},{-28,12},{-26,20}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-8,14},{-8,24},{-6,24},{-6,14},{-8,14}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,30},{-6,26}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,36},{-6,32}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,42},{-6,38}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,48},{-6,44}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4,14},{-4,26},{-2,26},{-2,14},{-4,14}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,32},{-2,28}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,38},{-2,34}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,44},{-2,40}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,50},{-2,46}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,20},{8,20},{8,22},{10,22},{18,22},{18,12},{-4,14},{-2,20}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-62,2},{-58,4},{-48,8},{-36,10},{-18,12},{6,12},{26,10},{42,
              6},{52,0},{42,4},{28,8},{6,10},{-12,10},{-18,10},{-38,8},{-50,6},
              {-62,2}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{22,12},{22,14},{22,16},{24,14},{20,18}},
          color={46,170,220},
          thickness=0.5),
        Line(
          points={{26,12},{26,14},{26,16},{28,14},{24,18}},
          color={46,170,220},
          thickness=0.5),
        Line(
          points={{30,10},{30,12},{30,14},{32,12},{28,16}},
          color={46,170,220},
          thickness=0.5),
        Polygon(
          points={{36,8},{36,30},{34,34},{36,38},{40,38},{40,8},{36,8}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-100,80},{80,-100}}, lineColor={0,0,255}),
        Line(
          points={{-100,80},{-80,100},{100,100},{100,-80},{80,-100}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{80,80},{100,100}},
          color={0,0,255},
          smooth=Smooth.None)}),
    Window(
      x=0.45,
      y=0.01,
      width=0.35,
      height=0.49,
      library=1,
      autolayout=1),
    Documentation(info="<html>
<p><b>Adapted from the ThermoFlow library (H. Tummescheit)</b></p>
</HTML>
<html>
<p><b>Version 1.0</b></p>
</HTML>
"));

end Common;
