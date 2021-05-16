using MediatR;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class AddLikeCommand : IRequest<LikeResponse>
    {
        public Guid UserId { get; set; }

        public int PostId { get; set; }
    }
}
