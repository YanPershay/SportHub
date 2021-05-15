using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using SportHub.API.JwtMiddlewareTest;
using SportHub.Application.Commands;
using SportHub.Application.Queries;
using SportHub.Application.Queries.SubscribesQueries;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportHub.API.Controllers
{
    public class SubscribeController : ApiController
    {
        public readonly IMediator _mediator;

        public SubscribeController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet("isSubscribed")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<bool>> IsUserSubscribed(Guid subscriberId, Guid userId)
        {
            var query = new IsUserSubscribedQuery(subscriberId, userId);
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [HttpGet("subsCount")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<SubscriptionsCountResponse>> GetSubscriptionsCountByUserId(Guid userId)
        {
            var query = new GetSubscriptionsCountByUserIdQuery(userId);
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [HttpGet("subObj")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<SubscribeObjectResponse>> GetSubscribeObject(Guid subscriberId, Guid userId)
        {
            var query = new GetSubscribeObjectQuery(subscriberId, userId);
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [HttpGet("getmysubs")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<PostResponse>>> GetMySubscribesByUserId(Guid subscriberId)
        {
            var query = new GetMySubscribesByUserIdQuery(subscriberId);
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [HttpGet("getsubs")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<PostResponse>>> GetSubscribersByUserId(Guid userId)
        {
            var query = new GetSubscribersByUserIdQuery(userId);
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [JwtAuthorize]
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<SubscribeResponse>> SubscribeToUser([FromBody] SubscribeToUserCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }

        [JwtAuthorize]
        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<int>> Unsubscribe([FromBody] UnsubscribeCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }
    }
}
