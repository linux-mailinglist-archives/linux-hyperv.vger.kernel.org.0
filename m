Return-Path: <linux-hyperv+bounces-797-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EAB7E5DD0
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 20:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE0528178C
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE2B374DA;
	Wed,  8 Nov 2023 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dn8wFB/c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A337143;
	Wed,  8 Nov 2023 19:00:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D302119;
	Wed,  8 Nov 2023 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699470022; x=1731006022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ugNGavNYuSf5wYXEen+dICOBfpsxHOVLj3Ud+LTuUyE=;
  b=dn8wFB/cveXev6ItVaR48e/7JdR1+mX2WzVWtWYMOe6OQGM0NptivTjg
   BaHi3JTLprSSe2Ikc0Lo7gQFhxXJ+8Nh+9VExZxvSJSRjPVVtbAlY2AWt
   w9r8rPv1HCNAT49p4yoaAuhzHiN7S2v+X0Bla3CzQ9GkR8k/L8rmO2WZW
   yREUpNjlcKHWWkChFEXPID9RpThh+5dhUx5IhOog3Wo6MGjNEphknujLB
   U3FWT/j7ebOS1vYE2e70Ldbv/WfgcS4c9fuWA5s1WvMYyXs7nDchvUSxX
   34AcSZTtMuJgfHMgpekMyGEMDAhZTdbJYFENX7YgP45Z6RP5Tie0qh+QX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8486325"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="8486325"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:00:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="10892459"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orviesa001.jf.intel.com with ESMTP; 08 Nov 2023 11:00:20 -0800
From: Xin Li <xin3.li@intel.com>
To: kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	corbet@lwn.net,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	vkuznets@redhat.com,
	peterz@infradead.org,
	ravi.v.shankar@intel.com
Subject: [PATCH v1 10/23] KVM: VMX: Add support for FRED context save/restore
Date: Wed,  8 Nov 2023 10:29:50 -0800
Message-ID: <20231108183003.5981-11-xin3.li@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108183003.5981-1-xin3.li@intel.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle host initiated FRED MSR access requests to allow FRED context
to be set/get from user level.

During VM save/restore and live migration, FRED context needs to be
saved/restored, which requires FRED MSRs to be accessed from a user
level application, e.g., Qemu.

Note, handling of MSR_IA32_FRED_SSP0, i.e., MSR_IA32_PL0_SSP, is not
added yet, which needs to be aligned with KVM CET patch set.

Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c     | 23 ++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d00ab9d4c93e..58d01e845804 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1429,6 +1429,24 @@ static void vmx_write_guest_kernel_gs_base(struct vcpu_vmx *vmx, u64 data)
 	preempt_enable();
 	vmx->msr_guest_kernel_gs_base = data;
 }
+
+static u64 vmx_read_guest_fred_rsp0(struct vcpu_vmx *vmx)
+{
+	preempt_disable();
+	if (vmx->guest_state_loaded)
+		vmx->msr_guest_fred_rsp0 = read_msr(MSR_IA32_FRED_RSP0);
+	preempt_enable();
+	return vmx->msr_guest_fred_rsp0;
+}
+
+static void vmx_write_guest_fred_rsp0(struct vcpu_vmx *vmx, u64 data)
+{
+	preempt_disable();
+	if (vmx->guest_state_loaded)
+		wrmsrl(MSR_IA32_FRED_RSP0, data);
+	preempt_enable();
+	vmx->msr_guest_fred_rsp0 = data;
+}
 #endif
 
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
@@ -2028,6 +2046,33 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_KERNEL_GS_BASE:
 		msr_info->data = vmx_read_guest_kernel_gs_base(vmx);
 		break;
