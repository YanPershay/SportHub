using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.PostQueries
{
    public class GetSavedPostsQuery : IRequest<IEnumerable<PostResponse>>
    {
        public Guid UserId { get; set; }
        public GetSavedPostsQuery(Guid userId)
        {
            UserId = userId;
        }
    }
}
