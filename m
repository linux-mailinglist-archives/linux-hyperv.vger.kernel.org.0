Return-Path: <linux-hyperv+bounces-8564-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLQHBSJLemkp5AEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8564-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 18:45:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC4A7156
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 18:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B35CB301E3DB
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D2130FC35;
	Wed, 28 Jan 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J4DTxvm4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214FF248861;
	Wed, 28 Jan 2026 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622123; cv=none; b=hUoZxCvav6ynExg5dXZ7LijCUw8Csf0/WmL7darLexO7vIFHNShDWZ3+qK4OlPpSoGF9eJ86ZrNCGFLovv4M3yxQhEROWVmQQZ2jWs0tgZK8l9V3fe3P2v0D/DLDPWM2MDRkYkGQTZUszXGf44ibstMVAW9ftX1BMxCmeqT1kDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622123; c=relaxed/simple;
	bh=4MV+sxYAXFmiGUuFYef4Riivb6GqxI2NoxIR9rPLND4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=UJCQVwQmo5S3ikH1JVcPjG3sS2WXe3pnHWM1KMh0O5u8L/zrrtjhoH4/0A6g2tc4wCuL7RsCLWADhj6YK+dGb+CNREdSzF763XR0/wskqTQSZCufC6H1rzVRA1sNwuBtzCFgMCGoNgCjDMO4dNhAG+11XG5NohxgOgXRq5fahBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J4DTxvm4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80BCE20B7165;
	Wed, 28 Jan 2026 09:41:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80BCE20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769622116;
	bh=MwsAKtB1TdslBChA/QaO2udawN6BW3NQscLnpI6z1uk=;
	h=Subject:From:To:Cc:Date:From;
	b=J4DTxvm4kRrZgoQn30xmwcM1RG7SvmBji6ufucYKoNL/rQlySET+GZZORrK6foPw0
	 8aED/KJYFEw97QPvFdxQcisN8zfEie/lu5/mqEl8Anium4xSuQJUm5zuV0E1vnCEKb
	 31RxVY2zTKNw2heWXh54Cj4apQr5MJR1AJ7wSWmg=
Subject: [PATCH 0/2] kexec: Refuse kernel-unsafe Microsoft Hypervisor
 transitions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 28 Jan 2026 17:41:56 +0000
Message-ID: 
 <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-8564-lists,linux-hyperv=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 5DCC4A7156
X-Rspamd-Action: no action

When Microsoft Hypervisor is active, the kernel may have memory “deposited”
to the hypervisor. Those pages are no longer safe for the kernel to touch,
and attempting to access them can trigger a GPF. The problem becomes acute
with kexec: the “deposited pages” state does not survive the transition,
and the next kernel has no reliable way to know which pages are still
owned/managed by the hypervisor.

Until there is a proper handoff mechanism to preserve that state across
kexec, the only safe behavior is to refuse kexec whenever there is shared
hypervisor state that cannot survive the transition—most notably deposited
pages, and also cases where VMs are still running.

This series adds the missing kexec integration point needed by MSHV: a
callback at the kexec “freeze” stage so the driver can make the transition
safe (or block it). With this hook, MSHV can refuse kexec while VMs are
running, attempt to withdraw deposited pages when possible (e.g. L1VH
host), and fail the transition if any pages remain deposited.

---

Stanislav Kinsburskii (2):
      kexec: Add permission notifier chain for kexec operations
      mshv: Add kexec blocking support


 drivers/hv/Makefile            |    1 +
 drivers/hv/hv_proc.c           |    4 ++
 drivers/hv/mshv_kexec.c        |   66 ++++++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h         |   14 ++++++++
 drivers/hv/mshv_root_hv_call.c |    2 +
 drivers/hv/mshv_root_main.c    |    7 ++++
 include/linux/kexec.h          |    6 ++++
 kernel/kexec_core.c            |   24 +++++++++++++++
 8 files changed, 124 insertions(+)
 create mode 100644 drivers/hv/mshv_kexec.c


