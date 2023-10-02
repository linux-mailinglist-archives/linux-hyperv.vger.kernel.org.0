Return-Path: <linux-hyperv+bounces-383-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A07B4DB5
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 0543DB20C04
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91C16FB9;
	Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A263BD
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F46CC433CC;
	Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696236795;
	bh=RreaA691Muoq1tBz/Pv/giyNwquLQXAxE/PNRJuaEjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sx2UpIMN8E2QXKGVQUFVNnMJ0GEtgZD0Ul+FoiWvMA4RYfG3dNoIZyjt1rKnTkOus
	 geyWn8BCmbb8IAOXXPPHU8p+gGM7OxFXK9KTqmOr7Ayx8+mkbIDznJkOD9R20ymkRh
	 urH65fP0+QOmmxKDcS+PmY1LQ6TIP4MG96NoorpTG6HVALms2t9G61U+avKtZf0APE
	 9+8GVHCSube0tamnDpXZPlQMIkWbiquO/LnJkFbiGiW3HQrAlzNKu/9DOj5yUThcuo
	 9N2zPQqenavT+rFipo4Ez0biDf4IUxN1i2hJqsdN2KDGJOm7HjbF31TLkAYu36Thep
	 T/+Z9BiGp08ew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0450BE784B1;
	Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Mon, 02 Oct 2023 10:55:21 +0200
Subject: [PATCH v2 04/15] tty: Remove now superfluous sentinel element from
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
 <20231002-jag-sysctl_remove_empty_elem_drivers-v2-4-02dd0d46f71e@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=820; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=b0aUzVe6G3QsR0W+3zYsGPcsPzyZspe7CT2B0wHyj9o=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGoV8JnfhmuDA3unWN1NVJZzrIz4lKZhdzp0HC
 lZ53f5+cRWJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqFfAAKCRC6l81St5ZB
 TwWTC/9eTUpJYa6b//Qxyv7U8gNWDnOx45RNIwyZjsQma+SD8AdbjbV6+B6BSuatpSFrt18HnY+
 vYpazQWS+IMuefi8tSCcVhSh9CG3PDLzT/eoK63p5PAFwkSamtfxcz5ti6jPzxAmIld2IWdZbdg
 fBjpnYqdRq3qt1/AfkaHHXFShI6uF5rLdwHvkGMd2A6+2EAfN1H7LrxhTTixfwLWrbbFxCvzXXD
 j7JbesmcmNk2u/StA9EEJUbqF7RA4e6WzuK074sB6Gd+E/jgjDWrUC2t8evThm+fsUkSK+5PXv3
 +h+E/QZEo5ueVCoUGHCRr2cA3xjXCInSPBUmsrCjVPXkvgdz0pidGY5lS5p7mz7XYzHPqzww00q
 kO+FFkLZ7da8MHGG/74o43NlhmgY6QKnmPHp461XJInY86fF9w/gZ9o2fHQ6whRiv9XVB8hxTF/
 ITzpqyfwdwSRlC8qVn87Ha2TbGtunBEsDmBv8kYTgthTWJkYRTuIu7Gw9wf6DgNNButHs=
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

Remove sentinel from tty_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/tty/tty_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8a94e5a43c6d..b3ae062912f5 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3608,7 +3608,6 @@ static struct ctl_table tty_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{ }
 };
 
 /*

-- 
2.30.2


