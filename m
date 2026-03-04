Return-Path: <linux-hyperv+bounces-9141-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEpcDJ3DqGk2xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9141-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE02090F4
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D64230988B4
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD3397692;
	Wed,  4 Mar 2026 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmkaU/Kh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDF382289;
	Wed,  4 Mar 2026 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667752; cv=none; b=KVCI0HaaPOjNhM5bhNMImWQubYEm4GH2VqDopc9B+pttjZKFvNX6exlSDQxCmFs8KYtjMlhX7VHQq/Buh08SZO9UKeuMo8s7fNKjjn8RGxidsdJ0bfUCUX6zfug0yhwxZFAE7R/1TMQqYDzQjtHn29y/qi2A+445zzuIjVQMEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667752; c=relaxed/simple;
	bh=ciTx6jFLRX+cYPzbQO5DkDfWrCNsSfpCsP/sfCfc7Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHL50y/PMUsuOha3OMy7DpR13+HUaOfBYwu7mLxFkn2fd8CzaffSc0vEkKDeqMmYt3x7kP1B5ZXVHCis4os3eg08GWu1RohwrAOFpXcGgSc4/Jlsd68Lsv4/itjWuP+HsQyb5O2DbovlvHr/qaQA2Gv5KrvqMaaC89g3pSnvPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmkaU/Kh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667752; x=1804203752;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ciTx6jFLRX+cYPzbQO5DkDfWrCNsSfpCsP/sfCfc7Zk=;
  b=TmkaU/KhbE6U4Ri6EnjGIZGFMRk7FBbPCojkGISsX+lx4+plo/cKukiW
   GINHpwdtQUtjePsdMLU/70d5mSXozowAVx3q4W70d3JCAvIjTTSN+kp0M
   AISGj5T4nOuAEc/RJ2uwKaPzJY27qr090nF+iSL+DxAybaBBjjdiDdeyy
   xXz/CugUPE2hh/ZRbNdQDjScPzkzarrR/B10g0RuO/MRxIgH1BHw7FW4y
   T4SkApHRSUXPtvH7qPgYoAcqs1jCCINlV9sJi3dY2wSavoUoPkXbLAeQe
   2z+Wpy8ZRVArcX7n+c8L+zddisgXCspEOLb8JyVuSQu1jg7ifFbXLWeO7
   g==;
X-CSE-ConnectionGUID: 6JeTAXVHSqWI1TPSdo9DPw==
X-CSE-MsgGUID: dadBYRQuQfehXh3nBLnvyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359377"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359377"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:30 -0800
X-CSE-ConnectionGUID: FzfG3nLdRsyG1ScA4+MSFg==
X-CSE-MsgGUID: OKXuyCwnRzuw4bEYCc0wqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376899"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:28 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 04 Mar 2026 15:41:14 -0800
Subject: [PATCH v9 03/10] dt-bindings: reserved-memory: Wakeup Mailbox for
 Intel processors
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-rneri-wakeup-mailbox-v9-3-a5c6845e6251@linux.intel.com>
References: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
In-Reply-To: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 "Rafael J. Wysocki (Intel)" <rafael.j.wysocki@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=5252;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=ciTx6jFLRX+cYPzbQO5DkDfWrCNsSfpCsP/sfCfc7Zk=;
 b=XkvYdYE34j1ulN0kd9woS3K+p89IhdGXqj/v3Z6brWdhNW0ROExOuBToSnyI6qtEWrfwjpQMo
 GrRtrhIKil5CuCo8um3ZIGFfolVbWvyDWos7a1Q7/c8WjUaJedKefSO
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: 9DEE02090F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9141-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[n:email,devicetree.org:url,linux.intel.com:mid,uefi.org:url,intel.com:dkim,intel.com:email,intel.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add DeviceTree bindings to enumerate the wakeup mailbox used in platform
firmware for Intel processors.

x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
followed by Start-Up IPI messages. The wakeup mailbox can be used when this
mechanism is unavailable.

The wakeup mailbox offers more control to the operating system to boot
secondary CPUs than a spin-table. It allows the reuse of the same wakeup
vector for all CPUs while maintaining control over which CPUs to boot and
when. While it is possible to achieve the same level of control using a
spin-table, it would require specifying a separate `cpu-release-addr` for
each secondary CPU.

The operation and structure of the mailbox are described in the
Multiprocessor Wakeup Structure defined in the ACPI specification. Note
that this structure does not specify how to publish the mailbox to the
operating system (ACPI-based platform firmware uses a separate table). No
ACPI table is needed in DeviceTree-based firmware to enumerate the mailbox.

Nodes that want to refer to the reserved memory usually define
a `memory-region` property. /cpus/cpu* nodes would want to refer to the
mailbox, but they do not have such property defined in the DeviceTree
specification. Moreover, it would imply that there is a memory region per
CPU. Instead, add a `compatible` property that the operating system can use
to discover the mailbox.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael.j.wysocki@intel.com>
Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v9:
 - Removed a spurious empty line. (Rob's bot)

Changes in v8:
 - None

Changes in v7:
 - Fixed Acked-by tag from Rafael to include the "(Intel)" suffix.

Changes in v6:
 - Reworded the changelog for clarity.
 - Added Acked-by tag from Rafael. Thanks!
 - Added Reviewed-by tag from Rob. Thanks!
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - Specified the version and section of the ACPI spec in which the
   wakeup mailbox is defined. (Rafael)
 - Fixed a warning from yamllint about line lengths of URLs.

Changes in v4:
 - Removed redefinitions of the mailbox and instead referred to ACPI
   specification as per discussion on LKML.
 - Clarified that DeviceTree-based firmware do not require the use of
   ACPI tables to enumerate the mailbox. (Rob)
 - Described the need of using a `compatible` property.
 - Dropped the `alignment` property. (Krzysztof, Rafael)
 - Used a real address for the mailbox node. (Krzysztof)

Changes in v3:
 - Implemented the mailbox as a reserved-memory node. Add to it a
   `compatible` property. (Krzysztof)
 - Explained the relationship between the mailbox and the `enable-mehod`
   property of the CPU nodes.
 - Expanded the documentation of the binding.

Changes in v2:
 - Added more details to the description of the binding.
 - Added requirement a new requirement for cpu@N nodes to add an
   `enable-method`.
---
 .../reserved-memory/intel,wakeup-mailbox.yaml      | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
new file mode 100644
index 000000000000..4362bc058df4
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/intel,wakeup-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wakeup Mailbox for Intel processors
+
+description: |
+  The Wakeup Mailbox provides a mechanism for the operating system to wake up
+  secondary CPUs on Intel processors. It is an alternative to the INIT-!INIT-
+  SIPI sequence used on most x86 systems.
+
+  The structure and operation of the mailbox is described in the Multiprocessor
+  Wakeup Structure of the ACPI specification version 6.6 section 5.2.12.19 [1].
+
+  The implementation of the mailbox in platform firmware is described in the
+  Intel TDX Virtual Firmware Design Guide section 4.3.5 [2].
+
+  1: https://uefi.org/specs/ACPI/6.6/05_ACPI_Software_Programming_Model.html#multiprocessor-wakeup-structure
+  2: https://www.intel.com/content/www/us/en/content-details/733585/intel-tdx-virtual-firmware-design-guide.html
+
+maintainers:
+  - Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: intel,wakeup-mailbox
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        wakeup-mailbox@ffff0000 {
+            compatible = "intel,wakeup-mailbox";
+            reg = <0x0 0xffff0000 0x1000>;
+        };
+    };

-- 
2.43.0


