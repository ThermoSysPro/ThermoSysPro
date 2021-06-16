within ThermoSysPro.Properties.WaterSteam;
package Region
  function boilingcurveL3_p "properties on the boiling curve"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p "pressure";
    output
      ThermoSysPro.Properties.WaterSteam.Common.IF97PhaseBoundaryProperties3rd
      bpro "property record";
  protected
    ThermoSysPro.Properties.WaterSteam.Common.GibbsDerivs3rd g
      "dimensionless Gibbs funcion and dervatives";
    ThermoSysPro.Properties.WaterSteam.Common.HelmholtzDerivs3rd f
      "dimensionless Helmholtz function and dervatives";
    Modelica.SIunits.Pressure plim=min(p,ThermoSysPro.Properties.WaterSteam.BaseIF97.data.PCRIT
                                                     - 1e-7)
      "pressure limited to critical pressure - epsilon";
    Modelica.SIunits.SpecificVolume v "Specific Volume";
    Real vp3 "vp^3";
    Real ivp3 "1/vp^3";
    Real pv "partial derivative of p w.r.t v";
    Real pv2 "pv^2";
    Real pv3 "pv^3";
    Real ptv "2nd partial derivative of p w.r.t t and v";
    Real pvv "2nd partial derivative of p w.r.t v and v";
  algorithm
    g.R := ThermoSysPro.Properties.WaterSteam.BaseIF97.data.RH2O;
    bpro.T := ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.tsat(plim);
    (bpro.dpT,bpro.dpTT) :=
      ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.d2ptofT(bpro.T);
    // need derivative of dpT
  //  g.Region3boundary := bpro.T > data.TLIMIT1;
    if not bpro.T > ThermoSysPro.Properties.WaterSteam.BaseIF97.data.TLIMIT1 then
      g := ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.g1L3(
                      p, bpro.T);
      bpro.d := p/(g.R*bpro.T*g.pi*g.gpi);
      bpro.h := if p > plim then ThermoSysPro.Properties.WaterSteam.BaseIF97.data.HCRIT
         else g.R*bpro.T*g.tau*g.gtau;
      bpro.s := g.R*(g.tau*g.gtau - g.g);
      bpro.cp := -g.R*g.tau*g.tau*g.gtautau;
      bpro.vt := g.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gpitau);
      bpro.vp := g.R*bpro.T/(p*p)*g.pi*g.pi*g.gpipi;
      bpro.pt := -p/bpro.T*(g.gpi - g.tau*g.gpitau)/(g.gpipi*g.pi);
      bpro.pd := -g.R*bpro.T*g.gpi*g.gpi/(g.gpipi);
      bpro.vtt := g.R*g.pi/p*g.tau/bpro.T*g.tau*g.gpitautau;
      bpro.vtp := g.R*g.pi*g.pi/(p*p)*(g.gpipi - g.tau*g.gpipitau);
      bpro.vpp := g.R*bpro.T*g.pi*g.pi*g.pi/(p*p*p)*g.gpipipi;
      bpro.cpt := g.R*g.tau*g.tau/bpro.T*(2*g.gtautau + g.tau*g.gtautautau);
      v := 1/bpro.d;
      vp3 := bpro.vp*bpro.vp*bpro.vp;
      ivp3 := 1/vp3;
      bpro.ptt := -(bpro.vtt*bpro.vp*bpro.vp -2.0*bpro.vt*bpro.vtp*bpro.vp +bpro.vt*bpro.vt*bpro.vpp)*ivp3;
      bpro.pdd := -bpro.vpp*ivp3*v*v*v*v - 2*v*bpro.pd "= pvv/d^4";
      bpro.ptd := (bpro.vtp*bpro.vp-bpro.vt*bpro.vpp)*ivp3*v*v "= -ptv/d^2";
      bpro.cvt := (vp3*bpro.cpt + bpro.vp*bpro.vp*bpro.vt*bpro.vt + 3.0*bpro.vp*bpro.vp*bpro.T*bpro.vt*bpro.vtt
        - 3.0*bpro.vtp*bpro.vp*bpro.T*bpro.vt*bpro.vt + bpro.T*bpro.vt*bpro.vt*bpro.vt*bpro.vpp)*ivp3;
    else
      bpro.d :=
        ThermoSysPro.Properties.WaterSteam.BaseIF97.Regions.rhol_p_R4b(plim);
      f := ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.f3L3(
                      bpro.d, bpro.T);
      bpro.h := ThermoSysPro.Properties.WaterSteam.BaseIF97.Regions.hl_p_R4b(
        plim);
      // g.R*bpro.T*(f.tau*f.ftau + f.delta*f.fdelta);
      bpro.s := f.R*(f.tau*f.ftau - f.f);
      bpro.cv := g.R*(-f.tau*f.tau*f.ftautau);
      bpro.pt := g.R*bpro.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      bpro.pd := g.R*bpro.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pv := (-f.d*f.d*bpro.pd);
      bpro.vp := 1/pv;
      bpro.vt := -bpro.pt/pv;
      bpro.pdd := f.R*bpro.T*f.delta/bpro.d*(2.0*f.fdelta + 4.0*f.delta*f.fdeltadelta +
           f.delta*f.delta*f.fdeltadeltadelta);
      bpro.ptt := f.R*bpro.d*f.delta*f.tau*f.tau/bpro.T*f.fdeltatautau;
      bpro.ptd := f.R*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta - 2.0*f.tau*f.fdeltatau
       -f.delta*f.tau*f.fdeltadeltatau);
      bpro.cvt := f.R*f.tau*f.tau/bpro.T*(2.0*f.ftautau + f.tau*f.ftautautau);
      bpro.cpt := (bpro.cvt*bpro.pd + bpro.cv*bpro.ptd + (bpro.pt + 2.0*bpro.T*bpro.ptt)*bpro.pt/(bpro.d*bpro.d)
       - bpro.cp*bpro.ptd)/bpro.pd;
      pv2 := pv*pv;
      pv3 := pv2*pv;
      pvv := bpro.pdd*f.d*f.d*f.d*f.d;
      ptv := (-f.d*f.d*bpro.ptd);
      bpro.vpp := -pvv/pv3;
      bpro.vtt := -(bpro.ptt*pv2 -2.0*bpro.pt*ptv*pv + bpro.pt*bpro.pt*pvv)/pv3;
      bpro.vtp := (-ptv*pv + bpro.pt*pvv)/pv3;
    end if;
  end boilingcurveL3_p;

  function dewcurveL3_p "properties on the dew curve"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p "pressure";
    output
      ThermoSysPro.Properties.WaterSteam.Common.IF97PhaseBoundaryProperties3rd
      bpro "property record";
  protected
    ThermoSysPro.Properties.WaterSteam.Common.GibbsDerivs3rd g
      "dimensionless Gibbs funcion and dervatives";
    ThermoSysPro.Properties.WaterSteam.Common.HelmholtzDerivs3rd f
      "dimensionless Helmholtz function and dervatives";
    Modelica.SIunits.Pressure plim=min(p,ThermoSysPro.Properties.WaterSteam.BaseIF97.data.PCRIT
                                                     - 1e-7)
      "pressure limited to critical pressure - epsilon";
    Modelica.SIunits.SpecificVolume v "Specific Volume";
    Real vp3 "vp^3";
    Real ivp3 "1/vp^3";
    Real pv "partial derivative of p w.r.t v";
    Real pv2 "pv^2";
    Real pv3 "pv^3";
    Real ptv "2nd partial derivative of p w.r.t t and v";
    Real pvv "2nd partial derivative of p w.r.t v and v";
  algorithm
    bpro.T := ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.tsat(plim);
    (bpro.dpT,bpro.dpTT) :=
      ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.d2ptofT(bpro.T);
    // need derivative of dpT
  //  bpro.region3boundary := bpro.T > data.TLIMIT1;
    if not bpro.T > ThermoSysPro.Properties.WaterSteam.BaseIF97.data.TLIMIT1 then
      g := ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.g2L3(
                      p, bpro.T);
      bpro.d := p/(g.R*bpro.T*g.pi*g.gpi);
      bpro.h := if p > plim then ThermoSysPro.Properties.WaterSteam.BaseIF97.data.HCRIT
         else g.R*bpro.T*g.tau*g.gtau;
      bpro.s := g.R*(g.tau*g.gtau - g.g);
      bpro.cp := -g.R*g.tau*g.tau*g.gtautau;
      bpro.vt := g.R/p*(g.pi*g.gpi - g.tau*g.pi*g.gpitau);
      bpro.vp := g.R*bpro.T/(p*p)*g.pi*g.pi*g.gpipi;
      bpro.pt := -p/bpro.T*(g.gpi - g.tau*g.gpitau)/(g.gpipi*g.pi);
      bpro.pd := -g.R*bpro.T*g.gpi*g.gpi/(g.gpipi);
      bpro.vtt := g.R*g.pi/p*g.tau/bpro.T*g.tau*g.gpitautau;
      bpro.vtp := g.R*g.pi*g.pi/(p*p)*(g.gpipi - g.tau*g.gpipitau);
      bpro.vpp := g.R*bpro.T*g.pi*g.pi*g.pi/(p*p*p)*g.gpipipi;
      bpro.cpt := g.R*g.tau*g.tau/bpro.T*(2*g.gtautau + g.tau*g.gtautautau);
      v := 1/bpro.d;
      vp3 := bpro.vp*bpro.vp*bpro.vp;
      ivp3 := 1/vp3;
      bpro.ptt := -(bpro.vtt*bpro.vp*bpro.vp -2.0*bpro.vt*bpro.vtp*bpro.vp +bpro.vt*bpro.vt*bpro.vpp)*ivp3;
      bpro.pdd := -bpro.vpp*ivp3*v*v*v*v - 2*v*bpro.pd "= pvv/d^4";
      bpro.ptd := (bpro.vtp*bpro.vp-bpro.vt*bpro.vpp)*ivp3*v*v "= -ptv/d^2";
      bpro.cvt := (vp3*bpro.cpt + bpro.vp*bpro.vp*bpro.vt*bpro.vt + 3.0*bpro.vp*bpro.vp*bpro.T*bpro.vt*bpro.vtt
        - 3.0*bpro.vtp*bpro.vp*bpro.T*bpro.vt*bpro.vt + bpro.T*bpro.vt*bpro.vt*bpro.vt*bpro.vpp)*ivp3;
    else
      bpro.d :=
        ThermoSysPro.Properties.WaterSteam.BaseIF97.Regions.rhov_p_R4b(plim);
      f := ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.f3L3(
                      bpro.d, bpro.T);
      bpro.h := ThermoSysPro.Properties.WaterSteam.BaseIF97.Regions.hv_p_R4b(
        plim);
      // f.R*bpro.T*(f.tau*f.ftau + f.delta*f.fdelta);
      bpro.s := f.R*(f.tau*f.ftau - f.f);
      bpro.cv := f.R*(-f.tau*f.tau*f.ftautau);
      bpro.pt := f.R*bpro.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      bpro.pd := f.R*bpro.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pv := (-f.d*f.d*bpro.pd);
      bpro.vp := 1/pv;
      bpro.vt := -bpro.pt/pv;
      bpro.pdd := f.R*bpro.T*f.delta/bpro.d*(2.0*f.fdelta + 4.0*f.delta*f.fdeltadelta +
           f.delta*f.delta*f.fdeltadeltadelta);
      bpro.ptt := f.R*bpro.d*f.delta*f.tau*f.tau/bpro.T*f.fdeltatautau;
      bpro.ptd := f.R*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta - 2.0*f.tau*f.fdeltatau
    -f.delta*f.tau*f.fdeltadeltatau);
      bpro.cvt := f.R*f.tau*f.tau/bpro.T*(2.0*f.ftautau + f.tau*f.ftautautau);
      bpro.cpt := (bpro.cvt*bpro.pd + bpro.cv*bpro.ptd + (bpro.pt + 2.0*bpro.T*bpro.ptt)*bpro.pt/(bpro.d*bpro.d)
    - bpro.cp*bpro.ptd)/bpro.pd;
      pv2 := pv*pv;
      pv3 := pv2*pv;
      pvv := bpro.pdd*f.d*f.d*f.d*f.d;
      ptv := (-f.d*f.d*bpro.ptd);
      bpro.vpp := -pvv/pv3;
      bpro.vtt := -(bpro.ptt*pv2 -2.0*bpro.pt*ptv*pv + bpro.pt*bpro.pt*pvv)/pv3;
      bpro.vtp := (-ptv*pv + bpro.pt*pvv)/pv3;
    end if;
  end dewcurveL3_p;

  function hvl_dp
    "derivative function for the specific enthalpy along the phase boundary"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p "pressure";
    input
      ThermoSysPro.Properties.WaterSteam.Common.IF97PhaseBoundaryProperties3rd
      bpro "property record";
    output Real dh_dp
      "derivative of specific enthalpy along the phase boundary";
  algorithm
      dh_dp := (1/bpro.d - bpro.T*bpro.vt) + bpro.cp/bpro.dpT;
      // dh_dp_der := vp - (T*vpt + dTp*vt) + d/dp(cp/(dp/dT))
    annotation (
      derivative(noDerivative=bpro) = hvl_dp_der,
      Inline=false,
      LateInline=true);
  end hvl_dp;

  function hvl_dp_der
    "derivative function for the specific enthalpy along the phase boundary"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p "pressure";
    input
      ThermoSysPro.Properties.WaterSteam.Common.IF97PhaseBoundaryProperties3rd
      bpro "property record";
    input Real p_der "Pressure derivative";
    output Real dh_dp_der
      "Second derivative of specific enthalpy along the phase boundary";
  protected
    Real cpp "Derivative of cp w.r.t. p";
    Real pv "partial derivative of p w.r.t. v";
    Real pv2 "pv*pv";
    Real pv3 "pv*pv*pv";
    Real ptv "2nd partial derivative of p w.r.t t and v";
    Real pvv "2nd partial derivative of p w.r.t v and v";
  algorithm
    pv :=-bpro.d*bpro.d*bpro.pd;
    pv2 := pv*pv;
    pv3 := pv2*pv;
    pvv := bpro.pdd*bpro.d*bpro.d*bpro.d*bpro.d;
    ptv := (-bpro.d*bpro.d*bpro.ptd);
    cpp := (bpro.T*(bpro.ptt*pv2 - 2.0*bpro.pt*ptv*pv + bpro.pt*bpro.pt*pvv))/pv3
      "T*(ptt*pv^2 - 2*pt*ptv*pv + pt^2*pvv)/pv^3";
    dh_dp_der := 0.0;
  //   dh_dp_der := 1/pv - (bpro.T*bpro.vtp + bpro.dpT*bpro.vt) +
  //     cpp/bpro.dpT - bpro.cp*(bpro.dpTT*bpro.dpT)/(bpro.dpT*bpro.dpT);
  //     //d/dp(cp/(dp/dT))

    annotation (Icon(graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={255,0,0},
            lineThickness=0.5)}));
  end hvl_dp_der;

    function dhl_dp
    "derivative of liquid specific enthalpy on the boundary between regions 4 and 3 or 1 w.r.t pressure"

    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p "pressure";
    output Modelica.SIunits.DerEnthalpyByPressure dh_dp
      "specific enthalpy derivative w.r.t. pressure";
    algorithm
    dh_dp := ThermoSysPro.Properties.WaterSteam.Region.hvl_dp(p,
      ThermoSysPro.Properties.WaterSteam.Region.boilingcurveL3_p(p));
    annotation(smoothOrder=2);
    end dhl_dp;

  function dhv_dp
    "derivative of vapour specific enthalpy on the boundary between regions 4 and 3 or 1 w.r.t pressure"

    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p "pressure";
    output Modelica.SIunits.DerEnthalpyByPressure dh_dp
      "specific enthalpy derivative w.r.t. pressure";
  algorithm
    dh_dp := ThermoSysPro.Properties.WaterSteam.Region.hvl_dp(p,
      ThermoSysPro.Properties.WaterSteam.Region.dewcurveL3_p(p));
    annotation(smoothOrder=2);
  end dhv_dp;

  function drhovl_dp
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p "saturation pressure";
    input
      ThermoSysPro.Properties.WaterSteam.Common.IF97PhaseBoundaryProperties3rd
      bpro "property record";
    output Real dd_dp(unit="kg/(m3.Pa)")
      "derivative of density along the phase boundary";
  algorithm
    dd_dp := -bpro.d*bpro.d*(bpro.vp + bpro.vt/bpro.dpT);
    annotation (
      derivative(noDerivative=bpro) = drhovl_dp_der,
      Inline=false,
      LateInline=true);
  end drhovl_dp;

  function drhol_dp "derivative of density of saturated water w.r.t. pressure"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p "saturation pressure";
    output Modelica.SIunits.DerDensityByPressure dd_dp
      "derivative of density of water at the boiling point";
  algorithm
    dd_dp := ThermoSysPro.Properties.WaterSteam.Region.drhovl_dp(p,
      ThermoSysPro.Properties.WaterSteam.Region.boilingcurveL3_p(p));
  end drhol_dp;

  function drhov_dp "derivative of density of saturated steam w.r.t. pressure"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p "saturation pressure";
    output Modelica.SIunits.DerDensityByPressure dd_dp
      "derivative of density of water at the boiling point";
  algorithm
    dd_dp := ThermoSysPro.Properties.WaterSteam.Region.drhovl_dp(p,
      ThermoSysPro.Properties.WaterSteam.Region.dewcurveL3_p(p));
  end drhov_dp;

  function drhovl_dp_der
    "Time derivative of density derivative along phase boundary"
    extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p "saturation pressure";
    input
      ThermoSysPro.Properties.WaterSteam.Common.IF97PhaseBoundaryProperties3rd
      bpro "property record";
    input Real p_der "Time derivative of pressure";
    output Real dd_dp_der "derivative of density along the phase boundary";
  algorithm
    dd_dp_der := 0.0;
  end drhovl_dp_der;
  annotation (Icon(graphics={
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
          smooth=Smooth.None)}));

end Region;
