using AutoMapper;
using SportHub.Application.Commands;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Mappers.Profiles
{
    class AdminPostMappingProfile : Profile
    {
        public AdminPostMappingProfile()
        {
            CreateMap<User, UserResponse>().ReverseMap();
            CreateMap<AdminPost, AdminPostResponse>().ReverseMap();
            CreateMap<AdminPost, CreateAdminPostCommand>().ReverseMap();
            CreateMap<AdminPost, DeleteTrainerPostCommand>().ReverseMap();
        }
    }
}
