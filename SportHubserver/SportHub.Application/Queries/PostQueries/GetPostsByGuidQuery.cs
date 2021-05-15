using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries
{
    public class GetPostsByGuidQuery : IRequest<IEnumerable<PostResponse>>
    {
        public Guid UserId { get; set; }
        public GetPostsByGuidQuery(Guid userId)
        {
            UserId = userId;
        }
    }
}
