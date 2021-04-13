Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186F435DEA4
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhDMM06 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 08:26:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231337AbhDMM05 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 08:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618316797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gHXO771pHe9zTon0JL2N9C6BipX6JwrG/i20Z7QO1yU=;
        b=GuA6Rtthf8JXqJQFj/qpp7burMWEpjnmaWQmghpIYLFBTi2eIyag/QVldlDlzsulqwCFlb
        wbItJAknyNXHEdulcAA5LOpaNx394ssS15qoeKg6Al0909mfgps1JzlDY1KOANPa8KmgZ/
        LNOi4wiTsNcO48vT2ORJ2lmmO9oiSv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-XnBuu0xjN3SGTxk9jSZ6cQ-1; Tue, 13 Apr 2021 08:26:36 -0400
X-MC-Unique: XnBuu0xjN3SGTxk9jSZ6cQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44E488030D0;
        Tue, 13 Apr 2021 12:26:34 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3AB660C04;
        Tue, 13 Apr 2021 12:26:31 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH RFC 00/22] KVM: x86: hyper-v: Fine-grained access check to Hyper-V hypercalls and MSRs
Date:   Tue, 13 Apr 2021 14:26:08 +0200
Message-Id: <20210413122630.975617-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, all implemented Hyper-V features (MSRs and hypercalls) are
available unconditionally to all Hyper-V enabled guests. This is not
ideal as KVM userspace may decide to provide only a subset of the
currently implemented features to emulate an older Hyper-V version,
to reduce attack surface,... Implement checks against guest visible
CPUIDs for all currently implemented MSRs and hypercalls.

RFC part:
- KVM has KVM_CAP_ENFORCE_PV_FEATURE_CPUID for KVM PV features. Should
 we use it for Hyper-V as well or should we rather add a Hyper-V specific
 CAP (or neither)?

TODO:
- Write a selftest
- Check with various Windows/Hyper-V versions that CPUID feature bits
 are actually respected.

Vitaly Kuznetsov (22):
  asm-generic/hyperv: add HV_STATUS_ACCESS_DENIED definition
  KVM: x86: hyper-v: Cache guest CPUID leaves determining features
    availability
  KVM: x86: hyper-v: Honor HV_MSR_VP_RUNTIME_AVAILABLE privilege bit
  KVM: x86: hyper-v: Honor HV_MSR_TIME_REF_COUNT_AVAILABLE privilege bit
  KVM: x86: hyper-v: Honor HV_MSR_HYPERCALL_AVAILABLE privilege bit
  KVM: x86: hyper-v: Honor HV_MSR_VP_INDEX_AVAILABLE privilege bit
  KVM: x86: hyper-v: Honor HV_MSR_RESET_AVAILABLE privilege bit
  KVM: x86: hyper-v: Honor HV_MSR_REFERENCE_TSC_AVAILABLE privilege bit
  KVM: x86: hyper-v: Honor HV_MSR_SYNIC_AVAILABLE privilege bit
  KVM: x86: hyper-v: Honor HV_MSR_SYNTIMER_AVAILABLE privilege bit
  KVM: x86: hyper-v: Honor HV_MSR_APIC_ACCESS_AVAILABLE privilege bit
  KVM: x86: hyper-v: Honor HV_ACCESS_FREQUENCY_MSRS privilege bit
  KVM: x86: hyper-v: Honor HV_ACCESS_REENLIGHTENMENT privilege bit
  KVM: x86: hyper-v: Honor HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
    privilege bit
  KVM: x86: hyper-v: Honor HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
    privilege bit
  KVM: x86: hyper-v: Honor HV_STIMER_DIRECT_MODE_AVAILABLE privilege bit
  KVM: x86: hyper-v: Honor HV_POST_MESSAGES privilege bit
  KVM: x86: hyper-v: Honor HV_SIGNAL_EVENTS privilege bit
  KVM: x86: hyper-v: Honor HV_DEBUGGING privilege bit
  KVM: x86: hyper-v: Honor HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED bit
  KVM: x86: hyper-v: Honor HV_X64_CLUSTER_IPI_RECOMMENDED bit
  KVM: x86: hyper-v: Check access to HVCALL_NOTIFY_LONG_SPIN_WAIT
    hypercall

 arch/x86/include/asm/kvm_host.h   |   8 +
 arch/x86/kvm/hyperv.c             | 305 +++++++++++++++++++++++++++---
 include/asm-generic/hyperv-tlfs.h |   1 +
 3 files changed, 291 insertions(+), 23 deletions(-)

-- 
2.30.2

