using MediatR;
using SportHub.Application.Mappers;
using SportHub.Application.Queries;
using SportHub.Application.Responses;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    class GetCommentsByPostIdHandler : IRequestHandler<GetCommentsByPostIdQuery, IEnumerable<CommentResponse>>
    {
        private readonly ICommentRepository _commentRepository;

        public GetCommentsByPostIdHandler(ICommentRepository commentRepository)
        {
            _commentRepository = commentRepository;
        }

        public async Task<IEnumerable<CommentResponse>> Handle(GetCommentsByPostIdQuery request, CancellationToken cancellationToken)
        {
            var comment = await _commentRepository.GetCommentsByPostIdAsync(request.PostId);
            var commentResponse = CommentMapper.Mapper.Map<IEnumerable<CommentResponse>>(comment);
            return commentResponse;
        }
    }
}
