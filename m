Return-Path: <linux-hyperv+bounces-8741-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPytA4PkhGlf6QMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8741-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:42:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7CF683B
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E7C3300440E
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992B3033F2;
	Thu,  5 Feb 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qfuyyMvv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8977A3002DD;
	Thu,  5 Feb 2026 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316925; cv=none; b=LyxEd0lm/O5jtW9GjFxDObetEGnT3ZU+HZPYX24pvcEIV1C2tO5WORYQp/K9t9sljf54bMQcfOcZYf43YAvvH+PcXYL4Y4G4vZd2pgZLPp01P77CYA1YLqlzG+omgCcox/hhjKEo2pyhmBFve90OgjZfyRpIf/EAsTs/pFU+G4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316925; c=relaxed/simple;
	bh=5zVdjC1wkI8oi9WHk1uT2dsbVTXScITKA+/k6qq5suM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=MEAuSIcyNn+tDtQPHyUVBxbRyCIw6evwyj63TZd7aLjMiFOujKEA3JI0GevHKCAdUks5J1s11GZilUDtkvV4NjsFHwoxx4UZJn28PTYlyfhzd6HFEKOXicdqd87Si/FjhdfUAVn9Fh94IPAfPVz2K3D9ySrEPGAYQ7Ke/UT/wbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qfuyyMvv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3AE5420B7168;
	Thu,  5 Feb 2026 10:42:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AE5420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770316925;
	bh=A+sjp7Jtmn4YiiOSBgay/IGalOMJZzzQGsBKURIjem8=;
	h=Subject:From:To:Cc:Date:From;
	b=qfuyyMvvfDU04v5iR0v2/ED+xww9VTL7F8gr2Blow0kDBRnVZ9Eq418PW3lDUVfV7
	 dzvqRSvNTdQCvjvEYuoEVaaJEe7qLc9+rsYcnpK85R5Vp0fGjYxiSA+kQPWxjpapaC
	 k6oRh7ncUNARFMkYSKtPcoAWPbL7Bvgr8WA1Ij64=
Subject: [PATCH v3 0/4] Improve Hyper-V memory deposit error handling
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Feb 2026 18:42:04 +0000
Message-ID: 
 <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8741-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: B4E7CF683B
X-Rspamd-Action: no action

This series extends the MSHV driver to properly handle additional
memory-related error codes from the Microsoft Hypervisor by depositing
memory pages when needed.

Currently, when the hypervisor returns HV_STATUS_INSUFFICIENT_MEMORY
during partition creation, the driver calls hv_call_deposit_pages() to
provide the necessary memory. However, there are other memory-related
error codes that indicate the hypervisor needs additional memory
resources, but the driver does not attempt to deposit pages for these
cases.

This series introduces a dedicated helper function macro to identify all
memory-related error codes (HV_STATUS_INSUFFICIENT_MEMORY,
HV_STATUS_INSUFFICIENT_BUFFERS, HV_STATUS_INSUFFICIENT_DEVICE_DOMAINS, and
HV_STATUS_INSUFFICIENT_ROOT_MEMORY) and ensures the driver attempts to
deposit pages for all of them via new hv_deposit_memory() helper.

With these changes, partition creation becomes more robust by handling
all scenarios where the hypervisor requires additional memory deposits.

v3:
- Fix uninitialized num_pages variable in hv_deposit_memory_node() in case
  of HV_STATUS_INSUFFICIENT_ROOT_MEMORY status

v2:
- Rename hv_result_oom() into hv_result_needs_memory()

---

Stanislav Kinsburskii (4):
      mshv: Introduce hv_result_needs_memory() helper function
      mshv: Introduce hv_deposit_memory helper functions
      mshv: Handle insufficient contiguous memory hypervisor status
      mshv: Handle insufficient root memory hypervisor statuses


 drivers/hv/hv_common.c         |    3 ++
 drivers/hv/hv_proc.c           |   53 ++++++++++++++++++++++++++++++++++---
 drivers/hv/mshv_root_hv_call.c |   50 +++++++++++++++--------------------
 drivers/hv/mshv_root_main.c    |    5 +---
 include/asm-generic/mshyperv.h |   13 +++++++++
 include/hyperv/hvgdk_mini.h    |   57 +++++++++++++++++++++-------------------
 include/hyperv/hvhdk_mini.h    |    2 +
 7 files changed, 120 insertions(+), 63 deletions(-)


