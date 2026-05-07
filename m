Return-Path: <linux-hyperv+bounces-10684-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGFCGpKz/GnlSgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10684-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:45:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D43A44EB49D
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2863306E7EB
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D524E3E8688;
	Thu,  7 May 2026 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pa39CMJI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFEA41B344;
	Thu,  7 May 2026 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168636; cv=none; b=IO0p9pn2aChPR3xhggBn+tf3hchTeYN0D8+XYrgjKp2419r6iy5l1sCT6Pn3ZFgPJ/lG4zYs/w68Y59puRSzWbRW+sJAlyVkQcJtmc/+xFDPDWZmtFj3QIq9WnJSlOvduDoYmiBCgRzXOtctkzPNntSS4/BJlXUT7jnPWeL7ji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168636; c=relaxed/simple;
	bh=nhGgC54aB3rhn+RFoCt3eaavjX60+Ln+0GBisYCAiEw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+HtaLrKwPzWX+n3yv9tohS2k6sfabhnVGyUY0imM+T+AiAFTbYmMiuHj+YpZvIr4ozyOTN5MGy9y0yhiIZ9YbnC7FSY4eYhO2piVuqlc6p0IiBpCqo9nhqgTB8Wzhrk1yyomRbE044VjOJGjARkZOnumrJRoYvDstLfVSQiBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pa39CMJI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7F29D20B7165;
	Thu,  7 May 2026 08:43:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F29D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168631;
	bh=iJ4CyRXbQ5+bZEQjJkJ6prPgKWag1od1O2gNa7ub8gY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pa39CMJIuf9m0oHv5u5oP3CJqOVh37r2eaCcYu5A9i28UTxIM2UQrh75i7t6shFiK
	 LvsFtS8MV212cVlWjbICM3pSmKYc8/buJ/rvkIX3b5rOoHwXkaLjmtDD0TH0s+fF8g
	 bHK8Itnz0GcrJ80UVULgO1wEf9xO+5VsX6GQvaj8=
Subject: [PATCH v4 10/18] mshv: portid_table: Make mshv_portid_lookup()
 RCU-aware by contract
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:43:54 +0000
Message-ID: 
 <177816863447.21765.7284842709694944084.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D43A44EB49D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10684-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,hv_port_doorbell.data:url]
X-Rspamd-Action: no action

mshv_portid_lookup() previously took rcu_read_lock() internally, ran
idr_find(), released the read lock, and copied the struct contents
into a caller-supplied buffer.  This had two problems.

1. The struct copy ran outside the read section, racing with
   mshv_portid_free() which does idr_remove + synchronize_rcu + kfree.
   A copy that started just before synchronize_rcu() observed the read
   section as already drained and was free to read freed memory while
   the writer was kfree()'ing the entry.

2. The only consumer, mshv_doorbell_isr(), then dispatched a callback
   using fields of the snapshot — entirely outside any RCU read
   section.  The callback's data argument and any field it touches
   were therefore safe only because mshv_isr() runs from
   sysvec_hyperv_callback, a non-threaded system vector that
   synchronize_rcu() implicitly waits for via the hardirq quiescent-
   state coupling.  That protection is real today but undocumented and
   fragile: a future move of mshv_isr() to a threaded context, or a
   future caller that registers a doorbell with a shorter-lived data
   pointer, would silently expose a use-after-free.

Make the contract explicit instead of implicit.  mshv_portid_lookup()
now returns a pointer to the table entry and requires the caller to
hold rcu_read_lock for the entire lifetime of that pointer.  The
contract is annotated with __must_hold(RCU) so sparse flags any
direct caller that forgets it.  The sole caller, mshv_doorbell_isr(),
takes rcu_read_lock around the whole drain loop, so the lookup, the
field reads, and the doorbell_cb dispatch all run inside one
read-side critical section.  synchronize_rcu() in mshv_portid_free()
now genuinely waits for any in-flight callback before kfree() runs,
without relying on hardirq context for correctness.

This also drops the by-value struct copy: entries are publish-once
(populated before idr_alloc) and free-once (after synchronize_rcu),
so a pointer dereferenced inside the read section gives a stable
view of the contents without copying.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_portid_table.c |   22 +++++++---------------
 drivers/hv/mshv_root.h         |    2 +-
 drivers/hv/mshv_synic.c        |   15 +++++++++------
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
index c349af1f0aaac..4cdf8e9575390 100644
--- a/drivers/hv/mshv_portid_table.c
+++ b/drivers/hv/mshv_portid_table.c
@@ -64,20 +64,12 @@ mshv_portid_free(int port_id)
 	kfree(info);
 }
 
-int
-mshv_portid_lookup(int port_id, struct port_table_info *info)
+/*
+ * Caller must hold rcu_read_lock for the entire lifetime of the
+ * returned pointer.  Returns NULL if @port_id is not in the table.
+ */
+struct port_table_info *mshv_portid_lookup(int port_id)
+	__must_hold(RCU)
 {
-	struct port_table_info *_info;
-	int ret = -ENOENT;
-
-	rcu_read_lock();
-	_info = idr_find(&port_table_idr, port_id);
-	rcu_read_unlock();
-
-	if (_info) {
-		*info = *_info;
-		ret = 0;
-	}
-
-	return ret;
+	return idr_find(&port_table_idr, port_id);
 }
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 2e6c4414740cc..b6961a6d9a98b 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -241,7 +241,7 @@ void mshv_irqfd_routing_update(struct mshv_partition *partition);
 
 void mshv_port_table_fini(void);
 int mshv_portid_alloc(struct port_table_info *info);
-int mshv_portid_lookup(int port_id, struct port_table_info *info);
+struct port_table_info *mshv_portid_lookup(int port_id) __must_hold(RCU);
 void mshv_portid_free(int port_id);
 
 int mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb,
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 43f1bcbbf2d34..bac890cd2b468 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -114,24 +114,27 @@ mshv_doorbell_isr(struct hv_message *msg)
 	if (notification->sint_index != HV_SYNIC_DOORBELL_SINT_INDEX)
 		return false;
 
+	rcu_read_lock();
 	while ((port = synic_event_ring_get_queued_port(HV_SYNIC_DOORBELL_SINT_INDEX))) {
-		struct port_table_info ptinfo = { 0 };
+		struct port_table_info *ptinfo;
 
-		if (mshv_portid_lookup(port, &ptinfo)) {
+		ptinfo = mshv_portid_lookup(port);
+		if (!ptinfo) {
 			pr_debug("Failed to get port info from port_table!\n");
 			continue;
 		}
 
-		if (ptinfo.hv_port_type != HV_PORT_TYPE_DOORBELL) {
+		if (ptinfo->hv_port_type != HV_PORT_TYPE_DOORBELL) {
 			pr_debug("Not a doorbell port!, port: %d, port_type: %d\n",
-				 port, ptinfo.hv_port_type);
+				 port, ptinfo->hv_port_type);
 			continue;
 		}
 
 		/* Invoke the callback */
-		ptinfo.hv_port_doorbell.doorbell_cb(port,
-						 ptinfo.hv_port_doorbell.data);
+		ptinfo->hv_port_doorbell.doorbell_cb(port,
+						 ptinfo->hv_port_doorbell.data);
 	}
+	rcu_read_unlock();
 
 	return true;
 }



