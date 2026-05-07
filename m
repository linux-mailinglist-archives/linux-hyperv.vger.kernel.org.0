Return-Path: <linux-hyperv+bounces-10678-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCFhMBi0/GmOSwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10678-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:47:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 230AB4EB566
	for <lists+linux-hyperv@lfdr.de>; Thu, 07 May 2026 17:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81FFD30AA0D8
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2026 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AF9428833;
	Thu,  7 May 2026 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UzcuG2Tq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226C3E8688;
	Thu,  7 May 2026 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168602; cv=none; b=bXPuWQJH40EmhcOTuFWuJpvYgJK1qHwE3tjbBNSEP/1SE07GcBFbNH/YuhmPxFIFMzPS7YUw+R6ih0JQ+PM8/rmS95Y/EPbHdQAqxp++rMyD5I7LUdJZWU42zDFkluDqDnfbL6j2Xlq/Cr84O+845bJPDsnOMymifyiivLJvf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168602; c=relaxed/simple;
	bh=ED2nM4CYq7YDWs8CMcszwV6PRkqmafvXlCK7VNhoiRw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdlKHr70lN6QKhFLk1N6bhMDwci9i6eNfTsNGo2iMWO0wFeDbtSAme8jLqqNnMZBgavtpJ7YBXEGEU2pneZRnPuwqZJTIvyaG4c+tNUfMEJQ6rhKHWvhaxEX+VuC/fyp2GodSY0FY+l1CDIhqBoO7UH1J6huS2OlfgvNu315WEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UzcuG2Tq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3975420B7165;
	Thu,  7 May 2026 08:43:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3975420B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168598;
	bh=ZCFdf1B3BgP5jBiKNktCHl5mFTO4NqiIgt5qvA9ixm4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UzcuG2Tqe1BwXw2oZdneA8hkpBvoNBIgpMyKaOTLlqbBST51tQA/CNrsukL0rDUQO
	 lK7iHE1KC+tcuEvOGdAdeRfG3mGdMr48Isv4HusO+dkEKyZar5mpR/5aXXNm4JanAD
	 4n3b+DFJ5KoMBdsi8qAOc2uvmv9YuPVzsyGqb6mI=
Subject: [PATCH v4 04/18] mshv: Add NULL check for vp in
 mshv_try_assert_irq_fast
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:43:21 +0000
Message-ID: 
 <177816860118.21765.7481864545928795603.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 230AB4EB566
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
	TAGGED_FROM(0.00)[bounces-10678-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

mshv_try_assert_irq_fast() dereferences the vp pointer obtained from
pt_vp_array[lapic_apic_id] without checking for NULL or validating that
lapic_apic_id is within bounds. A spurious interrupt from the hypervisor
targeting a non-existent VP (or one not yet created) causes a NULL
pointer dereference and crashes the host.

Add a bounds check on lapic_apic_id against MSHV_MAX_VPS and a NULL
check on the vp pointer before dereferencing.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 5995a62aff8d8..b398e58411dd7 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -169,7 +169,12 @@ static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
 		return -EOPNOTSUPP;
 #endif
 
+	if (irq->lapic_apic_id >= MSHV_MAX_VPS)
+		return -EINVAL;
+
 	vp = partition->pt_vp_array[irq->lapic_apic_id];
+	if (!vp)
+		return -EINVAL;
 
 	if (!vp->vp_register_page)
 		return -EOPNOTSUPP;



