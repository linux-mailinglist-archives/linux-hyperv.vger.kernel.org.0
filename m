Return-Path: <linux-hyperv+bounces-10338-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFwvE6IV6mkatwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10338-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:50:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8734524F0
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B6DB300AD5C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5725C382281;
	Thu, 23 Apr 2026 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o9WkEKDY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4B1D6DB5;
	Thu, 23 Apr 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948270; cv=none; b=JP6i1sNU6f1aPTriVjk8ECTntxTjSDwexGjR5CpzmlpKhzyt/rbSlmJWcLQeTPE7QB7wtw6xDz0l6PFFjyAxO+vMzOxWuC4AE3J0Vor7qQz9Zy+83HD6J1R4W2QFwa1ZlheSM7OOlO5HDkPtBfT0DUu/hs7G8IV1TXuENFneegc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948270; c=relaxed/simple;
	bh=CoDvSCNn4jGrMUulDHPvfhhkBsriG7oP3HcJNSqjRng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSfG1UDbI2BJvP4C4M2JKLjEAQnqgXiqH7xf5DfsTOIGTJwgbJU3HIffakGkHtkDVyLykkopwoAmERkVoGm2KgTRecENMM8QP8zAjlcLSe8tx0+KfHSVxhDMR9B6O5BmNnB7jeuVXBYmHRRaA4bLkWu0bsOTHUUDyQbmFn0VMEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o9WkEKDY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8D79720B716E;
	Thu, 23 Apr 2026 05:44:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D79720B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948255;
	bh=WCqVD6YRGkVlS61nC58ZQHPJoEDu23OMTFcYIc3KK7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9WkEKDY1+IjGA7KFzub4vgAD8r4TOVboRhyxRljZfT4Cn2GsJoqg7WNN9vIhuVXt
	 H2Yf3Nkj2Wsq271fqrX1wrAYYyvoFn2o8S7p9TnmsSNSUq3XOrQ1dDRVtCcJFMQy3B
	 QohTj61p/B/cM3PvJR+/k9oHkGlU7NBEhQoZ8ymM=
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
Subject: [PATCH v2 14/15] Drivers: hv: Add 4K page dependency in MSHV_VTL
Date: Thu, 23 Apr 2026 12:42:04 +0000
Message-ID: <20260423124206.2410879-15-namjain@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10338-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB8734524F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a dependency on 4K page size in Kconfig of MSHV_VTL
to support any assumptions that may be present in the code.
x86 anyways supports 4K page size only, and for arm64, higher
page size support is not validated. Remove this dependency as
and when this feature is supported.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/hv/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 7937ac0cbd0f..115821cc535c 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -96,6 +96,11 @@ config MSHV_VTL
 	# MTRRs are controlled by VTL0, and are not specific to individual VTLs.
 	# Therefore, do not attempt to access or modify MTRRs here.
 	depends on !MTRR
+	# The hypervisor interface operates on 4k pages. Enforcing it here
+	# simplifies many assumptions in the mshv_vtl code.
+	# VTL0 VMs can still support higher page size in ARM64 and is not limited
+	# by this setting.
+	depends on PAGE_SIZE_4KB
 	select CPUMASK_OFFSTACK
 	select VIRT_XFER_TO_GUEST_WORK
 	default n
-- 
2.43.0


