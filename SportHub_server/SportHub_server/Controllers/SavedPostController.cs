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
    public class SavedPostController : ApiController
    {
        public readonly IMediator _mediator;

        public SavedPostController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<SavedPostResponse>>> GetSavedPostsByUserId(Guid userId)
        {
            var query = new GetSavedPostsByUserIdQuery(userId);
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<SavedPostResponse>> SavePost([FromBody]SavePostCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }
    }
}
