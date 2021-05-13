Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0737F394
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 May 2021 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhEMHeX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 May 2021 03:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231653AbhEMHeI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 May 2021 03:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620891178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+Fi/o6bixFJhSZW4pML3RZ/w8HhogNfUgd+9rsduNXs=;
        b=cfbYG1j+9AV5XjVLRnkpPSxzOu3aI1FriN1JNhHwZdoG77aUeab+uA8iS9vwEtTZdu7u/s
        /cKlRt/Y5NmoO9q0FbQt0Xlh8Asgt2p3nVzNpKnvlTlrrY+Dy7s4WvN3WSJEmoiQBuDByd
        fEcr6x0AXPDSxvJ85nRKDNHjgP4ZVAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-xCkUuSzUMlaInR0QreUX6A-1; Thu, 13 May 2021 03:32:56 -0400
X-MC-Unique: xCkUuSzUMlaInR0QreUX6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD8A1107ACF6;
        Thu, 13 May 2021 07:32:54 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.193.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8274F5D736;
        Thu, 13 May 2021 07:32:47 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mohammed Gamal <mgamal@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] clocksource/drivers/hyper-v: Re-enable VDSO_CLOCKMODE_HVCLOCK on X86
Date:   Thu, 13 May 2021 09:32:46 +0200
Message-Id: <20210513073246.1715070-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Mohammed reports (https://bugzilla.kernel.org/show_bug.cgi?id=213029)
the commit e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO
differences inline") broke vDSO on x86. The problem appears to be that
VDSO_CLOCKMODE_HVCLOCK is an enum value in 'enum vdso_clock_mode' and
'#ifdef VDSO_CLOCKMODE_HVCLOCK' branch evaluates to false (it is not
a define). Use a dedicated HAVE_VDSO_CLOCKMODE_HVCLOCK define instead.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Mohammed Gamal <mgamal@redhat.com>
Fixes: e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO differences inline")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/vdso/clocksource.h | 2 ++
 drivers/clocksource/hyperv_timer.c      | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/vdso/clocksource.h b/arch/x86/include/asm/vdso/clocksource.h
index 119ac8612d89..136e5e57cfe1 100644
--- a/arch/x86/include/asm/vdso/clocksource.h
+++ b/arch/x86/include/asm/vdso/clocksource.h
@@ -7,4 +7,6 @@
 	VDSO_CLOCKMODE_PVCLOCK,	\
 	VDSO_CLOCKMODE_HVCLOCK
 
+#define HAVE_VDSO_CLOCKMODE_HVCLOCK
+
 #endif /* __ASM_VDSO_CLOCKSOURCE_H */
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 977fd05ac35f..d6ece7bbce89 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -419,7 +419,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 }
 
-#ifdef VDSO_CLOCKMODE_HVCLOCK
+#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 static int hv_cs_enable(struct clocksource *cs)
 {
 	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
@@ -435,7 +435,7 @@ static struct clocksource hyperv_cs_tsc = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.suspend= suspend_hv_clock_tsc,
 	.resume	= resume_hv_clock_tsc,
-#ifdef VDSO_CLOCKMODE_HVCLOCK
+#ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 	.enable = hv_cs_enable,
 	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
 #else
-- 
2.31.1

