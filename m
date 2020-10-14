Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CA328DD8D
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Oct 2020 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgJNJ0V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Oct 2020 05:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727165AbgJNJZt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Oct 2020 05:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602667548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcu5CBTxuJW65VmqyywXr6V7SM+/ZXJMA86sRFN+g+0=;
        b=FBZ6vBZ/SvUnaF63zpp+VXFMWTL5rwh/atrj/VlMkWpVbzprjpfPJXCtDuDebuPI81qc0Z
        0J8JBenEb8VOVYQ0+WDQbhdw4nvGt1xbEIpc5lptg2GJQzC9ZfVT8jnbeNTCngVssFvC3P
        gzfUqvS9JwEucedzy3VT/hz1jT/oyLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-v_wiZVNiPGSVoT7LqaaoeA-1; Wed, 14 Oct 2020 05:25:46 -0400
X-MC-Unique: v_wiZVNiPGSVoT7LqaaoeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0624A81C464;
        Wed, 14 Oct 2020 09:25:45 +0000 (UTC)
Received: from kasong-rh-laptop.redhat.com (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 868935C1BD;
        Wed, 14 Oct 2020 09:25:40 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, kexec@lists.infradead.org,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH 2/2] hyperv_fb: Update screen_info after removing old framebuffer
Date:   Wed, 14 Oct 2020 17:24:29 +0800
Message-Id: <20201014092429.1415040-3-kasong@redhat.com>
In-Reply-To: <20201014092429.1415040-1-kasong@redhat.com>
References: <20201014092429.1415040-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On gen2 HyperV VM, hyperv_fb will remove the old framebuffer, the
new allocated framebuffer address could be at a differnt location,
and it's no longer VGA framebuffer. Update screen_info
so that after kexec, kernel won't try to reuse the old invalid
framebuffer address as VGA.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 drivers/video/fbdev/hyperv_fb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 02411d89cb46..e36fb1a0ecdb 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1114,8 +1114,15 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 getmem_done:
 	remove_conflicting_framebuffers(info->apertures,
 					KBUILD_MODNAME, false);
-	if (!gen2vm)
+
+	if (gen2vm) {
+		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
+		screen_info.lfb_size = 0;
+		screen_info.lfb_base = 0;
+		screen_info.orig_video_isVGA = 0;
+	} else {
 		pci_dev_put(pdev);
+	}
 	kfree(info->apertures);
 
 	return 0;
-- 
2.28.0

