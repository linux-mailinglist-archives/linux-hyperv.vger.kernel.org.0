Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F045F783EE4
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Aug 2023 13:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjHVLcG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Aug 2023 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjHVLcF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Aug 2023 07:32:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2746CDF;
        Tue, 22 Aug 2023 04:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F21F6525F;
        Tue, 22 Aug 2023 11:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17862C433C8;
        Tue, 22 Aug 2023 11:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703889;
        bh=vUD2YiFwO8PxTtU4FsBb6DWzVnZZ6MMI6fj037Vq/+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDQ7JRNJcc3Wv8EwWsLzug0zk8HQvDyU1mgeBKz4AtweeGhxD1GgPDz1po4PHo3x2
         r7FArd2bQVRDGgUE1PdCQFrgWiFD15Jp00KFQc0XhXFwK7/RJp2pCwIj/RJuDuFTKL
         c+KjUFfuFwJCuoY6fJCY3J8lhCRR8Zl9kJlMNqeeTzV0h78Mp1JEWCochySOd6STWx
         GgGK8/eK48tZi8sE5TpDsgRnbu9C+pO81rRVQYhsFIt/vEoyh+pW+DqOvokM543q/x
         KiTKC2zp7y0hPokJwFdj+LIcipgyHcPF1DN21FPlq5+NoMZkSda9/o3F3GOk4imPH8
         AQeDY75+npIOw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 10/10] x86/hyperv: add noop functions to x86_init mpparse functions
Date:   Tue, 22 Aug 2023 07:31:00 -0400
Message-Id: <20230822113101.3549915-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113101.3549915-1-sashal@kernel.org>
References: <20230822113101.3549915-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit 9e2d0c336524706fb327e9b87477f5f3337ad7a6 ]

Hyper-V can run VMs at different privilege "levels" known as Virtual
Trust Levels (VTL). Sometimes, it chooses to run two different VMs
at different levels but they share some of their address space. In
such setups VTL2 (higher level VM) has visibility of all of the
VTL0 (level 0) memory space.

When the CONFIG_X86_MPPARSE is enabled for VTL2, the VTL2 kernel
performs a search within the low memory to locate MP tables. However,
in systems where VTL0 manages the low memory and may contain valid
tables, this scanning can result in incorrect MP table information
being provided to the VTL2 kernel, mistakenly considering VTL0's MP
table as its own

Add noop functions to avoid MP parse scan by VTL2.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/1687537688-5397-1-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_vtl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 85d38b9f35861..db5d2ea39fc0d 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -25,6 +25,10 @@ void __init hv_vtl_init_platform(void)
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 
+	/* Avoid searching for BIOS MP tables */
+	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
+
 	x86_platform.get_wallclock = get_rtc_noop;
 	x86_platform.set_wallclock = set_rtc_noop;
 	x86_platform.get_nmi_reason = hv_get_nmi_reason;
-- 
2.40.1

