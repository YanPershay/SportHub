﻿using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SportHub.Application.Commands;
using SportHub.Application.Queries;
using SportHub.Application.Queries.PostQueries;
using SportHub.Application.Responses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportHub.API.Controllers
{
    public class PostController : ApiController
    {
        public readonly IMediator _mediator;

        public PostController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet("postsByGuid")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<PostResponse>>> GetPostsByGuid(Guid guid)
        {
            var query = new GetPostsByGuidQuery(guid);
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [HttpGet("subsPosts")]
        [ProducesResponseType(StatusCodes.Status200OK)]//потом исключить чтобы не возвращался null
        public async Task<ActionResult<IEnumerable<PostResponse>>> GetSubscribesPosts(Guid subscriberId)
        {
            var query = new GetSubscribesPostsQuery(subscriberId);
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<PostResponse>> CreatePost([FromBody] CreatePostCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }
    }
}
