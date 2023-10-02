Return-Path: <linux-hyperv+bounces-386-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D46C7B4DB9
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 10:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DD1E1282355
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21768C19;
	Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA4D7493
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E83FC4E67B;
	Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696236795;
	bh=vDlxMU2ggFFcgL4XVv7yaCla84NzDst78pAlmrI/LAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pR95+O9r6nUzq07c9kPGKb7Ab0VcY5+68ndSSzB+hZmwZYikEf3FKE5QZgbbuqjOX
	 gQkhguZwdsurCaU0axfIZ2F0cJCq86v09nWDCYqoJnOhNSunu1At9WlawEgkBrEmJ6
	 y18G/0sKMdEFBxdOakpL3K6ARrEuVanraUCM76n/OBLvRpO3S0uhlUJVkFeuWm+fyr
	 dbr8FI1IRqLxTOLySLXMasu08oJ1w1pZXHhh4+kaXfndJ8OZR17RetwZax4Z6ehYkJ
	 mIoVTZonmVbDcGCi8ny+uoSKjBM1DIy75fzJacAsTb3IqeKffbenQJRDWZ7+Dfqjc4
	 7r/qhjuBtwo0A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B1FE7849A;
	Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Mon, 02 Oct 2023 10:55:26 +0200
Subject: [PATCH v2 09/15] char-misc: Remove the now superfluous sentinel
 element from ctl_table array
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20231002-jag-sysctl_remove_empty_elem_drivers-v2-9-02dd0d46f71e@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1339;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=Kv0ap7oOhCIEujO7K32kNHT+ZxUGAQsjjs8+/enag5M=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGoV+isCI8TDO6pwR+wgikdJs6dLv5S5QCOB04
 iOxWZrSGSiJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqFfgAKCRC6l81St5ZB
 T6oTC/9qOUC9BOwrcAbb8+8X5NEMfhYEKBwZOjn0qP7z2HP9F0B0s13QbRcV+nD/AboNml1SyV1
 2bME5eSPBRhDk/FgUi2dHVoWST0piu5f+xZVAdCGk0dlm6zx066OrZgELiJpoohNDrDPt3Hw74l
 vDFg1cmFZeVWLG+9hQVfG+0ip5WPINFZL6HG5Qaf5vQovahB6Axer95+p066sCI/hydwE7wEmQW
 AaBpPNfAYpiEL3HtJ935jxFkTOmK8sqEwQTXsN1aJcHVhbXpAwOog7xO+DfU6DOBHTdb4MVBOxq
 BDdLiqegmjac+IlK2slz/WfvUKW0V+2LZN7aJ0/GqoMforwaGZwvUhwn34nmenlx7NcpDwgIKDx
 orVBtck2IN7tetdBhNLpoy3r7xDl7WRjm3f3xIxDXcUNqlOY9x1VyHKww5KiFk49KJ9UPmc8tKT
 3ACEiDi7UvwEFAfJwF4Zc34OpSkdkpY3PQGUWRU0h2+aTGNKyDRzq42XfqrCcpxTHv5xA=
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

Remove sentinel from impi_table and random_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/char/ipmi/ipmi_poweroff.c | 1 -
 drivers/char/random.c             | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 870659d91db2..941d2dcc8c9d 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -656,7 +656,6 @@ static struct ctl_table ipmi_table[] = {
 	  .maxlen	= sizeof(poweroff_powercycle),
 	  .mode		= 0644,
 	  .proc_handler	= proc_dointvec },
-	{ }
 };
 
 static struct ctl_table_header *ipmi_table_header;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3cb37760dfec..4a9c79391dee 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1683,7 +1683,6 @@ static struct ctl_table random_table[] = {
 		.mode		= 0444,
 		.proc_handler	= proc_do_uuid,
 	},
-	{ }
 };
 
 /*

-- 
2.30.2


