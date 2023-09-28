Return-Path: <linux-hyperv+bounces-314-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0407B1E97
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3E8C22816FC
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911C23B79E;
	Thu, 28 Sep 2023 13:37:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AF43AC3D;
	Thu, 28 Sep 2023 13:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ED8C433C8;
	Thu, 28 Sep 2023 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1695908220;
	bh=+wQRUm2msRT1Vv6LzHjx16q1r07oTZukLX6w4Q72cRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQY4RQBXMdvdqFGAIafv/Phk7Y1oE+EJjzKjC3TRuINAbWxqzcqLPwyX0a9VAn7db
	 lrLv0OwYBTVD2TtgiIEZJRfo0bKqoMi2GBhCLXf4v+k2xekgAHOfI6frhHYfLI3c4k
	 s478XPbm0PhMMeW0NqTPzj3Xl+SvTPCIBgs7SdE0=
Date: Thu, 28 Sep 2023 15:36:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: j.granados@samsung.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
	josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
	Phillip Potter <phil@philpotter.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jiri Slaby <jirislaby@kernel.org>,
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
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-serial@vger.kernel.org, linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/15] cdrom: Remove now superfluous sentinel element
 from ctl_table array
Message-ID: <2023092855-cultivate-earthy-4d25@gregkh>
References: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
 <20230928-jag-sysctl_remove_empty_elem_drivers-v1-1-e59120fca9f9@samsung.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-1-e59120fca9f9@samsung.com>

On Thu, Sep 28, 2023 at 03:21:26PM +0200, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove sentinel element from cdrom_table
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  drivers/cdrom/cdrom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index cc2839805983..451907ade389 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -3654,8 +3654,7 @@ static struct ctl_table cdrom_table[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
>  		.proc_handler	= cdrom_sysctl_handler
> -	},
> -	{ }
> +	}

You should have the final entry as "}," so as to make any future
additions to the list to only contain that entry, that's long been the
kernel style for lists like this.

So your patches will just remove one line, not 2 and add 1, making it a
smaller diff.

thanks,

greg k-h

