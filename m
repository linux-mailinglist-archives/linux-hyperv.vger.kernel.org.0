Return-Path: <linux-hyperv+bounces-10393-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGnrF15372mZBgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10393-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 16:49:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2148474ACD
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862C8307B4C0
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CD63A6F16;
	Mon, 27 Apr 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h2bEV5XX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3C386571;
	Mon, 27 Apr 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301060; cv=none; b=UKVkZ8mbNeli6AM+mk+6BuBH1mAERlfhjJWo0A/bQhk/W48xAAYbQbsxzH+YnrAXjpDjA2YlX/CGWssmbkF/LTMwfI+MuYcWFmvgUEzZMAqPW7Isnz50esUJxo7SHvoS49JWHFNTXTyUDHXpfveDeAT1Gfyy+DbMG1+gs2VTRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301060; c=relaxed/simple;
	bh=zuy6yKanrahvtPzlSCAYX6YGphdraKmlWgmE4C4Xcf4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=QkmF6Lfn/8Y++1kFjMhzOiHsggvNcBxOc5leuQqsCglbN1/9MgChAnXYwAeOphLxLEJsvdAtYs1BnFSIEWo7DKfVPJa9Fi2tMPzvSmiwwzOTev5gcd7dxobO8Wu7+YIMssHQ4pkL2j2lcMt4fCgrc94m130E/1rIbzx2EgB2on0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h2bEV5XX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0CF3720B716A;
	Mon, 27 Apr 2026 07:44:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CF3720B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777301056;
	bh=d9sPejch5ixW+F8ylTsm3X6ugBW/JSAm2MnKU2hdd2Q=;
	h=Subject:From:To:Cc:Date:From;
	b=h2bEV5XXquRSIGF76iXSIheFLEjFG3vnX+bT9OnnRKvxdkXZkofqgZB7e2kAqIn5q
	 s8iwL+7LqzgkBIItdygHD8mPDYw2o3UdW2fSMTjONqwhdFEemX4Ytvin7cV48cSZib
	 PgOeb982IhT7FI3HFQFxvrfatPMt8srEoawWzYzA=
Subject: [PATCH v2] mshv: Fix interrupt state corruption in hv_do_map_pfns
 error path
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Apr 2026 14:44:15 +0000
Message-ID: 
 <177730104962.21733.4130809041576931551.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B2148474ACD
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
	TAGGED_FROM(0.00)[bounces-10393-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]

Restore interrupt state before breaking out of the loop on error.

The irq_flags are saved before entering the loop, but the early exit
path on error fails to restore them. This leaves interrupts in an
inconsistent state and can lead to lockdep warnings or other
interrupt-related issues.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_hv_call.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index ab210a7fcb8c3..61291ec6f3468 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -229,8 +229,10 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 			} else {
 				pfnlist[i] = mmio_spa + done + i;
 			}
-		if (ret)
+		if (ret) {
+			local_irq_restore(irq_flags);
 			break;
+		}
 
 		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
 					     input_page, NULL);



