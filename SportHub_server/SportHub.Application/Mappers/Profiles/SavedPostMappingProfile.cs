using AutoMapper;
using SportHub.Application.Commands;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Mappers.Profiles
{
    public class SavedPostMappingProfile : Profile
    {
        public SavedPostMappingProfile()
        {
            CreateMap<SavedPost, SavedPostResponse>().ReverseMap();
            CreateMap<SavedPost, SavePostCommand>().ReverseMap();
        }
    }
}
