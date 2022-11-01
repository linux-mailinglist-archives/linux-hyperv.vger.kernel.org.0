Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07306150AF
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Nov 2022 18:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKARbC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Nov 2022 13:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKARbA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Nov 2022 13:31:00 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAE27B86A;
        Tue,  1 Nov 2022 10:30:59 -0700 (PDT)
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [20.120.152.163])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8138B205D3B7;
        Tue,  1 Nov 2022 10:30:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8138B205D3B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667323859;
        bh=bWL2DdT42G4iphUgFrlIZ2M6RpV81Aj/se5dxpx2cQw=;
        h=Subject:From:Cc:Date:From;
        b=VPx0jo0tRj1ouu7vyKrxFK8xenm3D8WH15JFEWvZsg2qZlYVW1JikTmgiOVOhe/Nj
         kNXDPFgofEG0uMZbG0QAxEsCOQT1KsDN5hB8kxOChPay3apxRsyo7F4mNXg/jn68mj
         A/0LCzpaPGzTplBa1uP5XSsn2DV9ZnfjY0LkFIfc=
Subject: [PATCH 0/4] hyper-v: Introduce TSC page for root partition
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Liu <wei.liu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 01 Nov 2022 17:30:59 +0000
Message-ID: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-18.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,MISSING_HEADERS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This series does some cleanup and precursor changes to the hyper-v clock
source and introduces support for TSC page based clock in root partition.

Hyper-V root partition requires kernel to map the page, specified by the
hypervisor (instead of provide the PFN to the hypervisor like it's done in
guest partition).

The following series implements...

---

Stanislav Kinsburskiy (4):
      drivers/clocksource/hyper-v: Introduce a pointer to TSC page
      drivers/clocksource/hyper-v: Introduce TSC MSR register structure
      drivers/clocksource/hyper-v: Use TSC PFN getter to map vvar page
      drivers/clocksource/hyper-v: Add TSC page support for root partition


 arch/x86/entry/vdso/vma.c          |    7 ++---
 arch/x86/hyperv/hv_init.c          |    2 +
 drivers/clocksource/hyperv_timer.c |   51 ++++++++++++++++++++++++++----------
 include/clocksource/hyperv_timer.h |    7 +++++
 4 files changed, 49 insertions(+), 18 deletions(-)

