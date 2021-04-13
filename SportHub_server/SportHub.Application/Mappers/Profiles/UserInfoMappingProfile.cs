using AutoMapper;
using SportHub.Application.Commands;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Mappers
{
    class UserInfoMappingProfile : Profile
    {
        public UserInfoMappingProfile()
        {
            //CreateMap<User, UserResponse>().ReverseMap();

            CreateMap<UserInfo, UserInfoResponse>().ReverseMap();
            CreateMap<UserInfo, CreateUserInfoCommand>().ReverseMap();
        }
    }
}
