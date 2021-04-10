using AutoMapper;
using SportHub.Application.Commands;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Mappers.Profiles
{
    class PostMappingProfile : Profile
    {
        public PostMappingProfile()
        {
            CreateMap<User, UserResponse>().ReverseMap();
            CreateMap<UserInfo, UserInfoResponse>().ReverseMap();

            CreateMap<Post, PostResponse>().ReverseMap();
            CreateMap<Post, CreatePostCommand>().ReverseMap();
        }
    }
}
