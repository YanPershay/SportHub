using AutoMapper;
using SportHub.Application.Commands;
using SportHub.Application.Responses;
using SportHub.Core.Entities;

namespace SportHub.Application.Mappers.Profiles
{
    public class CommentMappingProfile : Profile
    {
        public CommentMappingProfile()
        {
            CreateMap<User, UserResponse>().ReverseMap();
            CreateMap<UserInfo, UserInfoResponse>().ReverseMap();

            CreateMap<Comment, CommentResponse>().ReverseMap();
            CreateMap<Comment, CreateCommentCommand>().ReverseMap();
            CreateMap<Comment, DeleteCommentCommand>().ReverseMap();
        }
    }
}
