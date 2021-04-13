Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FC835E886
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 23:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhDMVvy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 17:51:54 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:47320 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhDMVvy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 17:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1618350695; x=1649886695;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=/DkrO2gUg58Vl2JO3PCW7Y+6kEN3IaedAlHDNnqPV3Y=;
  b=dS2kZyNa6iLKFD+SrtXiS00y4NFbyAGB11Pe9IF99kgnuxrSPAWk9E/D
   XNJJluxSWpVmuAr6xjan5J66OF4hEsYMdlr/ZIK77Ra2G+NuvSwG6Wrid
   QIvzsp8MwVCFVR/gxM25Q5hMEbeP+t5YR1lHMthMln51KOznGsDFqKTjx
   Q=;
X-IronPort-AV: E=Sophos;i="5.82,220,1613433600"; 
   d="scan'208";a="118207171"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 13 Apr 2021 21:51:28 +0000
Received: from EX13D28EUC003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id EE0FEA1BE6;
        Tue, 13 Apr 2021 21:51:25 +0000 (UTC)
Received: from uc8bbc9586ea454.ant.amazon.com (10.43.161.39) by
 EX13D28EUC003.ant.amazon.com (10.43.164.43) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 13 Apr 2021 21:51:16 +0000
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
Subject: [PATCH v3 0/4] Add support for XMM fast hypercalls
Date:   Tue, 13 Apr 2021 23:50:53 +0200
Message-ID: <cover.1618349671.git.sidcha@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.39]
X-ClientProxiedBy: EX13D30UWC002.ant.amazon.com (10.43.162.235) To
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

v3:
- Remove inline for kvm_hv_hypercall_{read,write}_xmm()
- Fix typo: s/ouput/output/
- Remove sse128_t from kvm_emulate.h
- Reword comment to match TLFS wording
- Move num XMM registers macro to hyperv-tlfs.h
- Stop advertising HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE

v2:
- Remove inline for kvm_hv_hypercall_{read,write}_xmm()
- Fix typo: s/ouput/output/
- Remove sse128_t from kvm_emulate.h
- Reword comment to match TLFS wording
- Move num XMM registers macro to hyperv-tlfs.h
- Stop advertising HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE

Siddharth Chandrasekaran (4):
  KVM: x86: Move FPU register accessors into fpu.h
  KVM: hyper-v: Collect hypercall params into struct
  KVM: x86: kvm_hv_flush_tlb use inputs from XMM registers
  KVM: hyper-v: Advertise support for fast XMM hypercalls

 arch/x86/include/asm/hyperv-tlfs.h |   9 +-
 arch/x86/kvm/emulate.c             | 137 +++---------------
 arch/x86/kvm/fpu.h                 | 140 ++++++++++++++++++
 arch/x86/kvm/hyperv.c              | 222 +++++++++++++++++++----------
 arch/x86/kvm/kvm_emulate.h         |   3 +-
 5 files changed, 309 insertions(+), 202 deletions(-)
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



