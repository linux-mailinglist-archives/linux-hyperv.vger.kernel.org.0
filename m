Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F50039915F
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFBRWy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51110 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhFBRWy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id D4EDD20B7188;
        Wed,  2 Jun 2021 10:21:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4EDD20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654470;
        bh=qIKqxDhiVQFAYyc3uyCeXKZGMvLBVFOPM+kH3rX6xfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LF0pCeJXXnXmJf/ZvZyP3Zc0UTKU7JeG+fE+PsRzWKega/QsCGn66yQMkI9oSHKeh
         P3qMlaoL+oL7/7JPhXPwKb+okIp4f44fS1Z6hOIYZt+KRaAOfaG5/HfTe6HIsheMiN
         r2cpi2jfAoHU0241N/W06adZ/6NPzJZbVWbdvLHM=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 01/17] hyperv: Few TLFS definitions
Date:   Wed,  2 Jun 2021 17:20:46 +0000
Message-Id: <37197e2ff04baba4ca112fbd887e73b10e8d5719.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Adding few TLFS definitions which would be used later in
this patch series.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 arch/x86/include/uapi/asm/hyperv-tlfs.h | 2 ++
 include/asm-generic/hyperv-tlfs.h       | 6 ++++++
 include/uapi/asm-generic/hyperv-tlfs.h  | 1 +
 3 files changed, 9 insertions(+)

diff --git a/arch/x86/include/uapi/asm/hyperv-tlfs.h b/arch/x86/include/uapi/asm/hyperv-tlfs.h
index 4447ef5362e9..3ffd6336da27 100644
--- a/arch/x86/include/uapi/asm/hyperv-tlfs.h
+++ b/arch/x86/include/uapi/asm/hyperv-tlfs.h
@@ -1003,6 +1003,8 @@ enum hv_interrupt_type {
 	HV_X64_INTERRUPT_TYPE_MAXIMUM           = 0x000A
 };
 
+#define HV_INTERRUPT_VECTOR_NONE 0xFFFFFFFF
+
 union hv_interrupt_control {
 	struct {
 		__u32 interrupt_type; /* enum hv_interrupt type */
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index b5e4a5003b63..8f08d0e9163d 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -249,7 +249,13 @@ enum hv_status {
 /* Valid SynIC vectors are 16-255. */
 #define HV_SYNIC_FIRST_VALID_VECTOR	(16)
 
+/* Hyper-V defined statically assigned SINTs */
 #define HV_SYNIC_INTERCEPTION_SINT_INDEX 0x00000000
+#define HV_SYNIC_IOMMU_FAULT_SINT_INDEX  0x00000001
+#define HV_SYNIC_VMBUS_SINT_INDEX        0x00000002
+#define HV_SYNIC_HAL_HV_TIMER_SINT_INDEX 0x00000003
+#define HV_SYNIC_HVL_SHARED_SINT_INDEX   0x00000004
+#define HV_SYNIC_FIRST_UNUSED_SINT_INDEX 0x00000005
 
 #define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
 #define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
index 95020e3a67ba..388c4eb29212 100644
--- a/include/uapi/asm-generic/hyperv-tlfs.h
+++ b/include/uapi/asm-generic/hyperv-tlfs.h
@@ -10,6 +10,7 @@
 #define HV_MESSAGE_SIZE			(256)
 #define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
 #define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
+#define HV_ANY_VP			(0xFFFFFFFF)
 
 /* Define hypervisor message types. */
 enum hv_message_type {
-- 
2.25.1

