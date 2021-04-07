Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1423576D2
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Apr 2021 23:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhDGVaE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Apr 2021 17:30:04 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:18869 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhDGVaD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Apr 2021 17:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1617830994; x=1649366994;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=JJX07rFbUFSCmW7iMNBNJnLHN/ul/VCQMW2GB/8R+9w=;
  b=XuM5o68lErS/35iEYt03BoBEByEaahVaBHuJa1mkJTjtL7oqtuH4qY75
   iHu/dvbICz0zXNhP1ddHr25oFnbgtLcCgGPG+q8hNSdhD8CqAcyKizvdw
   EtNrMXQZ35Xqp6ZkE0YzgelKhIdzmKX9cdTxmNqAbgJBpcmVkHT4Wtduy
   Y=;
X-IronPort-AV: E=Sophos;i="5.82,204,1613433600"; 
   d="scan'208";a="100206498"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Apr 2021 21:29:51 +0000
Received: from EX13D28EUC003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id 18D5C1200AB;
        Wed,  7 Apr 2021 21:29:50 +0000 (UTC)
Received: from uc8bbc9586ea454.ant.amazon.com (10.43.162.68) by
 EX13D28EUC003.ant.amazon.com (10.43.164.43) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 7 Apr 2021 21:29:41 +0000
From:   Siddharth Chandrasekaran <sidcha@amazon.de>
To:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <pbonzini@redhat.com>,
        <seanjc@google.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>
CC:     <sidcha@amazon.de>, <graf@amazon.com>, <eyakovl@amazon.de>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 0/4] Add support for XMM fast hypercalls
Date:   Wed, 7 Apr 2021 23:29:26 +0200
Message-ID: <20210407212926.3016-1-sidcha@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.68]
X-ClientProxiedBy: EX13D01UWA003.ant.amazon.com (10.43.160.107) To
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

Siddharth Chandrasekaran (4):
  KVM: x86: Move FPU register accessors into fpu.h
  KVM: hyper-v: Collect hypercall params into struct
  KVM: x86: kvm_hv_flush_tlb use inputs from XMM registers
  KVM: hyper-v: Advertise support for fast XMM hypercalls

 arch/x86/include/asm/hyperv-tlfs.h |   4 +-
 arch/x86/kvm/emulate.c             | 138 +++--------------
 arch/x86/kvm/fpu.h                 | 140 +++++++++++++++++
 arch/x86/kvm/hyperv.c              | 241 +++++++++++++++++++----------
 4 files changed, 322 insertions(+), 201 deletions(-)
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



