using AutoMapper;
using SportHub.Application.Commands;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Mappers.Profiles
{
    class TrainerPostMappingProfile : Profile
    {
        public TrainerPostMappingProfile()
        {
            CreateMap<User, UserResponse>().ReverseMap();
            CreateMap<TrainerPost, TrainerPostResponse>().ReverseMap();
            CreateMap<TrainerPost, CreateTrainerPostCommand>().ReverseMap();
            CreateMap<TrainerPost, DeleteTrainerPostCommand>().ReverseMap();
        }
    }
}
