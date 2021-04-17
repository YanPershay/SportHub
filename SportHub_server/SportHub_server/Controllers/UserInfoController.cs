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

    public class UserInfoController : ApiController
    {
        public readonly IMediator _mediator;

        public UserInfoController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<UserInfoResponse>> GetUserInfoByGuid(Guid guid)
        {
            var query = new GetUserInfoByGuidQuery(guid);
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<UserInfoResponse>> CreateUserInfo([FromBody] CreateUserInfoCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }

        [HttpPut]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<UserInfoResponse>> UpdateUserInfo([FromBody] UpdateUserInfoCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }
    }
}
