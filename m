Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F428DD91
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Oct 2020 11:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgJNJ0V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Oct 2020 05:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbgJNJZq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Oct 2020 05:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602667545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AF5EHyVWVFXLN/yYF6ryGSvyFHTXybRiC8wgcAhI7fM=;
        b=AktYIYfZHXBnW+ChZuC0cLlYCfA8EOBKde5IMP2SN3aTzq+o/RieFQkdbnyVSN14qFuo13
        /OpaA/8tcUrjM7yay4QNULwM1CMQeWtn6EPblyd/6KNidC60amvqA8ZCnogpQofOPB1j83
        d0IMWXbzU4EHvXZjXqU1yAf4qo3Eydo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-jT22B8ypPYWoRId9bd6cqQ-1; Wed, 14 Oct 2020 05:25:41 -0400
X-MC-Unique: jT22B8ypPYWoRId9bd6cqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A7E518A8221;
        Wed, 14 Oct 2020 09:25:40 +0000 (UTC)
Received: from kasong-rh-laptop.redhat.com (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B7525C1BD;
        Wed, 14 Oct 2020 09:25:30 +0000 (UTC)
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
Subject: [PATCH 1/2] x86/kexec: Use up-to-dated screen_info copy to fill boot params
Date:   Wed, 14 Oct 2020 17:24:28 +0800
Message-Id: <20201014092429.1415040-2-kasong@redhat.com>
In-Reply-To: <20201014092429.1415040-1-kasong@redhat.com>
References: <20201014092429.1415040-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

kexec_file_load now just reuse the old boot_params.screen_info.
But if drivers have change the hardware state, boot_param.screen_info
could contain invalid info.

For example, the video type might be no longer VGA, or frame buffer
address changed. If kexec kernel keep using the old screen_info,
kexec'ed kernel may attempt to write to an invalid framebuffer
memory region.

There are two screen_info globally available, boot_params.screen_info
and screen_info. Later one is a copy, and could be updated by drivers.

So let kexec_file_load use the updated copy.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 57c2ecf43134..ce831f9448e7 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -200,8 +200,7 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 	params->hdr.hardware_subarch = boot_params.hdr.hardware_subarch;
 
 	/* Copying screen_info will do? */
-	memcpy(&params->screen_info, &boot_params.screen_info,
-				sizeof(struct screen_info));
+	memcpy(&params->screen_info, &screen_info, sizeof(struct screen_info));
 
 	/* Fill in memsize later */
 	params->screen_info.ext_mem_k = 0;
-- 
2.28.0

