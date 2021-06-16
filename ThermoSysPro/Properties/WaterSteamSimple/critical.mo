within ThermoSysPro.Properties.WaterSteamSimple;
record critical "critical point data"
  extends Modelica.Icons.Record;
  constant Modelica.SIunits.Pressure PCRIT=22064000.0 "the critical pressure";
  constant Modelica.SIunits.Temperature TCRIT=647.096
    "the critical temperature";
  constant Modelica.SIunits.Density DCRIT=322.0 "the critical density";
  constant Modelica.SIunits.SpecificEnthalpy HCRIT=2087546.84511715
    "the calculated specific enthalpy at the critical point";
  constant Modelica.SIunits.SpecificEntropy SCRIT=4412.02148223476
    "the calculated specific entropy at the critical point";
  annotation (Documentation(info="<HTML>
 <h4>Record description</h4>
 <p>Critical point data for IF97 steam properties. SCRIT and HCRIT are calculated from helmholtz function for region 3 </p>
<h4>Version Info and Revision history
</h4>
<ul>
<li>First implemented: <i>July, 2000</i>
       by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
       </li>
</ul>
 <address>Author: Hubertus Tummescheit, <br>
      Modelon AB<br>
      Ideon Science Park<br>
      SE-22370 Lund, Sweden<br>
      email: hubertus@modelon.se
 </address>
<ul>
 <li>Initial version: July 2000</li>
 <li>Documentation added: December 2002</li>
</ul>
</HTML>
"));
end critical;
