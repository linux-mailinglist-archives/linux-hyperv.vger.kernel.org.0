Return-Path: <linux-hyperv+bounces-9359-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PMtEPTlsmktQwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9359-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 17:12:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7A827549D
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21A603024952
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24B13CF694;
	Thu, 12 Mar 2026 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TJT4eO7v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE07134E74F;
	Thu, 12 Mar 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331374; cv=none; b=BzxqY8Dnp+nkjTqCI+ZjkPTdia2lY21un1SL+LYbnPDMx1cFk8jltQWbSCY1HWaczX0WNQI9ioOk+5tDirAvSuTH3Gu6m7YmIJLL3F5BZUotOoGbTSbLu0v5vx0iq/giZ88w2+H/ESjMvIBcUVwqtKvAV/9GlJ7Jm/gF7EYZu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331374; c=relaxed/simple;
	bh=NkIIQcGJNjhoGH9JqcEacRvqv1/6z+Qgxn7x/Te3w20=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=sLQkDrhTvf2CNaVoFRqrLpDAtfnOS4P6ty+xG+Sl8IXzo70PQf2BkcAgLwNgVpmBoqrfwB0v1yoxQPZtsuCosTGZkiomeCutIbe5Ra2B0+n1aaOhRwmpfn/6oaP6aol7kJPZ5vcFmwKsBxK7teMqWVkUU5ISXfrP+GsD6YvdCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TJT4eO7v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 742B120B710C;
	Thu, 12 Mar 2026 09:02:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 742B120B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773331373;
	bh=isXBVGrS0HqTdALf51zYJR6Bd7oeDfcrw7kvxv9MFDU=;
	h=Subject:From:To:Cc:Date:From;
	b=TJT4eO7vzseZsbDqcQWHJ0YYzu4zy2Uyy+Y0kZ5ciCYHupi3A9Om0xy9gdZtCHvPc
	 wwoC1zkf7+Kr6krVgBjx5HlbSi6AT4Mloo1WllSFyuAIiK8+N7zXaBVSdQL2j8LSQx
	 3VEKJqi/p1hjmF39ROv85k6tFiv34kcXiQq/QwcA=
Subject: [PATCH] mshv: Fix use-after-free in mshv_map_user_memory error path
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Mar 2026 16:02:53 +0000
Message-ID: 
 <177333136886.20575.6266852562711420295.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-9359-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: AC7A827549D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the error path of mshv_map_user_memory(), calling vfree() directly on
the region leaves the MMU notifier registered. When userspace later unmaps
the memory, the notifier fires and accesses the freed region, causing a
use-after-free and potential kernel panic.

Replace vfree() with mshv_partition_put() to properly unregister
the MMU notifier before freeing the region.

Fixes: b9a66cd5ccbb9 ("mshv: Add support for movable memory regions")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index d753f41d3b57..796f3ca8308f 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1388,7 +1388,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	return 0;
 
 errout:
-	vfree(region);
+	mshv_region_put(region);
 	return ret;
 }
 



