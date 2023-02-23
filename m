Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7706A04E8
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Feb 2023 10:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjBWJdi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Feb 2023 04:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjBWJdh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Feb 2023 04:33:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342E353EEF;
        Thu, 23 Feb 2023 01:33:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E087337AC;
        Thu, 23 Feb 2023 09:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677144789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ofUIuPQzCXz4x5AZ2jKl8mI1RQt2u+dS3skjEQjrkE=;
        b=c0M+XIgoq0CQq6ZMLqfzCUMBjPu6EtDslCanknZBqDxtcr+DglId3s0M7nE8h4fhrSwvwx
        9FZzkfOI0YziUrd3hZBN4Qt+YMz7PY1F+Mt+vQLrkLxKhDla0vk5yTYQFWh8yg+zPNe8Xf
        ZCtz17T+IpB+jcBMnA1XHfNGEU5jbfk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4654013928;
        Thu, 23 Feb 2023 09:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B/DdD9Uy92OUbAAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 23 Feb 2023 09:33:09 +0000
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
Subject: [PATCH v3 04/12] x86/hyperv: set MTRR state when running as SEV-SNP Hyper-V guest
Date:   Thu, 23 Feb 2023 10:32:35 +0100
Message-Id: <20230223093243.1180-5-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230223093243.1180-1-jgross@suse.com>
References: <20230223093243.1180-1-jgross@suse.com>
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
index f924a76c6923..95f17394eca0 100644
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

