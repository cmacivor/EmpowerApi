﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgmtModel.ViewModels;


namespace DJSCaseMgtService.Controllers
{

    
    [RoutePrefix("api/Assessment")]
    public class AssessmentController : BaseController<Assessment>
    {
           private IAssessmentRepository assessmentRepository;
        public AssessmentController(IBaseRepository<Assessment> baseRepository, IAssessmentRepository assessmentRepository) : base(baseRepository) {
        
            this.assessmentRepository=assessmentRepository;
        }

          [System.Web.Http.HttpGet, System.Web.Http.Route("DeleteAssessment/{id:int}")]
        public string DeleteAssessment(int id)
        {
            var assessments = assessmentRepository.DeleteAssessment(id);

            return assessments;
        }
    }
   
   
}