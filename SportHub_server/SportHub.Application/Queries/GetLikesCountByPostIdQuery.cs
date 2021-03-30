using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries
{
    public class GetLikesCountByPostIdQuery : IRequest<int>
    {
        public int PostId { get; set; }

        public GetLikesCountByPostIdQuery(int postId)
        {
            PostId = postId;
        }
    }
}
