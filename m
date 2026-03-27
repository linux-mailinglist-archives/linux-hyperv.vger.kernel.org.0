Return-Path: <linux-hyperv+bounces-9814-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDuoA7noxmloQAUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9814-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:29:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 602D634AF7B
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 21:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9423055C4D
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Mar 2026 20:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A2B374E41;
	Fri, 27 Mar 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SXGXx3dm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6933F37A;
	Fri, 27 Mar 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642779; cv=none; b=swy4ODmPEfDkTSQiIlUwdX31UFRN3O3goSpo5Wp2Ouc5Km37An70hfz77ON+WH+faazoId4sLbiFeZql7dzvuRPIUcOj4kaKXBOc7yA8EWyQN1mDmiGVZaDPcE9UiNsrPJrcoNzIOq0s2EcKmI82dcPZXO+cLqZGBnCXrfyFLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642779; c=relaxed/simple;
	bh=t2Bt4LiIPR3hMK3DapAAFG9xjxoklX17ELqeNB+HQpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bxwmzlo890DlF5b5CcIxSFLbTdLHpFpFDf0J6ObY5F9+71jRyV0MbJ28ivVtYzcnJ+wNR/49oof8HioU7wkcApV+/1jZD1AsmzrKiVdcxboJJGMYnnz/YjYY6kRc1jLApCYH84KtRZVQSiKLAcXRjWDGBLr5HzNJm++E0ikmSCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SXGXx3dm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id A2E0820B710C; Fri, 27 Mar 2026 13:19:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2E0820B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774642778;
	bh=JXxMEOAFkIGkl3Zik1wmh4KJ3D5FaaVkpFUSnN1XqMA=;
	h=From:To:Cc:Subject:Date:From;
	b=SXGXx3dm8lsIpchDX5xy5+zu/6l1Giel+9xzdTUxjziGPDLEDU+ZfYGWOMJ8Su4Nj
	 BhX9iY53Zxr2OJtaBwa4TI4Z6oE6OnvvURRPK0ZMIYj8tSJ9ZgGnpNX3qa+bdeI6pW
	 iQykqi7rzdboi2McqXQHU+C8xfbqkc/tHNa8iQr0=
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
	Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH 0/6] Hyper-V: kexec fixes for L1VH (mshv)
Date: Fri, 27 Mar 2026 13:19:11 -0700
Message-ID: <20260327201920.2100427-1-jloeser@linux.microsoft.com>
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
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linux.microsoft.com,outlook.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9814-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 602D634AF7B
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
 drivers/hv/mshv_synic.c        | 144 ++++++++++++++++++++++-----------
 drivers/hv/vmbus_drv.c         |   2 -
 include/asm-generic/mshyperv.h |  10 +++
 include/hyperv/hvgdk_mini.h    |   1 +
 include/hyperv/hvhdk_mini.h    |  12 +++
 9 files changed, 190 insertions(+), 70 deletions(-)

-- 
2.43.0


