using MediatR;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Application.Queries
{
    public class GetTrainerPostsQuery : IRequest<IEnumerable<TrainerPostResponse>>
    {
    }
}
