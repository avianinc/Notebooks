package studyMapperTemplate {

    doc /* Study Mapper Template - Provides the structure build variable and contastatn mappings between system models model and MS&A tools 
    - See 'Intro to the SysML v2 Language, p107 */

    import ScalarValues::*;
    import AnalysisTooling::*;
    
    action def c_Simulator {
    
        metadata ToolExecution {
            toolName = "SCILAB_6.0.1"; 
            uri = "http://localhost:5000/sci_script";
        }
        
        file = "scripts/test_script.sci";
        
        // Mapping definition
        in i_length: Real                { @ToolVariable { name = "s_length"; } }
        in i_width: Real                 { @ToolVariable { name = "s_width"; } }
        in i_height: Real                { @ToolVariable { name = "s_height"; } }
        out m_volume: Real               { @ToolVariable { name = "r_volume"; } }
    }
}