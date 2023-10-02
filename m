Return-Path: <linux-hyperv+bounces-394-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D20917B4E7C
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 11:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 83C0D282156
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C498C0D;
	Mon,  2 Oct 2023 09:02:42 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70252A20;
	Mon,  2 Oct 2023 09:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE7CC433C8;
	Mon,  2 Oct 2023 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696237361;
	bh=smbdD+CUEQ4ahMF3RqsYVNHHjGroQxTTaWRgCAR/D24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMX+58jl6hq9UFJUHZd1tjzFPgSTOpSlydUnTfJQnD4JkBTo1W3OhKwdiqRz3OSHL
	 5qGb/GMTdZ1Zi7txcN44MpKcZqjCquccKdPkeOQfVVDMci/1xfBziuQgAa/1GdsgkO
	 fTB8auP7M3L0i1rXICcsdIgBp+nJtQayOSXiZzAY=
Date: Mon, 2 Oct 2023 11:02:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	"j.granados@samsung.com" <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	Kees Cook <keescook@chromium.org>,
	Phillip Potter <phil@philpotter.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Corey Minyard <minyard@acm.org>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>,
	Russ Weight <russell.h.weight@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Song Liu <song@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 04/15] tty: Remove now superfluous sentinel element from
 ctl_table array
Message-ID: <2023100252-plod-user-4504@gregkh>
References: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
 <20230928-jag-sysctl_remove_empty_elem_drivers-v1-4-e59120fca9f9@samsung.com>
 <63e7a4fe-58c9-470e-84c2-dd92e76462ae@kernel.org>
 <4d7bf39e-e7f9-f497-13aa-73718456a653@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d7bf39e-e7f9-f497-13aa-73718456a653@csgroup.eu>

On Mon, Oct 02, 2023 at 08:47:53AM +0000, Christophe Leroy wrote:
> 
> 
> Le 02/10/2023 à 10:17, Jiri Slaby a écrit :
> > On 28. 09. 23, 15:21, Joel Granados via B4 Relay wrote:
> >> From: Joel Granados <j.granados@samsung.com>
> >>
> >> This commit comes at the tail end of a greater effort to remove the
> >> empty elements at the end of the ctl_table arrays (sentinels) which
> >> will reduce the overall build time size of the kernel and run time
> >> memory bloat by ~64 bytes per sentinel (further information Link :
> >> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> >>
> >> Remove sentinel from tty_table
> >>
> >> Signed-off-by: Joel Granados <j.granados@samsung.com>
> >> ---
> >>   drivers/tty/tty_io.c | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> >> index 8a94e5a43c6d..2f925dc54a20 100644
> >> --- a/drivers/tty/tty_io.c
> >> +++ b/drivers/tty/tty_io.c
> >> @@ -3607,8 +3607,7 @@ static struct ctl_table tty_table[] = {
> >>           .proc_handler    = proc_dointvec,
> >>           .extra1        = SYSCTL_ZERO,
> >>           .extra2        = SYSCTL_ONE,
> >> -    },
> >> -    { }
> >> +    }
> > 
> > Why to remove the comma? One would need to add one when adding a new entry?
> 
> Does it make any difference at all ?
> 
> In one case you have:
> 
> @xxxx
>   		something old,
>   	},
> +	{
> +		something new,
> +	},
>   }
> 
> In the other case you have:
> 
> @xxxx
>   		something old,
> + 	},
> +	{
> +		something new,
>   	}
>   }

Because that way it is obvious you are only touching the "something new"
lines and never have to touch the "something old" ones.

It's just a long-standing tradition in Linux, don't have an extra
character if you don't need it :)

thanks,

greg k-h

