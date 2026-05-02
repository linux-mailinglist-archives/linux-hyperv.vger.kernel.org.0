Return-Path: <linux-hyperv+bounces-10570-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJsUB9R99WnZLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10570-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:30:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8E84B0DF3
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 105123019522
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 04:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A56F299959;
	Sat,  2 May 2026 04:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MUibl5ax"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E828C84A;
	Sat,  2 May 2026 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696131; cv=none; b=XvNIa1vj2hK4aZRwHkHiGTo2Um12X6judvjINpoBwVy6jnNj3S3jBeMS6G2fFxt2b3as5aSYN1PU3oWsq0BzhdfziVRkk80P9/Dn2aJgxY88l86zL1y+ZNnMyLuIi/G/GtGbKdZawCsBfPELl8teaaL+ARF88YvjHdBhZiX5DTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696131; c=relaxed/simple;
	bh=OZmAt447JyxaP4W4YgO6kmRYZHoa6bya6hFxMSkEWsk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qT5gzXGthz8JL5eJ/ds35RGdy/Y9z1VRdV8Z2g15rWby74tTdMyBpXacyQWzakd+1UpMGE+I5y3TOPKqWYPTXEFwFVJdI6E7H+qzu3g/PWKXgTvo9Fcqj9jE30TaQaJgWlEi0yxzEw/r7s5gyJPAlubFgvENIu6SAUMwUMtzhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MUibl5ax; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id D097320B7168;
	Fri,  1 May 2026 21:28:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D097320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696129;
	bh=DijlIgZj2vSfcirGyY9xJC3xR7yXeMPqlgUDwTIffY8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MUibl5axoKA7VLtJ2i3brIM/ZRN1/y66uu/dQ9bWdtXriS1EgKrfLGNoi6JgRLpZH
	 zMVA6wlkDMZDPBOBoDCYwfJtNVwKqcB7IpbrxYUxiroKDcvjR9SBWjk0eg3WHpxsSE
	 M4fB6QADC4oBHvmui9xtaPrs4Kb23f1nizwx7AE4=
Subject: [PATCH v2 18/18] mshv: Fix missing error code on VP allocation
 failure
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:28:49 +0000
Message-ID: 
 <177769612985.222166.3014850132476471330.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: 6F8E84B0DF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10570-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]

In mshv_partition_ioctl_create_vp(), when kzalloc for the VP struct
fails, the code jumps to the cleanup path without setting ret. At that
point ret is 0 from the preceding successful mshv_vp_stats_map() call,
so the function returns success to userspace despite having failed to
create the VP. No fd is installed and no VP is registered in pt_vp_array,
but userspace has no way to know the operation failed.

Set ret to -ENOMEM before jumping to the cleanup path.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index f01bd0877aef1..c9371e049c42b 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1186,8 +1186,10 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
 		goto unmap_ghcb_page;
 
 	vp = kzalloc_obj(*vp);
-	if (!vp)
+	if (!vp) {
+		ret = -ENOMEM;
 		goto unmap_stats_pages;
+	}
 
 	vp->vp_partition = mshv_partition_get(partition);
 	if (!vp->vp_partition) {



