Return-Path: <linux-hyperv+bounces-10541-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEUSKM3/82n99QEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10541-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 03:20:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD8D4A9902
	for <lists+linux-hyperv@lfdr.de>; Fri, 01 May 2026 03:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D8DA30074FA
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2026 01:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEBF18C008;
	Fri,  1 May 2026 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cVJ5Tr07"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F00A2D77E9;
	Fri,  1 May 2026 01:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598406; cv=none; b=e7Cz2qTX8zs3P5GKsvUZmZApSHe8CVlgbukREi6IdnXhCL8nu83bhul/Uw1QSEIPlMtTWqy7zR0NjIyra9+YkZIp4KOWqyww2bwMNa1Lm4JDkclD1uAih5xm+AuYWWPfyTZXQzS6iHkRV/vhArqMaKqynUPpYsAH6I9rvF2nDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598406; c=relaxed/simple;
	bh=ivC6NaGevzpeEC2uJ0LjCOFMFy1P1XbOvXJqLDETukY=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=JUQA6lQSAk2jYCvI+CVQX1Yv0Ajg2KZzUys+Gqn7A0Y2LLPt/tabveSFDNNvtrnkMWc2h3mNj0RqtAJydqDWLXz8m8kTGX2P2MNTu3DwOGtznejZVvFdlyUj8SeyUYMBYHCR73OUw0Lf12K5FWbSLLaX39PQTW6GoxDHwSv2A9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cVJ5Tr07; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2870D20B7165;
	Thu, 30 Apr 2026 18:20:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2870D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777598403;
	bh=5o3nM5EVlRJoNz5ukY0K6ieimgMHdk0LSx+1vRWfGac=;
	h=Subject:From:To:Cc:Date:From;
	b=cVJ5Tr07tZ/FaAC6+vEXHo3ppds1Wokaw1f/8dI9rfLxXXR9l7Qtymk/6nQ2S0sI3
	 bi4Tbzn71EGUOiBWgEC1Hfukic5GOgS9N7uDUMAp9FV3ptkAeYqSh9Psx1dy5lO747
	 0hyEkPr02WK+j3tCMyeUe4Aehe6e2HCU0Hp8RxnQ=
Subject: [PATCH 0/3] mm/hmm: Add mmap lock-drop support for userfaultfd-backed
 mappings
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 akpm@linux-foundation.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, corbet@lwn.net, leon@kernel.org,
 longli@microsoft.com, ljs@kernel.org, mhocko@suse.com, rppt@kernel.org,
 shuah@kernel.org, skhan@linuxfoundation.org, surenb@google.com,
 vbabka@kernel.org, wei.liu@kernel.org
Cc: linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Date: Fri, 01 May 2026 01:20:02 +0000
Message-ID: 
 <177759835313.221039.2807391868456411507.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DDD8D4A9902
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10541-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

This series extends the HMM framework to support userfaultfd-backed memory
by allowing the mmap read lock to be dropped during hmm_range_fault().

Some page fault handlers — most notably userfaultfd — require the mmap lock
to be released so that userspace can resolve the fault. The current HMM
interface never sets FAULT_FLAG_ALLOW_RETRY, making it impossible to fault
in pages from userfaultfd-registered regions.

This series follows the established int *locked pattern from
get_user_pages_remote() in mm/gup.c. A new entry point,
hmm_range_fault_unlockable(), accepts an int *locked parameter. When the
mmap lock is dropped during fault resolution (VM_FAULT_RETRY or
VM_FAULT_COMPLETED), the function returns 0 with *locked = 0, signalling
the caller to restart its walk. The existing hmm_range_fault() is
refactored into a thin wrapper that passes NULL, preserving current
behavior for all existing callers.

Faulting hugetlb pages on the unlockable path is not supported because
walk_hugetlb_range() unconditionally holds and releases
hugetlb_vma_lock_read across the callback; if the mmap lock is dropped
inside the callback, the VMA may be freed before the walk framework's
unlock. Hugetlb pages already present in page tables are handled normally.
Possible approaches to lift this limitation are documented in
Documentation/mm/hmm.rst.

Patch 1 adds hmm_range_fault_unlockable() to the HMM core, refactors
hmm_range_fault() into a wrapper, and updates Documentation/mm/hmm.rst.
Patch 2 converts the mshv driver to use the new API, enabling
userfaultfd-backed guest memory regions. Patch 3 adds a selftest exercising
the unlockable path with a userfaultfd handler that fills pages via
UFFDIO_COPY.

---

Stanislav Kinsburskii (3):
      mm/hmm: Add hmm_range_fault_unlockable() for mmap lock-drop support
      mshv: Use hmm_range_fault_unlockable() for userfaultfd support
      selftests/mm: Add userfaultfd test for HMM unlockable path


 Documentation/mm/hmm.rst               |   89 +++++++++++++++++++++
 drivers/hv/mshv_regions.c              |  127 +++++++++++++++++++++----------
 include/linux/hmm.h                    |    1 
 lib/test_hmm.c                         |  122 +++++++++++++++++++++++++++++
 lib/test_hmm_uapi.h                    |    1 
 mm/hmm.c                               |   91 ++++++++++++++++++++--
 tools/testing/selftests/mm/hmm-tests.c |  133 ++++++++++++++++++++++++++++++++
 7 files changed, 515 insertions(+), 49 deletions(-)


