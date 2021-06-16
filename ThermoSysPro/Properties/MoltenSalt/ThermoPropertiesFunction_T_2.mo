within ThermoSysPro.Properties.MoltenSalt;
function ThermoPropertiesFunction_T_2 "ThermoPropertiesFunction of Solt: KNO3-NaNO3
"
  input Modelica.SIunits.Temperature T
    "dimensionless derivatives of the Gibbs function";
  output ThermoSysPro.Properties.MoltenSalt.ThermoProperties_T pro;
//protected
  //Real vt;
  //Real vp;

algorithm
  //if (T-273)>538 then
  if (T-273)>838 then
    assert(false, "Molten salt_T: Temperature is too high (" + String(T-273) + ")");
  elseif (T-273)<149 then
    assert(false, "Molten salt_T: Temperature is too low (" + String(T-273) + ")");
  else

//////////////////////////////////

    //pro.cp := 1417.54 + 0.172*T;        // = 1561.7 à T=838.16
    //pro.cp := 1464.84 + 0.172*T;        // = 1561.7 à T=563.15

    //pro.cp := 1396.0182 + 0.172*T;      //Stephanie = 1539.84 à T=838.16

    //pro.cp := 976.78 + 1.0634*T;        // Williams et al. [2006]   range of 770?1040 K
    //pro.cp := 5806 - 10.833*T + 0.0072413*T*T;   //Janz et al     range of 426?776 K
    //pro.cp := 1721.86;                  //moyenne  Williams et al. [2006]   div

//////////////////////////////////

//Stephanie  // for T= 500 °C or 773 °K => cp= 1529 J ke-1 K-1
//Specific Heat Capacity
//    pro.cp := 1443 + 0.172*(T - 273.15);                           // temperature in °C
//    pro.cp := 1396.11639230963 + 0.171740545944394*T;              // temperature in °K
//Thermal Conductivity
//    pro.k := 0.443 + 0.00019*(T - 273.15);                         // temperature in °C
//    pro.k := 0.3911015 + 0.00019*T;                                // temperature in °K
//Dynamic Viscosity
//    pro.mu := (22.714 - 0.12*(T - 273.15) + 2.281*1e-7*(T - 273.15)**2 - 1.474*1e-10*(T - 273.15)**3);   // temperature in °C
//    pro.mu :=( 0.0755147595 - 0.00027760398*T + 3.4888693*1e-7*T^2 - 1.4739999*1e-10*T^3);   // temperature in °K
//Density
//    pro.d := 2090 - 0.636*(T - 273.15);                             // temperature in °C
//    pro.d := 2263.7234- 0.636*T;                                    // temperature in °C

//////////////////////////////////
// CAS
//    pro.d := 2090-0.636*T;      // kg m-3
//    pro.cp := 1443+0.172*T;     // J ke-1 K-1
//    pro.k := 0.443+0.00019*T;   // W m-1 k-1
//    pro.mu := (22.714-0.12*T+2.281*T*0.0001*T-1.474*T*0.0001*T*0.001*T)/1000;    //Pa s(kg m-1 s-1)

//////////////////////////////////
//PHD
    pro.d := 1938.0-(0.732*(T-273-200));

    pro.cp := 1561.7;

    pro.k := 0.421-6.53e-4*(T-273-260);
    pro.mu := Modelica.Math.exp(-4.343-2.0143*(Modelica.Math.log(T-273)-5.011));
    //pro.mu :=(2.5-((T-273)-300)/(450-300))*0.001;
//
    pro.ddpT := 1e-6;
    pro.ddTp := -0.732;
  end if;

  annotation (smoothOrder=2,Icon(graphics={
        Text(extent={{-136,102},{140,42}}, textString=
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
               "function")}),
                           Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end ThermoPropertiesFunction_T_2;
