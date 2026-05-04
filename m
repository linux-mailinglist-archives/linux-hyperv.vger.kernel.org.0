Return-Path: <linux-hyperv+bounces-10608-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKs8F5/w+Gmr3QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10608-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:16:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7BF4C31D5
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 648523061A3B
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD563F0742;
	Mon,  4 May 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cMiHr+gd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0289B3EFD2E;
	Mon,  4 May 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921806; cv=none; b=VStQz33aB0fD6KMcn7g0NIRQG703DiVKkFcJcSIhT+ifKQGPUOuHPs3kq8RluSyllrzBaUXplw7BWVyj2YBQugeMgGk13YGpbfoYbmS58UdBXLl+Ou9WiFG1PSa2gFpzcsmcfMA80a6m1/GUQ9iGRfiFuUUVay5p1YhRhO/43sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921806; c=relaxed/simple;
	bh=c8LHzBNzI7BHchDKfgh/e9MvO0h6wDrfGJbjn7vIn5A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnhtQs8352DUiOLzz5S70me3P9gs8v73ugt2t9BflttYEOOnO2p16ENKtw+bMHpaOxec3UPjhTnVKgyQtEpJozHoMjMX+g79ecq8I0m71Szazerj1Fo3lGvdxkivtWrJ0y+3JUfakiE6ANuoo6YbRXIrsR6+rGDeCglb7XdFW0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cMiHr+gd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 19BF620B7168;
	Mon,  4 May 2026 12:10:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19BF620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921803;
	bh=ey70lcx+BVallWG8rfFgGzN9FQMMI/df+OXYEPTzdZs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cMiHr+gd/QhVe+rKto4X24d804yBOgnZLM8TBd9AWclsnZ+TQvTbnvNizVEn+04Sb
	 EuD+iTgiepqlNhSIU5m/EDZeF7ZDcLGZZvORPd9M6BLz+TznPkm4mmNkJ4lO0vY9Og
	 Wb/PJbvrkSvbY4jElGoaadtHoRjHx6Dyou16sT/w=
Subject: [PATCH v3 13/18] mshv: Fix sleeping under spinlock in
 mshv_portid_alloc
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:10:04 +0000
Message-ID: 
 <177792180453.90827.15386802468064727510.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177792164525.90827.16672331609214066870.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AC7BF4C31D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10608-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]

idr_alloc() is called with GFP_KERNEL inside idr_lock(), which holds a
spinlock. GFP_KERNEL allows the allocator to sleep, triggering a
sleeping-while-atomic bug.

Fix by using idr_preload(GFP_KERNEL) before taking the lock to
pre-allocate memory in a sleepable context, then idr_alloc() with
GFP_NOWAIT inside the spinlock-protected section.

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_portid_table.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
index f1aaef69eb9b7..d6884c601b298 100644
--- a/drivers/hv/mshv_portid_table.c
+++ b/drivers/hv/mshv_portid_table.c
@@ -40,12 +40,14 @@ mshv_port_table_fini(void)
 int
 mshv_portid_alloc(struct port_table_info *info)
 {
-	int ret = 0;
+	int ret;
 
+	idr_preload(GFP_KERNEL);
 	idr_lock(&port_table_idr);
 	ret = idr_alloc(&port_table_idr, info, PORTID_MIN,
-			PORTID_MAX, GFP_KERNEL);
+			PORTID_MAX, GFP_NOWAIT);
 	idr_unlock(&port_table_idr);
+	idr_preload_end();
 
 	return ret;
 }



