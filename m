Return-Path: <linux-hyperv+bounces-397-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D77B54CC
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 16:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 89B302827D7
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462019BCC;
	Mon,  2 Oct 2023 14:17:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80202C2EB;
	Mon,  2 Oct 2023 14:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53217C433C8;
	Mon,  2 Oct 2023 14:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696256258;
	bh=vkYSu3CMdUku1DYMLSbi1CqSIx/Y+w371ZyBOHbOWQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=exLEpilJBAgz5ZnsirATe9JxW+UqjlphdsbHWsfr4jfuvvcdvfFqCOOPADpHoegLG
	 QT1ZRviNOCQSFKPR+2ncqqKUmVN5OgF6Y3H/MOzAcM/iVe2Rhws0drvVplI+2eIc8B
	 vEtl9FK4HkZ3OOjR4RCkE9u+Gvi4K1kPyS1jOYkSvxJSQs2ZBIu74ouWye+qLIE93j
	 akqIqYVLy6LU2/F78IRxLEwEfXTSJG6/bFwFcDmsl1IBSzB7eh4B9D9E143cSdty4X
	 r2p6zx5xCX9grOdpP+GalyJ8YI4rJQvVL0i4iN5OQXuy6/X9d744gUtflnDsfOCo5Y
	 8pia5lOvzI0rg==
Message-ID: <e493d101-348a-949d-5160-3d633817adf2@kernel.org>
Date: Mon, 2 Oct 2023 08:17:35 -0600
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 10/15] vrf: Remove the now superfluous sentinel element
 from ctl_table array
Content-Language: en-US
To: j.granados@samsung.com, Luis Chamberlain <mcgrof@kernel.org>,
 willy@infradead.org, josh@joshtriplett.org, Kees Cook
 <keescook@chromium.org>, Phillip Potter <phil@philpotter.co.uk>,
 Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jiri Slaby <jirislaby@kernel.org>, "James E.J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Corey Minyard <minyard@acm.org>, Theodore Ts'o <tytso@mit.edu>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>,
 Russ Weight <russell.h.weight@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Song Liu <song@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-serial@vger.kernel.org, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20231002-jag-sysctl_remove_empty_elem_drivers-v2-0-02dd0d46f71e@samsung.com>
 <651a84ff.050a0220.51ca9.2e91SMTPIN_ADDED_BROKEN@mx.google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <651a84ff.050a0220.51ca9.2e91SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/23 2:55 AM, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove sentinel from vrf_table
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  drivers/net/vrf.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



