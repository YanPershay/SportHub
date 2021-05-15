using MediatR;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Commands
{
    public class DeletePostCommand : IRequest<int>
    {
        public int Id { get; set; }
    }
}
