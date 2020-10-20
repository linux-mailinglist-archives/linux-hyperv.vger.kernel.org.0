Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF0288745
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Oct 2020 12:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbgJIKq1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Oct 2020 06:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387783AbgJIKq0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Oct 2020 06:46:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA989C0613D2;
        Fri,  9 Oct 2020 03:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=oifcmCxgengDm0xlwPlx0P/sTS4kOs7GnADWSNebHiM=; b=NcGFYa2qfSUwdH8mcITnks74J5
        EnDN910UORGykfR//CV5V5ibG5pfQ2Csav9qhmBWIDZ0dVZV3g/KHu16nm3SmADXEr25/oURzSh6V
        08n+YT8VuEwzVrWR0vkBE0PaIFdGemU3fYj/uBasz0CBl0KveLTPo3LqaSyHfanhIt3BrOjMUoJUJ
        RKGhZeIeOIEEqumnsPmzYPOr2qcEkkDGakVyFCdVHG295FzjZNaOpLh/OHV6rH+dzKQXLlW+Dxbif
        4KMtOfcH2qU46yr3aIv2Zx8LxPZcuJqyLpOq5242xyuoXmTqk3uiAuPbVrngiHcR4QhxYmdgZ6c50
        OZB9COXw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQpuq-00050S-13; Fri, 09 Oct 2020 10:46:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1kQpup-005W3r-0K; Fri, 09 Oct 2020 11:46:23 +0100
From:   David Woodhouse <dwmw2@infradead.org>
To:     x86@kernel.org
Cc:     kvm <kvm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH v2 0/8] Fix x2apic enablement and allow up to 32768 CPUs without IR where supported
Date:   Fri,  9 Oct 2020 11:46:08 +0100
Message-Id: <20201009104616.1314746-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <803bb6b2212e65c568c84ff6882c2aa8a0ee03d5.camel@infradead.org>
References: <803bb6b2212e65c568c84ff6882c2aa8a0ee03d5.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Fix the conditions for enabling x2apic on guests without interrupt 
remapping, and support 15-bit Extended Destination ID to allow 32768 
CPUs without IR on hypervisors that support it.

The last patch in the series now makes io_apic.c generate its RTE from 
the MSI message created by the parent irqchip, and removes all the nasty 
hackery where IRQ remapping drivers would frob I/OAPIC RTEs for 
themselves directly. It's last because I'd quite like to see it tested 
especially with Hyper-V and it doesn't actually eliminate the need for 
io_apic.c to know about the 15-bit extension anyway.

v2:
 • Minor cleanups.
 • Move __irq_msi_compose_msg() to apic.c, make virt_ext_dest_id static.
 • Generate I/OAPIC RTE directly from parent irqchip's MSI messages.
 • Clean up HPET MSI support into hpet.c now that we can.

David Woodhouse (8):
      x86/apic: Fix x2apic enablement without interrupt remapping
      x86/msi: Only use high bits of MSI address for DMAR unit
      x86/apic: Always provide irq_compose_msi_msg() method for vector domain
      x86/ioapic: Handle Extended Destination ID field in RTE
      x86/apic: Support 15 bits of APIC ID in MSI where available
      x86/kvm: Add KVM_FEATURE_MSI_EXT_DEST_ID
      x86/hpet: Move MSI support into hpet.c
      x86/ioapic: Generate RTE directly from parent irqchip's MSI message

 Documentation/virt/kvm/cpuid.rst     |   4 +
 arch/x86/include/asm/apic.h          |   9 +--
 arch/x86/include/asm/hpet.h          |  11 ---
 arch/x86/include/asm/hw_irq.h        |  11 ++-
 arch/x86/include/asm/io_apic.h       |   3 +-
 arch/x86/include/asm/msidef.h        |   2 +
 arch/x86/include/asm/x86_init.h      |   2 +
 arch/x86/include/uapi/asm/kvm_para.h |   1 +
 arch/x86/kernel/apic/apic.c          |  68 ++++++++++++++--
 arch/x86/kernel/apic/io_apic.c       |  66 +++++++++------
 arch/x86/kernel/apic/msi.c           | 152 +++--------------------------------
 arch/x86/kernel/apic/vector.c        |   6 ++
 arch/x86/kernel/apic/x2apic_phys.c   |   9 +++
 arch/x86/kernel/hpet.c               | 116 ++++++++++++++++++++++++--
 arch/x86/kernel/kvm.c                |   6 ++
 arch/x86/kernel/x86_init.c           |   1 +
 drivers/iommu/amd/iommu.c            |  14 ----
 drivers/iommu/hyperv-iommu.c         |  31 -------
 drivers/iommu/intel/irq_remapping.c  |  19 ++---
 19 files changed, 276 insertions(+), 255 deletions(-)

