Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B921E1A3823
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Apr 2020 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgDIQiF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Apr 2020 12:38:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43149 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDIQiF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Apr 2020 12:38:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id i10so6352048wrv.10;
        Thu, 09 Apr 2020 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FZy/hx0dFV0MlwQD6zEDjIMh7JIfKHthxPFBWJ2qd2A=;
        b=Qzd7vNCx8chriIimQXaA03B4sENJuQOERkd2pFIPxM9PZrSPptuV/IwwWbiVO+r2H2
         ab+m2fr3UVLhHzx6eFE5CRBScgS+r0YuPTRwIWu7q2NMN3QTJpkh848y8LX0d3897cV3
         IVu0C9l9OmyVfj2l4Gik6ddweXHzFsolwQ9cj8xX3gIrcscVZCR9tek1RdZI6MvYUagd
         ucaGtRefbjJVY9XhyIWKl5dio1kwCPJq3Vo0OQtzUUi13mLKac3twZOnm22e++i1/Pd6
         wd+IoqraBbdX3vjglC9E4CKbc6AWvsyQzMi6S2WEQqM23c2dw93zTDtRL92Y7J0HYunX
         N7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZy/hx0dFV0MlwQD6zEDjIMh7JIfKHthxPFBWJ2qd2A=;
        b=OTWTQvpnhO8GkwokncMs7mzO8+grsOVDvJ/+r0CIY3FLJXjp6uVHj46kWAbSkWyAq4
         F+j0f/UyT2Dw3omR7mtLazCxzHigiGBYmwwhO+9bXxIi5VKXvVLdbH9FxfHrd05RGztC
         gyH72AC6+6gTw+8G3eEcf1DkiAcQuZwQuuM1IKb2bZ2pKn5RZYtcugp80YrRJfmKpQmZ
         h+s5LVGhM+/HbIwHggPS5In98bz6jNXVOK8ZkD78cQy+ayUbgUKgATpcMpgo6f2IxuGs
         zTAVuRJSnAGwZt6a71fu4Pk3XNluf0EPoT0R9bqqnlGamdVTKPrkh5go0ryhvMjp38Dl
         7Pdw==
X-Gm-Message-State: AGi0PuYE/Tai0UOvGP/lVotwcDRNWrsXUdhFhHQ8M64aosXZUDgXb0Wg
        uVCDwsFFIjjsrFS4myqMwwzeI1Ts7JlpMg==
X-Google-Smtp-Source: APiQypKVQf2ccgkskFm0DByLZ6M5DU5iVXnGIoTyDMgIA0r+ZdYUN3v+CFSTlU0/ww2e2DLOvyILOg==
X-Received: by 2002:adf:9e8c:: with SMTP id a12mr14662907wrf.273.1586450282847;
        Thu, 09 Apr 2020 09:38:02 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-55.inter.net.il. [84.229.155.55])
        by smtp.gmail.com with ESMTPSA id f16sm4239240wmc.37.2020.04.09.09.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 09:38:02 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Subject: [PATCH v1 1/1] x86/kvm/hyper-v: Add support to SYNIC exit on EOM
Date:   Thu,  9 Apr 2020 19:37:45 +0300
Message-Id: <20200409163745.573547-2-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200409163745.573547-1-arilou@gmail.com>
References: <20200409163745.573547-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

According to the TLFS a write to the EOM register by the guest
causes the hypervisor to scan for any pending messages and if there
are any it will try to deliver them.

To do this we must exit so any pending messages can be written.

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/hyperv.c           | 65 +++++++++++++++++++++++++++++----
 arch/x86/kvm/hyperv.h           |  1 +
 arch/x86/kvm/x86.c              |  5 +++
 include/uapi/linux/kvm.h        |  1 +
 5 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 42a2d0d3984a..048a1db488e2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -548,6 +548,7 @@ struct kvm_vcpu_hv_synic {
 	DECLARE_BITMAP(vec_bitmap, 256);
 	bool active;
 	bool dont_zero_synic_pages;
+	bool enable_eom_exit;
 };
 
 /* Hyper-V per vcpu emulation context */
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index bcefa9d4e57e..7432f67b2746 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -186,6 +186,49 @@ static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 }
 
