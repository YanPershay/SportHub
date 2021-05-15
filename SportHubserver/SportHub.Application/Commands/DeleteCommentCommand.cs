using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class DeleteCommentCommand : IRequest<int>
    {
        public int Id { get; set; }
    }
}
