Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35078495F
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Aug 2023 20:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjHVS0B (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Aug 2023 14:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHVS0B (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Aug 2023 14:26:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB077CCB;
        Tue, 22 Aug 2023 11:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618EF64676;
        Tue, 22 Aug 2023 18:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2200BC433C8;
        Tue, 22 Aug 2023 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692728758;
        bh=D1aKSF/2SZQ7zmJpVY9L5WKJ+QUpGfpqfVmFQt4hxaU=;
        h=From:Date:Subject:To:Cc:From;
        b=ReGXukQAfep2M5ZEaoIQDvQC+uruYENF8XEJAohJsYNOfvukrhdlaz4SMtvuToWLy
         Uoj+DeoPbav/ZR9E7oHBhuQybxWicKx1PsuNofiPGs+pQb74cjh83ekBfr5dxHo+7N
         TGd3nsrAuzAQsMkVnX1Knxy2XaSSqiGGVlQFWRHTu4IQ4lpKiK9r1oDFtS8MAckIs/
         rLk35h9VgzvBN4NK7CqpUJcdBF+SNOR+GtW3mRa9rv56S0xBlAAdeu4iBAykHzyXUU
         dpwqMXvaXbpNjfrG0I/kpd9Mu1zwi5Yy6YrKmXU0bm/qg++ipU24IMaOVGVCtkR9Xb
         rddiQgnDy/pUg==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 22 Aug 2023 11:25:49 -0700
Subject: [PATCH] x86/hyperv: Add missing 'inline' to hv_snp_boot_ap() stub
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-hv_snp_boot_ap-missing-inline-v1-1-e712dcb2da0f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK395GQC/x3M0QqCQBAF0F+ReW5gnVKiX4lYzEa9ULPLTkgg/
 rtLj+flbORaoE63ZqOiKxzJKtpTQ+My2KyMVzVJkHO4ivCyRrccnyl945D5A3fYzLA3TFlCp33
 b6WXSnuqRi074/f/7Y98P6hFpT28AAAA=
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com
Cc:     x86@kernel.org, mikelley@microsoft.com, tiala@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=nathan@kernel.org;
 h=from:subject:message-id; bh=D1aKSF/2SZQ7zmJpVY9L5WKJ+QUpGfpqfVmFQt4hxaU=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDClP/m5NndNxqzP63vZnD0w6S+JX9SeuPLaxNnE5n5S0X
 sTZIu6VHaUsDGIcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiLUmMDK9MZx2YNcl9jmA/
 c67srzcsmbzK6160Kj9iOZTKKb1K5xwjw++ifRdmiJ/7tFFz2cuOI7aC0zqnt3682al8Pf9V08e
 L9QwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When building without CONFIG_AMD_MEM_ENCRYPT, there are several
repeated instances of -Wunused-function due to missing 'inline' on
the stub of hy_snp_boot_ap():

  In file included from drivers/hv/hv_common.c:29:
  ./arch/x86/include/asm/mshyperv.h:272:12: error: 'hv_snp_boot_ap' defined but not used [-Werror=unused-function]
    272 | static int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
        |            ^~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Add 'inline' to fix the warnings.

Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/include/asm/mshyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 6bd9ae04d9c3..b6be267ff3d0 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -269,7 +269,7 @@ static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline void hv_vtom_init(void) {}
-static int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
+static inline int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
 #endif
 
 extern bool hv_isolation_type_snp(void);

---
base-commit: bb9b0e46b84c19d3dd7d453a2da71a0fdc172b31
change-id: 20230822-hv_snp_boot_ap-missing-inline-205e615e4fe6

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