+static int synic_read_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
+			  struct hv_message_header *msg)
+{
+	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
+	int msg_off = offsetof(struct hv_message_page, sint_message[sint]);
+	gfn_t msg_page_gfn;
+	int r;
+
+	if (!(synic->msg_page & HV_SYNIC_SIMP_ENABLE))
+		return -ENOENT;
+
+	msg_page_gfn = synic->msg_page >> PAGE_SHIFT;
+
+	r = kvm_vcpu_read_guest_page(vcpu, msg_page_gfn, msg, msg_off,
+				     sizeof(*msg));
+	if (r < 0)
+		return r;
+
+	return 0;
+}
+
+static bool synic_should_exit_for_eom(struct kvm_vcpu_hv_synic *synic)
+{
+	int i;
+
+	if (!synic->enable_eom_exit)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
+		struct hv_message_header hv_hdr;
+		/* If we failed to read from the msg slot then we treat this
+		 * msg slot as free */
+		if (synic_read_msg(synic, i, &hv_hdr) < 0)
+			continue;
+
+		/* See if this msg slot has a pending message */
+		if (hv_hdr.message_flags.msg_pending == 1)
+			return true;
+	}
+
+	return false;
+}
+
 static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
 {
 	struct kvm_vcpu *vcpu = synic_to_vcpu(synic);
@@ -254,6 +297,9 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 
 		for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
 			kvm_hv_notify_acked_sint(vcpu, i);
+
+		if (!host && synic_should_exit_for_eom(synic))
+			synic_exit(synic, msr);
 		break;
 	}
 	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
@@ -571,8 +617,9 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 	struct hv_message_header hv_hdr;
 	int r;
 
-	if (!(synic->msg_page & HV_SYNIC_SIMP_ENABLE))
-		return -ENOENT;
+	r = synic_read_msg(synic, sint, &hv_hdr);
+	if (r < 0)
+		return r;
 
 	msg_page_gfn = synic->msg_page >> PAGE_SHIFT;
 
@@ -582,12 +629,6 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 	 * is only called in vcpu context so the entire update is atomic from
 	 * guest POV and thus the exact order here doesn't matter.
 	 */
-	r = kvm_vcpu_read_guest_page(vcpu, msg_page_gfn, &hv_hdr.message_type,
-				     msg_off + offsetof(struct hv_message,
-							header.message_type),
-				     sizeof(hv_hdr.message_type));
-	if (r < 0)
-		return r;
 
 	if (hv_hdr.message_type != HVMSG_NONE) {
 		if (no_retry)
@@ -785,6 +826,14 @@ int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages)
 	return 0;
 }
 
+int kvm_hv_synic_enable_eom(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv_synic *synic = vcpu_to_synic(vcpu);
+
+	synic->enable_eom_exit = true;
+	return 0;
+}
+
 static bool kvm_hv_msr_partition_wide(u32 msr)
 {
 	bool r = false;
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 757cb578101c..ff89f0ff103c 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -56,6 +56,7 @@ void kvm_hv_irq_routing_update(struct kvm *kvm);
 int kvm_hv_synic_set_irq(struct kvm *kvm, u32 vcpu_id, u32 sint);
 void kvm_hv_synic_send_eoi(struct kvm_vcpu *vcpu, int vector);
 int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages);
+int kvm_hv_synic_enable_eom(struct kvm_vcpu *vcpu);
 
 void kvm_hv_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_hv_vcpu_postcreate(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 027dfd278a97..0def4ab31dc1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3350,6 +3350,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_SPIN:
 	case KVM_CAP_HYPERV_SYNIC:
 	case KVM_CAP_HYPERV_SYNIC2:
+	case KVM_CAP_HYPERV_SYNIC_EOM:
 	case KVM_CAP_HYPERV_VP_INDEX:
 	case KVM_CAP_HYPERV_EVENTFD:
 	case KVM_CAP_HYPERV_TLBFLUSH:
@@ -4209,6 +4210,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 
 	switch (cap->cap) {
+	case KVM_CAP_HYPERV_SYNIC_EOM:
+		kvm_hv_synic_enable_eom(vcpu);
+		return 0;
+
 	case KVM_CAP_HYPERV_SYNIC2:
 		if (cap->args[0])
 			return -EINVAL;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 428c7dde6b4b..78172ad156d8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1017,6 +1017,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_VCPU_RESETS 179
 #define KVM_CAP_S390_PROTECTED 180
 #define KVM_CAP_PPC_SECURE_GUEST 181
+#define KVM_CAP_HYPERV_SYNIC_EOM 182
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.24.1

