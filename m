Return-Path: <linux-hyperv+bounces-2091-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A08C2876
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 18:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A55F1C241E4
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 16:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEB8172BCA;
	Fri, 10 May 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GBtFAzYW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D7172761;
	Fri, 10 May 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357189; cv=none; b=usjWAptHqWLFh01CmLYDAjxh0Ihyn1x7OyONIjEl5HudB+hhprxM8yCuL70aV4BSPMUpEQIq4bzOMhIMs1wLpTs4nAYB8ZzTuwr1+PLbPmZNMG0U3cfkhJMlYfTFp/s874eMjytMBS3gXDpbXabsxoNCcP0Z3fjxd+MncrtXf10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357189; c=relaxed/simple;
	bh=TEnUv8xcmqE696rwwBMkjSZIHNju2H3PsfeU3Tj8/Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqFZ1wg9SvXIPEJeDFaLUbmJwiAaHF0BDAmY9tOmudlJDRVmwPQcFBntRJU8PY21S4EUGxkyyhQ0izZC0YWQvWjEMGq8odDeYGew1g12Gvq9t/0n9KHBCxqA7syTnNzg9lr7xqDpzvi4IPuCP6tk7TGm60UT4SV5sJYHv+SYOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GBtFAzYW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 29FE1209122A;
	Fri, 10 May 2024 09:06:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29FE1209122A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715357180;
	bh=DbJI7sPFnvaKMs0+uBHHpBULjrM84eRWrgyYSqdRp8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBtFAzYWSJlPnqjxYwUJ14RUQoJ+AdzEttjClYL3yjLKPsxlMAdQ/rhJ3USI4ajfP
	 mYu7wbfozgdR03UZtDU8CuIis0HWH1cnYWZr1GIZRlA+1BHwYyh8v/ezb5xGSfeWhv
	 ChOVxto7ZFOAbFdclZGUCchGQZw+LFATVu3dGjQA=
From: romank@linux.microsoft.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Cc: ssengar@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH 1/6] arm64/hyperv: Support DeviceTree
Date: Fri, 10 May 2024 09:05:00 -0700
Message-ID: <20240510160602.1311352-2-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510160602.1311352-1-romank@linux.microsoft.com>
References: <20240510160602.1311352-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Kisel <romank@linux.microsoft.com>

Update the driver to support DeviceTree boot as well along with ACPI.
This enables the Virtual Trust Level platforms boot up on ARM64.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index b1a4de4eee29..208a3bcb9686 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -15,6 +15,9 @@
 #include <linux/errno.h>
 #include <linux/version.h>
 #include <linux/cpuhotplug.h>
+#include <linux/libfdt.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
 #include <asm/mshyperv.h>
 
 static bool hyperv_initialized;
@@ -27,6 +30,29 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 	return 0;
 }
 
+static bool hyperv_detect_fdt(void)
+{
+#ifdef CONFIG_OF
+	const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
+			of_get_flat_dt_root(), "hypervisor");
+
+	return (hyp_node != -FDT_ERR_NOTFOUND) &&
+			of_flat_dt_is_compatible(hyp_node, "microsoft,hyperv");
+#else
+	return false;
+#endif
+}
+
+static bool hyperv_detect_acpi(void)
+{
+#ifdef CONFIG_ACPI
+	return !acpi_disabled &&
+			!strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8);
+#else
+	return false;
+#endif
+}
+
 static int __init hyperv_init(void)
 {
 	struct hv_get_vp_registers_output	result;
@@ -35,13 +61,11 @@ static int __init hyperv_init(void)
 
 	/*
 	 * Allow for a kernel built with CONFIG_HYPERV to be running in
-	 * a non-Hyper-V environment, including on DT instead of ACPI.
+	 * a non-Hyper-V environment.
+	 *
 	 * In such cases, do nothing and return success.
 	 */
-	if (acpi_disabled)
-		return 0;
-
-	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
+	if (!hyperv_detect_fdt() && !hyperv_detect_acpi())
 		return 0;
 
 	/* Setup the guest ID */
-- 
2.45.0


