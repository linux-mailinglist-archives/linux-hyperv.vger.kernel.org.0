Return-Path: <linux-hyperv+bounces-10339-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBU7MtIV6mlHtwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10339-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:51:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A67452538
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E9D4304B35C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD33EDAA5;
	Thu, 23 Apr 2026 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TZwi8EF3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624EE1D6DB5;
	Thu, 23 Apr 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948288; cv=none; b=SgWkhGTs4tZsAbcVc5Me3K9wKZS4bUaPA6U+BNc1hmcI5+ieBs9nDSYNDZJE0GFgZPDv9r9mJ0mkeZ3kRJLGCAxHpy0gbcnEPZlB0SlN9MNx/h55kF7SgCy+4VLTtzzJ5xStvHO9oFfrqvgoSa/6oz8DFPvKJsBk7nddgwuPLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948288; c=relaxed/simple;
	bh=UJFdtsv+xUTxCdD902MCvqyrQbINo6D6Gc7EY3d+HRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Joa8IXeLKJ9I9aR+8LmKzOE3ZhLOp9DkOcPp+TEEOAPyD7nUO68QQQkSmId7BfCbsaMz/jOYoloZA7qjgwb3lL3YTGzF43BqvJnezxF40NOcvKzdroQ2SySmJp4alc2VPuFHQdOezrLQnKYwTGwqkdW62VMyrA0oSzc+Ub16K6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TZwi8EF3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 070C020B7185;
	Thu, 23 Apr 2026 05:44:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 070C020B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948277;
	bh=R8uasiKJJqB0UypVXrQ/4MfR+9wKG2jPGAjkmO/egns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZwi8EF3KFtKojnKql1YiP0AxnEytUmxPRo3tGXKd7KO+PMWGFiqKd6B2H0MhaQYM
	 YGXvBpEzByzP3E7BIOFqlkvqdMymumuRVtYgejafE2X8vrjrWmk57c9IhZ4qd5vNc+
	 GpA+cyWtUSQ/hPB3EXOg0C2B5OBUflbRhUenyRL4=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	vdso@mailbox.org,
	ssengar@linux.microsoft.com
Subject: [PATCH v2 15/15] Drivers: hv: Add ARM64 support for MSHV_VTL in Kconfig
Date: Thu, 23 Apr 2026 12:42:05 +0000
Message-ID: <20260423124206.2410879-16-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423124206.2410879-1-namjain@linux.microsoft.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10339-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org,mailbox.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,outlook.com:email,linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4A67452538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable ARM64 support in MSHV_VTL Kconfig now that all the necessary
support is present.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Roman Kisel <vdso@mailbox.org>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 115821cc535c..0bec3bc81a1a 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -87,7 +87,7 @@ config MSHV_ROOT
 
 config MSHV_VTL
 	tristate "Microsoft Hyper-V VTL driver"
-	depends on X86_64 && HYPERV_VTL_MODE
+	depends on (X86_64 || ARM64) && HYPERV_VTL_MODE
 	depends on HYPERV_VMBUS
 	# Mapping VTL0 memory to a userspace process in VTL2 is supported in OpenHCL.
 	# VTL2 for OpenHCL makes use of Huge Pages to improve performance on VMs,
-- 
2.43.0


