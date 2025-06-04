Return-Path: <linux-hyperv+bounces-5734-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72BACD098
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 02:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FF5176BD9
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 00:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F572624;
	Wed,  4 Jun 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBp4DTF8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B341BC5C;
	Wed,  4 Jun 2025 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748996287; cv=none; b=kYljDw/LNa+l5h9nAs7+qqEG4C+J8ckStA37KYlOmw/6iO+epIZoNLD566qOsEKrdO5OniaN8/7fB+yFTrb9iiObcF5Wme5qV43nTxXeiIzMXNw1X+IIjow4NyoEoCAwVfzIMC185UtDF97LD9q0d9pO5huQLjNbvslD/vESN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748996287; c=relaxed/simple;
	bh=NWTFVdsTu15JID3vMZXamOvuYlBjkvLIfQE8cTt7NKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iW41UwodfQn+FcQTnzwFBHcQXhxsM5icu4xCCjgcf2E+PgZ0GxrdsQn9S/ppmyOIJASM/0lGdqphROvmF2yw95HWU2zajySwVs26p3xrZrKPNYzW16Ge4QTuquJG+TDWXmc6zEsGRzsn99T9rene8jQEi7kkF0UH/EnZF1S5fE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBp4DTF8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748996286; x=1780532286;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NWTFVdsTu15JID3vMZXamOvuYlBjkvLIfQE8cTt7NKg=;
  b=nBp4DTF8zvNwzJiP+1/a7ecP/O/bAxoMaF6VX3Z2VBuuAIaXWgaKgE1p
   wfEb3Fz97p+fmavB7asGrgbV59/WLWLNTu2849hAlWcqegIur9/b1Kjj2
   WW2GOfc57FI3bAQsYbyC7EuEztgbxyZEKU6XTioFUGAzvyoRShHDPg+iD
   7MSfDg2BQhuPANhgw4DiQY236nANwxF7F0m6pfShjqzKrsr6zOHkwyOOv
   GdFk9YzF/5raGsch19/NY2v88a/TlTyhYNZusnvZWVLCia0vy77i2rErB
   G5R4EpBlBiWvfaCifY6kJDIV0IW0ghRzv0049MH3vVbZa6haZszcJi5Dv
   g==;
X-CSE-ConnectionGUID: XTn8HViyQ2uEtSFW6gZFHg==
X-CSE-MsgGUID: i3wW5Ai0Q32zmb/7s3MXJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62112953"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62112953"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:02 -0700
X-CSE-ConnectionGUID: FytyVrbJSn6EQTC47ZrZ3A==
X-CSE-MsgGUID: 3aQpAMD1TWSq/JeozQXYyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="149904467"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:01 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 03 Jun 2025 17:15:17 -0700
Subject: [PATCH v4 05/10] x86/hyperv/vtl: Set real_mode_header in
 hv_vtl_init_platform()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-rneri-wakeup-mailbox-v4-5-d533272b7232@linux.intel.com>
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
In-Reply-To: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748996287; l=1988;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=NksHFVn/eI0Fawofj7b00BEZiD32GqG4d/7RPbAEdi8=;
 b=MN+Qd6iKIzbJOTMiDJkH7medS+yCAXXXI1B2TzD3+vzND9xt24W4AWRTAtiLpb3eCFprENtUf
 4lqo5BemmKJB3tL5Egmg24JdKGJDMEGcPaiHzQcQcuj3VN/cpby/Ab8
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

Hyper-V VTL clears x86_platform.realmode_{init(), reserve()} in
hv_vtl_platform_init() whereas it sets real_mode_header later in
hv_vtl_early_init(). There is no need to deal with the real mode memory
in two places: x86_platform.realmode_init() is invoked much later via an
early_initcall.

Set real_mode_header in hv_vtl_init_platform() to keep all code dealing
with memory for the real mode trampoline in one place. Besides making the
code more readable, it prepares it for a subsequent changeset in which the
behavior needs to change to support Hyper-V VTL guests in TDX environment.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 - Added Reviewed-by tag from Michael. Thanks!

Changes since v2:
 - Edited the commit message for clarity.

Changes since v1:
 - Introduced this patch.
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 4580936dcb03..6bd183ee484f 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -60,6 +60,7 @@ void __init hv_vtl_init_platform(void)
 
 	x86_platform.realmode_reserve = x86_init_noop;
 	x86_platform.realmode_init = x86_init_noop;
+	real_mode_header = &hv_vtl_real_mode_header;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 	x86_init.resources.probe_roms = x86_init_noop;
@@ -279,7 +280,6 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	real_mode_header = &hv_vtl_real_mode_header;
 	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;

-- 
2.43.0


