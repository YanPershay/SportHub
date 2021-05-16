using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SportHub.API.JwtMiddlewareTest;
using SportHub.Application.Commands;
using SportHub.Application.Queries;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportHub.API.Controllers
{
    public class TrainerPostController : ApiController
    {
        public readonly IMediator _mediator;

        public TrainerPostController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<TrainerPostResponse>>> GetPostsByCategoryId()
        {
            var query = new GetTrainerPostsQuery();
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [JwtAuthorize]
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<TrainerPostResponse>> CreateAdminPost([FromBody] CreateTrainerPostCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }

        [JwtAuthorize]
        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<int>> DeleteTrainerPost([FromBody] DeleteTrainerPostCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }
    }
}

