Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A9C18F226
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 10:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgCWJvY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 05:51:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38934 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727761AbgCWJvY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 05:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584957083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9+6645sPi1fASJ0KcCpm2RFsMRfFr6BqqazyX1wN/k=;
        b=Yr6IDOTPMves1f2IUYLtjwsjSe1gMH+QaL40qS6UXbwCryX2+mQIOEasVeGdGOc7COoFla
        2hdR2cKabO0gtnN0QHNCzXlPDJB0SJisb+6+BSUmwHzQwBULQcEoUBb9B5al666j70bY11
        Nc2liKy6Zj8IzyvPP/hubuC8mKdpixU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-OOMVferVM52_c_F4t1-SzA-1; Mon, 23 Mar 2020 05:51:21 -0400
X-MC-Unique: OOMVferVM52_c_F4t1-SzA-1
Received: by mail-wr1-f69.google.com with SMTP id w12so475623wrl.23
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Mar 2020 02:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9+6645sPi1fASJ0KcCpm2RFsMRfFr6BqqazyX1wN/k=;
        b=ZiyUDcH1Zi10f7AYgFprh2wW2yg59dIpheWN1lQxG+yyR0WSjxf2/VT2c3FLNPqCUI
         rdI3/8xMVMeHO3Qtxr2/GgUf8Rn3TcuGa86yrYbBtPm3NWhorDF0XG1+gvunQMbhAkQo
         wG1ofTIawSpA+fUAB/RDf4LE0IEMi3xQ/o7cFPEmjIXtQdkcPsV1gEXo+C1W10j+fLMg
         MZypfm5rkvAAbxbZPWmMq2HzMl+1k2Le501XQ4F4XgzjZRKsWE3LVWt2ZJTyxN2jLj6x
         ZB5fm1gJd+KDaDoN3aeB9QejMt0O70gbeo5FcoVjp033cHmpPU6TbDwLYkE6h4sHx9Ht
         2f9A==
X-Gm-Message-State: ANhLgQ30zLmS6oh2CPTHUEdPWv0WMg0RZsMar/fovSDvkSZwx6JemfYh
        fvN0jguSC5n2VKV4hY+XhehYO4j7/6dzjttmpI2cGSdZ2hduAqkUyOt3RHqSBieOCC7gIqUpGMC
        jTuyjmE4yKfEcRh/ai6c9Ba2L
X-Received: by 2002:adf:82ab:: with SMTP id 40mr27417734wrc.323.1584957080160;
        Mon, 23 Mar 2020 02:51:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtUV7FqQscmqj3q4oH38ic1AMhDaUYsywOSrGal0U/EKipzlg4SOAnK2JAsoZzy7hHYSffBTQ==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr27417703wrc.323.1584957079858;
        Mon, 23 Mar 2020 02:51:19 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d5sm13256414wrh.40.2020.03.23.02.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 02:51:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org, Jon Doron <arilou@gmail.com>
Subject: [PATCH v9 7/6] KVM: selftests: update hyperv_cpuid with SynDBG tests
Date:   Mon, 23 Mar 2020 10:51:16 +0100
Message-Id: <20200323095116.415586-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320172839.1144395-1-arilou@gmail.com>
References: <20200320172839.1144395-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Test all four combinations with eVMCS and SynDBG capabilities,
check that we get the right number of entries and that
0x40000000.EAX always returns the correct max leaf.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 .../selftests/kvm/x86_64/hyperv_cpuid.c       | 138 ++++++++++++------
 1 file changed, 96 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index 83323f3d7ca0..4a2ef7e1b1f9 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -26,18 +26,18 @@ static void guest_code(void)
 {
 }
 
-static int smt_possible(void)
+static bool smt_possible(void)
 {
 	char buf[16];
 	FILE *f;
-	bool res = 1;
+	bool res = true;
 
 	f = fopen("/sys/devices/system/cpu/smt/control", "r");
 	if (f) {
 		if (fread(buf, sizeof(*buf), sizeof(buf), f) > 0) {
 			if (!strncmp(buf, "forceoff", 8) ||
 			    !strncmp(buf, "notsupported", 12))
-				res = 0;
+				res = false;
 		}
 		fclose(f);
 	}
@@ -45,30 +45,48 @@ static int smt_possible(void)
 	return res;
 }
 
