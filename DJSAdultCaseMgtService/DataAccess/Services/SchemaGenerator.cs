using System;
using System.Collections.Generic;
using System.Linq;
//using System.Web;
using System.Data;
using System.Data.SqlClient;
using Dapper;
using DJSCaseMgtModel.Entities;
//using DJSCaseMgtModel.ViewModels;
//using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtService.Utility;
using System.Threading.Tasks;
//using System.Configuration;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using Newtonsoft.Json.Schema;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgtService.DataAccess.Services
{
    public class SchemaGenerator : ISchemaGenerator
    {
        public SchemaGenerator()
        {
        }

        public Object Generate()
        {
            JsonSchemaGenerator generator = new JsonSchemaGenerator();
            JsonSchema schema = generator.Generate(typeof(AddressType));
            //schema.Annotate(typeof(Person));
            return schema;
        }

    }
}