Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEAA1ABC38
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2020 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502689AbgDPIjL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Apr 2020 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502682AbgDPIjF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Apr 2020 04:39:05 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DF4C061A10;
        Thu, 16 Apr 2020 01:39:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k11so3820502wrp.5;
        Thu, 16 Apr 2020 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PkvJMl1gqjbqsZHs+qV+I97naXMp6apsvSAWhtAhZ1U=;
        b=Us5R3I5nXYZ/qD4V87LVi5rjfklLkNZJPGc1m/boLL6nmQoSwEmWJXz/ZYIinnCMsp
         C8wqvCQxkRXFrgmYGkZdIPTO1UCOIHnTuV97OWUzSWVl7ll0CvjQ6IN+kPq76sXXUUpj
         Vbi5Q3iVbVYYpeHqC7EDerGtiu7vmtsxq1KmVQhRAmzE1YPPyEfdpFIREvUfXbB84jg1
         73+0U50AS/wVu4qR089bG+eVc/ptnAys70Rt56hZy5i/Sv/1UL3gYIoquJllqaPyP+kJ
         +9gxelePEjcgFxDHgqHMw2t7hwo6zCCgtM5X9wA3CHzwvRHZRjwPBWjkibg1k+5YGw0Y
         CqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PkvJMl1gqjbqsZHs+qV+I97naXMp6apsvSAWhtAhZ1U=;
        b=fa1nu7odWMFnINTfF80ERmeHqNnUmdC1/XW7YmstkZD4H+vvX7DzDw9eK3aDu0mfm/
         hNh5UdwV/6AeFpLsbnxB0Um2qfTJ+QprzZJJVYPodzOggQ3nNHW3XumA54S4MC2zd/y1
         Hj0AiId5fltsyeYfdMSzYJwGQrQb6e6w2Zs8M2rJsN1tuY/d7UtqCSxl/nfpcX0mgulc
         YpQwsWZP4mqFhqj9k6REaV2XAmr1SX8xIq9x4J2A0b6VtpHGcGhJjU1gqs0BkurZqndm
         q2nBi2n69xx/uTdJqjswP5YFxeLEZ+i9SIaeFbfcJkDt/+IhcaXvKV/keeZP9xndUxzu
         rASQ==
X-Gm-Message-State: AGi0PubwGoVrNle46nf1/zwy8bI+8Dtos5CdGGNt7spAPOQEX3Vbq7Nr
        u/nBK+j4zFvM5LvsENVmufbwsIX2NW986w==
X-Google-Smtp-Source: APiQypJKsd9oyZg3ySBMjY8FH2RQyTioVfnAsmkgeOFQTYRHKx0dtq8hnwkidMNNEulteSXbN3wzRA==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr32017503wrs.22.1587026342989;
        Thu, 16 Apr 2020 01:39:02 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-55.inter.net.il. [84.229.155.55])
        by smtp.gmail.com with ESMTPSA id s12sm1256358wmc.7.2020.04.16.01.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:39:02 -0700 (PDT)
From:   Jon Doron <arilou@gmail.com>
To:     kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     vkuznets@redhat.com, rvkagan@yandex-team.ru,
        Jon Doron <arilou@gmail.com>
Subject: [PATCH v2 1/1] x86/kvm/hyper-v: Add support to SYNIC exit on EOM
Date:   Thu, 16 Apr 2020 11:38:47 +0300
Message-Id: <20200416083847.1776387-2-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416083847.1776387-1-arilou@gmail.com>
References: <20200416083847.1776387-1-arilou@gmail.com>
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
 arch/x86/kvm/hyperv.c           | 67 +++++++++++++++++++++++++++++----
 arch/x86/kvm/hyperv.h           |  1 +
 arch/x86/kvm/x86.c              |  5 +++
 include/uapi/linux/kvm.h        |  1 +
 5 files changed, 67 insertions(+), 8 deletions(-)

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
index bcefa9d4e57e..4bf35452ae5c 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -186,6 +186,51 @@ static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 }
 
+static int synic_read_msg_hdr(struct kvm_vcpu_hv_synic *synic, u32 sint,
+			      struct hv_message_header *msg)
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
+static bool synic_should_exit_on_eom(struct kvm_vcpu_hv_synic *synic)
+{
+	int i;
+
+	if (!synic->enable_eom_exit)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(synic->sint); i++) {
+		struct hv_message_header hv_hdr;
+		/*
+		 * If we failed to read from the msg slot then we treat this
+		 * msg slot as free
+		 */
+		if (synic_read_msg_hdr(synic, i, &hv_hdr) < 0)
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
@@ -254,6 +299,9 @@ static int synic_set_msr(struct kvm_vcpu_hv_synic *synic,
 
 		for (i = 0; i < ARRAY_SIZE(synic->sint); i++)
 			kvm_hv_notify_acked_sint(vcpu, i);
+
+		if (!host && synic_should_exit_on_eom(synic))
+			synic_exit(synic, msr);
 		break;
 	}
 	case HV_X64_MSR_SINT0 ... HV_X64_MSR_SINT15:
@@ -571,8 +619,9 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 	struct hv_message_header hv_hdr;
 	int r;
 
-	if (!(synic->msg_page & HV_SYNIC_SIMP_ENABLE))
-		return -ENOENT;
+	r = synic_read_msg_hdr(synic, sint, &hv_hdr);
+	if (r < 0)
+		return r;
 
 	msg_page_gfn = synic->msg_page >> PAGE_SHIFT;
 
@@ -582,12 +631,6 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
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
@@ -785,6 +828,14 @@ int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages)
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
index 3bf2ecafd027..1615be238806 100644
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

