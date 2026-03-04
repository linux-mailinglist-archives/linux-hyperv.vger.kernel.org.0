Return-Path: <linux-hyperv+bounces-9127-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yChPAYZ7p2kshwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9127-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:23:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3E41F8DEB
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCABB303B91D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 00:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9929C339;
	Wed,  4 Mar 2026 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ciqV0cX1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F52C028B;
	Wed,  4 Mar 2026 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583810; cv=none; b=W7c3ffOXvPxf25MR3GBSBHVzFa9S0ATXVMamOobJRKejtFCpm8795bnt4adaZ7xzud3bB7eDqvsO8PqVtz2KboiRYg5PChb9Dj1qpRtRsFxMZcMKPn2ZkjUDxvVz5761zsk5jsS/2pHjD9H7P8awZIaoErbk2B61ZGwosfsfq14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583810; c=relaxed/simple;
	bh=EurKehYJRKavngli1rgvpeH+NozmmEiZanEGb/r+1Lk=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=WNYFcVJK/E9zkcZYWY3dr1tr4sOyvsltjXeeaweeOvUUl/fMsz82vtmcLEnSdQnd338QAfnKRsBCsQHDKWDIjSn9+LrTwsgTOAHs+v9SpHVm2XQ+xWG8CVpATkaTIXMhSESs8uon+74OXTMhpbMZvVROx3HF1rQCznkOAg4AY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ciqV0cX1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 17BE020B6F02;
	Tue,  3 Mar 2026 16:23:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17BE020B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772583809;
	bh=oWXccP+SABjA6e9hYGvaln7cscnLkuH0TF5mUBK4cdo=;
	h=Subject:From:To:Cc:Date:From;
	b=ciqV0cX1s7dvxPAU0EaGVSOnc8Jpukd5mB8SHZXD7S7vVM6Ss4eH+Dae+2NrnFGkb
	 3i6XxUYEpN58NbmtIfO4//e7IhqRedc9oCFvTkCe0QE8NrqovV5PZsbq5TaivjTZaJ
	 sc25yT4WUsjQo9l6sHpR/QpS4YHK+bM4pEGkZGJI=
Subject: [PATCH 0/4] mshv: Fix and improve memory pre-depositing
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2026 00:23:28 +0000
Message-ID: 
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9C3E41F8DEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	TAGGED_FROM(0.00)[bounces-9127-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Action: no action

This series fixes and improves memory pre-depositing in the Microsoft
Hypervisor (MSHV) driver to avoid partition and virtual processor
creation failures due to insufficient deposited memory, and to speed
up guest creation.

The first patch converts hv_call_deposit_pages() into a wrapper that
supports arbitrarily large deposit requests by splitting them into
HV_DEPOSIT_MAX-sized chunks. It also doubles the deposit amount for
L1 virtual hypervisor (L1VH) partitions to reserve memory for
Hypervisor Hot Restart (HHR), since L1VH guests cannot request
additional memory from the root partition during HHR.

The second patch moves partition initialization page depositing from
the hypercall wrapper to the partition initialization ioctl. The
required number of pages is determined empirically. Partitions with
nested virtualization capability require significantly more pages
(20 MB) to accommodate the nested hypervisor. The partition creation
flags are saved in the partition structure to allow selecting the
correct deposit size at initialization time.

The third patch moves virtual processor page depositing from
hv_call_create_vp() to mshv_partition_ioctl_create_vp(). A fixed
deposit of 1 MB per VP is used, which covers both regular and nested
virtualization cases. Deposited memory is now properly withdrawn if
VP creation fails.

The fourth patch adds pre-depositing of pages for guest address space
(SLAT) region creation. The deposit size is calculated based on the
region size rounded up to 1 GB chunks, with 6 MB deposited per GB of
address space. Deposited pages are withdrawn on failure.

---

Stanislav Kinsburskii (4):
      mshv: Support larger memory deposits
      mshv: Fix pre-depositing of pages for partition initialization
      mshv: Fix pre-depositing of pages for virtual processor initialization
      mshv: Pre-deposit pages for SLAT creation


 drivers/hv/hv_proc.c           |   58 +++++++++++++++++++++++++++++++++------
 drivers/hv/mshv_root.h         |    1 +
 drivers/hv/mshv_root_hv_call.c |    6 ----
 drivers/hv/mshv_root_main.c    |   59 +++++++++++++++++++++++++++++++++++++---
 4 files changed, 104 insertions(+), 20 deletions(-)


