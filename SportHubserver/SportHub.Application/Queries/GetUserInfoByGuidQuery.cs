using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries
{
    public class GetUserInfoByGuidQuery : IRequest<UserInfoResponse>
    {
        public Guid UserId { get; set; }
        public GetUserInfoByGuidQuery(Guid userId)
        {
            UserId = userId;
        }
    }
}
