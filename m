Return-Path: <linux-hyperv+bounces-2090-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829648C2875
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 18:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B234A1C22785
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 May 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518FE172763;
	Fri, 10 May 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QYSUuwbb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C143F171E7C;
	Fri, 10 May 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357189; cv=none; b=S5+ZMg7E3jd6QYJyRkyNHEsbwWBTzXIprp6XJ2Zby+zxKK9kbdoho1uRHXZbocvEHvA0VeDng7hks5Vk9SOa6d8bZyBw/Benj4Gewlv6BiWvfLX/gGe+zl7C+YePGOzApieDdBfgRsp72iikhVV183IRfguWa6vsrro0YT8/pxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357189; c=relaxed/simple;
	bh=ZFQEJj/HsfljCrFKMUE9UyYGfOEsgr1gbTXTWuK/an0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abPeDmmK7/ju3QT+xEZQWpk9wIg64J/HBLm4ckKKF1hHnvUc83w0D6m35Iqpkbm8z0btkCbgcgMi4qkmnDWidN8maxmWXatTdqvMLMR99CWG0FAkHZ4YHHT18UJKG/Q+ngaiRMuutMLaejIFVYf374Tchc5D5dyqodSid4ofSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QYSUuwbb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 58006209122D;
	Fri, 10 May 2024 09:06:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58006209122D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715357180;
	bh=i8sURU7VZy9XbERdslCO4zd0i0m4z48sr2ICI5U3xH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYSUuwbbm+sG3R23wRRulV8ZTIZtvLx2SWeK8z2C2YifG3+i/qjb0voiSNoCIJG38
	 ioliCBHp9FxLvEauXPZv+3CuV/gc1PE9lPm9eequqv61TFVIK5ywHYhs6Z2GVJFSuF
	 qbuVS/9vwsKz5W6m/i6FKUHlW51AYulqHtFMCLgE=
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
Subject: [PATCH 2/6] drivers/hv: Enable VTL mode for arm64
Date: Fri, 10 May 2024 09:05:01 -0700
Message-ID: <20240510160602.1311352-3-romank@linux.microsoft.com>
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

This change removes dependency on ACPI when buidling the hv drivers to
allow Virtual Trust Level boot with DeviceTree.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 862c47b191af..a5cd1365e248 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
 	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
-		|| (ACPI && ARM64 && !CPU_BIG_ENDIAN)
+		|| (ARM64 && !CPU_BIG_ENDIAN)
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
@@ -15,7 +15,7 @@ config HYPERV
 
 config HYPERV_VTL_MODE
 	bool "Enable Linux to boot in VTL context"
-	depends on X86_64 && HYPERV
+	depends on HYPERV
 	depends on SMP
 	default n
 	help
@@ -31,7 +31,7 @@ config HYPERV_VTL_MODE
 
 	  Select this option to build a Linux kernel to run at a VTL other than
 	  the normal VTL0, which currently is only VTL2.  This option
-	  initializes the x86 platform for VTL2, and adds the ability to boot
+	  initializes the kernel to run in VTL2, and adds the ability to boot
 	  secondary CPUs directly into 64-bit context as required for VTLs other
 	  than 0.  A kernel built with this option must run at VTL2, and will
 	  not run as a normal guest.
-- 
2.45.0


