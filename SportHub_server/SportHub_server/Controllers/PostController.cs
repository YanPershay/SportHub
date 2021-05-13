using Azure.Storage.Blobs;
using Azure.Storage.Blobs.Models;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using SportHub.API.JwtMiddlewareTest;
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
        private readonly string _azureConnectionString;

        public PostController(IMediator mediator, IConfiguration configuration)
        {
            _mediator = mediator;
            _azureConnectionString = configuration.GetConnectionString("AzureConnectionString");
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

        [HttpGet("savedPosts")]
        [ProducesResponseType(StatusCodes.Status200OK)]//потом исключить чтобы не возвращался null
        public async Task<ActionResult<IEnumerable<PostResponse>>> GetSavedsPosts(Guid userId)
        {
            var query = new GetSavedPostsQuery(userId);
            var result = await _mediator.Send(query);
            return Ok(result);
        }

        [JwtAuthorize]
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<PostResponse>> CreatePost([FromBody] CreatePostCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }

        [JwtAuthorize]
        [HttpDelete]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<int>> DeletePost([FromBody] DeletePostCommand command)
        {
            var result = await _mediator.Send(command);
            return Ok(result);
        }

        //[JwtAuthorize]
        [HttpPost("blob")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<IActionResult> UploadImageToAzureBlob()
        {
            try
            {
                var formCollection = await Request.ReadFormAsync();
                var file = formCollection.Files.First();

                if(file.Length > 0)
                {
                    var container = new BlobContainerClient(_azureConnectionString, "sporthubpostsimages");
                    var createResponse = await container.CreateIfNotExistsAsync();
                    if(createResponse != null && createResponse.GetRawResponse().Status == 201)
                    {
                        await container.SetAccessPolicyAsync(PublicAccessType.Blob);
                    }

                    var blob = container.GetBlobClient(file.FileName);
                    await blob.DeleteIfExistsAsync(DeleteSnapshotsOption.IncludeSnapshots);

                    using(var fileStream = file.OpenReadStream())
                    {
                        await blob.UploadAsync(fileStream, new BlobHttpHeaders { ContentType = file.ContentType });
                    }

                    return Ok(blob.Uri.ToString());
                }

                return BadRequest();
            }
            catch(Exception ex)
            {
                return StatusCode(500, $"Azure blob error: {ex}");
            }
        }
    
    [JwtAuthorize]
    [HttpDelete("blob")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    public async Task<IActionResult> DeleteImageFromAzureBlob(string imgName)
    {
        try
        {
            var container = new BlobContainerClient(_azureConnectionString, "sporthubpostsimages");
            var createResponse = await container.CreateIfNotExistsAsync();
            if (createResponse != null && createResponse.GetRawResponse().Status == 201)
            {
                await container.SetAccessPolicyAsync(PublicAccessType.Blob);
            }

            var blob = container.GetBlobClient(imgName);
            await blob.DeleteIfExistsAsync();

            return NoContent();
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Azure blob error: {ex}");
        }
    }
}
}
