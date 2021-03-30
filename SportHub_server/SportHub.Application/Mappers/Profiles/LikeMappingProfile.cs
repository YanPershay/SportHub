using AutoMapper;
using SportHub.Application.Commands;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Mappers.Profiles
{
    class LikeMappingProfile : Profile
    {
        public LikeMappingProfile()
        {
            CreateMap<Like, LikeResponse>().ReverseMap();
            CreateMap<Like, AddLikeCommand>().ReverseMap();
        }
    }
}
