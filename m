Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D496A39A425
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jun 2021 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhFCPQi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Jun 2021 11:16:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45716 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhFCPQg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Jun 2021 11:16:36 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5A27420B8010;
        Thu,  3 Jun 2021 08:14:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A27420B8010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622733291;
        bh=iQN0d8I5sicWeBnRwCE2733S1qvQ5j7UkULfuF/VYLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qEfGQ8F1EacN8c9Smya0hlpm5xjPzJWnmtTOQS3Tqy/Ls4QDucG5FNwn6a56/BxMQ
         JnTj/11b+yjS9fDneNksy2ODKmrPGXm0yF8WEZ+qPpiPnXpgRuTLOpYveQ/XpzUnkS
         OjZypL12T32IVVVO6uXW6MfZXd4p0sXOGtuYmfvc=
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
Subject: [PATCH v5 6/7] KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
Date:   Thu,  3 Jun 2021 15:14:39 +0000
Message-Id: <87df0710f95d28b91cc4ea014fc4d71056eebbee.1622730232.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622730232.git.viremana@linux.microsoft.com>
References: <cover.1622730232.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Enlightened MSR-Bitmap as per TLFS:

 "The L1 hypervisor may collaborate with the L0 hypervisor to make MSR
  accesses more efficient. It can enable enlightened MSR bitmaps by setting
  the corresponding field in the enlightened VMCS to 1. When enabled, L0
  hypervisor does not monitor the MSR bitmaps for changes. Instead, the L1
  hypervisor must invalidate the corresponding clean field after making
  changes to one of the MSR bitmaps."

Enable this for SVM.

Related VMX changes:
commit ceef7d10dfb6 ("KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support")

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 arch/x86/kvm/svm/svm.c          |  3 +++
 arch/x86/kvm/svm/svm.h          |  5 +++++
 arch/x86/kvm/svm/svm_onhyperv.h | 27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a39865dbc200..d2a625411059 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -671,6 +671,9 @@ static void set_msr_interception_bitmap(struct kvm_vcpu *vcpu, u32 *msrpm,
 	write ? clear_bit(bit_write, &tmp) : set_bit(bit_write, &tmp);
 
 	msrpm[offset] = tmp;
+
+	svm_hv_vmcb_dirty_nested_enlightenments(vcpu);
+
 }
 
 void set_msr_interception(struct kvm_vcpu *vcpu, u32 *msrpm, u32 msr,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index eb4b91832912..1d64d246ebbe 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -254,6 +254,11 @@ static inline void vmcb_mark_all_clean(struct vmcb *vmcb)
 			       & ~VMCB_ALWAYS_DIRTY_MASK;
 }
 
+static inline bool vmcb_is_clean(struct vmcb *vmcb, int bit)
+{
+	return (vmcb->control.clean & (1 << bit));
+}
+
 static inline void vmcb_mark_dirty(struct vmcb *vmcb, int bit)
 {
 	vmcb->control.clean &= ~(1 << bit);
diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
index 57291e222395..0f262460b2e6 100644
--- a/arch/x86/kvm/svm/svm_onhyperv.h
+++ b/arch/x86/kvm/svm/svm_onhyperv.h
@@ -31,6 +31,11 @@ struct hv_enlightenments {
 	u64 reserved;
 } __packed;
 
+/*
+ * Hyper-V uses the software reserved clean bit in VMCB
+ */
+#define VMCB_HV_NESTED_ENLIGHTENMENTS VMCB_SW
+
 static inline void svm_hv_init_vmcb(struct vmcb *vmcb)
 {
 	struct hv_enlightenments *hve =
@@ -52,6 +57,23 @@ static inline void svm_hv_hardware_setup(void)
 	}
 }
 
+static inline void svm_hv_vmcb_dirty_nested_enlightenments(
+		struct kvm_vcpu *vcpu)
+{
+	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
+	struct hv_enlightenments *hve =
+		(struct hv_enlightenments *)vmcb->control.reserved_sw;
+
+	/*
+	 * vmcb can be NULL if called during early vcpu init.
+	 * And its okay not to mark vmcb dirty during vcpu init
+	 * as we mark it dirty unconditionally towards end of vcpu
+	 * init phase.
+	 */
+	if (vmcb && vmcb_is_clean(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS) &&
+	    hve->hv_enlightenments_control.msr_bitmap)
+		vmcb_mark_dirty(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS);
+}
 #else
 
 static inline void svm_hv_init_vmcb(struct vmcb *vmcb)
@@ -61,6 +83,11 @@ static inline void svm_hv_init_vmcb(struct vmcb *vmcb)
 static inline void svm_hv_hardware_setup(void)
 {
 }
+
+static inline void svm_hv_vmcb_dirty_nested_enlightenments(
+		struct kvm_vcpu *vcpu)
+{
+}
 #endif /* CONFIG_HYPERV */
 
 #endif /* __ARCH_X86_KVM_SVM_ONHYPERV_H__ */
-- 
2.25.1

