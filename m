Return-Path: <linux-hyperv+bounces-10402-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBLRNH/X72koGwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10402-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 23:39:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3651F47AB37
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 23:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C72C304B2B6
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 21:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DCA375ACB;
	Mon, 27 Apr 2026 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xa+wSnlP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BB62F7478;
	Mon, 27 Apr 2026 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325945; cv=none; b=r8EUrW0CxWlaScTb/Ab2tLX7gKe7+jVphyzsbItPNkexuOGDB46OGOxGhjJ37fbTpXV1iCgs/mwXyE8WfwCHZz4e/+5GEtNhoV+RG3qyZ5rnCJC/RDPr022qDf180R1pYDKKVIpsJ6DZGULc6vWoUEDyoQ2efb7jSeKKxotWEGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325945; c=relaxed/simple;
	bh=0LWP6ceI3rzU+1ASAE0SUacXnQgdecy1kn+ZJsmqBEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xu1Om7UVMqeLnN7Pj0ZnM+rg/GiD4mhj59/EDQcTIjQyXsgPdZKo0X5VvlE6S5lNkcTsyNg4+skRoRda6kbC5PUsmZwwMp48zqFqDZkB9fcd/l6x0XujorAh15xRPAMFN8doixV9xHqB88AzbKIBcMEPi7YxNWt9j4gtnOTz6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xa+wSnlP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 2069520B716A; Mon, 27 Apr 2026 14:39:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2069520B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777325944;
	bh=cv5zNLs9Vb20grZX2o3UEW4A1I+5kcQkll/3aCad5fE=;
	h=From:To:Cc:Subject:Date:From;
	b=Xa+wSnlPl9TP74nOwkzlVAOiT1nMeuAGgsr+FFDu96YJA3Rgcb2lyijZ5RMcRt7Z7
	 buekxTbN4UXyNcxippbKWZa5Jl7LN3yFinv8sAQHMPfsu9Y/sDXDFUHtTJpAjLy6yX
	 leGF/jzpAvG38NjFMvdlwEEwVwbWCPb9D82QUEmc=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>,
	Anirudh Rayabharam <anirudh@anirudhrb.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH v4 0/3] Hyper-V: kexec fixes for L1VH (mshv)
Date: Mon, 27 Apr 2026 14:38:51 -0700
Message-ID: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3651F47AB37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10402-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,anirudhrb.com,vger.kernel.org,linux.microsoft.com];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series fixes kexec support when Linux runs as an L1 Virtual Host
(L1VH) under Hyper-V, using the MSHV driver to manage child VMs.

1-2. SynIC cleanup: the MSHV driver manages its own SynIC resources
     separately from vmbus. Add proper teardown of MSHV-owned SINTs
     and SIRBP on kexec, scoped to only the resources MSHV owns.
     Use hv_vmbus_exists() to decide at runtime whether VMBus owns
     SIMP/SIEFP/SCONTROL (so MSHV must not touch them) or whether
     MSHV must manage them itself (bare root partition without VMBus).
     Also fix SIEFP and SIRBP address calculations to use
     HV_HYP_PAGE_SHIFT instead of PAGE_SHIFT, which produces wrong
     addresses on ARM64 with 64K pages.

3.   Debugfs stats pages: unmap the VP statistics overlay pages before
     kexec to avoid machine check exceptions when the new kernel
     reuses those physical pages.

Changes since v3:
- Dropped patches 1-3 (vmbus variable shadowing, stimer cleanup,
  LP/VP skip), now merged via hyperv-next.
- Patch 1: fix SIEFP and SIRBP memremap()/virt_to_phys() to use
  HV_HYP_PAGE_SHIFT/HV_HYP_PAGE_SIZE instead of PAGE_SHIFT/PAGE_SIZE.

Changes since v2:
- Rebased onto linux-next/master to adapt to the upstream SynIC
  refactor (commit 5a674ef871fe, "mshv: refactor synic init and
  cleanup").

Changes since v1:
- Patch 1: account for nested root partitions where VMBus is also
  active (not just L1VH); use a vmbus_active local variable; allocate
  SIRBP in L1VH allocation path for when the hypervisor doesn't
  pre-provision the page.

Jork Loeser (3):
  mshv: limit SynIC management to MSHV-owned resources
  mshv: clean up SynIC state on kexec for L1VH
  mshv: unmap debugfs stats pages on kexec

 drivers/hv/hv.c           |   3 +
 drivers/hv/mshv_debugfs.c |   7 +-
 drivers/hv/mshv_synic.c   | 154 +++++++++++++++++++++++++-------------
 3 files changed, 110 insertions(+), 54 deletions(-)

-- 
2.43.0


