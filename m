Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A1E3A3F04
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jun 2021 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFKJ2e (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Jun 2021 05:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230358AbhFKJ2c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Jun 2021 05:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623403592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ciFwyqsjj/jCSwc755tZr8PbGQ5eE5XaY/j7ippp2pk=;
        b=ZPskKW16iCnpOb4T6ZLyctXxHuf1RjA6wL1k+VIcTOdsrH2K1QoV6BckGh9GVqVAbJmhhs
        NvA8XDd/SOEtAM7Y7IuThLPHVqgWtL7qgysAOQ4gCX4gs689kB9bqFlHuhJ4NSra79c/La
        C3LxfkC9iPis6y+U3KAuYurKnx5/Tj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-dqsMMCZlPr66RHOopSrZfA-1; Fri, 11 Jun 2021 05:26:31 -0400
X-MC-Unique: dqsMMCZlPr66RHOopSrZfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E555EC1A3;
        Fri, 11 Jun 2021 09:26:28 +0000 (UTC)
Received: from starship (unknown [10.40.194.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CE7F5D71D;
        Fri, 11 Jun 2021 09:26:17 +0000 (UTC)
Message-ID: <683fa50765b29f203cb4b0953542dc43226a7a2f.camel@redhat.com>
Subject: Re: [PATCH v5 0/7] Hyper-V nested virt enlightenments for SVM
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Date:   Fri, 11 Jun 2021 12:26:16 +0300
In-Reply-To: <5af1ccce-a07d-5a13-107b-fc4c4553dd4d@redhat.com>
References: <cover.1622730232.git.viremana@linux.microsoft.com>
         <5af1ccce-a07d-5a13-107b-fc4c4553dd4d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 2021-06-10 at 17:17 +0200, Paolo Bonzini wrote:
> On 03/06/21 17:14, Vineeth Pillai wrote:
> > This patch series enables the nested virtualization enlightenments for
> > SVM. This is very similar to the enlightenments for VMX except for the
> > fact that there is no enlightened VMCS. For SVM, VMCB is already an
> > architectural in-memory data structure.
> > 
> > Note: v5 is just a rebase on hyperv-next(5.13-rc1) and needed a rework
> > based on the patch series: (KVM: VMX: Clean up Hyper-V PV TLB flush)
> > https://lore.kernel.org/lkml/20210305183123.3978098-1-seanjc@google.com/
> > 
> > The supported enlightenments are:
> > 
> > Enlightened TLB Flush: If this is enabled, ASID invalidations invalidate
> > only gva -> hpa entries. To flush entries derived from NPT, hyper-v
> > provided hypercalls (HvFlushGuestPhysicalAddressSpace or
> > HvFlushGuestPhysicalAddressList) should be used.
> > 
> > Enlightened MSR bitmap(TLFS 16.5.3): "When enabled, L0 hypervisor does
> > not monitor the MSR bitmaps for changes. Instead, the L1 hypervisor must
> > invalidate the corresponding clean field after making changes to one of
> > the MSR bitmaps."
> > 
> > Direct Virtual Flush(TLFS 16.8): The hypervisor exposes hypercalls
> > (HvFlushVirtualAddressSpace, HvFlushVirtualAddressSpaceEx,
> > HvFlushVirtualAddressList, and HvFlushVirtualAddressListEx) that allow
> > operating systems to more efficiently manage the virtual TLB. The L1
> > hypervisor can choose to allow its guest to use those hypercalls and
> > delegate the responsibility to handle them to the L0 hypervisor. This
> > requires the use of a partition assist page."
> > 
> > L2 Windows boot time was measured with and without the patch. Time was
> > measured from power on to the login screen and was averaged over a
> > consecutive 5 trials:
> >    Without the patch: 42 seconds
> >    With the patch: 29 seconds
> > --
> > 
> > Changes from v4
> > - Rebased on top of 5.13-rc1 and reworked based on the changes in the
> >    patch series: (KVM: VMX: Clean up Hyper-V PV TLB flush)
> >    
> > Changes from v3
> > - Included definitions for software/hypervisor reserved fields in SVM
> >    architectural data structures.
> > - Consolidated Hyper-V specific code into svm_onhyperv.[ch] to reduce
> >    the "ifdefs". This change applies only to SVM, VMX is not touched and
> >    is not in the scope of this patch series.
> > 
> > Changes from v2:
> > - Refactored the Remote TLB Flush logic into separate hyperv specific
> >    source files (kvm_onhyperv.[ch]).
> > - Reverted the VMCB Clean bits macro changes as it is no longer needed.
> > 
> > Changes from v1:
> > - Move the remote TLB flush related fields from kvm_vcpu_hv and kvm_hv
> >    to kvm_vcpu_arch and kvm_arch.
> > - Modify the VMCB clean mask runtime based on whether L1 hypervisor
> >    is running on Hyper-V or not.
> > - Detect Hyper-V nested enlightenments based on
> >    HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS.
> > - Address other minor review comments.
> > ---
> > 
> > Vineeth Pillai (7):
> >    hyperv: Detect Nested virtualization support for SVM
> >    hyperv: SVM enlightened TLB flush support flag
> >    KVM: x86: hyper-v: Move the remote TLB flush logic out of vmx
> >    KVM: SVM: Software reserved fields
> >    KVM: SVM: hyper-v: Remote TLB flush for SVM
> >    KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
> >    KVM: SVM: hyper-v: Direct Virtual Flush support
> > 
> >   arch/x86/include/asm/hyperv-tlfs.h |   9 ++
> >   arch/x86/include/asm/kvm_host.h    |   9 ++
> >   arch/x86/include/asm/svm.h         |   9 +-
> >   arch/x86/include/uapi/asm/svm.h    |   3 +
> >   arch/x86/kernel/cpu/mshyperv.c     |  10 ++-
> >   arch/x86/kvm/Makefile              |   9 ++
> >   arch/x86/kvm/kvm_onhyperv.c        |  93 +++++++++++++++++++++
> >   arch/x86/kvm/kvm_onhyperv.h        |  32 +++++++
> >   arch/x86/kvm/svm/svm.c             |  14 ++++
> >   arch/x86/kvm/svm/svm.h             |  22 ++++-
> >   arch/x86/kvm/svm/svm_onhyperv.c    |  41 +++++++++
> >   arch/x86/kvm/svm/svm_onhyperv.h    | 129 +++++++++++++++++++++++++++++
> >   arch/x86/kvm/vmx/vmx.c             | 105 +----------------------
> >   arch/x86/kvm/vmx/vmx.h             |   9 --
> >   arch/x86/kvm/x86.c                 |   9 ++
> >   15 files changed, 384 insertions(+), 119 deletions(-)
> >   create mode 100644 arch/x86/kvm/kvm_onhyperv.c
> >   create mode 100644 arch/x86/kvm/kvm_onhyperv.h
> >   create mode 100644 arch/x86/kvm/svm/svm_onhyperv.c
> >   create mode 100644 arch/x86/kvm/svm/svm_onhyperv.h
> > 
> 
> Queued, thanks.
> 
> Paolo
> 

Hi!

This patch series causes a build failure here:

arch/x86/kvm/vmx/vmx.c: In function ‘hardware_setup’:
arch/x86/kvm/vmx/vmx.c:7752:34: error: ‘hv_remote_flush_tlb’ undeclared (first use in this function)
 7752 |   vmx_x86_ops.tlb_remote_flush = hv_remote_flush_tlb;
      |                                  ^~~~~~~~~~~~~~~~~~~
arch/x86/kvm/vmx/vmx.c:7752:34: note: each undeclared identifier is reported only once for each function it appears in
arch/x86/kvm/vmx/vmx.c:7754:5: error: ‘hv_remote_flush_tlb_with_range’ undeclared (first use in this function)
 7754 |     hv_remote_flush_tlb_with_range;
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Also this:

arch/x86/kvm/vmx/vmx.c: In function ‘hardware_setup’:
arch/x86/kvm/vmx/vmx.c:7752:34: error: ‘hv_remote_flush_tlb’ undeclared (first use in this function)
 7752 |   vmx_x86_ops.tlb_remote_flush = hv_remote_flush_tlb;
      |                                  ^~~~~~~~~~~~~~~~~~~
arch/x86/kvm/vmx/vmx.c:7752:34: note: each undeclared identifier is reported only once for each function it appears in
arch/x86/kvm/vmx/vmx.c:7754:5: error: ‘hv_remote_flush_tlb_with_range’ undeclared (first use in this function)
 7754 |     hv_remote_flush_tlb_with_range;
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 

Best regards,
	Maxim Levitsky

