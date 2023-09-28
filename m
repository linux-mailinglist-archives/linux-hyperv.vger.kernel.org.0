Return-Path: <linux-hyperv+bounces-300-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB39A7B1D90
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 15:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7495728204E
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 13:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB413AC20;
	Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0838DD8
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C67AC433CB;
	Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695907236;
	bh=j/2eYg//PJ1GbwZhUAaOz18f7AbRQ4O+NNbYuKt3mq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WRmGiG4AsourgR8PePRCUHkmrHTjGa0GLOwLlRslD9y6Gxglwb/sKdeaYMIiM+m2U
	 HCEzm7JFG1uUimaSxcCst+jqGOAk+LPd5ofcZjp7Dr/INDF6+dXWJzwECnaIlHFcRw
	 LEZBmRJGbn8CUOMTRZ7oRD405kgYVjEhh4TF32uTBtIqzoTuo9rHeIERNGqM3IsJTd
	 E3AOMsUDv9ORWkadDdcnKmhR9zz5DqiW7MH0ddnh45htLMFfazKbEwb6eN+rYXmR1r
	 qDAClZUoaj39Nqk9YphBEF7rdkqlcU4nn2uOKk0jMqKnWUeeRkM0qbnycd10U9Ld3x
	 iYyDOHPWNIO8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF38E732CF;
	Thu, 28 Sep 2023 13:20:36 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Sep 2023 15:21:26 +0200
Subject: [PATCH 01/15] cdrom: Remove now superfluous sentinel element from
 ctl_table array
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20230928-jag-sysctl_remove_empty_elem_drivers-v1-1-e59120fca9f9@samsung.com>
References:
 <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
In-Reply-To:
 <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org, 
 josh@joshtriplett.org, Kees Cook <keescook@chromium.org>, 
 Phillip Potter <phil@philpotter.co.uk>, 
 Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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
 "Jason A. Donenfeld" <Jason@zx2c4.com>, David Ahern <dsahern@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
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
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=qSsthXDIpINcD2xITRy2TOv8R22x0qMRyMvqjqljpm0=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlFX3bxBTXVZalX2OxDj+67GtOqe8IxIGJwSLF1
 iLnIskFGxCJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRV92wAKCRC6l81St5ZB
 T9hZC/wJ7EgDM6vrFYYmNrYQRkQQUSj4jjafOUPMhsZdNSqZu4kVh8xyDtcKgxhctnq+INR87Nr
 dwm3eyWcssi6Zi3rFSiOI9vdZ2zESFY5OJ4dNUGBRAofgcVpLAvu4ZYQeXaCx7XzSIlzsCyd/dg
 +Ym3KCHhaY2KSd0wJE8MuZN8/J6RxSwT1SyXgnBMjieGNWnw/mxbi7RnSHxARqjAMrAacvr1pUr
 vqS9lxYeOv5aKInqTkx7sBu2iXx1/kgQGA7MNqvKgrgooVkICokoKPgcDvDR1nWTDzrnUzKEAa4
 LroyVmn9iYYNuuXhhBl1BVgWeXVdkN7/r1r69wCAZWcVaadyFOoMNLxRsOvwsw6kynVTfbNOo+4
 OxoS60XgqKVygBBx6urNukqqtiEYIzpDpU/QU00wUDSoHwIOyq4geKJEjTui+QORzF2/rfMdAii
 IGAGzQM4oARjvwY26lxvyJdVBd4NtwRMk5g7yxIYVwfBC4G3Y6+/HFF2COHYzGYBEU5es=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel element from cdrom_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/cdrom/cdrom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index cc2839805983..451907ade389 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3654,8 +3654,7 @@ static struct ctl_table cdrom_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= cdrom_sysctl_handler
-	},
-	{ }
+	}
 };
 static struct ctl_table_header *cdrom_sysctl_header;
 

-- 
2.30.2


