Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9B2678234
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jan 2023 17:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjAWQvp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Jan 2023 11:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjAWQvn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Jan 2023 11:51:43 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26635298C1;
        Mon, 23 Jan 2023 08:51:43 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9ED5F20E1ABC;
        Mon, 23 Jan 2023 08:51:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9ED5F20E1ABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674492702;
        bh=iXDswEmTakfKGhN5QPKSBgNjZ3wfETJIr5E58OOkzlc=;
        h=From:To:Cc:Subject:Date:From;
        b=OvKZ+2WD6ti+zkEgW7x7/TPAdZL3Elx7jqHOrvQwmbWGUCIk75cr7EpIDKgeKpheq
         r7GdGjLxjIBaxBct9Oj98Pc14uM/GerxskXqy2ptQMG+JAJCqypJxNPzsu1WvrgV+P
         l/JlbXv/uvx8tyo6H05keMreUWQsVpDd4VUlKbIk=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-crypto@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux.dev
Subject: [RFC PATCH v1 0/6] Support nested SNP KVM guests on Hyper-V
Date:   Mon, 23 Jan 2023 16:51:22 +0000
Message-Id: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch series enables SNP-host support when running on Hyper-V, which
allows launching nested SNP guests. No guest or qemu changes are necessary
for this to work.

Patch 1 deals with allocating an RMP table which is not provided by
firmware/hypervisor. Patch 2 implements MSR-based rmpupdate/psmash instructions
which are meant for virtualized environments. Patch 3 maintains the rmptable
for internal kernel page tracking. Patch 4 makes sure that the kernel does not
disable SNP support during early CPU init. Patch 5 allows SNP initialization to
proceed when no iommus are available. Patch 6 adds a quirk in psp command
buffer handling, because of differences in SNP firmware spec interpretation.

This series depends on

- "Add AMD Secure Nested Paging (SEV-SNP) Hypervisor Support" (applies on top of RFC v7)
  https://lore.kernel.org/lkml/20221214194056.161492-1-michael.roth@amd.com/
- "Support ACPI PSP on Hyper-V"
  https://lore.kernel.org/lkml/20230123152250.26413-1-jpiotrowski@linux.microsoft.com/

Jeremi Piotrowski (6):
  x86/hyperv: Allocate RMP table during boot
  x86/sev: Add support for NestedVirtSnpMsr
  x86/sev: Maintain shadow rmptable on Hyper-V
  x86/amd: Configure necessary MSRs for SNP during CPU init when running
    as a guest
  iommu/amd: Don't fail snp_enable when running virtualized
  crypto: ccp - Introduce quirk to always reclaim pages after SEV-legacy
    commands

 arch/x86/hyperv/hv_init.c          |   5 ++
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/hyperv-tlfs.h |   3 +
 arch/x86/include/asm/mshyperv.h    |   3 +
 arch/x86/include/asm/msr-index.h   |   2 +
 arch/x86/include/asm/sev.h         |   2 +
 arch/x86/kernel/cpu/amd.c          |   8 +-
 arch/x86/kernel/cpu/mshyperv.c     |  41 ++++++++++
 arch/x86/kernel/sev.c              | 122 ++++++++++++++++++++++++++---
 drivers/crypto/ccp/sev-dev.c       |   6 +-
 drivers/crypto/ccp/sp-dev.h        |   4 +
 drivers/crypto/ccp/sp-platform.c   |   1 +
 drivers/iommu/amd/init.c           |   6 ++
 13 files changed, 191 insertions(+), 13 deletions(-)

-- 
2.25.1

