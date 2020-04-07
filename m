Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC871A12B2
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2020 19:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDGR1v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Apr 2020 13:27:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:15187 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDGR1u (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Apr 2020 13:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586280469;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=y+glctGf8I9d0ulLgSiaydzTvNcHv3FkPBRQdNMb17Q=;
        b=bPyp9X0UHthssng+sAVvebVKh1C4p0hY07ZF05tKJk8J+GN4O7O4G210UtYKoD4fk1
        4A0KuXMireNZDLpBpSWP64YDENJjE8VsFIU9HC9MW1F5A14nJukwPZ2k0i4xYlDBlBoY
        cQlhmewUO6bQwjNRNPSOyabtmLWyVQDk/8edzxNk7dskA1UoKdHl2ycnr9ck9HLCWBjA
        0U8sjfIfB+Xf9MKAfUE9vWZm3vGa+ZVObmrntKB78hdFTygKtiXTtHbTFvyYJU2QBbdn
        Hsj+ueDb+ONh5GxrhpPZB1zBslYdvGFvKwiCRVhd5V2FY7FYgC2UAWi1aePJPgdAOo7l
        z+XA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS32kg"
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id 204e5fw37HRmhOG
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 7 Apr 2020 19:27:48 +0200 (CEST)
From:   Olaf Hering <olaf@aepfle.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Olaf Hering <olaf@aepfle.de>
Subject: [PATCH v1] x86: hyperv: report value of misc_features
Date:   Tue,  7 Apr 2020 19:27:39 +0200
Message-Id: <20200407172739.31371-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A few kernel features depend on ms_hyperv.misc_features, but unlike its
siblings ->features and ->hints, the value was never reported during boot.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 arch/x86/kernel/cpu/mshyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index caa032ce3fe3..53706fb56433 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -227,8 +227,8 @@ static void __init ms_hyperv_init_platform(void)
 	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
 	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
 
-	pr_info("Hyper-V: features 0x%x, hints 0x%x\n",
-		ms_hyperv.features, ms_hyperv.hints);
+	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
+		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
 
 	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
 	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
