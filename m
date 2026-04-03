Return-Path: <linux-hyperv+bounces-9968-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEbAHNUP0GlQ2wYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9968-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 21:07:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B461639782C
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 21:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E210E3020CD8
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6C2355F36;
	Fri,  3 Apr 2026 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N+6VqeIp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7D9D531;
	Fri,  3 Apr 2026 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243178; cv=none; b=G45rHQrTOI5EniQdgUJsQn8aTLjtVbxYEQALZtKPK639Jl2odo62bizFpWolk6TP6YTGxNcf4CjbUr3sKhX5N9r5XZk3Cdu6Hra685Z5SIgbaKA1/wBPGy6LBarhqXCszJ3dRiCcmKlNRqn1rrqYEjKQFaKBXWNSNhx/tOb6mNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243178; c=relaxed/simple;
	bh=nY/wVkWW4SAQ0rO7S4Mij0TKOf5J6/vkXLa6Ljn6AzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgZlR0fsCHNEdTJUebL5ULogfa2uejKjr5D9gPtjy/nqqs2Y4GTtG6nCorCxuOgijednanH7m2SMhI0aJTm4dF7CUkECeb70If2QTfPC7LQQnkaGyvwoD18X4pCs/QfwBzLO2I8YUky81wdGGEWHSbvcDEoEaSc5KV8w/1y5bEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N+6VqeIp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 241F520B6F01; Fri,  3 Apr 2026 12:06:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 241F520B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775243177;
	bh=0EOhkGoGuAhFcFdz1q2xlbqKA4Lor/t7/YYZHFhiuXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=N+6VqeIpkswtHyIObJZmwR7uVrmCXcj0KPazwtj6Ya9UMzw0fAFrNtdiJG95MiGJX
	 mv4WhfsCZ664h71ha4SU6RsG90z87w57dKlaJ1YhUK8MhpGP6FEGhU42vbjGNH9qro
	 L54wiXpDmn/FxWPh/8zVsZdV3ttt9WmLbrdUFke4=
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
Subject: [PATCH v2 0/6] Hyper-V: kexec fixes for L1VH (mshv)
Date: Fri,  3 Apr 2026 12:06:06 -0700
Message-ID: <20260403190613.47026-1-jloeser@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9968-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: B461639782C
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
 drivers/hv/mshv_root_main.c    |  22 ++---
 drivers/hv/mshv_synic.c        | 142 ++++++++++++++++++++++-----------
 drivers/hv/vmbus_drv.c         |   2 -
 include/asm-generic/mshyperv.h |  10 +++
 include/hyperv/hvgdk_mini.h    |   1 +
 include/hyperv/hvhdk_mini.h    |  12 +++
 9 files changed, 188 insertions(+), 70 deletions(-)

--
2.43.0


