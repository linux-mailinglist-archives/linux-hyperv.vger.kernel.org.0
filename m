Return-Path: <linux-hyperv+bounces-10068-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH7WM7Gx1WlQ8wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10068-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:38:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAD73B5FCA
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81A23305B2A3
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 01:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DF1367F2F;
	Wed,  8 Apr 2026 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pThPYPrH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82742346E66;
	Wed,  8 Apr 2026 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612229; cv=none; b=eOYkG2ttKyOde2PXqowH8gt857ZhLs9IR/Aqz19EMSvX74H7xdUcncRKXoLl/UDwXbWNl6JVePgZ8PnWdkytZmzYeOu7+ky/9l2QPooj/zvJZCZQumxQcENN7HFlPk2XqwWWF/S9cLRXvK/4JiIL/qj3k44I4OCjYEtj88Ed7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612229; c=relaxed/simple;
	bh=Q2izXC+z+WbDbggmCi3c0ohROAx7P7cRonWTVcfg1Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuUJTvvlfQgDQw0VKUIOYSHO4twNOY+d+B1cR5gvAtg4OJDw+ths+vciH450bTJzCCPdkpyEuH34FIN93vR/ncifHUukj31zrChH0W5KlZ0ZkP4cyptqpmhmbOFiOFICo9P7d0Nj5HOj1O69ZX3qjI7eF3e9tjDAFpvFn1lBCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pThPYPrH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 82DCB20B6F28; Tue,  7 Apr 2026 18:37:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82DCB20B6F28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775612228;
	bh=qnoh1H1pe46ptsG+0LuWtQ2zk76EKOhH6XRzycpSQRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pThPYPrH0DQUmVBVWzRMsJx3EV8MyMvi0U5Ys0DheZDosVyTFzMk/veGahRVH2yOb
	 jSB13o7OKYfh8bsFSpfqKEHuHfpk2HGihLW7+pSn0wUuNI1I2dmZ8Jrpa2MKhMKT3z
	 jDmCnLldSAWMjk3mQkENLHSj7ys0cKi4cB67C1IM=
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
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH v3 5/6] mshv: clean up SynIC state on kexec for L1VH
Date: Tue,  7 Apr 2026 18:36:42 -0700
Message-ID: <20260408013645.286723-6-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260408013645.286723-1-jloeser@linux.microsoft.com>
References: <20260408013645.286723-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10068-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DAD73B5FCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index f71d5dfce1c1..8fe673c876fd 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -719,9 +719,6 @@ mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
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


