Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F205617046
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 23:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiKBWHV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiKBWHU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 18:07:20 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B8E8E089;
        Wed,  2 Nov 2022 15:07:19 -0700 (PDT)
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [20.120.152.163])
        by linux.microsoft.com (Postfix) with ESMTPSA id 14C5C20C28B1;
        Wed,  2 Nov 2022 15:07:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14C5C20C28B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667426839;
        bh=JUG42jeyjvgFHGNMvsR/hCvKSrT4pTWK7OPsWykBFGw=;
        h=Subject:From:Cc:Date:From;
        b=jCklmZzcyhMvq5FiY2of143rpnpgqxIIpQkdYGqyO4afU72B6wJmkh9UqlXX9tLTe
         /CL46x3PNGGs4a+eJeF1d8W6ALFzYEmuNsO+heYkO/a3GN7Cbhb0x8gEwlr1uZcaOY
         idcxVx3Ld4+dvJS4BwZVrVmiQ/UVyrwq2L0YOX04=
Subject: [PATCH v2 0/4] hyper-v: Introduce TSC page for root partition
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Date:   Wed, 02 Nov 2022 22:07:18 +0000
Message-ID: <166742670556.205987.18227942188746093700.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

v2:
1. Addressed all the comments to the commit messages.
2. TSC page in root partition is now remapped based on size of the tsc_pg
variable.

The following series implements...

---

Stanislav Kinsburskiy (4):
      drivers/clocksource/hyper-v: Introduce a pointer to TSC page
      drivers/clocksource/hyper-v: Introduce TSC PFN getter
      drivers/clocksource/hyper-v: Use TSC PFN getter to map vvar page
      drivers/clocksource/hyper-v: Add TSC page support for root partition


 arch/x86/entry/vdso/vma.c          |    7 ++---
 arch/x86/hyperv/hv_init.c          |    2 +
 drivers/clocksource/hyperv_timer.c |   54 +++++++++++++++++++++++++++---------
 include/clocksource/hyperv_timer.h |    7 +++++
 4 files changed, 52 insertions(+), 18 deletions(-)

