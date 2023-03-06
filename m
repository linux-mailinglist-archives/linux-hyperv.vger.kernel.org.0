Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8816AC827
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Mar 2023 17:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCFQgZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Mar 2023 11:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCFQgL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Mar 2023 11:36:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B2F4390C;
        Mon,  6 Mar 2023 08:35:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7789921E5D;
        Mon,  6 Mar 2023 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678120490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEyy0YGNrjiScFEJSCN9XqA2TAW4Ejl4yGBfINYDlUs=;
        b=hykKurK9/WXS6qISoyLDcDHoUPTa6DT2LVEsW+HX1QsXJ0G5yeT0pc2YbmUapmb9VennA3
        yx5uPl6pHjSN+PR7U5sxC+wj8Z/kbztWb3NkzdcLlXeUJXYTivVOxlBOrfZl+IdV536VzX
        e3PDiwTRa+CSvX3UOk/PJo5Y3opyfRA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2756B13A66;
        Mon,  6 Mar 2023 16:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yD1zCCoWBmREUwAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 06 Mar 2023 16:34:50 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 04/12] x86/hyperv: set MTRR state when running as SEV-SNP Hyper-V guest
Date:   Mon,  6 Mar 2023 17:34:17 +0100
Message-Id: <20230306163425.8324-5-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230306163425.8324-1-jgross@suse.com>
References: <20230306163425.8324-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In order to avoid mappings using the UC- cache attribute, set the
MTRR state to use WB caching as the default.

This is needed in order to cope with the fact that PAT is enabled,
while MTRRs are not supported by the hypervisor.

Fixes: 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/kernel/cpu/mshyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f36dc2f796c5..0a6cc3cf8919 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -34,6 +34,7 @@
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
 #include <asm/coco.h>
+#include <asm/mtrr.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -408,6 +409,9 @@ static void __init ms_hyperv_init_platform(void)
 #ifdef CONFIG_SWIOTLB
 			swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
 #endif
+
+			/* Set WB as the default cache mode. */
+			mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
 		}
 		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
 		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-- 
2.35.3

