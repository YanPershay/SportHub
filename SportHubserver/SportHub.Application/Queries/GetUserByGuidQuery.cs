using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries
{
    public class GetUserByGuidQuery : IRequest<UserResponse>
    {
        public Guid GuidId { get; set; }

        public GetUserByGuidQuery(Guid guidId)
        {
            GuidId = guidId;
        }
    }
}
