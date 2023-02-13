Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD746942E4
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 11:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBMKe0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 05:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBMKeZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 05:34:25 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3C3CDBF6;
        Mon, 13 Feb 2023 02:34:24 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id C5DD320C8B6F;
        Mon, 13 Feb 2023 02:34:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5DD320C8B6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676284464;
        bh=kUxyGvvc3xmDFCdw49PrKXz00eMSLrPZ+lnvBvg/bD8=;
        h=From:To:Cc:Subject:Date:From;
        b=H4ZuISmDctrnLzjAXkk3Dr6el126LBocSFL3rBzKdKa8DiPxthZamKsRcEJqRuIHZ
         2FXmYdreUkEh62Ae8oeatyNusCF4pK/6A7cKs1Y0czMvFWkeea8r3anBHXBG5myjZR
         lPRBgRbmWniwN4iPAuiM1HUUaqSOOoIB/d2D3Ocw=
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
Subject: [RFC PATCH v2 0/7] Support nested SNP KVM guests on Hyper-V
Date:   Mon, 13 Feb 2023 10:33:55 +0000
Message-Id: <20230213103402.1189285-1-jpiotrowski@linux.microsoft.com>
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
allows launching SNP guests while running as a nested hypervisor. This works
with SNP guest side support that was merged in v5.19, and the snp capable qemu
from AMD.

In this scenario the L0 hypervisor is Hyper-V, L1 is KVM, and L2 is an SNP
guest. The code from this patchset runs in L1. L1 is not an SNP guest itself,
SNP guests are not capable of supporting virtualization.

Patch 1 deals with allocating an RMP table which is not provided by
firmware/hypervisor, but is needed by the kernel to keep track of page
assignment to guests and rmp page size. Patch 2 implements MSR-based
rmpupdate/psmash instructions which are meant for virtualized environments.
Patch 3 containts the logic to update the rmp table when rmpupdate/psmash is
issued. Patch 4 makes sure that the kernel does not disable SNP support during
early CPU init. Patch 5 allows SNP initialization to proceed when no iommus
are available. Patch 6 adds a quirk in psp command buffer handling, because of
differences in SNP firmware spec interpretation. Patch 7 adds handling for RMP
faults which occur as NPF and the L0 is not able to resolve the address that
the fault occurred at.

This series depends on:

- "Add AMD Secure Nested Paging (SEV-SNP) Hypervisor Support" (applies on top of RFC v7)
  https://lore.kernel.org/lkml/20221214194056.161492-1-michael.roth@amd.com/
- "Support ACPI PSP on Hyper-V"
  https://lore.kernel.org/lkml/20230213092429.1167812-1-jpiotrowski@linux.microsoft.com/

Changes since v1:
* added handling for rmp page faults that occur during copy_to_user() that
  don't come with a proper fault address when running nested.
* fold IS_ENABLED() test into hv_needs_snp_rmp(), and use CONFIG_KVM_AMD_SEV
  instead of CONFIG_AMD_MEM_ENCRYPT
* introduce snp_soft_rmptable() wrapper to remove core dependency on hyperv
  specific code
* use msr_set_bit for SYSCFG_MEM_ENCRYPT bit instead of open coding

Jeremi Piotrowski (7):
  x86/hyperv: Allocate RMP table during boot
  x86/sev: Add support for NestedVirtSnpMsr
  x86/sev: Maintain shadow rmptable on Hyper-V
  x86/amd: Configure necessary MSRs for SNP during CPU init when running
    as a guest
  iommu/amd: Don't fail snp_enable when running virtualized
  crypto: ccp - Introduce quirk to always reclaim pages after SEV-legacy
    commands
  x86/fault: Handle RMP faults with 0 address when nested

 arch/x86/hyperv/hv_init.c          |   5 +
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/hyperv-tlfs.h |   3 +
 arch/x86/include/asm/mshyperv.h    |   3 +
 arch/x86/include/asm/msr-index.h   |   2 +
 arch/x86/include/asm/sev.h         |   6 ++
 arch/x86/kernel/cpu/amd.c          |   5 +-
 arch/x86/kernel/cpu/mshyperv.c     |  47 +++++++++
 arch/x86/kernel/sev.c              | 150 ++++++++++++++++++++++++++---
 arch/x86/mm/fault.c                |  14 +++
 drivers/crypto/ccp/sev-dev.c       |   6 +-
 drivers/crypto/ccp/sp-dev.h        |   4 +
 drivers/crypto/ccp/sp-platform.c   |   1 +
 drivers/iommu/amd/init.c           |   6 ++
 14 files changed, 240 insertions(+), 13 deletions(-)

-- 
2.25.1

