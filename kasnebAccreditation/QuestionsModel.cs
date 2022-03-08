using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace kasnebAccreditation
{
    public class QuestionsModel
    {
        public string QuestionNumber { get; set; }
        public string QuestionDescription { get; set; }
        public string QuestionType { get; set; }
        public decimal maxscore { get; set; }
        public string QuestionCode { get; set; }
        public string ComponentCode { get; set; }
        public String response { get; set; }
        public decimal score { get; set; }
        public String AccreditationAnswer { get; set; }
        public String Attachment { get; set; }
        public String applicationNo { get; set; }
        public string subquestion { get; set; }
        public string childquestionCode { get; set; }
        public string subquestionResponce { get; set; }
        public string subquestionCode { get; set; }
        public string subquestionType { get; set; }
        public string childResponse { get; set; }
        public string evaluationHeader { get; set; }
        public string comment { get; set; }

        ////////////////////////Accreditation Sections
        public string chapter { get; set; }
        public string topic { get; set; }
       

    }
}