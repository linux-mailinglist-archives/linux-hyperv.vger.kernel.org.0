Return-Path: <linux-hyperv+bounces-11834-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8dCzFGr/S2pyeQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11834-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 21:18:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE48714DD4
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 21:18:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hySgxsfh;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11834-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11834-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B819B36A2E78
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2026 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2AB42A16E;
	Mon,  6 Jul 2026 17:54:59 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D141C307
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Jul 2026 17:54:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360498; cv=none; b=oBoKLVBrzz14sooZysH6m/A+oosrTTN9uJLjVZlsrtkcpEuLDf1XlSavgfqs4BgCRo68V79RSmeQFGXdBrShFhylZVVh26ovKZcuT3OktWQIWaJxV86lJgAzuBG1A2DLiKKPe4ZHdbfsZlVFSDN89yPyzjnDU8DSZpBOQ4o4Egw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360498; c=relaxed/simple;
	bh=ycv2BoXCHb5oo4aS8e5sx2b774vzMMHbqpSNM8HQ2L4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=sx91lRmxC8iNc0O7mYQ8xv4r+D5fb5jzlzEDYWLkP26OlxEEsI42MIXdVDosxit2GxdQZ/DshwOcMnWdbRLFLTCUiI8lohK6qZhGu3eDB/qro6+4k192f+oUYqaP0qArGPslLtQHcJLAmJM6HY6M+Y7kPBXqLyfJRwpGcVuUt0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hySgxsfh; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so2513698a12.0
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Jul 2026 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360495; x=1783965295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=cnwJHJEouqLhDU4VS1gzSe1nEPe1/QANOGjZf+5gN18=;
        b=hySgxsfhErEzgrNcNdZPP8YKzrUYzCy7WrxKa1MFGX03dmyhxpqaPrOSdIq4j56AiZ
         YCuM7t29XnaCbYUFaJXPQdN4L7VCE8V6P2qvV/ITu+ymPrvfRxadpvJaOUnhp0J4ULZd
         Q4ioAFqMLzoycsgsbSzR33aN9N/O8HqUYIbGE8njtO6fnciua4G94tFPZzO1RvCdps9E
         FHNP16NhtOs0SXyRa8+VVL/xBDDjbIG5Yv32ms6dmeb9O5xfqh/l8jxG1k3wjPLtD+12
         wep4pA2IEGqFPRK44k74eXj0g161qB3MU3oLogFNwrqkhY166UacflTjf3KiUCNb350M
         hs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360495; x=1783965295;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cnwJHJEouqLhDU4VS1gzSe1nEPe1/QANOGjZf+5gN18=;
        b=KKY0q07vuUyWb6OHzdoBUpOHf3eCNba14mcr5LAyWpt3I1AeAwhJIaRZys4Fe39kSG
         eaW9JK17espCJUwYPOVIIO4AZWZ4kD/DbCC/3ByoqK7rICgw2QIMedZ9LVJ5bShcO3YB
         Wp7S94GXhqYpYqNDqd4Spq0y85EDMb7PwcUoUngSlP30fgcGyooH1UbP/CAda42xfrza
         bWNXu0rp0DC1CH/enUPGvW6eRTdURDTklEu9yEMBE1GRUN4mekwAFsyF4OrBzBS+8Am6
         TbCK3czdcfllKPB+9FxfQM6EI3iZcCLyR1PmjdWdRm/3LVr5E2LY8bFMNWbW8/kxONoT
         XQZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqW/Skiv257wStGjle/9HZHDS14T/wY1s0lvQ14yCy31tVzO/B7+l+U8Ls3cHSwjm9HdBDZIHZumFNK8So=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgXCBXdsWpALdxWciHLmEGIbJq//eeUzxpm/j4Qw2iBuRCXDGe
	LIkdHK1cOtsT5J6D9O8936LnC1KrKEHE7efblMn5l303zmllgXCtHI+Phfikxw==
X-Gm-Gg: AfdE7cm2oSjqKG3UZHGo+oLf/y2GRbaxy1apcn2wF4L3/6/5LG5w7+9LCfZVg/RgNMq
	cM62U9acOk6uESK+loauVpzQ/xARaPhrI7BY0XuAy/xfHiG8SnZZe8R0s8LWd5Qms4VfLVeySc0
	B475sHeHySvHkqWDZhXvyYXv6waWgLgi7M32JH0TTPVZmxsOypCsJVcVw6ny/9VxmFXlQ6HD+fT
	fnQkAMc8C7NJflgPVY3JYOSrI+kb1/QQmsj/P5FjBaeTSX1fgc7jl44cAYBx6tsA4M4CIsRL8e5
	UTGOZQlSJCsflCNECeMQ7Ow3ZAkvgk3yRC/4V6AqtJKLmbHty9bRY5xVspocuwvjkhqizSad2xj
	vxATCcvdTtq88kh7pWaaVvjMRy88kq/SXAolK+mi51X0+BVEI0dEs0Mra7DH8dwJDqpWXEckY5O
	CKPxGuVYNGU4Z9goFJFEfA/JsGdnGibZLA1b7NYOi8Tl//QaZF27ZwupOms88=
X-Received: by 2002:a05:6a21:485:b0:398:9b42:69f7 with SMTP id adf61e73a8af0-3c08eed6b41mr1940825637.39.1783360495452;
        Mon, 06 Jul 2026 10:54:55 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e927a1152sm6529965a12.29.2026.07.06.10.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:54:54 -0700 (PDT)
