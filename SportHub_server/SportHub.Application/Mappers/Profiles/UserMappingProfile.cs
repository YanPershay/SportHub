using AutoMapper;
using SportHub.Application.Commands;
using SportHub.Application.Responses;
using SportHub.Core.Entities;

namespace SportHub.Application.Mappers
{
    class UserMappingProfile : Profile
    {
        public UserMappingProfile()
        {
            CreateMap<UserInfo, UserInfoResponse>().ReverseMap();
            CreateMap<User, UserResponse>().ReverseMap();
            CreateMap<User, CreateUserCommand>().ReverseMap();
        }
    }
}
