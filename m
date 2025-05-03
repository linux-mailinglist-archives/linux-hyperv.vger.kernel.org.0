Return-Path: <linux-hyperv+bounces-5329-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257EAAA8221
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDAC4600FB
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC10F27F4F4;
	Sat,  3 May 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xkw92MiG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFDD27E7ED;
	Sat,  3 May 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299415; cv=none; b=AtwbsIVgt5ATj6kW/cxGiIfUyuqalPcJSmJFY3MZboK59c3QoCIHDTArFr1xp2sLXKkcQr0mGL1JpzF9POggIZPGed8AY+VqKDl7nD/dTHGBdb5CE8CL5NzZkMATfLBV3x8ax7Uj1wj4LEY8qu8B9Un5uszx14BowQihifKckxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299415; c=relaxed/simple;
	bh=Mm45ENIs0X8EBABbvMlBglzE/tjG4gJ+KwRueBg/+98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o04X9llMCvu8v6qiVYomOQMqx8BgTxk6FDPULCH3hHAyiK9HBC6dGAzr0+FErSJUCKpJ/u4m+9hFUZ2T5oSX4EuNQbP7BW30v/vgYZrGfXuhU+bgaUy9eM4G2GfxE0WDGv28aJJa7L34I+/wQG9SvMNtmGSnPHfeQk6N64gJU6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xkw92MiG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299414; x=1777835414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Mm45ENIs0X8EBABbvMlBglzE/tjG4gJ+KwRueBg/+98=;
  b=Xkw92MiGk47XRWZSuOJanMLNZfA9zAwk0btpzdrK92+vE0hSI0oSWUmr
   Gj3W2oNH0Ci3Je7pKX7DhF2KvMwF06VAv/EltskmemxTKj0awgmfQZwyf
   +PU+L/RgQHWM16KbboTXK7N4CD/+ZBoem2LtZ8sFRk8TOMogWIFgB0MUJ
   V4SiDFB0Cq8CY/8LTQ/uajOYLMqv94b0HYO/C7zXwe5Fn9yR/2O0NMzf7
   mN5hvG2VGTh3yDw1/3M3pegb9YA3MCNTGOlEwEmr0JiG30F7Rwp8uBHGK
   Crb8xS3OoOHxJj23BQ3b3fRHbDciVu4bec38s1UKcZCcaE1RpcWUOF9sA
   A==;
X-CSE-ConnectionGUID: af/qQsNJQ9ePcQfjnA6URw==
X-CSE-MsgGUID: EMBhOsngSW+RAwNKu0qx7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095619"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095619"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:12 -0700
X-CSE-ConnectionGUID: MUDMeDGRRW2YBJL7GUPhkA==
X-CSE-MsgGUID: IlITNeJ2T3euc0JVo6FNew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046091"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:11 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org ,
	linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v3 04/13] dt-bindings: x86: Add CPU bindings for x86
Date: Sat,  3 May 2025 12:15:06 -0700
Message-Id: <20250503191515.24041-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add bindings for CPUs in x86 architecture. Start by defining the `reg` and
`enable-method` properties and their relationship to x86 APIC ID and the
available mechanisms to boot secondary CPUs.

Start defining bindings for Intel processors. Bindings for other vendors
can be added later as needed.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 .../devicetree/bindings/x86/cpus.yaml         | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/x86/cpus.yaml

diff --git a/Documentation/devicetree/bindings/x86/cpus.yaml b/Documentation/devicetree/bindings/x86/cpus.yaml
new file mode 100644
index 000000000000..108b3ad64aea
--- /dev/null
+++ b/Documentation/devicetree/bindings/x86/cpus.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/x86/cpus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: x86 CPUs
+
+maintainers:
+  - Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
+
+description: |
+  Description of x86 CPUs in a system through the "cpus" node.
+
+  Detailed information about the CPU architecture can be found in the Intel
+  Software Developer's Manual:
+    https://intel.com/sdm
+
+properties:
+  compatible:
+    enum:
+      - intel,x86
+
+  reg:
+    description: |
+      Local APIC ID of the CPU. If the CPU has more than one execution thread,
+      then the property is an array with one element per thread.
+
+  enable-method:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      The method used to wake up secondary CPUs. This property is not needed if
+      the secondary processors are booted using INIT assert, de-assert followed
+      by Start-Up IPI messages as described in the Volume 3, Section 11.4 of
+      Intel Software Developer's Manual.
+
+      It is also optional for the bootstrap CPU.
+
+    oneOf:
+      - items:
+          - const: intel,wakeup-mailbox
+            description: |
+              CPUs are woken up using the mailbox mechanism. The platform
+              firmware boots the secondary CPUs and puts them in a state
+              to check the mailbox for a wakeup command from the operating
+              system.
+
+required:
+  - reg
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    /*
+     * A system with two CPUs. cpu@0 is the bootstrap CPU and its status is
+     * "okay". It does not have the enable-method property. cpu@1 is a
+     * secondary CPU. Its status is "disabled" and defines the enable-method
+     * property.
+     */
+
+    cpus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cpu@0 {
+        reg = <0x0 0x1>;
+        compatible = "intel,x86";
+        status = "okay";
+      };
+
+      cpu@1 {
+        reg = <0x0 0x1>;
+        compatible = "intel,x86";
+        status = "disabled";
+        enable-method = "intel,wakeup-mailbox";
+      };
+    };
+
-- 
2.43.0


