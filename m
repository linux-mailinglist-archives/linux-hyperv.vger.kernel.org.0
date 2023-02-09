Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20039690129
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 08:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBIHXM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 02:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBIHXJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 02:23:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85241EBC1;
        Wed,  8 Feb 2023 23:22:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DDD75C221;
        Thu,  9 Feb 2023 07:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675927360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zyHEmKeSFHe5+oN4UisgzjtUbIgCf4lrIbd7KednrR0=;
        b=k4aWSkE2BdtZFM8V//WNQjG7991Som7Xdthx3JxwnltctXG4G560YCzM645blnAk5C0FSS
        dJNKo7/JR5JdWeVZi3grOarBdIRkBuONkWYEoPOKCNkJwSTASjeXt1BQ4CDGaZwVjFKYx+
        E7kDdY95qpv+pxR1L9jYpElSa/0WIjc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FDF71339E;
        Thu,  9 Feb 2023 07:22:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iS6GBkCf5GP6eAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 09 Feb 2023 07:22:40 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 3/8] x86/hyperv: set MTRR state when running as SEV-SNP Hyper-V guest
Date:   Thu,  9 Feb 2023 08:22:15 +0100
Message-Id: <20230209072220.6836-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209072220.6836-1-jgross@suse.com>
References: <20230209072220.6836-1-jgross@suse.com>
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
while MTRRs are disabled by the hypervisor.

Fixes: 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/kernel/cpu/mshyperv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 46668e255421..51e47dc0e987 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -34,6 +34,7 @@
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
 #include <asm/coco.h>
+#include <asm/mtrr.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -335,6 +336,13 @@ static void __init ms_hyperv_init_platform(void)
 			static_branch_enable(&isolation_type_snp);
 #ifdef CONFIG_SWIOTLB
 			swiotlb_unencrypted_base = ms_hyperv.shared_gpa_boundary;
+#endif
+#ifdef CONFIG_MTRR
+			/*
+			 * Set WB as the default cache mode in case MTRRs are
+			 * disabled by the hypervisor.
+			 */
+			mtrr_overwrite_state(NULL, 0, NULL, MTRR_TYPE_WRBACK);
 #endif
 		}
 		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
-- 
2.35.3

