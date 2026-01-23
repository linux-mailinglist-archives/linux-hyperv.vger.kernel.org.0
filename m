Return-Path: <linux-hyperv+bounces-8495-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMQWN0v0c2ny0AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8495-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 23:20:59 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1085F7B189
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 23:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4C82300372D
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 22:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FFA21ABC1;
	Fri, 23 Jan 2026 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r80ZQtTA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80823EBF38;
	Fri, 23 Jan 2026 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206855; cv=none; b=QBf46vZUPqEe6SWSlJmMLmoAhqtbTtvWWEFCqMjuYapXUlJmTmd8QO29VARyGsRjwBB5INQm2+FinN4bjDXduDE6iQGE20ufT/eRP6zVHVtp4PwoWF7jdH6B0lSqh5F4xuBbn2B5ZTL2ngfdUEdoH2pvvBQA8IdwwDdv/DkyMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206855; c=relaxed/simple;
	bh=eI1jJ741cVEZzaWN7MZD6S2mxymSIpRwOOyT/X+5+AI=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=XQnlnyVqND6lEJ80oU2aeOR0cTXmYxYtimJ8OarJJkr/LyscuXJdaFELbzHOON4IRuPf5pLh9AdGgm54Os0qq9SzdebAyXiw8dmKfOKP5YqIFULBgZh/8OnZUtYr11RrMWu5yX741lOKMD8e6dJCm3o0wdg2zjMRrUTtHiuFjIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r80ZQtTA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4527A20B7167;
	Fri, 23 Jan 2026 14:20:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4527A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769206853;
	bh=ZtKMDmgGkdkLplmmFB27JNyIVkDabzMrD6HdUulsNBI=;
	h=Subject:From:To:Cc:Date:From;
	b=r80ZQtTAtaRXylgk3CxXO+QZ6sC/iCtHNfywOgs8B41QVBmDqItQmk+9meq56BBw2
	 4mjE2IF54SFqMWGRo1JME2FukqvbcFVRGdnsD+hJ++28+FU/YceIDYaZLCvV0j3VTA
	 8grpqkhMb7TUnEkfRujer40maa6OJ9io/Ruls5kc=
Subject: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Jan 2026 22:20:53 +0000
Message-ID: 
 <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8495-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 1085F7B189
X-Rspamd-Action: no action

The MSHV driver deposits kernel-allocated pages to the hypervisor during
runtime and never withdraws them. This creates a fundamental incompatibility
with KEXEC, as these deposited pages remain unavailable to the new kernel
loaded via KEXEC, leading to potential system crashes upon kernel accessing
hypervisor deposited pages.

Make MSHV mutually exclusive with KEXEC until proper page lifecycle
management is implemented.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 7937ac0cbd0f..cfd4501db0fa 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -74,6 +74,7 @@ config MSHV_ROOT
 	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
 	# no particular order, making it impossible to reassemble larger pages
 	depends on PAGE_SIZE_4KB
+	depends on !KEXEC
 	select EVENTFD
 	select VIRT_XFER_TO_GUEST_WORK
 	select HMM_MIRROR



