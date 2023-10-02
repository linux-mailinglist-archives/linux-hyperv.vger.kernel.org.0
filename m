Return-Path: <linux-hyperv+bounces-389-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6587B4DCC
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 10:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7904E282103
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5167DC2EB;
	Mon,  2 Oct 2023 08:53:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCC6C2CC
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Oct 2023 08:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D5DBC32789;
	Mon,  2 Oct 2023 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696236796;
	bh=hrtUSBUCIyA9Xh0J2iqcV4rs/NRa5ErFNI1zyion65E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=igvGXr7OERaYZNfGyUIFtp2Q7kMPNrHAWsrMMnl5p7MsQtKv9Po/DSZFJ5uPrgpJ3
	 v/qQil/ibb6NbmpzeMSq/8El/gUPR0ioHl8RGNv4b9t5idX2rSzd6qX6u8urBFNKNc
	 0M0ZL8l9JPtiD/iUxNsiutTpOe3P8QZ38ay43bihunK/z4g4ZahiyRoK33sPyQ9xJb
	 UTdffDYaP87PUvPbYytP7teBFUaSkwU5X8iVs9zp3r/iaUSB6UrhUBf6AlvsH097eu
	 QojU9Xh8Pl58kl0FzCcARVvO+csbyxxGFKkkpayKuL6S4NvjsZrH4wziwddy9JFjil
	 nBj4ko+yP1xAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3695E784B2;
	Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Mon, 02 Oct 2023 10:55:30 +0200
Subject: [PATCH v2 13/15] raid: Remove now superfluous sentinel element
 from ctl_table array
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: =?utf-8?q?=3C20231002-jag-sysctl=5Fremove=5Fempty=5Felem=5Fdrive?=
 =?utf-8?q?rs-v2-13-02dd0d46f71e=40samsung=2Ecom=3E?=
References:
 <20231002-jag-sysctl_remove_empty_elem_drivers-v2-0-02dd0d46f71e@samsung.com>
In-Reply-To:
 <20231002-jag-sysctl_remove_empty_elem_drivers-v2-0-02dd0d46f71e@samsung.com>
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
Cc: Joel Granados <j.granados@samsung.com>, linux-kernel@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-serial@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-rdma@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
 netdev@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=e2yFW2EFHsQwkB5PotCjZgXoqNEEyAhbQnmUD5zfaNQ=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGoV/Vs6zaJYkusRcda3GvHqHD8FkD0XllyxOR
 gpkY40Yv/6JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqFfwAKCRC6l81St5ZB
 T+5+C/9PG7Hu/Q+dsKCXDvY5Iy6CwCHH/JFsZ4t/aJUGwdfzUbDixMixD2mtLH27N3jGk6EsP+f
 TuT8qWNicQP6gZrT5r/weMxtSLFJObHVzSmm7laysrDcBw992wSR/bSaa22COnNEBPqIC8esU0Q
 pGb1W4km4w2r1wQCyP4ciYMGGrzDlkkP9Ftg7+PrhQgUzqHwcgNSiQkAYaMrHNx9aUE7pN65eqW
 S6r5qG3U+doLXvkDZyRHPifN3KC63mSs2PpDc/NX3fp5y86xBczeVNYidlNzguQK2QuZ+FROlNb
 xakkCrxK6U7rjUfK5FHvHYSSOStbsSOmjPmzhbCIYDHB/I8zWeGPGIKRJzP1C4yRCEl77u49B/h
 Suqp6Db8KacQipTzrj5zKGnSXTTwjMaoljlvWzrd0uCEgyFiJEbdb/BYb8M0GeDb+Kf8+KLxzWD
 Q6+VM9vMi9hHwjythRlXiqljd0T1YtM5HwY8rmd392dMC+XgoD9p38YjDqsyBZSkPCk04=
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

Remove sentinel from raid_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/md/md.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a104a025084d..3bdff9e03188 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -305,7 +305,6 @@ static struct ctl_table raid_table[] = {
 		.mode		= S_IRUGO|S_IWUSR,
 		.proc_handler	= proc_dointvec,
 	},
-	{ }
 };
 
 static int start_readonly;

-- 
2.30.2


