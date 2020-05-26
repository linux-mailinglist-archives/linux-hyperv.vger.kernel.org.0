Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625851CFA06
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2020 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgELQCB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 May 2020 12:02:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40049 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727831AbgELQCB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 May 2020 12:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589299320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nL6n0gs44aSe+c4xP2RS6AmyhHuCE1lHHuLbFzSoNGo=;
        b=FacGXlpVTipMCzw5E65rtqe8Cs412aCVT9+1x6ZyhwGaeF4J+CDpxmQpYFhDUGd5KTAnmd
        M7lADnX1RG9DtF0el8rPIdqJ6xIDmLaye3K9L7AaQuFTHtEoR9Y3EeNM+RwP2D7za5xayx
        lvG2pcaNoGBCzswl7E6E9o+xGs4h2rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-yGbGbgOGNEWr2HXPNBc0CA-1; Tue, 12 May 2020 12:01:58 -0400
X-MC-Unique: yGbGbgOGNEWr2HXPNBc0CA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09855800687;
        Tue, 12 May 2020 16:01:57 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A42EE60C05;
        Tue, 12 May 2020 16:01:54 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: [PATCH] x86/hyperv: Properly suspend/resume reenlightenment notifications
Date:   Tue, 12 May 2020 18:01:53 +0200
Message-Id: <20200512160153.134467-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Errors during hibernation with reenlightenment notifications enabled were
reported:

 [   51.730435] PM: hibernation entry
 [   51.737435] PM: Syncing filesystems ...
 ...
 [   54.102216] Disabling non-boot CPUs ...
 [   54.106633] smpboot: CPU 1 is now offline
 [   54.110006] unchecked MSR access error: WRMSR to 0x40000106 (tried to
     write 0x47c72780000100ee) at rIP: 0xffffffff90062f24
     native_write_msr+0x4/0x20)
 [   54.110006] Call Trace:
 [   54.110006]  hv_cpu_die+0xd9/0xf0
 ...

Normally, hv_cpu_die() just reassigns reenlightenment notifications to some
other CPU when the CPU receiving them goes offline. Upon hibernation, there
is no other CPU which is still online so cpumask_any_but(cpu_online_mask)
returns >= nr_cpu_ids and using it as hv_vp_index index is incorrect.
Disable the feature when cpumask_any_but() fails.

Also, as we now disable reenlightenment notifications upon hibernation we
need to restore them on resume. Check if hv_reenlightenment_cb was
previously set and restore from hv_resume().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_init.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index fd51bac11b46..acf76b466db6 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -226,10 +226,18 @@ static int hv_cpu_die(unsigned int cpu)
 
 	rdmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
 	if (re_ctrl.target_vp == hv_vp_index[cpu]) {
-		/* Reassign to some other online CPU */
+		/*
+		 * Reassign reenlightenment notifications to some other online
+		 * CPU or just disable the feature if there are no online CPUs
+		 * left (happens on hibernation).
+		 */
 		new_cpu = cpumask_any_but(cpu_online_mask, cpu);
 
-		re_ctrl.target_vp = hv_vp_index[new_cpu];
+		if (new_cpu < nr_cpu_ids)
+			re_ctrl.target_vp = hv_vp_index[new_cpu];
+		else
+			re_ctrl.enabled = 0;
+
 		wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
 	}
 
@@ -293,6 +301,13 @@ static void hv_resume(void)
 
 	hv_hypercall_pg = hv_hypercall_pg_saved;
 	hv_hypercall_pg_saved = NULL;
+
+	/*
+	 * Reenlightenment notifications are disabled by hv_cpu_die(0),
+	 * reenable them here if hv_reenlightenment_cb was previously set.
+	 */
+	if (hv_reenlightenment_cb)
+		set_hv_tscchange_cb(hv_reenlightenment_cb);
 }
 
 /* Note: when the ops are called, only CPU0 is online and IRQs are disabled. */
-- 
2.25.4

