using SportHub.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities
{
    public class PostCategory : Entity
    {
        public string CategoryName { get; set; }
        public List<AdminPost> AdminPosts { get; set; }

        public PostCategory(string categoryName)
        {
            CategoryName = categoryName;
        }
    }
}
