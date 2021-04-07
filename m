Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C650A356EF2
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Apr 2021 16:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbhDGOlv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Apr 2021 10:41:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52636 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhDGOlt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Apr 2021 10:41:49 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 60D1220B5680;
        Wed,  7 Apr 2021 07:41:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60D1220B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1617806499;
        bh=RW3dGYVmkQJ81p9LCGjxdTOdnRHf5p6gzfOsmE15srA=;
        h=From:To:Cc:Subject:Date:From;
        b=Us9lf1tq6SKsXOX+Gk+BQdwovWevpXxp5hu+/E96tUiFLiEJuPMLz8AkIaAYze5GT
         DZ82VSEuGo5lgEZeVhKduwj9EyrocE65Lt3ViUvUYjDKFLHpOOfXFAzYXLZRs1G/vA
         SZCcLItDLOtjouYdZpaytaAB6fxqDnv3wmm6gg4E=
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
Subject: [PATCH 0/7] Hyper-V nested virt enlightenments for SVM
Date:   Wed,  7 Apr 2021 14:41:21 +0000
Message-Id: <cover.1617804573.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch series enables the nested virtualization enlightenments for
SVM. This is very similar to the enlightenments for VMX except for the
fact that there is no enlightened VMCS. For SVM, VMCB is already an
in-memory data structure. The supported enlightenments are:

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

Vineeth Pillai (7):
  hyperv: Detect Nested virtualization support for SVM
  hyperv: SVM enlightened TLB flush support flag
  KVM: x86: hyper-v: Move the remote TLB flush logic out of vmx
  KVM: SVM: hyper-v: Nested enlightenments in VMCB
  KVM: SVM: hyper-v: Remote TLB flush for SVM
  KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
  KVM: SVM: hyper-v: Direct Virtual Flush support

 arch/x86/include/asm/hyperv-tlfs.h |   9 +++
 arch/x86/include/asm/kvm_host.h    |  15 ++++
 arch/x86/include/asm/svm.h         |  24 ++++++-
 arch/x86/kernel/cpu/mshyperv.c     |  10 ++-
 arch/x86/kvm/hyperv.c              |  89 +++++++++++++++++++++++
 arch/x86/kvm/hyperv.h              |  12 ++++
 arch/x86/kvm/svm/svm.c             | 110 +++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h             |  30 +++++++-
 arch/x86/kvm/vmx/vmx.c             |  97 ++-----------------------
 arch/x86/kvm/vmx/vmx.h             |  10 ---
 10 files changed, 302 insertions(+), 104 deletions(-)

-- 
2.25.1

