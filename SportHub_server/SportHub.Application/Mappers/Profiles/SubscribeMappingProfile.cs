﻿using AutoMapper;
using SportHub.Application.Commands;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Mappers.Profiles
{
    public class SubscribeMappingProfile : Profile
    {
        public SubscribeMappingProfile()
        {
            CreateMap<Subscribe, SubscribeResponse>().ReverseMap();
            CreateMap<Subscribe, SubscribeToUserCommand>().ReverseMap();
        }
    }
}
