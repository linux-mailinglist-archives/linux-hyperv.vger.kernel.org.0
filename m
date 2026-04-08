Return-Path: <linux-hyperv+bounces-10063-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMhbAEWx1WlF8wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10063-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:37:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 465B53B5F49
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 03:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97BC2301BF53
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 01:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68374325483;
	Wed,  8 Apr 2026 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oeKqQQLL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC8C2A1CF;
	Wed,  8 Apr 2026 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775612224; cv=none; b=VdB6x10oSSViK5HN+U49ppn7ZfJkLw5Pktb0XvFB2wjjrG/EQLUDhcm8HgW87PDxZrfHuOOEq31SuwnTz+O76S0xRh/gEpe5BjroGTk22jMFPBwRKaLskgW9Hf18eTQMRauJRtgh6L07SHZDFv72W40snmnZ7yoX6ciK8qvDJbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775612224; c=relaxed/simple;
	bh=qAAXXUf31V1W4U48so4/pb2LZfSOX0ZlnahMg7pjCuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJG89SiQAE9JBW0Or6omRemweZaDFDwYtmYG47euverB8XzbPJQg7cyu0bMcx4ARz9Mh+0z0L2hu/8xD15QMNB/swB//jON5MfdOkmrmd7DUmWoOahYOYSjqTZZe2x9SKBvyvFxAg0HG2oCxdnPrrse4JTOLQRjIfyrqmn4JX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oeKqQQLL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 08A5020B6F01; Tue,  7 Apr 2026 18:37:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08A5020B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775612223;
	bh=P5YOE94qmflbKI4KNIZ9HTZuRIRxciKMFCLVLXKNBvY=;
	h=From:To:Cc:Subject:Date:From;
	b=oeKqQQLLcDFMaQtFDqXQD6lo9VKHZtvTpBwoLLQHkSDa0/paeKFbkLASSfktgh9J1
	 bOR/52qBxaMeN37k8sGs8A5yJz8Q45PxZXTyv07SqgXON8C3RsVF+GNWobCYEcheHx
	 bcM5C7mHxoqekcesdlllGe/K1L1r3/K/hOLzZ6EU=
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
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH v3 0/6] Hyper-V: kexec fixes for L1VH (mshv)
Date: Tue,  7 Apr 2026 18:36:37 -0700
Message-ID: <20260408013645.286723-1-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10063-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 465B53B5F49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes kexec support when Linux runs as an L1 Virtual Host
(L1VH) under Hyper-V, using the MSHV driver to manage child VMs.

1. A variable shadowing bug in vmbus that hides the cpuhp state used
   for teardown.

2. Move hv_stimer_global_cleanup() from vmbus's hv_kexec_handler() to
   hv_machine_shutdown(). This ensures stimer cleanup happens before
   the vmbus unload.

3. LP/VP re-creation: after kexec, logical processors and virtual
   processors already exist in the hypervisor. Detect this and skip
   re-adding them.

4-5. SynIC cleanup: the MSHV driver manages its own SynIC resources
     separately from vmbus. Add proper teardown of MSHV-owned SINTs,
     SIMP, and SIEFP on kexec, scoped to only the resources MSHV
     owns.

6. Debugfs stats pages: unmap the VP statistics overlay pages before
   kexec to avoid stale mappings in the new kernel.

Changes since v2:
- Rebased onto linux-next/master to adapt to the upstream SynIC
  refactor (commit 5a674ef871fe, "mshv: refactor synic init and
  cleanup").

Changes since v1:
- Patch 4: account for nested root partitions where VMBus is also
  active (not just L1VH); use a vmbus_active local variable; allocate
  SIRBP L1VH allocation path for when the hypervisor doesn't
  pre-provision the page

Jork Loeser (6):
  Drivers: hv: vmbus: fix hyperv_cpuhp_online variable shadowing
  x86/hyperv: move stimer cleanup to hv_machine_shutdown()
  x86/hyperv: Skip LP/VP creation on kexec
  mshv: limit SynIC management to MSHV-owned resources
  mshv: clean up SynIC state on kexec for L1VH
  mshv: unmap debugfs stats pages on kexec

 arch/x86/kernel/cpu/mshyperv.c |  15 +++-
 drivers/hv/hv_proc.c           |  47 +++++++++++
 drivers/hv/mshv_debugfs.c      |   7 +-
 drivers/hv/mshv_synic.c        | 146 +++++++++++++++++++++------------
 drivers/hv/vmbus_drv.c         |   2 -
 include/asm-generic/mshyperv.h |  10 +++
 include/hyperv/hvgdk_mini.h    |   1 +
 include/hyperv/hvhdk_mini.h    |  12 +++
 8 files changed, 184 insertions(+), 56 deletions(-)

--
2.43.0