Subject: [PATCH v6 0/4] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 akpm@linux-foundation.org, david@kernel.org, jgg@ziepe.ca, corbet@lwn.net,
 leon@kernel.org, ljs@kernel.org, mhocko@suse.com, rppt@kernel.org,
 shuah@kernel.org, skhan@linuxfoundation.org, surenb@google.com,
 vbabka@kernel.org, skinsburskii@gmail.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-hyperv@vger.kernel.org
Date: Mon, 06 Jul 2026 10:54:52 -0700
Message-ID: <178336023903.504354.7500950448226027718.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11834-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,linux-foundation.org,kernel.org,ziepe.ca,lwn.net,suse.com,linuxfoundation.org,google.com,gmail.com,microsoft.com];
	FORGED_SENDER(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:jgg@ziepe.ca,m:corbet@lwn.net,m:leon@kernel.org,m:ljs@kernel.org,m:mhocko@suse.com,m:rppt@kernel.org,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:surenb@google.com,m:vbabka@kernel.org,m:skinsburskii@gmail.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-mm@kvack.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,skinsburskii:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBE48714DD4

This series extends the HMM framework to support userfaultfd-backed memory
by allowing the mmap read lock to be dropped during hmm_range_fault().

Some page fault handlers — most notably userfaultfd — require the mmap lock
to be released so that userspace can resolve the fault. The current HMM
interface never sets FAULT_FLAG_ALLOW_RETRY, making it impossible to fault
in pages from userfaultfd-registered regions.

This series follows the established int *locked pattern from
get_user_pages_remote() in mm/gup.c. A new helper function,
hmm_range_fault_locked(), accepts an int *locked parameter. When the
mmap lock is dropped during fault resolution (VM_FAULT_RETRY or
VM_FAULT_COMPLETED), the function returns 0 with *locked = 0, signalling
the caller to restart its walk. The existing hmm_range_fault() is
refactored into a thin wrapper that passes NULL, preserving current
behavior for all existing callers.

Possible approaches to lift this limitation are documented in
Documentation/mm/hmm.rst.

Changes in v6:
  - Reworked the new API from the external int *locked pattern to
    hmm_range_fault_unlocked(), which owns mmap_read_lock() internally.
  - Changed the dropped-lock contract: hmm_range_fault_unlocked() now returns
    -EBUSY when the mmap lock is dropped, and callers restart with a fresh
    mmu_interval_read_begin() sequence.
  - Kept hmm_range_fault() as the locked variant for existing users, preserving
    its caller-held mmap lock contract.
  - Added an in-tree user by converting the MSHV region fault path to
    hmm_range_fault_unlocked().
  - Updated Documentation/mm/hmm.rst and kernel-doc to describe the unlocked
    helper and retry pattern.
  - Updated commit messages to match the new API and return semantics.
  - Kept the userfaultfd HMM selftest using the test_hmm unlocked read ioctl
    path.

Changes in v5:
 - Rework hmm_range_fault_unlockable() retry handling to retry
   VM_FAULT_RETRY internally with FAULT_FLAG_TRIED set, matching the
   fixup_user_fault() pattern and avoiding repeated first-retry lock drops.
 - Distinguish VM_FAULT_RETRY from VM_FAULT_COMPLETED: retry faults now
   reacquire the mmap lock internally, while completed faults return to the
   caller with *locked = 0 so the caller can restart with a fresh notifier
   sequence.
 - Document the two *locked return states, including the -EINTR case when a
   fatal signal is pending after the mmap lock has already been dropped.
 - Update comments around HMM_FAULT_UNLOCKED and the HMM fault loop to match
   the current hmm_range_fault_unlockable() implementation.

Changes in v4:
 - Rebased on 7.2-rc1

Changes in v3:
 - Return -EFAULT from dmirror_fault_unlockable() when the mirrored mm can
   no longer be pinned.
 - Add an eventfd stop signal for the userfaultfd handler thread to avoid
   waiting for the poll timeout on successful test completion.


Changes in v2:

 - Split into a preparatory refactor (new patch 1) that moves
   handle_mm_fault() out of the walk callbacks, plus a smaller feature
   patch on top.  Suggested by David Hildenbrand.
 - Hugetlb regions are now supported on the unlockable path; the v1
   -EFAULT short-circuit and the hugetlb_vma_lock_read drop/retake
   dance are gone.
 - Distinct internal sentinels for "needs fault" (HMM_FAULT_PENDING)
   and "lock dropped" (HMM_FAULT_UNLOCKED).
 - Outer loop now re-walks after a successful internal fault so the
   faulted pfns end up in range->hmm_pfns.
 - Kernel-doc on hmm_range_fault_unlockable() and the
   Documentation/mm/hmm.rst example match the implementation.
 - Dropped the mshv driver conversion (v1 patch 2); will post
   separately.
 - Selftest converted to drive the path through test_hmm with a
   userfaultfd handler (new HMM_DMIRROR_READ_UNLOCKABLE ioctl).

---

Stanislav Kinsburskii (4):
      mm/hmm: move page fault handling out of walk callbacks
      mm/hmm: add hmm_range_fault_unlocked() for mmap lock-drop support
      selftests/mm: add userfaultfd test for HMM unlocked path
      mshv: Use hmm_range_fault_unlocked() for region faults


 Documentation/mm/hmm.rst               |   59 ++++++++
 drivers/hv/mshv_regions.c              |   14 +-
 include/linux/hmm.h                    |    1 
 lib/test_hmm.c                         |  114 ++++++++++++++++
 lib/test_hmm_uapi.h                    |    1 
 mm/hmm.c                               |  223 +++++++++++++++++++++++---------
 tools/testing/selftests/mm/hmm-tests.c |  149 +++++++++++++++++++++
 7 files changed, 492 insertions(+), 69 deletions(-)


