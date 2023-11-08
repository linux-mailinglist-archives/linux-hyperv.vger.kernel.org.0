Return-Path: <linux-hyperv+bounces-768-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022DD7E5994
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 15:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72106B20CD7
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DE62FE38;
	Wed,  8 Nov 2023 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxaxzQlz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA642FE36
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 14:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72196C433C8;
	Wed,  8 Nov 2023 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699455509;
	bh=n/5YMcECTbkGb6OIl60kw0HV/aeCmVYYSLfcJLtQke0=;
	h=From:To:Cc:Subject:Date:From;
	b=BxaxzQlzzgzah4q3Rh46fm22Wea2D6PMhRF+M/Z6V7P9WdTCxzDZLAh1/afga9Pf3
	 mbVZkmuG7VjCjasBW+5ZpOjJ+KcRXp5kDm4Z4a5TY04isCKUXs5vcnNmo7xmQi1HD9
	 r+OYjsa7WqOPqoQkQ6H1M/JuVQyCInIN/F3NBX1/xZqHtnCrrO5Syq2Otr1+dDNPTf
	 P5XRwtNiT9egVLCUCdShArCvTZy555+hvNn+KgGgdXpAa8/fA0AbBpl9QE7UxjQI8b
	 J2diMU8BzAaoIYNgH9gGgVM1XTWM9s4YoGpKBMDsoAAHR1KUojHLGXwtOSudivEzQ4
	 EyOh/wEQ655Ag==
From: Arnd Bergmann <arnd@kernel.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Michael Kelley <mikelley@microsoft.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dawei Li <set_pte_at@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: hyperv_fb: fix uninitialized local variable use
Date: Wed,  8 Nov 2023 15:58:13 +0100
Message-Id: <20231108145822.3955219-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_SYSFB is disabled, the hyperv_fb driver can now run into
undefined behavior on a gen2 VM, as indicated by this smatch warning:

drivers/video/fbdev/hyperv_fb.c:1077 hvfb_getmem() error: uninitialized symbol 'base'.
drivers/video/fbdev/hyperv_fb.c:1077 hvfb_getmem() error: uninitialized symbol 'size'.

Since there is no way to know the actual framebuffer in this configuration,
just return an allocation failure here, which should avoid the build
warning and the undefined behavior.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202311070802.YCpvehaz-lkp@intel.com/
Fixes: a07b50d80ab6 ("hyperv: avoid dependency on screen_info")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/hyperv_fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index bf59daf862fc..a80939fe2ee6 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1013,6 +1013,8 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 	} else if (IS_ENABLED(CONFIG_SYSFB)) {
 		base = screen_info.lfb_base;
 		size = screen_info.lfb_size;
+	} else {
+		goto err1;
 	}
 
 	/*
-- 
2.39.2


