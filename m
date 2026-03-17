Return-Path: <linux-hyperv+bounces-9496-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI5OEY1vuWm8EgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9496-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 16:13:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 922042ACC10
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 16:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 137A931A835C
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9278B3EAC6B;
	Tue, 17 Mar 2026 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qtWMwFAm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744433DCD9B;
	Tue, 17 Mar 2026 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759897; cv=none; b=A7ufsftekHwYNAfCPlp7ROweSSqAc/K4GvpAo5/oMDApCDwS9q0wajOgtSt1Q/uVpXKjk1BAAjfKt2L9ybbzeAHP+SuwS4e30ouDtED9DJ5D4WgDVkX+EOfoadpDMGEawoDUTxlDSw0JZx7rRiz5PGc8X/8BN0biWo/sYZFaGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759897; c=relaxed/simple;
	bh=Nju13bP2JQNZWaaAghXqnxHQYnUOGSAsO3eiRARZc1I=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=mcFvTKdmNK82z9M3k7Sn3sisMmMCHzugLEqzvEV4stcRMYukJANRgfOS94TiErTtrFhaUMc/skYHj9Xf7AcaAVgEmEhRqTK4VS/BZaJtj18a3kLPBx0M42UBPKfOQ15iR8P7Ub6INtMGSbYFoB9+AvR/obiF713HaFyG19B2JW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qtWMwFAm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0E80620B710C;
	Tue, 17 Mar 2026 08:04:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E80620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773759896;
	bh=FpiJ7gAW8P+u7C6i3BGyK2rHhO2RLMU7+6KhBeJQ3rY=;
	h=Subject:From:To:Cc:Date:From;
	b=qtWMwFAmxojLt0gg4frYqhMAn+gfDjCXi4C7Haj6XPl/BUS05VbABwKXAGo7TgKlJ
	 j+rv2K2aUwqEcs5Qmd+Ou84Kx957YA2Md2YdmgGS6qzDbG6fRyZnv94jz/0+/Egg6T
	 ZSKuB+tjxTzon+vZU6M04j9Qws+4pJkWimKJQcMw=
Subject: [PATCH] mshv: Fix error handling in mshv_region_populate_pages
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Mar 2026 15:04:55 +0000
Message-ID: 
 <177375989324.25621.6532741522672582851.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-9496-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 922042ACC10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current error handling has two issues:

First, pin_user_pages_fast() can return a short pin count (less than
requested but greater than zero) when it cannot pin all requested pages.
This is treated as success, leading to partially pinned regions being
used, which causes memory corruption.

Second, when an error occurs mid-loop, already pinned pages from the
current batch are not released before calling mshv_region_evict_pages(),
causing a page reference leak.

Fix by treating short pins as errors and explicitly unpinning the
partial batch before cleanup.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index c28aac0726de..fdffd4f002f6 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -314,15 +314,17 @@ int mshv_region_pin(struct mshv_mem_region *region)
 		ret = pin_user_pages_fast(userspace_addr, nr_pages,
 					  FOLL_WRITE | FOLL_LONGTERM,
 					  pages);
-		if (ret < 0)
+		if (ret != nr_pages)
 			goto release_pages;
 	}
 
 	return 0;
 
 release_pages:
+	if (ret > 0)
+		done_count += ret;
 	mshv_region_invalidate_pages(region, 0, done_count);
-	return ret;
+	return ret < 0 ? ret : -ENOMEM;
 }
 
 static int mshv_region_chunk_unmap(struct mshv_mem_region *region,



