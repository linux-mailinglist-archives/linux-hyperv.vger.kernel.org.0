Return-Path: <linux-hyperv+bounces-10602-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGA8IfDv+Gl93QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10602-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:13:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADD04C30F8
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 21:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2349C303EE8C
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 19:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5853F0AAB;
	Mon,  4 May 2026 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MbsWB7Tu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC2D3F23AE;
	Mon,  4 May 2026 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921773; cv=none; b=ghnPerYAeSVbW2oISQHWHo8MAMZ8h0zqQf7jUNVIX0eHzql7G6N6j8rX+4rVYmg93l5xBOr9t36f+S9ZnYSehJBywzZfeAiyhlQvGoi3sUSFFFObByuB5zQxSx83mgyDKoxZ4mUnRb8o/4nJ4hAMnppZRK4dn9gW6/wpP3bpCQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921773; c=relaxed/simple;
	bh=MbZ5KVCawFViFafLCX6qRWN5V0jr8hdY5lIeo8hn8T4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqZzFBxgmNscf9csPsA+fzbeJiVJYnHrfocIkXrbelts45kg9UyrKK6B9ZepEJIuOxLmPB4vRqw5Qn+KO6++p5vlenDU3R/jwu1ryVZFYvao9Nm1xBLmY+lDGu2JT6IxPcjVqE7FSLy/GDQVKCAsVTSspzTeKkwAaGfbqWe3huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MbsWB7Tu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 63DDF20B7168;
	Mon,  4 May 2026 12:09:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63DDF20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777921770;
	bh=xSRikRlsBO0iFMCFnKhc/aitU2zdUFWg73GdutlvGhY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MbsWB7Tu50wXjBa1puda4RG9woFIvMDuE5tbroh222Bg5MuUx0fP4+wSCrNDw7GEp
	 1fqFq7zrKlEjg2eOlKg6acbBhms/LLcBRCp1UQB0aH5CCDCK0Kiie8PErsOh9uRli7
	 b0AHqQWHidgZU0J6HNkzRggqg04n+/bTekvriDF4=
Subject: [PATCH v3 07/18] mshv: Add NULL check for vp in
 mshv_try_assert_irq_fast
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 04 May 2026 19:09:31 +0000
Message-ID: 
 <177792177183.90827.14993047337701610344.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: 3ADD04C30F8
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
	TAGGED_FROM(0.00)[bounces-10602-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim]

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
index 3ab6338064237..509911ffcbeee 100644
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



