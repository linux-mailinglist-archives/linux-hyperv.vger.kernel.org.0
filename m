Return-Path: <linux-hyperv+bounces-8439-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAh5AM1UcWkNEwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8439-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:35:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE75EE30
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECF9D5075CE
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E802E3A7DE9;
	Wed, 21 Jan 2026 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eSxzS4qJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B376410D3E;
	Wed, 21 Jan 2026 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034950; cv=none; b=t12LUFsL3v/Fn+OQ8pSqT6zkybQcc9+wrM+Bzpv9du9n/PaMiNye/DIcw532TV8wT3sclIF6x19u10xPuTA/Osiztfe2jBAhg4yFXn0QS2doi0tw7R0QzVMYdZ/VGxIPE9oplSTOASUTaXBosCiO/KM1qu0ASDO0gws5iOh2S7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034950; c=relaxed/simple;
	bh=NsISPSisMUvM3sAGZu14B8bxaXk+BuJSNHWxK2/zB2w=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=FjEzrJeL2fLiG3xVwNvX26VSIfai+erzebncJGVTLdcDx8PjmJ5tRZujDBYW9O4l/lVHXiKlBM9AMySDrNs2OcQmRiVVfMDToTS25cHM+y1k40sZjms963s94c1Dl2uEfCLz3mRVacYXOJf79DZufb+g7zLI5YlF9Br02N+JO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eSxzS4qJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id C86A720B7167;
	Wed, 21 Jan 2026 14:35:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C86A720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769034948;
	bh=PmjoVkUqKpw128I4MnFQMcOf59dbMnertfkZXkwfEbY=;
	h=Subject:From:To:Cc:Date:From;
	b=eSxzS4qJwtYbT7/K7DvL13HP567Fxu/AFhMF8T0fJpDNQm6Y/+HFrM/UAJkKERH2Q
	 J3jkpghzbkG1WWndPP6XRZfgS4Xwk6vVfTMSvUw8yWALbYa/YbWxvO88h0GdVN3fnW
	 CONYrlnA7wsCLKys1WSpjvgjEnFjccO2AXGg26Jk=
Subject: [PATCH 0/2] Introduce Hyper-V integrated scheduler support
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Jan 2026 22:35:48 +0000
Message-ID: 
 <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8439-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a01:60a::1994:3:14:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[52.25.139.140:received,13.77.154.182:received,4.155.116.186:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,skinsburskii-cloud-desktop.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 8AEE75EE30
X-Rspamd-Action: no action

Microsoft Hypervisor originally provided two schedulers: root and core. The
root scheduler allows the root partition to schedule guest vCPUs across
physical cores, supporting both time slicing and CPU affinity (e.g., via
cgroups). In contrast, the core scheduler delegates vCPU-to-physical-core
scheduling entirely to the hypervisor.

Direct virtualization introduces a new privileged guest partition type - L1
Virtual Host (L1VH) — which can create child partitions from its own
resources. These child partitions are effectively siblings, scheduled by
the hypervisor's core scheduler. This prevents the L1VH parent from setting
affinity or time slicing for its own processes or guest VPs. While cgroups,
CFS, and cpuset controllers can still be used, their effectiveness is
unpredictable, as the core scheduler swaps vCPUs according to its own logic
(typically round-robin across all allocated physical CPUs). As a result,
the system may appear to "steal" time from the L1VH and its children.

To address this, Microsoft Hypervisor introduces the integrated scheduler.
This allows an L1VH partition to schedule its own vCPUs and those of its
guests across its "physical" cores, effectively emulating root scheduler
behavior within the L1VH, while retaining core scheduler behavior for the
rest of the system.

---

Andreea Pintilie (2):
      hyperv: Sync guest VMM capabilities structure with Microsoft Hypervisor ABI
      mshv: Add support for integrated scheduler


 drivers/hv/mshv_root_main.c |   79 +++++++++++++++++++++++++++++--------------
 include/hyperv/hvhdk_mini.h |    7 +++-
 2 files changed, 59 insertions(+), 27 deletions(-)


