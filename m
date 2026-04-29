Return-Path: <linux-hyperv+bounces-10505-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EX2UKiWR8mlhsgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10505-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 01:15:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E449B438
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 01:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA1BA3009E0F
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 23:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B83242B8;
	Wed, 29 Apr 2026 23:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lgaKqoCJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A631A6806;
	Wed, 29 Apr 2026 23:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504542; cv=none; b=UGOSa8useXu7MJDBnuLhqWvh0A20nij9UIVrjiybEZKibh1nqMtg63DNjfz4hNJc/Ulm1LZwfiE/lAaSxD4mURr9ovrl0y2YMzmw+tw4sL0RdwiZIM0mtejD+oWhEoXTYRLZCg5f341YdN42cFQzk/U5VACtEAKRaRwsVqdDNFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504542; c=relaxed/simple;
	bh=JWIHMcVVFylVAfBEENGPPBkZNDa3YL17yQ/ow/GLEUQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XVyWWeUmg8ujmupUy/J8EWN3aQuFZWI5WJZIo65ZZ/27FmVnNRXOCupVbRbVacU5z3ScVjTIm3ZxqQMS7FPhsdkSQZbaZAjtD8QhAOb00ttRnagi5bLWrjPu5Fc7iyocl8UMPkyIr06JRU+HjcbTB8YfHFPHMh5rJpW+LTySft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lgaKqoCJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2FD2E20B716C;
	Wed, 29 Apr 2026 16:15:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2FD2E20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777504541;
	bh=B2Zd5c7UVP5s1ibl2SuRUTzfdRiFQP+Fsa1z9SMFJ/M=;
	h=From:To:Subject:Date:From;
	b=lgaKqoCJFWKvGbR8P/brPD2egu/GQj7ipssgo0zl7LDwHKqMGrLIukWqqJhiEYhci
	 vReZ1uB4C7i5C9oQUHLc9zlOQkWj7gyvbMOMu0zPyJS9wpw/ArtK+ejLBfEy4M6ysT
	 lDNkWdwwVXO1vUJfi1I/gjpYqBf/zmd7jzyG54CQ=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v0 0/3] PCI passthru on Hyper-V (Part II)
Date: Wed, 29 Apr 2026 16:15:16 -0700
Message-ID: <20260429231519.2569088-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A49E449B438
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10505-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

This patch series implements interrupt remapping part of the PCI
passthru feature on Hyper-V when Linux is running as a privileged VM.
These patches complement the Part I of the feature at:

https://lore.kernel.org/linux-hyperv/20260422023239.1171963-1-mrathor@linux.microsoft.com/T/#t

Testing and other details are listed there.

Thanks,
-Mukesh

Mukesh R (3):
  mshv: Import declarations for irq remap and add irqbypass support
  hyperv: Implement irq remap for passthru devices
  mshv: Implement guest irq migration for passthru'd devices

 arch/x86/hyperv/irqdomain.c         |  18 +-
 drivers/hv/Kconfig                  |   1 +
 drivers/hv/mshv_eventfd.c           | 500 +++++++++++++++++++++++++++-
 drivers/hv/mshv_eventfd.h           |   3 +
 drivers/iommu/hyperv-iommu-root.c   |  14 +
 drivers/pci/controller/pci-hyperv.c |  10 +
 include/asm-generic/mshyperv.h      |   4 +
 include/hyperv/hvgdk_mini.h         |   3 +
 include/hyperv/hvhdk.h              |  17 +
 9 files changed, 564 insertions(+), 6 deletions(-)

-- 
2.51.2.vfs.0.1


