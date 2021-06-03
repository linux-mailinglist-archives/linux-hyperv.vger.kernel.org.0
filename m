Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD1339A41D
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jun 2021 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhFCPQg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Jun 2021 11:16:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45612 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhFCPQf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Jun 2021 11:16:35 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id B3BF420B7178;
        Thu,  3 Jun 2021 08:14:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3BF420B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622733290;
        bh=DEyo5xvG+1x+OremPDmGcOgrzcnN/Vfy+U+eJe72wNg=;
        h=From:To:Cc:Subject:Date:From;
        b=dxgHlMf4qfmbKGzOPJq3vN9MURpZ687Pbgsg5xhIiHhE/bzG6Zio0ptVUnTPLGwfu
         /Y+36CZLtvI2WupJR3xb4zQzWjUfdVjRqed4myBrRvlPQ//E9jQNGEWwLsbg8+B0OH
         W9Qg3xUPChQixJEBgKIjWYu2jBA2aEjUOB0xVyCU=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [PATCH v5 0/7] Hyper-V nested virt enlightenments for SVM
Date:   Thu,  3 Jun 2021 15:14:33 +0000
Message-Id: <cover.1622730232.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch series enables the nested virtualization enlightenments for
SVM. This is very similar to the enlightenments for VMX except for the
fact that there is no enlightened VMCS. For SVM, VMCB is already an
architectural in-memory data structure.

Note: v5 is just a rebase on hyperv-next(5.13-rc1) and needed a rework
based on the patch series: (KVM: VMX: Clean up Hyper-V PV TLB flush)
https://lore.kernel.org/lkml/20210305183123.3978098-1-seanjc@google.com/

The supported enlightenments are:

Enlightened TLB Flush: If this is enabled, ASID invalidations invalidate
only gva -> hpa entries. To flush entries derived from NPT, hyper-v
provided hypercalls (HvFlushGuestPhysicalAddressSpace or
HvFlushGuestPhysicalAddressList) should be used.

Enlightened MSR bitmap(TLFS 16.5.3): "When enabled, L0 hypervisor does
not monitor the MSR bitmaps for changes. Instead, the L1 hypervisor must
invalidate the corresponding clean field after making changes to one of
the MSR bitmaps."

Direct Virtual Flush(TLFS 16.8): The hypervisor exposes hypercalls
(HvFlushVirtualAddressSpace, HvFlushVirtualAddressSpaceEx,
HvFlushVirtualAddressList, and HvFlushVirtualAddressListEx) that allow
operating systems to more efficiently manage the virtual TLB. The L1
hypervisor can choose to allow its guest to use those hypercalls and
delegate the responsibility to handle them to the L0 hypervisor. This
requires the use of a partition assist page."

L2 Windows boot time was measured with and without the patch. Time was
measured from power on to the login screen and was averaged over a
consecutive 5 trials:
  Without the patch: 42 seconds
  With the patch: 29 seconds
--

Changes from v4
- Rebased on top of 5.13-rc1 and reworked based on the changes in the
  patch series: (KVM: VMX: Clean up Hyper-V PV TLB flush)
  
Changes from v3
- Included definitions for software/hypervisor reserved fields in SVM
  architectural data structures.
- Consolidated Hyper-V specific code into svm_onhyperv.[ch] to reduce
  the "ifdefs". This change applies only to SVM, VMX is not touched and
  is not in the scope of this patch series.

Changes from v2:
- Refactored the Remote TLB Flush logic into separate hyperv specific
  source files (kvm_onhyperv.[ch]).
- Reverted the VMCB Clean bits macro changes as it is no longer needed.

Changes from v1:
- Move the remote TLB flush related fields from kvm_vcpu_hv and kvm_hv
  to kvm_vcpu_arch and kvm_arch.
- Modify the VMCB clean mask runtime based on whether L1 hypervisor
  is running on Hyper-V or not.
- Detect Hyper-V nested enlightenments based on
  HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS.
- Address other minor review comments.
---

Vineeth Pillai (7):
  hyperv: Detect Nested virtualization support for SVM
  hyperv: SVM enlightened TLB flush support flag
  KVM: x86: hyper-v: Move the remote TLB flush logic out of vmx
  KVM: SVM: Software reserved fields
  KVM: SVM: hyper-v: Remote TLB flush for SVM
  KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
  KVM: SVM: hyper-v: Direct Virtual Flush support

 arch/x86/include/asm/hyperv-tlfs.h |   9 ++
 arch/x86/include/asm/kvm_host.h    |   9 ++
 arch/x86/include/asm/svm.h         |   9 +-
 arch/x86/include/uapi/asm/svm.h    |   3 +
 arch/x86/kernel/cpu/mshyperv.c     |  10 ++-
 arch/x86/kvm/Makefile              |   9 ++
 arch/x86/kvm/kvm_onhyperv.c        |  93 +++++++++++++++++++++
 arch/x86/kvm/kvm_onhyperv.h        |  32 +++++++
 arch/x86/kvm/svm/svm.c             |  14 ++++
 arch/x86/kvm/svm/svm.h             |  22 ++++-
 arch/x86/kvm/svm/svm_onhyperv.c    |  41 +++++++++
 arch/x86/kvm/svm/svm_onhyperv.h    | 129 +++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c             | 105 +----------------------
 arch/x86/kvm/vmx/vmx.h             |   9 --
 arch/x86/kvm/x86.c                 |   9 ++
 15 files changed, 384 insertions(+), 119 deletions(-)
 create mode 100644 arch/x86/kvm/kvm_onhyperv.c
 create mode 100644 arch/x86/kvm/kvm_onhyperv.h
 create mode 100644 arch/x86/kvm/svm/svm_onhyperv.c
 create mode 100644 arch/x86/kvm/svm/svm_onhyperv.h

-- 
2.25.1

