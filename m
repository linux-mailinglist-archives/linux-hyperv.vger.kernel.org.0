Return-Path: <linux-hyperv+bounces-3692-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3336AA132F7
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 07:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6D71887E2A
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Jan 2025 06:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3C18A6D7;
	Thu, 16 Jan 2025 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N+2qUiwg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60477082F;
	Thu, 16 Jan 2025 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737007952; cv=none; b=iocfOL5dw3UHkUzYvdAqVVBEHXxhi+rjaRogvxzncsavpxQ2OsOZJcP0uNodtadpbJiZWS9yrcBe+w4yjE5yRr6zAEM4gDL5rG/OfdBdeVbBUK6BcqUwnzLeC97GQLb9CKzh/Cf72LGBdP48qHhu9xODnEmwEHPs6yBpC9FQvS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737007952; c=relaxed/simple;
	bh=wx0L0s5lw2Ue27/s5MAk7zurF3XpZSNpnVARgUq4z5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fh0TmTMOyFpymkOnrdVMLMjA9V6ByCHleCB11+A7A7yuve6uoZVKsJ0yGVmh2K/C14IbwiZWsYaQWIg1bjXvHOiui0MP/dXQvQWt/AVpx9c/gR+mXMLlKrj4grlP7xNdzrAL8eu4umR/2dNuHr7ovJtEFQer0zw7zTrqiNx85Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N+2qUiwg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-hibernation.4uyjgaamrtuunfhsycmekme4ua.xx.internal.cloudapp.net (unknown [20.94.232.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id 222B7203D608;
	Wed, 15 Jan 2025 22:12:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 222B7203D608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737007950;
	bh=QukWsI7AClV1k83KOW///qMqhXC/yY5t0dJRKNVQKEs=;
	h=From:To:Cc:Subject:Date:From;
	b=N+2qUiwgs3URnS1HAGj3lC5OYU9a7S1LXmpHfYaUELPRyyndhD5JeuOimRGHctwy4
	 TvwrmBjewvzJ8vaS+Mw2z538OtHLtrtBXqeh7YcdHBRykbu83+2fTYH3yASnf8GqFo
	 xSeivfDy4AlkmlmxdeG+q51o7wcOvFPT819d+kaQ=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH] x86/hyperv/vtl: Stop kernel from probing VTL0 low memory
Date: Thu, 16 Jan 2025 06:12:24 +0000
Message-ID: <20250116061224.1701-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Linux, running in Hyper-V VTL (Virtual Trust Level), kernel in VTL2
tries to access VTL0 low memory in probe_roms. This memory is not
described in the e820 map. Initialize probe_roms call to no-ops
during boot for VTL2 kernel to avoid this. The issue got identified
in OpenVMM which detects invalid accesses initiated from kernel running
in VTL2.

Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 4e1b1e3b5658..3f4e20d7b724 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -30,6 +30,7 @@ void __init hv_vtl_init_platform(void)
 	x86_platform.realmode_init = x86_init_noop;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
+	x86_init.resources.probe_roms = x86_init_noop;
 
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_mptable = x86_init_noop;

base-commit: 37136bf5c3a6f6b686d74f41837a6406bec6b7bc
-- 
2.43.0


