Return-Path: <linux-hyperv+bounces-10559-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIo7KX999WnZLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10559-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:28:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B088F4B0D87
	for <lists+linux-hyperv@lfdr.de>; Sat, 02 May 2026 06:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90D37300BE09
	for <lists+linux-hyperv@lfdr.de>; Sat,  2 May 2026 04:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239B28DB49;
	Sat,  2 May 2026 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jYySGZZB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2742D73B8;
	Sat,  2 May 2026 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696072; cv=none; b=JQXIq3+Y+xcQMnGO3eeYYic/Sx3blZ75rR3j/CHD/dnXoFgYWo3QO/Y3Ys9sKamoGHbtkOBdezTOSXMZ61x1If7IIecvUzka5s+O1uLFEszci1UbnUw2mhtXn0Eq1ZvF4PvcvQTSkWEdTUJsNPR7aXgtG+UH9rGUdh536JqgrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696072; c=relaxed/simple;
	bh=MbZ5KVCawFViFafLCX6qRWN5V0jr8hdY5lIeo8hn8T4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liY2ARFXrF8aUM25fw5zzuDECAoMS3s/dlZfST6X5wcylNgoFICfva6g0PamvH/b7abTBVSPhGixPEqxoZenJVI6ruS/8LYQAlS01MPT1cheuCFRco90FrZY49CYaWY67hIkueBhC3dOUicY3LhKSoTHfWeqfEd6txjKxNKcb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jYySGZZB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3138220B716C;
	Fri,  1 May 2026 21:27:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3138220B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696070;
	bh=xSRikRlsBO0iFMCFnKhc/aitU2zdUFWg73GdutlvGhY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jYySGZZBSmpY9E0SYIzhTERQFoEgXAbTAOJf5umCFEcDN75av/LjWbDxICxkpWE4/
	 W+jFDgIN7uffkEfB8JKY/kIpnQsl0UeWT4aS5Km+q60eb0T0pqys5FnNT58BWUhbxT
	 VEX3MJJPrzlajwTOxLF9+5uGCWGI3RTiYEpbndAM=
Subject: [PATCH v2 07/18] mshv: Add NULL check for vp in
 mshv_try_assert_irq_fast
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:27:50 +0000
Message-ID: 
 <177769607021.222166.12740321302796397367.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: B088F4B0D87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-10559-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]

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



