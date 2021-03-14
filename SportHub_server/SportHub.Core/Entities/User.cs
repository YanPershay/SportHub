using SportHub.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities
{
    public class User : Entity
    {
        public Guid GuidId { get; set; }
        public string Username { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public bool IsOnline { get; set; }
        public bool IsAdmin { get; set; }
    }
}
