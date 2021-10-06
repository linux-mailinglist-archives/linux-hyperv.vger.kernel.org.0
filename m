Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58439423E29
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Oct 2021 14:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbhJFMw0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Oct 2021 08:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238562AbhJFMwZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Oct 2021 08:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633524633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yEd1nl5sTg+RWty43ssaYveHIjPOLpFS5qrgx7WwBNw=;
        b=X01VH1fnKwqWuJ4pbrRAPMYTySmYkwkMW27r8MdMhR0heI591oZQUHL6a5xj7vSJidbc7F
        342Ri8gBS1jVb+4MZZYBMmc6EoIWJO29Yl7uBf2pN0sv4frVctF+Vqess+aOJXg87BziXn
        SPlFMf4sgjGB2mV27I1s25T9eVAgVqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-OEvNXBC1Od2Atfgtea_O8g-1; Wed, 06 Oct 2021 08:50:23 -0400
X-MC-Unique: OEvNXBC1Od2Atfgtea_O8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F7701007908;
        Wed,  6 Oct 2021 12:50:21 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6AFE60657;
        Wed,  6 Oct 2021 12:50:17 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] x86/hyperv: Avoid erroneously sending IPI to 'self'
Date:   Wed,  6 Oct 2021 14:50:16 +0200
Message-Id: <20211006125016.941616-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

__send_ipi_mask_ex() uses an optimization: when the target CPU mask is
equal to 'cpu_present_mask' it uses 'HV_GENERIC_SET_ALL' format to avoid
converting the specified cpumask to VP_SET. This case was overlooked when
'exclude_self' parameter was added. As the result, a spurious IPI to
'self' can be send.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Fixes: dfb5c1e12c28 ("x86/hyperv: remove on-stack cpumask from hv_send_ipi_mask_allbutself")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_apic.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 32a1ad356c18..db2d92fb44da 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -122,17 +122,27 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 	ipi_arg->reserved = 0;
 	ipi_arg->vp_set.valid_bank_mask = 0;
 
-	if (!cpumask_equal(mask, cpu_present_mask)) {
+	/*
+	 * Use HV_GENERIC_SET_ALL and avoid converting cpumask to VP_SET
+	 * when the IPI is sent to all currently present CPUs.
+	 */
+	if (!cpumask_equal(mask, cpu_present_mask) || exclude_self) {
 		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
 		if (exclude_self)
 			nr_bank = cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
 		else
 			nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
-	}
-	if (nr_bank < 0)
-		goto ipi_mask_ex_done;
-	if (!nr_bank)
+
+		/*
+		 * 'nr_bank <= 0' means some CPUs in cpumask can't be
+		 * represented in VP_SET. Return an error and fall back to
+		 * native (architectural) method of sending IPIs.
+		 */
+		if (nr_bank <= 0)
+			goto ipi_mask_ex_done;
+	} else {
 		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
+	}
 
 	status = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
 			      ipi_arg, NULL);
-- 
2.31.1

