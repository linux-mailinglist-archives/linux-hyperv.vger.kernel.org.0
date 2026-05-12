Return-Path: <linux-hyperv+bounces-10784-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A8pCfCMAmrzuAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10784-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:14:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72175518C2B
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 04:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 203643008207
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 02:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061830C61F;
	Tue, 12 May 2026 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rNKp8W8N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A22E62A9;
	Tue, 12 May 2026 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551973; cv=none; b=JhXGJvXI3Hl4Ir5NpRSNMhshE2LWzcZT/n24vzcdcWR/Nmp6FyqTHiTsuogd4CajHlCohPmZmeYjJwZbM36kINgqblmrsefJzeQswzb4U5WXf3QywJV0YDhc+IBK2FEvdgacajaIdlVkq2zQa9fej3yHbZKU9n3N+jl1HhzP02s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551973; c=relaxed/simple;
	bh=cFZPDRvidSPlSDE/MbooQ8HREXd83BLa/JIiL1naeXU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gIyVJZJPFvlPO1bmDBhIZULipWJeN1MkxbjmQtmyR7/tB/1+Uv4SY1OB2MDlgpUthH4CSHDuZ+iz7U6W7B/GpHL2Wrj0DX/zvvZI8khrugRl+5t3fQhgiUSdRGFDircXba2k8dEDvf1mjMxQjR9aEHjB+aRe0ieHQ7fesAoi8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rNKp8W8N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 68A8A20B7166;
	Mon, 11 May 2026 19:12:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68A8A20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778551969;
	bh=v9cDjqIfAoJ+KWzCXupIbwnpZfeCoBykcJ22CFF2HGQ=;
	h=From:To:Subject:Date:From;
	b=rNKp8W8Nh24A0GMdok8VjUDmbgLghNnMQwAuYz3r+2mZdByJrJ87kj95PNjIP9Qi6
	 Olxwoig6R+3NNmEll7OsortX60mr23he1Mh19jBjPk5fm5RUBhIXh1cUu8+b1yIqnJ
	 17ATEvD7545sTOHfB20+HekbmkQ6QIbcJIefoc6A=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH V1 0/3] PCI passthru on Hyper-V (Part II)
Date: Mon, 11 May 2026 19:12:39 -0700
Message-ID: <20260512021242.1679786-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72175518C2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10784-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch series implements interrupt remapping part of the PCI
passthru feature on Hyper-V when Linux is running as a privileged VM.
These patches complement Part I of the feature at:

https://lore.kernel.org/linux-hyperv/20260512020259.1678627-1-mrathor@linux.microsoft.com/T/#t

Testing and other details are listed there.

Changes in V1:
 o rebase to above V3 of Part I
 o check for NULL irqdata->parent_data->chip before calling 
   irq_chip_unmask_parent().

Thanks,
-Mukesh

Mukesh R (3):
  mshv: Import declarations for irq remap and add irqbypass support
  hyperv: Implement irq remap for passthru devices
  mshv: Implement guest irq migration for passthru devices

 arch/x86/hyperv/irqdomain.c         |  18 +-
 drivers/hv/Kconfig                  |   1 +
 drivers/hv/mshv_eventfd.c           | 501 +++++++++++++++++++++++++++-
 drivers/hv/mshv_eventfd.h           |   3 +
 drivers/iommu/hyperv-iommu-root.c   |  14 +
 drivers/pci/controller/pci-hyperv.c |  10 +
 include/asm-generic/mshyperv.h      |   3 +
 include/hyperv/hvgdk_mini.h         |   3 +
 include/hyperv/hvhdk.h              |  17 +
 9 files changed, 564 insertions(+), 6 deletions(-)

-- 
2.51.2.vfs.0.1


