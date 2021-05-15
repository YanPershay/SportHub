using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries.PostQueries
{
    class GetPostByIdQuery : IRequest<PostResponse>
    {
        public int PostId { get; set; }
        public GetPostByIdQuery(int postId)
        {
            PostId = postId;
        }
    }
}
