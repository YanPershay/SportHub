using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries
{
    public class GetCommentsByPostIdQuery : IRequest<IEnumerable<CommentResponse>>
    {
        public int PostId { get; set; }

        public GetCommentsByPostIdQuery(int postId)
        {
            PostId = postId;
        }
    }
}

