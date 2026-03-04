Return-Path: <linux-hyperv+bounces-9147-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOG1Ji3EqGk2xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9147-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:45:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DF3209170
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93AA331117D3
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516B83B5854;
	Wed,  4 Mar 2026 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuQH2l//"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B033A1A57;
	Wed,  4 Mar 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667756; cv=none; b=JNwk9SHVr2gSZbBSI6F2uviC9JxviS3SJmbSGny1joBWOaNiyQOdDluY9vLeWdUjUVSy/IeWuh5cqnvyM5Y9xJWh/xvXSJ03YON4m0TJyNZJGPEQXhnS+3x/2W0riFCwruGnfCh2wXqNc+bkBtqNrMhZiP+cSGNw884UlQlH6iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667756; c=relaxed/simple;
	bh=4ImPkuHX0JnsNxTdR6Gbhl0L3k7v5fMn2n2Td8f8HKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DENf5bXdYGFZ+BOiUCh/7LsI8UXpYx5iD2CsQfII+2hSEG8ao3SXCVYxD12sqkMVQZPUbFtnRsxH9YSUzn8RSd3XdtRUjLDeEU0UbzIfI7dxl+ujQu35ERHBbkYUheFPKuGpFaoJrO+1lUAvSvWbLWj3pcESRnNMEFvtpy9Tfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuQH2l//; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667755; x=1804203755;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4ImPkuHX0JnsNxTdR6Gbhl0L3k7v5fMn2n2Td8f8HKc=;
  b=ZuQH2l//kCLutBfCK6qyUFznbbmTWf0Axn172nUPbQFGUZ73Gs7jnU/A
   CKjWZcrNeeJ7cZT1hGmuAWLpMQ/EadxW2KTyqa5/Rd3apGDbuD1PwpVQp
   4jdmroWIoSRhiN5FhjWdzJL59Y6cQfDKYBBAgTTGTbaxTJwolnQtmxOkm
   rPbvWs/sYQHytMN+tVo1AC3vYXq4XoPTWe13UrmGjhwFoubgq1kah+Imv
   pbly/jy8wkl9XNdKHZVn2OiowBbJ6SW0X9oqSH53zYgEv/bcIWce3pNGV
   RebH0HcgbzRkJaEgVn8LOzP1ue/BLyAunBVGNkmxy5xXVtjPbyzgUlbAZ
   w==;
X-CSE-ConnectionGUID: IiJvyQoAQP66OgwD3GTQbA==
X-CSE-MsgGUID: H7Fhx0ScR4Se3G0hag0vww==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359405"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359405"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:31 -0800
X-CSE-ConnectionGUID: J0MFm4ujRGmzMTlWgVc6+Q==
X-CSE-MsgGUID: 4rWWICZlRKSF0AL4A9mFXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376924"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:29 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 04 Mar 2026 15:41:21 -0800
Subject: [PATCH v9 10/10] x86/hyperv/vtl: Use the wakeup mailbox to boot
 secondary CPUs
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-rneri-wakeup-mailbox-v9-10-a5c6845e6251@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=2059;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=4ImPkuHX0JnsNxTdR6Gbhl0L3k7v5fMn2n2Td8f8HKc=;
 b=1fd4O5CSN59eMQ8HBo+M366SHzD8Kqya0ZKIQI1fLSgv3tOoNuq7VkpnEfmfV+o/lnsF8Xlym
 AmWWZw5zY1DAAShL6EZRRLRipxtnCi4Gg7ddidkqa8+sBaZodpKNQ3y
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: 33DF3209170
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9147-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,outlook.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email]
X-Rspamd-Action: no action

The hypervisor is an untrusted entity for TDX guests. It cannot be used
to boot secondary CPUs. The function hv_vtl_wakeup_secondary_cpu() cannot
be used.

Instead, the virtual firmware boots the secondary CPUs and places them in
a state to transfer control to the kernel using the wakeup mailbox. The
firmware enumerates the mailbox via either an ACPI table or a DeviceTree
node.

If the wakeup mailbox is present, the kernel updates the APIC callback
wakeup_secondary_cpu_64() to use it.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v9:
 - None

Changes in v8:
 - None

Changes in v7:
 - None

Changes in v6:
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - None

Changes in v4:
 - Added Reviewed-by tag from Michael. Thanks!

Changes in v3:
 - Unconditionally use the wakeup mailbox in a TDX confidential VM.
   (Michael).
 - Edited the commit message for clarity.

Changes in v2:
 - None
---
 arch/x86/hyperv/hv_vtl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 1e2f5b3ea772..07fac3d687c3 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -274,7 +274,15 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
+	/*
+	 * TDX confidential VMs do not trust the hypervisor and cannot use it to
+	 * boot secondary CPUs. Instead, they will be booted using the wakeup
+	 * mailbox if detected during boot. See setup_arch().
+	 *
+	 * There is no paravisor present if we are here.
+	 */
+	if (!hv_isolation_type_tdx())
+		apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;
 }

-- 
2.43.0


