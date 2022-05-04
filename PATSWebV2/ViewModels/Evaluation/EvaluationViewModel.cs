using IdentityManagement.Entities;
using System;
using System.Collections.Generic;

namespace PATSWebV2.ViewModels.Evaluation
{
    public class EvaluationViewModel
    {
        public int EpisodeId { get; set; }
        public int EvaluationID { get; set; }
        public string SelectedStaffId { get; set; }
        public int LoginStaffId { get; set; }
        public DateTime SelectedEvaluationDate { get; set; }
        public string ActiveTabIn { get; set; }
        public List<EvaluationData> Evaluations { get; set; }
        public bool CanEdit { get; set; }

        public EvaluationViewModel() { }
    }
}