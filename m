Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A947735DECD
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Apr 2021 14:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbhDMM2G (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Apr 2021 08:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345641AbhDMM1g (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Apr 2021 08:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618316836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZh8yvp08X9sL/+XytQvJGFXyJuUQXuceQE5OT+pb50=;
        b=f/PUScGANuf4bJ3rpSCfpwBY8Bk/yV8FF1PAWPs0rhPEGUvz3kWsswPn6lFg+t3winT9aq
        yCB18uEsQwSsucDLZDGCMKh91E/e494CHplE4BJAqyZmX8lb6PjYXMXseaBAdGZTtrbYyg
        HliyUpWHlYZsb0SQNDe5/2KswBZSfC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-7Sywpr7zN8WjQTh_b3gBFg-1; Tue, 13 Apr 2021 08:27:14 -0400
X-MC-Unique: 7Sywpr7zN8WjQTh_b3gBFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FA73A40C0;
        Tue, 13 Apr 2021 12:27:13 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78DB160C04;
        Tue, 13 Apr 2021 12:27:11 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH RFC 12/22] KVM: x86: hyper-v: Honor HV_ACCESS_FREQUENCY_MSRS privilege bit
Date:   Tue, 13 Apr 2021 14:26:20 +0200
Message-Id: <20210413122630.975617-13-vkuznets@redhat.com>
In-Reply-To: <20210413122630.975617-1-vkuznets@redhat.com>
References: <20210413122630.975617-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

HV_X64_MSR_TSC_FREQUENCY/HV_X64_MSR_APIC_FREQUENCY are only available to
guest when HV_ACCESS_FREQUENCY_MSRS bit is exposed.

Note, writing to HV_X64_MSR_TSC_FREQUENCY/HV_X64_MSR_APIC_FREQUENCY is
unsupported so kvm_hv_set_msr() doesn't need an additional check.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9c4454873e00..e92a1109ad9b 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1637,9 +1637,17 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 					pdata, host);
 	}
 	case HV_X64_MSR_TSC_FREQUENCY:
+		if (unlikely(!host && !(hv_vcpu->cpuid_cache.features_eax &
+					HV_ACCESS_FREQUENCY_MSRS)))
+			return 1;
+
 		data = (u64)vcpu->arch.virtual_tsc_khz * 1000;
 		break;
 	case HV_X64_MSR_APIC_FREQUENCY:
+		if (unlikely(!host && !(hv_vcpu->cpuid_cache.features_eax &
+					HV_ACCESS_FREQUENCY_MSRS)))
+			return 1;
+
 		data = APIC_BUS_FREQUENCY;
 		break;
 	default:
-- 
2.30.2