+	case MSR_IA32_FRED_RSP0:
+		msr_info->data = vmx_read_guest_fred_rsp0(vmx);
+		break;
+	case MSR_IA32_FRED_RSP1:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_RSP1);
+		break;
+	case MSR_IA32_FRED_RSP2:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_RSP2);
+		break;
+	case MSR_IA32_FRED_RSP3:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_RSP3);
+		break;
+	case MSR_IA32_FRED_STKLVLS:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_STKLVLS);
+		break;
+	case MSR_IA32_FRED_SSP1:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_SSP1);
+		break;
+	case MSR_IA32_FRED_SSP2:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_SSP2);
+		break;
+	case MSR_IA32_FRED_SSP3:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_SSP3);
+		break;
+	case MSR_IA32_FRED_CONFIG:
+		msr_info->data = vmcs_read64(GUEST_IA32_FRED_CONFIG);
+		break;
 #endif
 	case MSR_EFER:
 		return kvm_get_msr_common(vcpu, msr_info);
@@ -2233,6 +2278,33 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vmx_update_exception_bitmap(vcpu);
 		}
 		break;
+	case MSR_IA32_FRED_RSP0:
+		vmx_write_guest_fred_rsp0(vmx, data);
+		break;
+	case MSR_IA32_FRED_RSP1:
+		vmcs_write64(GUEST_IA32_FRED_RSP1, data);
+		break;
+	case MSR_IA32_FRED_RSP2:
+		vmcs_write64(GUEST_IA32_FRED_RSP2, data);
+		break;
+	case MSR_IA32_FRED_RSP3:
+		vmcs_write64(GUEST_IA32_FRED_RSP3, data);
+		break;
+	case MSR_IA32_FRED_STKLVLS:
+		vmcs_write64(GUEST_IA32_FRED_STKLVLS, data);
+		break;
+	case MSR_IA32_FRED_SSP1:
+		vmcs_write64(GUEST_IA32_FRED_SSP1, data);
+		break;
+	case MSR_IA32_FRED_SSP2:
+		vmcs_write64(GUEST_IA32_FRED_SSP2, data);
+		break;
+	case MSR_IA32_FRED_SSP3:
+		vmcs_write64(GUEST_IA32_FRED_SSP3, data);
+		break;
+	case MSR_IA32_FRED_CONFIG:
+		vmcs_write64(GUEST_IA32_FRED_CONFIG, data);
+		break;
 #endif
 	case MSR_IA32_SYSENTER_CS:
 		if (is_guest_mode(vcpu))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2c924075f6f1..c5a55810647f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1451,6 +1451,9 @@ static const u32 msrs_to_save_base[] = {
 	MSR_STAR,
 #ifdef CONFIG_X86_64
 	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
+	MSR_IA32_FRED_RSP0, MSR_IA32_FRED_RSP1, MSR_IA32_FRED_RSP2,
+	MSR_IA32_FRED_RSP3, MSR_IA32_FRED_STKLVLS, MSR_IA32_FRED_SSP1,
+	MSR_IA32_FRED_SSP2, MSR_IA32_FRED_SSP3, MSR_IA32_FRED_CONFIG,
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
@@ -1890,6 +1893,16 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 
 		data = (u32)data;
 		break;
+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
+		if (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_FRED))
+			break;
+
+		/*
+		 * Inject #GP upon FRED MSRs accesses from a non-FRED guest to
+		 * make sure no malicious guest can write to FRED MSRs thus to
+		 * corrupt host FRED MSRs.
+		 */
+		return 1;
 	}
 
 	msr.data = data;
@@ -1933,6 +1946,16 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDPID))
 			return 1;
 		break;
+	case MSR_IA32_FRED_RSP0 ... MSR_IA32_FRED_CONFIG:
+		if (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_FRED))
+			break;
+
+		/*
+		 * Inject #GP upon FRED MSRs accesses from a non-FRED guest to
+		 * make sure no malicious guest can write to FRED MSRs thus to
+		 * corrupt host FRED MSRs.
+		 */
+		return 1;
 	}
 
 	msr.index = index;
-- 
2.42.0


