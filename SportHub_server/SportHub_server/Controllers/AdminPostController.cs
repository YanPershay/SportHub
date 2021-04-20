using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SportHub.Application.Commands;
using SportHub.Application.Queries;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportHub.API.Controllers
{
    public class AdminPostController : ApiController
    {
        public readonly IMediator _mediator;

        public AdminPostController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<AdminPostResponse>>> GetPostsByCategoryId()
        {
            var query = new GetAdminPostsQuery();
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<AdminPostResponse>> CreateAdminPost([FromBody] CreateAdminPostCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }
    }
}

