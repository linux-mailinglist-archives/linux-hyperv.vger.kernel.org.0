Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFED1360AD0
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Apr 2021 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhDONoT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Apr 2021 09:44:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41504 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhDONoS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Apr 2021 09:44:18 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id EB6D020B8001;
        Thu, 15 Apr 2021 06:43:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB6D020B8001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1618494235;
        bh=f+72EpphKYDyWb2ni9IPH1kTpGV8sLOlwjys3mFfBxI=;
        h=From:To:Cc:Subject:Date:From;
        b=KkjRctg//cx736rviMBMko/DerhF/2bHx3YRxjgwH+KTq9v0c0jITUtNAKkvMbaHH
         I3Pp9qTlwLvjsXR53qZUFJlG4MIwku4JjZHaWDeXSYEM5e4Fsm59nhDU+XgK0/rflv
         eoFIjulbg0eh/ZZF/b+m7IuXBehE31DefmdLu4xA=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
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
Subject: [PATCH v2 0/7] Hyper-V nested virt enlightenments for SVM
Date:   Thu, 15 Apr 2021 13:43:35 +0000
Message-Id: <cover.1618492553.git.viremana@linux.microsoft.com>
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
  KVM: SVM: hyper-v: Nested enlightenments in VMCB
  KVM: SVM: hyper-v: Remote TLB flush for SVM
  KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
  KVM: SVM: hyper-v: Direct Virtual Flush support

 arch/x86/include/asm/hyperv-tlfs.h |   9 +++
 arch/x86/include/asm/kvm_host.h    |  14 ++++
 arch/x86/include/asm/svm.h         |  24 +++++-
 arch/x86/kernel/cpu/mshyperv.c     |  10 ++-
 arch/x86/kvm/hyperv.c              |  87 +++++++++++++++++++++
 arch/x86/kvm/hyperv.h              |  20 +++++
 arch/x86/kvm/svm/svm.c             | 120 +++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h             |  30 +++++++-
 arch/x86/kvm/vmx/vmx.c             |  97 ++---------------------
 arch/x86/kvm/vmx/vmx.h             |  10 ---
 arch/x86/kvm/x86.c                 |   9 ++-
 11 files changed, 323 insertions(+), 107 deletions(-)

-- 
2.25.1

