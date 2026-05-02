Return-Path: <linux-hyperv+bounces-10568-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJmoGkt+9WnZLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10568-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:32:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34B4B0E35
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83723301DC24
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 04:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD424263C7F;
	Sat,  2 May 2026 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VaPmpqRw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7F621ADA4;
	Sat,  2 May 2026 04:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696120; cv=none; b=Prso56FPMJyfQj/9EO0Xgavn9pury1CU9t/662b0EUYVeofe123xfwFFuLE0ZiewCW7PwvP7+JjKZCFQ6b20yO/ywpYBihRjAayNEUlKkj49lf1PMBM3TjgjnvuWnEg+xMZsglvI+GLMWEpb21aAyTNlvv1xWdhbI6mevq6/lgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696120; c=relaxed/simple;
	bh=1JCzDCBzvqbaePUrSylQij5FF8HwK7HQxV7tha0FF94=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRlaXH2CSPKygshLenWNkqa4boGrSUatF1kOjpFlODTKhtn1kM1ZWPR5dqDKq2Ti3TpwGLWr2M3oXmyQb7zipanjaVAhaRNQ9J+8iXPBqB1gqn6JQprVXl2Y9BbrDaMe5HANYJBycng5R+YfFhxWwFHymkyRnxAL1h9tLGeffPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VaPmpqRw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0FF2520B7168;
	Fri,  1 May 2026 21:28:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FF2520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696119;
	bh=aCcNA0uwumXaSJvd6U4yvamZcLIgd5xoIVIDi3+uReU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VaPmpqRwc6z4M0o3uZ53KWZ1SlkteelLVWExbkDIlMETs9UwmlZ2VjrIj7nJU1diZ
	 fFXie0L6H6YaLjNb72utpPfbt5s44FI1mPfF2XaZcwvyGTWXNl8rtUNKzDIkOQFw1D
	 q7QfYYYsvJ4NEzY5YUJKHhr6+ruw3Ly8F0d/E73o=
Subject: [PATCH v2 16/18] mshv: Add store/load ordering for VP array publish
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:28:39 +0000
Message-ID: 
 <177769611908.222166.15568609936261149068.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DA34B4B0E35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10568-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

mshv_vp_create() publishes a VP pointer to pt_vp_array with a plain
store. The ISR reads this array locklessly from interrupt context on
other CPUs. Without memory ordering, a reader may observe the non-NULL
pointer before all VP fields (e.g. vp_register_page, run.vp_suspend_queue)
are fully initialized, leading to use of uninitialized data.

Fix by using smp_store_release() when publishing the VP pointer and
smp_load_acquire() on all lockless ISR read sites. This guarantees that
all VP initialization is visible to readers before the pointer itself.

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |    3 ++-
 drivers/hv/mshv_synic.c     |    6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 2b7d56e108bad..f01bd0877aef1 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1224,7 +1224,8 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 
 	/* already exclusive with the partition mutex for all ioctls */
 	partition->pt_vp_count++;
-	partition->pt_vp_array[args.vp_index] = vp;
+	/* Ensure VP is fully initialized before visible to lockless ISR readers */
+	smp_store_release(&partition->pt_vp_array[args.vp_index], vp);
 
 	goto out;
 
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index d4d98fa771189..5333b3889a408 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -244,7 +244,7 @@ handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
 				goto unlock_out;
 			}
 
-			vp = partition->pt_vp_array[vp_index];
+			vp = smp_load_acquire(&partition->pt_vp_array[vp_index]);
 			if (unlikely(!vp)) {
 				pr_debug("failed to find VP %u\n", vp_index);
 				goto unlock_out;
@@ -293,7 +293,7 @@ handle_pair_message(const struct hv_vp_signal_pair_scheduler_message *msg)
 			break;
 		}
 
-		vp = partition->pt_vp_array[vp_index];
+		vp = smp_load_acquire(&partition->pt_vp_array[vp_index]);
 		if (!vp) {
 			pr_debug("failed to find VP %u\n", vp_index);
 			break;
@@ -388,7 +388,7 @@ mshv_intercept_isr(struct hv_message *msg)
 		pr_debug("VP index %u out of bounds\n", vp_index);
 		goto unlock_out;
 	}
-	vp = partition->pt_vp_array[vp_index];
+	vp = smp_load_acquire(&partition->pt_vp_array[vp_index]);
 	if (unlikely(!vp)) {
 		pr_debug("failed to find VP %u\n", vp_index);
 		goto unlock_out;



