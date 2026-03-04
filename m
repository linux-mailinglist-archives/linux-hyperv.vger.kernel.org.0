Return-Path: <linux-hyperv+bounces-9142-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEYaF3vDqGk0xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9142-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:42:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A66209082
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53CF23026510
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4130339EF3C;
	Wed,  4 Mar 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CT82jUBl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A83914EB;
	Wed,  4 Mar 2026 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667754; cv=none; b=ESJ+uS7t4KbPOLjODknqT3/ZCog1S5A+Eu7Zb15+TKP+aQxlHvMT9fvl5p/2KEQWO/RJo6+2BZMI35rLukJgxTyP2h0xypco7Ik+/5qogQhqVsUiLkatwELt3AgJTKg2vIxPNr7OsFURgONWI50uIl40+/ctRyuhBU6mPoUdDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667754; c=relaxed/simple;
	bh=JDBcIU3oLzy6nR7gCTw/cB7hCWrF8Ykxag6iBFuscOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbrfJwYK2rZBhKF4mdMysCyyWSCpVVznvHVp1CDvLTY/cfOcVF0HOnGX5dt76cgMQdBW4s96S4qEnaAp3AGJ0r3/zuTdkN1roW8DJNPvpDG9Sk+Xeea0zXtD7qrtv9TbJb0KRdyLOIIgiAe3e3wM8FeYJ4tuquSdvV0/4RHKdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CT82jUBl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667753; x=1804203753;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JDBcIU3oLzy6nR7gCTw/cB7hCWrF8Ykxag6iBFuscOw=;
  b=CT82jUBlZ+oCza2cm/hxPB1Qg8tAxqobgw8JdgNvZs1HpHZ2HnOE0Mbq
   g1lclwszTvBeVAY+bq5pyyCj5NRYi0gx+uDgqrWQAmM4oPdHMGhuiyMK7
   FDUmsPDlav8uwCVij3D3g4yHvsbpw2jPywsc7zhG2KH8guoH7ZsF/468w
   lKA/jddXR+GVqB6jBPXYfTfclR8e4x9V+tokIkHISPpoNJxDizM1gBi/z
   F0JdFbu9KNCJ8f/+TISkqpCCmwqjFLiANtkWtbxVtGHcuY7eocvvgT8A6
   7LhySxHREnRImJUfJY5eiPYRmRLvPFFor/lWHLL3L2y6z+1zkfalgY7ja
   g==;
X-CSE-ConnectionGUID: jnxZ87f5SYaVQHkkxbRCsA==
X-CSE-MsgGUID: 6ap271UcTYSnuINyW51EaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359389"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359389"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:30 -0800
X-CSE-ConnectionGUID: bQI2OXMkRji1/NWcKKnL/Q==
X-CSE-MsgGUID: l6aAjajfSzWu5KxBdIVl+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376906"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:28 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 04 Mar 2026 15:41:16 -0800
Subject: [PATCH v9 05/10] x86/hyperv/vtl: Set real_mode_header in
 hv_vtl_init_platform()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-rneri-wakeup-mailbox-v9-5-a5c6845e6251@linux.intel.com>
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
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=2364;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=3I3YmnN/1McteB5oTgTUDd+p5JYa7dqLPq6/RX+ToAU=;
 b=decoK6P5d5qSAFB2QaKNVFhE4bD6HhEyCOofVP3dBzQuDa2BSA9cP8meaZPCD7m1O48LrvItr
 KEYRolCT//LBd8Z2Rr2e1EOibvhz6MvsEurHUwK2tv1DIhc/Qs+LrJA
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: F0A66209082
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9142-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,outlook.com:email,linux.intel.com:mid]
X-Rspamd-Action: no action

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

Hyper-V VTL clears x86_platform.realmode_{init(), reserve()} in
hv_vtl_init_platform() whereas it sets real_mode_header later in
hv_vtl_early_init(). There is no need to deal with the settings of real
mode memory in two places. Also, both functions are called much earlier
than x86_platform.realmode_init() (via an early_initcall), where the
real_mode_header is needed.

Set real_mode_header in hv_vtl_init_platform() to keep all code dealing
with memory for the real mode trampoline in one place. Besides making the
code more readable, it prepares it for a subsequent changeset in which the
behavior needs to change to support Hyper-V VTL guests in TDX a
environment.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v9:
 - None

Changes in v8:
 - None

Changes in v7:
 - None

Changes in v6:
 - Corrected reference to hv_vtl_init_platform() in the changelog.
   (Dexuan)
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - None

Changes in v4:
 - Added Reviewed-by tag from Michael. Thanks!

Changes in v3:
 - Edited the commit message for clarity.

Changes in v2:
 - Introduced this patch.
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 9b6a9bc4ab76..e045bf3a2c59 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -70,6 +70,7 @@ void __init hv_vtl_init_platform(void)
 
 	x86_platform.realmode_reserve = x86_init_noop;
 	x86_platform.realmode_init = x86_init_noop;
+	real_mode_header = &hv_vtl_real_mode_header;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 	x86_init.resources.probe_roms = x86_init_noop;
@@ -251,7 +252,6 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	real_mode_header = &hv_vtl_real_mode_header;
 	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;

-- 
2.43.0


