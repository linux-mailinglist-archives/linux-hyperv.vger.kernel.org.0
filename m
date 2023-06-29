Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D94742CCC
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jun 2023 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjF2TBo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 15:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjF2TBQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 15:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86572D78;
        Thu, 29 Jun 2023 12:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490E461614;
        Thu, 29 Jun 2023 19:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499C7C433CD;
        Thu, 29 Jun 2023 19:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065273;
        bh=BfBq32+wUjq/ixVzTsMobWC5JLbxN7vWJFEZGGw/1hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXAZOBI6j8LtrWrl1R9HBGJXsx7y+7w09f2umB4vTFUHiAtuEd95tWMLAmIMq14Uc
         q4AzvUJ8fz+DT9wQipeNbxcrVuB3r5Tisy7XPxCJj44FqEoVGKn2uOoSEwySVk/Byp
         bGpeE9y5CbfkLM3oksJRJW9Th4pXVjp7u2P+XTsUmRmjvd1FQrklnpSKnXznVRE/8W
         AcQOoUjtyT1PU9yOmFddDI3dN61BWbKHIc3xAMCvJwONdbcLhmB5UxATrh/SEt7zM/
         tKU1WcAtnUdrSexeeo8CBe46jze9Thx3jnfByd0KxMOFjoBNjF2k4WC3jML00BtO4Y
         jMZbV+t2O7Cmg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Sasha Levin <sashal@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
        linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 07/17] arm64/hyperv: Use CPUHP_AP_HYPERV_ONLINE state to fix CPU online sequencing
Date:   Thu, 29 Jun 2023 15:00:36 -0400
Message-Id: <20230629190049.907558-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190049.907558-1-sashal@kernel.org>
References: <20230629190049.907558-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 52ae076c3a9b366b6fa9f7c7e67aed8b28716ed9 ]

State CPUHP_AP_HYPERV_ONLINE has been introduced to correctly sequence the
initialization of hyperv_pcpu_input_arg. Use this new state for Hyper-V
initialization so that hyperv_pcpu_input_arg is allocated early enough.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Link: https://lore.kernel.org/r/1684862062-51576-2-git-send-email-mikelley@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/hyperv/mshyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index a406454578f07..f1b8a04ee9f26 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -67,7 +67,7 @@ static int __init hyperv_init(void)
 	if (ret)
 		return ret;
 
-	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:online",
+	ret = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "arm64/hyperv_init:online",
 				hv_common_cpu_init, hv_common_cpu_die);
 	if (ret < 0) {
 		hv_common_free();
-- 
2.39.2

