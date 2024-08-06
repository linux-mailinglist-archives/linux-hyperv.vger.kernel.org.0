Return-Path: <linux-hyperv+bounces-2734-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B726949B10
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 00:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9332821A3
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D849175D50;
	Tue,  6 Aug 2024 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huLaEt/y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AD0171658;
	Tue,  6 Aug 2024 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982384; cv=none; b=NQsiCqVEGwihI+ZegERAi1obDo1+j7lMSaxwglqclYd8raA1ETc/52I9ArW84OryPMT/OOkGUtFgjpU65Fzu/KUf7TpNNgHuyGXSJvuTVArUSgQqoKIQZ2OsxTYAB1k/NHwJ3Azh/8JWn0E79igoh9bSwOZbx66lqLVu5C6H/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982384; c=relaxed/simple;
	bh=+aj49VLk6JdinOkdJmhZB5zTeiU2ZPgnDn7C3ioCimc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btfyYnXCh528TA2WHT5J+gHg6Rt2BfP7qwW41Leuc1evtM8mRa1pAFE+EXB8pgQ02P56gQLgaoHp5u6sVN4IBFIL2he0O+7DM9FowUF9/TJJ+iKTnXJIYy4J8lrTirUj+3vS09wQxqc350N2B95CqwLABMXis2WzeVt3dAFXc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huLaEt/y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982382; x=1754518382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+aj49VLk6JdinOkdJmhZB5zTeiU2ZPgnDn7C3ioCimc=;
  b=huLaEt/yccy5Gl/qkYunBbljmWB38in1hduUytxSWXt1/zBMjjQJhpwU
   oxXYGAFLmjUKFQpgIYm3rSQAgPRb3aMvDVWiOSI717xs6TLwv9lGOalq1
   sjI4BltSaT1t9/J8YjZEFO8DqXrsjpD+g9VSPu9VTMDRwPP0jO6np+023
   5xg3AnUqQEGSjJO2RU/zKEoe2OOSSWoayl+r2AvmkNNa6MIe+xJtqonrJ
   9GOOH4Yxj5mwcxbwMn/1wqykmHMUvSi+MECAX4xE6yWPoEDP3bhkwJzfl
   hREVbyQ3Og4Qg0GNwcsjRX6VZe+y6XohK6fcmGkfFTI9Mjx11GS3I2Dik
   Q==;
X-CSE-ConnectionGUID: ikSI7s0QRcW4DNB5vvrJ0Q==
X-CSE-MsgGUID: Ly+IcOyVQqOG4cgpwV72Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38534369"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38534369"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:13:02 -0700
X-CSE-ConnectionGUID: kBYtrCfKQkGlGqUR2vOz3w==
X-CSE-MsgGUID: FxPDqP/IT9i1EItM9nW9yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61465626"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 15:13:01 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	yunhong.jiang@linux.intel.com
Subject: [PATCH 2/7] dt-bindings: x86: Add ACPI wakeup mailbox
Date: Tue,  6 Aug 2024 15:12:32 -0700
Message-Id: <20240806221237.1634126-3-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the binding to use the ACPI wakeup mailbox mechanism to bringup APs.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 .../devicetree/bindings/x86/wakeup.yaml       | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml

diff --git a/Documentation/devicetree/bindings/x86/wakeup.yaml b/Documentation/devicetree/bindings/x86/wakeup.yaml
new file mode 100644
index 000000000000..8af40dcdb592
--- /dev/null
+++ b/Documentation/devicetree/bindings/x86/wakeup.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+
+$id: http://devicetree.org/schemas/x86/wakeup.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: x86 acpi wakeup mailbox
+
+description: |
+
+This document describes the "acpi-wakeup-mailbox" method for enabling secondary
+CPUs.
+
+The ACPI spec defines a mechanism to let the bootstrap processor wake up
+application processors with a mailbox. The "acpi-wakeup-mailbox" enable-method
+follows the "Multiprocessor Wakeup Mailbox Structure" defined in the ACPI
+spec[1].
+
+Since the ACPI mailbox structure is shared by all the CPUs, this enable method
+applies to all CPUs and should be defined in the "cpus" node and should not be
+defined on each "cpu" node.
+
+select: false
+
+properties:
+  wakeup-mailbox-addr:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description: |
+    The physical address of the wakeup mailbox data structure. The address must
+    meet the ACPI spec requirement, like be 4K bytes aligned and it should be in
+    the reserved memory.
+
+  wakeup-mailbox-version:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description: |
+    The MailBoxVersion defined in the ACPI spec that this binding follows.
+
+required:
+  - wakeup-mailbox-addr
+
+[1] https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#multiprocessor-wakeup-structure
-- 
2.25.1


