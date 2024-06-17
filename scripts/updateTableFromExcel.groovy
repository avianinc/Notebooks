import com.nomagic.magicdraw.core.Application
import com.nomagic.magicdraw.core.Project
import com.nomagic.magicdraw.importexport.ImportExportManager

String TABLE_QUALIFY_NAME = "Demo - Evaluation Workflow::RequirementEvaluationContext::Instances::Instances - Test Cases"
Project project = Application.getInstance().getProject()

ImportExportManager.importToTable(project, TABLE_QUALIFY_NAME)