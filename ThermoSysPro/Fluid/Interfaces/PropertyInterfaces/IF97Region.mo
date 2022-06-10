within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;
type IF97Region = enumeration(
    All_regions "All regions - IF97 is selected automatically",
    Region_1 "Region 1 - Liquid",
    Region_2 "Region 2 - Vapor",
    Region_3 "Region 3",
    Region_4 "Region 4 - Saturation line",
    Region_5 "Region 5") "IF97 Regions" annotation (Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