+void vcpu_enable_syndbg(struct kvm_vm *vm, int vcpu_id)
+{
+	struct kvm_enable_cap enable_syndbg_cap = {
+		.cap = KVM_CAP_HYPERV_SYNDBG,
+	};
+
+	vcpu_ioctl(vm, vcpu_id, KVM_ENABLE_CAP, &enable_syndbg_cap);
+}
+
 static void test_hv_cpuid(struct kvm_cpuid2 *hv_cpuid_entries,
-			  int evmcs_enabled)
+			  bool evmcs_enabled, bool syndbg_enabled)
 {
 	int i;
+	int nent = 6;
+	u32 test_val;
+
+	if (evmcs_enabled)
+		nent += 1; /* 0x4000000A */
 
-	if (!evmcs_enabled)
-		TEST_ASSERT(hv_cpuid_entries->nent == 6,
-			    "KVM_GET_SUPPORTED_HV_CPUID should return 6 entries"
-			    " when Enlightened VMCS is disabled (returned %d)",
-			    hv_cpuid_entries->nent);
-	else
-		TEST_ASSERT(hv_cpuid_entries->nent == 7,
-			    "KVM_GET_SUPPORTED_HV_CPUID should return 7 entries"
-			    " when Enlightened VMCS is enabled (returned %d)",
-			    hv_cpuid_entries->nent);
+	if (syndbg_enabled)
+		nent += 3; /* 0x40000080 - 0x40000082 */
+
+	TEST_ASSERT(hv_cpuid_entries->nent == nent,
+		    "KVM_GET_SUPPORTED_HV_CPUID should return %d entries"
+		    " with evmcs=%d syndbg=%d (returned %d)",
+		    nent, evmcs_enabled, syndbg_enabled,
+		    hv_cpuid_entries->nent);
 
 	for (i = 0; i < hv_cpuid_entries->nent; i++) {
 		struct kvm_cpuid_entry2 *entry = &hv_cpuid_entries->entries[i];
 
 		TEST_ASSERT((entry->function >= 0x40000000) &&
-			    (entry->function <= 0x4000000A),
+			    (entry->function <= 0x40000082),
 			    "function %x is our of supported range",
 			    entry->function);
 
+		TEST_ASSERT(evmcs_enabled || (entry->function != 0x4000000A),
+			    "0x4000000A leaf should not be reported");
+
+		TEST_ASSERT(syndbg_enabled || (entry->function <= 0x4000000A),
+			    "SYNDBG leaves should not be reported");
+
 		TEST_ASSERT(entry->index == 0,
 			    ".index field should be zero");
 
@@ -78,12 +96,27 @@ static void test_hv_cpuid(struct kvm_cpuid2 *hv_cpuid_entries,
 		TEST_ASSERT(!entry->padding[0] && !entry->padding[1] &&
 			    !entry->padding[2], "padding should be zero");
 
-		if (entry->function == 0x40000004) {
-			int nononarchcs = !!(entry->eax & (1UL << 18));
-
-			TEST_ASSERT(nononarchcs == !smt_possible(),
+		switch (entry->function) {
+		case 0x40000000:
+			test_val = 0x40000005;
+			if (evmcs_enabled)
+				test_val = 0x4000000A;
+			if (syndbg_enabled)
+				test_val = 0x40000082;
+
+			TEST_ASSERT(entry->eax == test_val,
+				    "Wrong max leaf report in 0x40000000.EAX: %x"
+				    " (evmcs=%d syndbg=%d)",
+				    entry->eax, evmcs_enabled, syndbg_enabled
+				);
+			break;
+		case 0x40000004:
+			test_val = entry->eax & (1UL << 18);
+
+			TEST_ASSERT(!!test_val == !smt_possible(),
 				    "NoNonArchitecturalCoreSharing bit"
 				    " doesn't reflect SMT setting");
+			break;
 		}
 
 		/*
@@ -133,8 +166,9 @@ struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(struct kvm_vm *vm)
 int main(int argc, char *argv[])
 {
 	struct kvm_vm *vm;
-	int rv;
+	int rv, stage;
 	struct kvm_cpuid2 *hv_cpuid_entries;
+	bool evmcs_enabled, syndbg_enabled;
 
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
@@ -150,31 +184,51 @@ int main(int argc, char *argv[])
 
 	test_hv_cpuid_e2big(vm);
 
-	hv_cpuid_entries = kvm_get_supported_hv_cpuid(vm);
-	if (!hv_cpuid_entries)
-		return 1;
-
-	test_hv_cpuid(hv_cpuid_entries, 0);
+	kvm_vm_free(vm);
 
-	free(hv_cpuid_entries);
+	for (stage = 0; stage < 5; stage++) {
+		evmcs_enabled = false;
+		syndbg_enabled = false;
+
+		vm = vm_create_default(VCPU_ID, 0, guest_code);
+		switch (stage) {
+		case 0:
+			test_hv_cpuid_e2big(vm);
+			continue;
+		case 1:
+			break;
+		case 2:
+			if (!kvm_check_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS)) {
+				print_skip("Enlightened VMCS is unsupported");
+				continue;
+			}
+			vcpu_enable_evmcs(vm, VCPU_ID);
+			evmcs_enabled = true;
+			break;
+		case 3:
+			if (!kvm_check_cap(KVM_CAP_HYPERV_SYNDBG)) {
+				print_skip("Synthetic debugger is unsupported");
+				continue;
+			}
+			vcpu_enable_syndbg(vm, VCPU_ID);
+			syndbg_enabled = true;
+			break;
+		case 4:
+			if (!kvm_check_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS) ||
+			    !kvm_check_cap(KVM_CAP_HYPERV_SYNDBG))
+				continue;
+			vcpu_enable_evmcs(vm, VCPU_ID);
+			vcpu_enable_syndbg(vm, VCPU_ID);
+			evmcs_enabled = true;
+			syndbg_enabled = true;
+			break;
+		}
 
-	if (!kvm_check_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS)) {
-		print_skip("Enlightened VMCS is unsupported");
-		goto vm_free;
+		hv_cpuid_entries = kvm_get_supported_hv_cpuid(vm);
+		test_hv_cpuid(hv_cpuid_entries, evmcs_enabled, syndbg_enabled);
+		free(hv_cpuid_entries);
+		kvm_vm_free(vm);
 	}
 
-	vcpu_enable_evmcs(vm, VCPU_ID);
-
-	hv_cpuid_entries = kvm_get_supported_hv_cpuid(vm);
-	if (!hv_cpuid_entries)
-		return 1;
-
-	test_hv_cpuid(hv_cpuid_entries, 1);
-
-	free(hv_cpuid_entries);
-
-vm_free:
-	kvm_vm_free(vm);
-
 	return 0;
 }
-- 
2.25.1

