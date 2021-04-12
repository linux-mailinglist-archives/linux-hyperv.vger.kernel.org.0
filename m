Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC47F35CF17
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Apr 2021 19:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243981AbhDLRCj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Apr 2021 13:02:39 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:16009 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243659AbhDLRBo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Apr 2021 13:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1618246887; x=1649782887;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=rqIXEoKr8J06sdj1H8DHbETKlNN7iSR0KNAHaBFZ++A=;
  b=SclBWRXYus0mkGCeRdXZ3YXtUZKaVogr37JxIqMhkU7N5Q3U5crEECus
   nXf5iWOcFJ5lLp4StAidEcagIlSPpXAX6Y2VbKDCFSA4cLk/CPD2zhUeZ
   c1u2t/ZcO8wERxbilT720jcyOH30NtYWNFI8GrP5ldWYPY8TUDmwDOA2L
   8=;
X-IronPort-AV: E=Sophos;i="5.82,216,1613433600"; 
   d="scan'208";a="126988018"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-1e-42f764a0.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Apr 2021 17:00:59 +0000
Received: from EX13D28EUC003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-42f764a0.us-east-1.amazon.com (Postfix) with ESMTPS id D3C0DC03BD;
        Mon, 12 Apr 2021 17:00:52 +0000 (UTC)
Received: from uc8bbc9586ea454.ant.amazon.com (10.43.161.253) by
 EX13D28EUC003.ant.amazon.com (10.43.164.43) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 12 Apr 2021 17:00:44 +0000
From:   Siddharth Chandrasekaran <sidcha@amazon.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Joerg Roedel" <joro@8bytes.org>
CC:     Siddharth Chandrasekaran <sidcha@amazon.de>,
        Alexander Graf <graf@amazon.com>,
        Evgeny Iakovlev <eyakovl@amazon.de>,
        Liran Alon <liran@amazon.com>,
        Ioannis Aslanidis <iaslan@amazon.de>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH v2 0/4]  Add support for XMM fast hypercalls
Date:   Mon, 12 Apr 2021 19:00:13 +0200
Message-ID: <cover.1618244920.git.sidcha@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D16UWB001.ant.amazon.com (10.43.161.17) To
 EX13D28EUC003.ant.amazon.com (10.43.164.43)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V supports the use of XMM registers to perform fast hypercalls.
This allows guests to take advantage of the improved performance of the
fast hypercall interface even though a hypercall may require more than
(the current maximum of) two general purpose registers.

The XMM fast hypercall interface uses an additional six XMM registers
(XMM0 to XMM5) to allow the caller to pass an input parameter block of
up to 112 bytes. Hyper-V can also return data back to the guest in the
remaining XMM registers that are not used by the current hypercall.

Although the Hyper-v TLFS mentions that a guest cannot use this feature
unless the hypervisor advertises support for it, some hypercalls which
we plan on upstreaming in future uses them anyway. This patchset adds
necessary infrastructure for handling input/output via XMM registers and
patches kvm_hv_flush_tlb() to use xmm input arguments.

~ Sid.

v2:
- Add hc.fast to is_xmm_fast_hypercall() check
- Split CPUID feature bits for input and output

Siddharth Chandrasekaran (4):
  KVM: x86: Move FPU register accessors into fpu.h
  KVM: hyper-v: Collect hypercall params into struct
  KVM: x86: kvm_hv_flush_tlb use inputs from XMM registers
  KVM: hyper-v: Advertise support for fast XMM hypercalls

 arch/x86/include/asm/hyperv-tlfs.h |   7 +-
 arch/x86/kvm/emulate.c             | 138 +++-------------
 arch/x86/kvm/fpu.h                 | 140 +++++++++++++++++
 arch/x86/kvm/hyperv.c              | 242 +++++++++++++++++++----------
 4 files changed, 327 insertions(+), 200 deletions(-)
 create mode 100644 arch/x86/kvm/fpu.h

-- 
2.17.1



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



