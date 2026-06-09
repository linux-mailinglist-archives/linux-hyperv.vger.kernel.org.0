Return-Path: <linux-hyperv+bounces-11564-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HJnHDY1ZKGpQCgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11564-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:21:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A201766344C
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 20:21:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=IuJ7iNid;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11564-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11564-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6263068FFD
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 18:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C214BCACC;
	Tue,  9 Jun 2026 18:10:52 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F8B49250F;
	Tue,  9 Jun 2026 18:10:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028651; cv=none; b=UnEqCJhL7Mc9VsZluqsbi3jNZcPkUXyDzAZf488hXMfjN4iH4q6kWRiO5UxSNV4VXqiE5oPtCZm0eziNrOAuUKnq8zwoqnkq5wXEX1KKhrbUVt3TR+gB0nhSq7CCRwiKUtmQcMKerK+M4arA1YNe4Vl1kp9PmqAzXpLc1WzR1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028651; c=relaxed/simple;
	bh=YvrRnYgFRPT3pktew9Oa0h+yh61Hi+hMc8epaXZyJlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F34NGVuuh0W6Y0K1hsbcWO62zxm5uEzKmkgSF/GXkpPTZ+qypS371Cyf4/Ng+4amNEtvWYadXKf3QPj+GQ7/dMsOOqcDVv24pXGauu5W3W95JWn30jye2pCgFfF3RhNQhP6NjJyX5+q6pMGQTyd327t/k7wFSTD/J/DJ5t0ZAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IuJ7iNid; arc=none smtp.client-ip=13.77.154.182
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E9F1920B716C;
	Tue,  9 Jun 2026 11:10:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E9F1920B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781028633;
	bh=xGLsNEvgsOokSRt2P87m8r94Kd1xZNQ7RfME0Rovs8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IuJ7iNidMDVBOuCO1DnLihoOhHsa1FexmfVhEgCgDclLZQeFgjqnmqHew9RRny7cS
	 qGwc/8OlCSOjyJ/XT6gajMFqGMP9fs+W65XCLqG+ccLlksEtnVT3kUjcxuEXZbVHF0
	 5qHaQ0oosmF9RpFqsWrvFdqwnxH0Dm5xNHGGdxTY=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@kernel.org,
	arnd@arndb.de,
	thuth@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com
Subject: [RFC PATCH 4/6] Drivers: hv: Mark shared memory as decrypted for CCA Realms
Date: Tue,  9 Jun 2026 11:10:28 -0700
Message-ID: <20260609181030.2378391-5-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11564-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,arndb.de,redhat.com,vger.kernel.org,lists.infradead.org,outlook.com];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kameroncarr@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kameroncarr@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,linux.microsoft.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A201766344C

In hv_common_cpu_init(), the per-CPU hypercall input/output pages need
to be marked as decrypted (shared) for confidential VM isolation types.
This is already done for SNP and TDX isolation; extend the same handling
to Arm CCA Realm guests so that the host hypervisor can access the
shared hypercall buffers.

is_realm_world() is only declared in arch/arm64/include/asm/rsi.h, so
using it directly in the arch-neutral drivers/hv/hv_common.c would
break the x86 build. Introduce a Hyper-V-specific helper following the
established hv_isolation_type_snp() / hv_isolation_type_tdx() pattern.

On architectures other than arm64 the weak default keeps the existing
behaviour.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c   | 5 +++++
 drivers/hv/hv_common.c         | 9 ++++++++-
 include/asm-generic/mshyperv.h | 1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 08fec82691683..b595b2b9bdbbb 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -208,3 +208,8 @@ bool hv_is_hyperv_initialized(void)
 	return hyperv_initialized;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+bool hv_isolation_type_cca(void)
+{
+	return is_realm_world();
+}
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 6b67ac6167891..010c7d98b5de1 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -499,7 +499,8 @@ int hv_common_cpu_init(unsigned int cpu)
 		}
 
 		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
+		     hv_isolation_type_cca())) {
 			ret = set_memory_decrypted((unsigned long)mem, pgcount);
 			if (ret) {
 				/* It may be unsafe to free 'mem' */
@@ -666,6 +667,12 @@ bool __weak hv_isolation_type_tdx(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
 
+bool __weak hv_isolation_type_cca(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_cca);
+
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
 }
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb9..1fa79abce743c 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -79,6 +79,7 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
 
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
+bool hv_isolation_type_cca(void);
 
 /*
  * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
-- 
2.45.4


