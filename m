Return-Path: <linux-hyperv+bounces-385-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8197B4DB4
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C630028218F
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4579E4;
	Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC00B63C4
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88FECC32776;
	Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696236795;
	bh=amz0lmR6ktjSFYbXFf8SJ/rD/LGezf37esDcBUcG4VA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ivo+qQiovpQQJq0vFwPkgisug1Pppm96a/bVqga8oaV4kgvEby500kN2Dhw1ukZNg
	 +q/m0XC+RByxKFw1CgR1L/RGthyJyQCHLdTbejDTWXaxQuqYA7Zcxa4zich+rCjo53
	 Ak/b8FhOqr3Nd/0oKFNdytahECQM3W04/BwpLjss74/NFOWkqovAALiGP5i3mWn/7p
	 68dCoKFe1ZkRjyjhHlua+jyGPELXpRm/+3tI9gcKKD9fhW+wmFz/FLNZRsvjfnd1yR
	 gfZeyuxKySJXmB+tspGrEdZn4VULNRVO6fRSbJPTuJ90m/yelcjvEL0MAGNFxyf46o
	 8pYt9MzyjQQBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E722E784A4;
	Mon,  2 Oct 2023 08:53:15 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Mon, 02 Oct 2023 10:55:25 +0200
Subject: [PATCH v2 08/15] infiniband: Remove the now superfluous sentinel
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
 <20231002-jag-sysctl_remove_empty_elem_drivers-v2-8-02dd0d46f71e@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=gz7T61c3mpYSXDkYtspjqyukqPQ8G3NAC15+ZhhmUg8=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGoV9Z1pjf+iYaTcrpDqomSqDrWKWFayUHCWw9
 +AUAffywyqJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqFfQAKCRC6l81St5ZB
 T/JFC/9TTtJdLb2PgHoU/qPORU0LWDxrdSEgO8uCjljCKGZhuFpPUKZbEd0rpHrNpki2b8pKynT
 MLcOr1s9ad+5SDCpUH/yLdJliUTWWvOtoMlXpO48uDR59mZX0//MP5HkHzjmetk/8lTfgT5BO6l
 Qn5dUfYq+irkQRBRjgRMHwVyc4A4crKuZEE9Tct8092ObCV3YvfOgQm7zQMbfR29PHrnL+uPHE5
 sNi3FYH38aLdW399HO1ONj4ssyAcOKq5nEXFzCmX/u6dgWVruM+h4AvbhaWsrIDITXM6MNBdwUf
 i5spcncMQQ11S0U8mtiKNH/7XHqmJBSGNBCVX9VtvpUNfvHMRDpShUTcduVGg4Vs9IR8Im+0yuT
 fMV19bF+hlgs7vNHYDKVGZe+h9vlbcMsvnQZWkrlFVvlUj6yUxi9sw+K1QrW4UaCo6f7vt/1i46
 Q/Fu7wsyyGFTQAHbDASRb4cCDdYx7GuUIvwS4VXhlHj3fhXILPrJcYZfg3+CsF5zKhFfA=
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

Remove sentinel from iwcm_ctl_table and ucma_ctl_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/infiniband/core/iwcm.c | 1 -
 drivers/infiniband/core/ucma.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 2b47073c61a6..0301fcad4b48 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -111,7 +111,6 @@ static struct ctl_table iwcm_ctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{ }
 };
 
 /*
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index bf42650f125b..5f5ad8faf86e 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -71,7 +71,6 @@ static struct ctl_table ucma_ctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{ }
 };
 
 struct ucma_file {

-- 
2.30.2


