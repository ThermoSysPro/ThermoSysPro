within ThermoSysPro.Properties.WaterSteamSimple;
record triple "triple point data"
  extends Modelica.Icons.Record;
  constant Modelica.SIunits.Temperature Ttriple=273.16
    "the triple point temperature";
  constant Modelica.SIunits.Pressure ptriple=611.657
    "the triple point temperature";
  constant Modelica.SIunits.Density dltriple=999.792520031617642
    "the triple point liquid density";
  constant Modelica.SIunits.Density dvtriple=0.485457572477861372e-2
    "the triple point vapour density";
  annotation (Documentation(info="<HTML>
 <h4>Record description</h4>
 <p>Vapour/liquid/ice triple point data for IF97 steam properties.</p>
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
end triple;
