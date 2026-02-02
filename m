Return-Path: <linux-hyperv+bounces-8647-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDYvIODlgGleCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8647-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 18:58:56 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A693CFDA3
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 18:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7185C3007B9E
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F472389462;
	Mon,  2 Feb 2026 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JBrfMz1v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9FD388846;
	Mon,  2 Feb 2026 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055134; cv=none; b=Z+WzayKRTjiNEm9Ipn5RvYh7yEUu90TRjtDXnr6UGTtjVVJ94jZTlSipvW2aAflIOmqn6RQtCY9F5brx61me6YIlWv353nyxtZp5K/BMDAaUL40ojPttUT8YtT2BpPFDFj2vPEfWRAD+kpTCVJZa7xB4U0TjYYjmiBYJx/Qt4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055134; c=relaxed/simple;
	bh=ALvWyIaGTB3YmvvV/aPAySDsVdVpyqKI7Cbdg+/o4yA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ZIWkNg5hbm0tOTr4mApufVUWkqF/a0YVfM5bqYyVPiDsKbVEwwlKnRcHEct7twAiPXenCs9RPYZNpKUULQ1xRkfzdkkP6ExDOt1mIwQdKqhH6692N5Ya2SA6keLvanlK5t0ADq8VZm3Xx7ceLPWuVnhOvoW3surqpjf9csPUKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JBrfMz1v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id A07A320B7169;
	Mon,  2 Feb 2026 09:58:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A07A320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770055132;
	bh=gXdrLD0jdsvyGIjA+JGaWPdnJc5FvQ0Q2kkCpv3GFSY=;
	h=Subject:From:To:Cc:Date:From;
	b=JBrfMz1vWgAOOlWDDPNJipq0AyhyNm6u07XsnCkUIF2c4Sc1c4tSgWCfoUbwA9uDb
	 +pEkppr8Y+Zpo3QT2O7G6ETb11H9AdsqJwCrzTWmB7AIgw6J8CFfsQpwmTVkFyc2gm
	 yPVCip3CYDxyIQvOX2AVzpcz56y9R583Gzmr5+lc=
Subject: [PATCH v2 0/4] Improve Hyper-V memory deposit error handling
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 02 Feb 2026 17:58:52 +0000
Message-ID: 
 <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8647-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A693CFDA3
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

v2:
- Rename hv_result_oom() into hv_result_needs_memory()

---

Stanislav Kinsburskii (4):
      mshv: Introduce hv_result_needs_memory() helper function
      mshv: Introduce hv_deposit_memory helper functions
      mshv: Handle insufficient contiguous memory hypervisor status
      mshv: Handle insufficient root memory hypervisor statuses


 drivers/hv/hv_common.c         |    3 ++
 drivers/hv/hv_proc.c           |   54 +++++++++++++++++++++++++++++++++++---
 drivers/hv/mshv_root_hv_call.c |   45 +++++++++++++-------------------
 drivers/hv/mshv_root_main.c    |    5 +---
 include/asm-generic/mshyperv.h |   13 +++++++++
 include/hyperv/hvgdk_mini.h    |   57 +++++++++++++++++++++-------------------
 include/hyperv/hvhdk_mini.h    |    2 +
 7 files changed, 119 insertions(+), 60 deletions(-)


