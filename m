Return-Path: <linux-hyperv+bounces-9833-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DxpL8bXymk1AgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9833-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:06:30 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14023360CCE
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46BE0301496A
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 20:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C0395272;
	Mon, 30 Mar 2026 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U5qUMwOI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA690391E65;
	Mon, 30 Mar 2026 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901053; cv=none; b=rtZ0hsJjnpZIC/lOxXWVgdMWKWE6pdZba5/Fwd6dtp9RUdZTDk5IX+Y455rOXbGowiV8h/77VL2oFvm/PiJL7LlY6lJGvb7UX1eG0vxPaM62Ww7BnoznwAg4w4hr+C284zqwJ76bPvFTZWRRSuuz83x+M+EkwvZcNwB6P93LCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901053; c=relaxed/simple;
	bh=8g2LhLxRs/yBNMARJIFxJ2laJOAOcreJO7V60frQ3mg=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=UcbVKAzunzaXLXJBQ3UgobyAWzN9Z28SVk0SzcSs07kZiiS9l0aeqTchMT0/W3d5VCQCSSjCRMtDy6oTTfBYGOoyNz7cBhDnNkTi8ogERy5GqiPtewfEOAKpZgzKYrSszxHQX5b/BI88DiCMNLTzQloW3zR3/g8ei11nHNhAd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U5qUMwOI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 98C3120B7001;
	Mon, 30 Mar 2026 13:04:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98C3120B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774901052;
	bh=nuaa1MKtIM/TxUwZfypKIVv0cOkJp9091UYiNN1blzI=;
	h=Subject:From:To:Cc:Date:From;
	b=U5qUMwOIJjwUoBktYBNTxeJmJzqsjIdDeOqU8kcqssn+3ZspIUeoh4oL7l6N6X9cj
	 TC0IVYbgPEIVgl+7IN9MhEYw6/ijHkOOv2+j1PwRu9FkXz88GWQ7h48qMnqScD+5rt
	 tt2kror7x+7ZuGuSymm5trwtbZQRLi2uv6oY22DM=
Subject: [PATCH 0/7] mshv: Refactor memory region management and map pages at
 creation
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Mar 2026 20:04:12 +0000
Message-ID: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-9833-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: 14023360CCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series refactors the mshv memory region subsystem in preparation
for mapping populated pages into the hypervisor at movable region
creation time, rather than relying solely on demand faulting.

The primary motivation is to ensure that when userspace passes a
pre-populated mapping for a movable memory region, those pages are
immediately visible to the hypervisor. Previously, all movable regions
were created with HV_MAP_GPA_NO_ACCESS on every page regardless of
whether the backing pages were already present, deferring all mapping
to the fault handler. This added unnecessary fault overhead and
complicated the initial setup of child partitions with pre-populated
memory.

The series takes a bottom-up approach:

- Patches 1-2 lay the groundwork by converting internal data structures
from page pointers to PFNs and teaching the range processing
infrastructure to handle holes (invalid PFNs) uniformly. The PFN
conversion eliminates redundant page_to_pfn()/pfn_to_page() conversions
between the HMM interface (which returns PFNs) and the hypervisor
hypercalls (which consume PFNs). The hole handling enables mapping
regions that contain a mix of present and absent pages, remapping holes
with no-access permissions to preserve hypervisor dirty page tracking
for precopy live migration.

- Patch 3 extends HMM fault handling to support memory regions that span
multiple VMAs with different protection flags, which is required for
flexible guest memory layouts.

- Patch 4 consolidates region setup by moving pinned region preparation
into mshv_regions.c, making five helper functions static, and fixing
a pre-existing bug where mshv_region_map() failures on non-encrypted
partitions were silently ignored.

- Patch 5 is the core functional change: movable regions now collect
already-present PFNs from userspace at creation time and map them
into the hypervisor immediately. A new do_fault parameter controls
whether hmm_range_fault() should fault in missing pages or only
collect those already present.

- Patches 6-7 are cleanups: extracting the MMIO mapping path into its
own function for consistency with the pinned and movable paths, and
adding a tracepoint for GPA mapping hypercalls to aid debugging.

---

Stanislav Kinsburskii (7):
      mshv: Convert from page pointers to PFNs
      mshv: Add support to address range holes remapping
      mshv: Support regions with different VMAs
      mshv: Move pinned region setup to mshv_regions.c
      mshv: Map populated pages on movable region creation
      mshv: Extract MMIO region mapping into separate function
      mshv: Add tracepoint for map GPA hypercall


 drivers/hv/mshv_regions.c      |  580 +++++++++++++++++++++++++++++-----------
 drivers/hv/mshv_root.h         |   29 +-
 drivers/hv/mshv_root_hv_call.c |   53 ++--
 drivers/hv/mshv_root_main.c    |   99 +------
 drivers/hv/mshv_trace.h        |   36 ++
 5 files changed, 503 insertions(+), 294 deletions(-)


