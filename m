Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FAD37B856
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 May 2021 10:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhELIsI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 May 2021 04:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231254AbhELIrt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 May 2021 04:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620809201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o2vKHOZEryLEQCCxZtV6KAbvFC9hG/G6U3+3Dopo/KU=;
        b=QiP3sgGx2cENwz8KGF8AxskYueXXCG1IwvNuoMQR3QYDZ/EnoDGpwfqiOq6V+87XhmXkFP
        Pe2/zdVLeaA95YFhE7WlGZicEgq1z4/+nQfS8zAD/Y3G/Ztzv/8RQRI+4911//Gy8dUgWI
        ro3Zebuc1oiUEv72dCpHbyLnOg1Xk/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-5rYu9DHWPXSwdi5nERih_A-1; Wed, 12 May 2021 04:46:39 -0400
X-MC-Unique: 5rYu9DHWPXSwdi5nERih_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C1F21007467;
        Wed, 12 May 2021 08:46:38 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.193.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41A02BA6F;
        Wed, 12 May 2021 08:46:32 +0000 (UTC)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/hyper-v: Re-enable VDSO_CLOCKMODE_HVCLOCK on X86
Date:   Wed, 12 May 2021 10:46:30 +0200
Message-Id: <20210512084630.1662011-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Mohammed reports (https://bugzilla.kernel.org/show_bug.cgi?id=213029)
the commit e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO
differences inline") broke vDSO on x86. The problem appears to be that
VDSO_CLOCKMODE_HVCLOCK is an enum value in 'enum vdso_clock_mode' and
'#ifdef VDSO_CLOCKMODE_HVCLOCK' branch evaluates to false (it is not
a define). Replace it with CONFIG_X86 as it is the only arch which
has this mode currently.

Reported-by: Mohammed Gamal <mgamal@redhat.com>
Fixes: e4ab4658f1cf ("clocksource/drivers/hyper-v: Handle vDSO differences inline")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/clocksource/hyperv_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 977fd05ac35f..e17421f5e47d 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -419,7 +419,7 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 }
 
-#ifdef VDSO_CLOCKMODE_HVCLOCK
+#ifdef CONFIG_X86
 static int hv_cs_enable(struct clocksource *cs)
 {
 	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
@@ -435,7 +435,7 @@ static struct clocksource hyperv_cs_tsc = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.suspend= suspend_hv_clock_tsc,
 	.resume	= resume_hv_clock_tsc,
-#ifdef VDSO_CLOCKMODE_HVCLOCK
+#ifdef CONFIG_X86
 	.enable = hv_cs_enable,
 	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
 #else
-- 
2.31.1

