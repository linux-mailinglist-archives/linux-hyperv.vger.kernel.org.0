Return-Path: <linux-hyperv+bounces-310-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFB7B1DB9
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 814C4283331
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD903B7A7;
	Thu, 28 Sep 2023 13:20:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5113B78A
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Sep 2023 13:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40FAAC4E75A;
	Thu, 28 Sep 2023 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695907237;
	bh=pdmmOE3H0wl7JFnvUs0cXne6T7FXMEXGOOHMgYRq81A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=McrTLgHDanDgnZWCaB/eneBszGhElISFiQo6HjDYeW3/iQ7vK4TEsIr9rCVBFP7VV
	 jJrpav4wOkhdr9+H0n9dA07uVfAIbW4bu7uDORQLms5gr2BVHM95p8nhjbshPidbcm
	 oGKfzbqnNsfNHDx8xl4r04xNGUmbWlrXE+3JrTurNRAyLwAQPDcUD4TVwX1my9st6c
	 myBX24/Y3sM0TgM9G24BHP2iiYSVWJw7WofK5uW4U8Q4ncZokrEmf/BuZ0/5xBI+ax
	 JcQkdY9Cq2AxLm0PimNb5cKLGQPe5VlDOtR7vbZgHrx72JdJLBoL1XloPEp/OtMHBM
	 qxf6Ws66a3HNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E4FE732D1;
	Thu, 28 Sep 2023 13:20:37 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Sep 2023 15:21:37 +0200
Subject: [PATCH 12/15] fw loader: Remove the now superfluous sentinel
 element from ctl_table array
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: =?utf-8?q?=3C20230928-jag-sysctl=5Fremove=5Fempty=5Felem=5Fdrive?=
 =?utf-8?q?rs-v1-12-e59120fca9f9=40samsung=2Ecom=3E?=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=IR+b7PptXcF/Oyt7GII4OytQxFoRCLXOyY8FOTQVz/s=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlFX3fTo3kXpUY6L3nYABmnsBNawGT28Z3SlPam
 YfpaY395dKJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRV93wAKCRC6l81St5ZB
 T8TaC/9cDBQVLZYH4Fdmw6vKuueXYd7pABhWuZZOmPgU8kP984zBWEF8yAPOxtCqZKnUQVkYDT9
 waw5OPrbtH7Cj5Ljs6zW7XQjbeHOXi/mCJnfxYKOJYgP46vtfuBJLls3tXnVd1YYOnCm9RWYr37
 JtU0m7McLmcwBDou77zQKrmFA2NQLgVPt8w+q+UgXo1XKtCuiLSu3G9pqUkcUZWNbDt2slckrdI
 D3PL+UVlpD9hz7SXyy4dbOqOMMBH5GNGZ+jLrM00pLwb1cKDqFFmIS9/6YCc7Mi2SXUpAaICEdw
 296JfYljQ93faYsdJfS/vz1mP0qOl8oxlwNN3MB/zLBT51rkA4CkBz3o7Uc2UHMNA+XvKjpEsB0
 YT/Sex/r1M8Rs2guSZE0bqzXIpOmgF/aIgLP6mpRS4H7kVLn7641YhjsAGpapmRxcwDowR1yYks
 LUkw71CcusI5v074k5FRJK5s8cHeKcBUgr/I21329k6u29vxMfRVdPlR/ZQILG6HhQqHg=
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

Remove sentinel from firmware_config_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/base/firmware_loader/fallback_table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index e5ac098d0742..968aef19e118 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -43,8 +43,7 @@ static struct ctl_table firmware_config_table[] = {
 		.proc_handler   = proc_douintvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{ }
+	}
 };
 
 static struct ctl_table_header *firmware_config_sysct_table_header;

-- 
2.30.2


