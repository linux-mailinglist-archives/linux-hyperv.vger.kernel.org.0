Return-Path: <linux-hyperv+bounces-8561-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFISIoM0eml+4gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8561-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:08:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ECDA5243
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4BF93015ADA
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 16:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE53090CF;
	Wed, 28 Jan 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="HeqW7o97"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C83033C4;
	Wed, 28 Jan 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616324; cv=pass; b=lLUqTcMyggFUIKg5d+YOQDtqWIODUyH8/IstJKjFjW372nK+7QgMD9dP4p9txVKFjVdFgfiVkEutwNt1q1ORBX1JFrTDVddcJx/z9nCfVYdaGqspBe+ce8I9eQlGTkhE7U8kp50wlw701Hq2FvCf8HReKljMP+StLb5nVRrN8rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616324; c=relaxed/simple;
	bh=46MpuE7cj/nMDFCGc2gs3Dv76e31vD8Bg6S7WpievX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qd161BXL32e1EOPm6dX+/F26qRwu5q5+v/qPnmHKmYspKZKrxn+BvxP+6vMln8yS0c9gLCl19uBaof7f4/DZUd9CeVfhIhTKWQbtzfsIpWz1T9jGjjNQMHGHg1xYakK++WXJW3TTAYck4RCpLZscoITSWWbtVXPft5aBGFLofGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=HeqW7o97; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769616316; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gyxdnOx7JhI9IL4xls+06Wov7Mxp+jS9youn4JDiUqyBpiB5Wr1tnrYgmalAw3xhVv7Cvh6nymZ1zUgp7u42X/WN40Jrh5FlpNT9ZRsSdmdiG1pes+h4NcWmnXiPS+yOceuC13ciMFctO7L2zITfRnkobl/fppOVT0K7E4b9y0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769616316; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zJoSbIKZMgdEKdInpaUpwUo7fY/+kfv6C7aT5wuETMI=; 
	b=RPLaBxc83L53aH7hSOCn0aQH8xp9g1n49bp43W34CgdnjkOVmMHmi2b53rTXU/1Kc5d/n5sKnoN+WSzIpVB+wns8gmFS6bNnMshfX+JsnKxwtJgJKn+N6UBodQI8A2+s67WV6qLgAXos3k0tUhi7h/ndKNZ4nQL31vUcqYNodDg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769616316;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=zJoSbIKZMgdEKdInpaUpwUo7fY/+kfv6C7aT5wuETMI=;
	b=HeqW7o97VW4vhZlwMH0HIs8TTujRpIqjV056XVWPfudQUnXlXxARkod3wTQA0ObQ
	ixi6k9lVZZR8a2Z2sMP8LpCDD0tabBx+GrmqPhG/fNMHnWS5FT3WcLcc0Rq/PuSkGv6
	r3usnd6S22s63cHgWT1/1js53K0KUbD18m4SAVB4=
Received: by mx.zohomail.com with SMTPS id 1769616314675624.4464552548868;
	Wed, 28 Jan 2026 08:05:14 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH 1/2] mshv: rename synic per-cpu init/cleanup functions
Date: Wed, 28 Jan 2026 16:04:36 +0000
Message-Id: <20260128160437.3342167-2-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128160437.3342167-1-anirudh@anirudhrb.com>
References: <20260128160437.3342167-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8561-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:dkim,anirudhrb.com:mid]
X-Rspamd-Queue-Id: 28ECDA5243
X-Rspamd-Action: no action

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Rename mshv_synic_init() to mshv_synic_cpu_init() and
mshv_synic_cleanup() to mshv_synic_cpu_exit() to better reflect that
these functions handle per-cpu synic setup and teardown.

This prepares for a future patch that will introduce mshv_synic_init()
and mshv_synic_cleanup() for common, non per-cpu initialization.

No functional change.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_root.h      | 4 ++--
 drivers/hv/mshv_root_main.c | 4 ++--
 drivers/hv/mshv_synic.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 3c1d88b36741..c02513f75429 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -242,8 +242,8 @@ int mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb,
 void mshv_unregister_doorbell(u64 partition_id, int doorbell_portid);
 
 void mshv_isr(void);
-int mshv_synic_init(unsigned int cpu);
-int mshv_synic_cleanup(unsigned int cpu);
+int mshv_synic_cpu_init(unsigned int cpu);
+int mshv_synic_cpu_exit(unsigned int cpu);
 
 static inline bool mshv_partition_encrypted(struct mshv_partition *partition)
 {
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 681b58154d5e..abb34b37d552 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2284,8 +2284,8 @@ static int __init mshv_parent_partition_init(void)
 	}
 
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
-				mshv_synic_init,
-				mshv_synic_cleanup);
+				mshv_synic_cpu_init,
+				mshv_synic_cpu_exit);
 	if (ret < 0) {
 		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
 		goto free_synic_pages;
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index f8b0337cdc82..ba89655b0910 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -446,7 +446,7 @@ void mshv_isr(void)
 	}
 }
 
-int mshv_synic_init(unsigned int cpu)
+int mshv_synic_cpu_init(unsigned int cpu)
 {
 	union hv_synic_simp simp;
 	union hv_synic_siefp siefp;
@@ -542,7 +542,7 @@ int mshv_synic_init(unsigned int cpu)
 	return -EFAULT;
 }
 
-int mshv_synic_cleanup(unsigned int cpu)
+int mshv_synic_cpu_exit(unsigned int cpu)
 {
 	union hv_synic_sint sint;
 	union hv_synic_simp simp;
-- 
2.34.1


