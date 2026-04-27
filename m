Return-Path: <linux-hyperv+bounces-10404-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBbxM6PX72koGwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10404-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 23:39:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F20647AB81
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 23:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 652293086672
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 21:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788E37C939;
	Mon, 27 Apr 2026 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YykBf/xs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EC938A717;
	Mon, 27 Apr 2026 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325947; cv=none; b=fGAyDNHuVcORdxUDJOa68MlA2OJT8NzbGwiMsBVMM237omhqC7zWFrlNGnv/YvKCO1vJuPkFtYmVO+v88bLngdfF4Nzzl+xV6IfamsLGRYmvCHA5dDU5728zw6WBjlcXeSj1sqUeb+P88r4Y+p20ogAAnvmBCr3I4JZPSR8R/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325947; c=relaxed/simple;
	bh=Mt9XKRmVe/67nhmObCnNyk5v/+5rvNqVEgXwWee6Q9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4gS2z0KtkGABT4SS+Uus8dnLXuSm4sSniflRtlORXATXvtNGSeLQAg8Nz22HC2q5GL6Ro3bsvDG89pa1DhBEHkhHlDv0B2G+wFuQhTxq9oABUcrC6ph9xn7O8NRTiPodoqftQ71qGpB04y62C4WFHF+J6wkupltERiDZhZ0m8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YykBf/xs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 2FF6820B716C; Mon, 27 Apr 2026 14:39:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2FF6820B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777325947;
	bh=Yx64nvYTvY6la2T5WN/L3+C9DJts9dYoqLMPjR+w/9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YykBf/xs+2L7LiYQtM2VMoKQaauNSRLrW5xe5mxETfnK7btUSZsHQq+Yv4g8NKVaT
	 ktbJ2dONBy9a4hLntlMwu3nrS4LZ5QYbRwVC4DqDmaS+7ybFRP+tSzpJprfcF0VOUe
	 A50pWZuh5PNBUeacgWSQjKpCfcBkTovigkPghDWQ=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>,
	Anirudh Rayabharam <anirudh@anirudhrb.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH v4 2/3] mshv: clean up SynIC state on kexec for L1VH
Date: Mon, 27 Apr 2026 14:38:53 -0700
Message-ID: <20260427213855.1675044-3-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F20647AB81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10404-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,anirudhrb.com,vger.kernel.org,linux.microsoft.com];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

The reboot notifier that tears down the SynIC cpuhp state guards the
cleanup with hv_root_partition(), so on L1VH (where
hv_root_partition() is false) SINT0, SINT5, and SIRBP are never
cleaned up before kexec. The kexec'd kernel then inherits stale
unmasked SINTs and an enabled SIRBP pointing to freed memory.

Remove the hv_root_partition() guard so the cleanup runs for all
parent partitions.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_synic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 2db3b0192eac..978a1cace341 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -723,9 +723,6 @@ mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
 static int mshv_synic_reboot_notify(struct notifier_block *nb,
 			      unsigned long code, void *unused)
 {
-	if (!hv_root_partition())
-		return 0;
-
 	cpuhp_remove_state(synic_cpuhp_online);
 	return 0;
 }
-- 
2.43.0


