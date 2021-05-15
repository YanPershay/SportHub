using AutoMapper;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Mappers.Profiles
{
    public class SubscribeObjectMappingProfile : Profile
    {
        public SubscribeObjectMappingProfile()
        {
            CreateMap<Subscribe, SubscribeObjectResponse>().ReverseMap();
        }
    }
}
