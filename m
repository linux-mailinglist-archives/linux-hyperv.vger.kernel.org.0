Return-Path: <linux-hyperv+bounces-8516-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NTgJ40SdWkAAgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8516-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 19:42:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0427E800
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1EB7300B9BC
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 18:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC47220B7ED;
	Sat, 24 Jan 2026 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MBO71hFK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF23EBF12;
	Sat, 24 Jan 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280137; cv=none; b=RO51NauOKTBL92xZjO5Ox7cmGCRPdLk3O7J/txtnf2I2kH9O1zjdVwsSgLBHN+OAgEa5zd8L/wYOnvZbELFAD+SaIXkbSa+YEF36vFlUoi2iC6NY2YCXcEPsw5FzhMxXhpq26gA1DuY8XHyDwk8DjCZzFXi+/pG+PGyQNsEZeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280137; c=relaxed/simple;
	bh=suhoK/5bBzhcSseWa1XtZwioDgnkfQ8bWhaI3yyXD0U=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=nOYOpsWXVf2Yofm2ZT1/Gv3xIpU+/OC1YNQyKHHIF+jy974iK3GE+g7Y5xpkg/IS6zwL6gRqaIgFf1jkN6MgLYKPYCtdjNSwxny/JaP7sDkDb8fgKzIU2PEO2w1HHpcPcIi8xURzmOrkAKM611aUFu73rm+Ch+jZTii/okp+isU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MBO71hFK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 023D520B7165;
	Sat, 24 Jan 2026 10:42:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 023D520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769280130;
	bh=pKQW6P+srcpxYjXW37kNDDmdjAXqukhCCLX+H+RDNNg=;
	h=Subject:From:To:Cc:Date:From;
	b=MBO71hFKGfW2TUnwO+nlx+QydRtzcHnZomhE5nkVavokPtSvHTR3K/oY7MRXP/Ax0
	 JjeNcxZhA8Pe6IAjSxXdkHs6qR1Ro8/aEcPgGXVutjwavwoE+obLohXuu1djBH1X7S
	 r9NY6CTJ7OceV1gwD2Jt4VCUDpiXLCg2uvl9Wygs=
Subject: [RFC PATCH 0/3] mshv: Add kexec safety for deposited pages
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 24 Jan 2026 18:42:09 +0000
Message-ID: 
 <176927917602.26405.4149319776242398706.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-8516-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: 0C0427E800
X-Rspamd-Action: no action

This is an RFC series. The goal is to discuss an approach; it is not
intended for merging as-is.

Microsoft Hypervisor is active, the kernel cannot access pages that have
been deposited to the hypervisor; doing so can trigger a GPF. The “pages
deposited” state is also lost across kexec, and the next kernel has no way
to know which pages are still owned/managed by the hypervisor.

Until a proper handoff of that state to the next kernel exists, kexec (and
liveupdate-based transitions) must be refused whenever there is shared
state that cannot safely survive the transition (in particular, deposited
pages; also running VMs).

What MSHV needs (until proper state preservation is ready) is simply a callback into the driver at the “freeze” stage
so it can:
 - refuse the transition while VMs are running
 - attempt to withdraw deposited pages (L1VH host case)
 - fail the transition if any pages remain deposited

Current liveupdate/LUO interfaces are primarily userspace-facing and are
structured around file/FD preservation. In order to reuse the existing
freeze sequencing with minimal churn, this RFC adapts a small part of the
LUO/file plumbing to allow a kernel user (mshv driver) to register into
that flow. This results in creating a session file solely as a vehicle to
get the freeze callback invoked, which is acknowledged to be awkward.

The intent of posting this is to get feedback on:
  - whether reusing the existing file-based liveupdate hooks for a pure
    in-kernel “freeze veto” is acceptable, or
  - whether we should instead introduce a dedicated kernel-side
    registration API (e.g. a notifier-style “freeze blockers” interface)
    that does not involve files at all.

---

Stanislav Kinsburskii (3):
      luo: Extract file object logic
      mshv: Account pages deposited to hypervisor
      mshv: Block kexec when hypervisor has pages deposited


 MAINTAINERS                      |    1 
 drivers/hv/Kconfig               |    1 
 drivers/hv/Makefile              |    1 
 drivers/hv/hv_proc.c             |    4 +
 drivers/hv/mshv_luo.c            |  113 ++++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h           |   14 +++++
 drivers/hv/mshv_root_hv_call.c   |    2 +
 drivers/hv/mshv_root_main.c      |    7 ++
 include/linux/kho/abi/mshv.h     |   14 +++++
 include/linux/liveupdate.h       |    3 +
 kernel/liveupdate/luo_file.c     |   55 +++++++++++++++---
 kernel/liveupdate/luo_internal.h |    2 -
 kernel/liveupdate/luo_session.c  |    2 -
 13 files changed, 208 insertions(+), 11 deletions(-)
 create mode 100644 drivers/hv/mshv_luo.c
 create mode 100644 include/linux/kho/abi/mshv.h


