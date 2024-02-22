Return-Path: <linux-hyperv+bounces-1582-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB5585EEF1
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Feb 2024 03:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0901F1C21DC6
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Feb 2024 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CF14287;
	Thu, 22 Feb 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anjfdKKI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826EF516;
	Thu, 22 Feb 2024 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567844; cv=none; b=fR8rhRa0/VQH2yqE4eVUNv4lgy1EWX1nzVi+zPjaDi5oaMLM3O7oxbnJ+Zu33sBArQ5Ak6nYJIl5QASejkqjT98Mvdx38EgfSTN5KqUc5R4EWBRx01ks3dysFCwECQGjwZ7B65hwoBelEq80hWkqVI0T+ddqq7R3QZGgrbHe20U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567844; c=relaxed/simple;
	bh=2iQQTy6WCqwTsssftJv4V810WwcqtAi5jWn3NTRwc/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ILmJbVai9ZBt/gl3j1vODghXBmv+DwSfat9Ae5tIBdDigo2L3eyj7wThXOE9wpfpJXgqLXDkCAcaTaNcbVcxsXCVTiTdmpKMpZ4OIvhW7SwS43G3dD0GJH9BMYG3ROTdlMWg0dylNxtpPz919HAHeffzxiihrkWB/njv5C4+zPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anjfdKKI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708567843; x=1740103843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2iQQTy6WCqwTsssftJv4V810WwcqtAi5jWn3NTRwc/I=;
  b=anjfdKKIfaGiJAvsvXZylhvpcPYtpl5cqauJJRpzyItSzB+0k/elbVkz
   MmsnEyYMsH8ZDe68tPvPHHlXpSQj9oPA422Vi40Mz/AK4QByWz0RXHMYD
   baW5mIlQPIfT0jK761P/5r3R91r6+LAlazzRDZpv0V7rqnxM6184rsMQE
   q52rp53T0rU2doVhpUUUCxxRaCNEHZu+cwFjZHvFttW7/pHQAuEw0NSD+
   Ep4ez98OBZQOHl5ptw0w2IzFM1WVNTpPGXEUGtZ/bq21WovfrOr+yUjFs
   NCxLC6dkhs505kn5qtDyjBW8AkGmoCxBKJ9cvxX70kLmmi+RA7XmkskMB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2641006"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2641006"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5226882"
Received: from nlokaya-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.62.65])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:10:41 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhklinux@outlook.com,
	linux-hyperv@vger.kernel.org,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	elena.reshetova@intel.com,
	rick.p.edgecombe@intel.com
Subject: [RFC RFT PATCH 0/4] Handle  set_memory_XXcrypted() errors in hyperv
Date: Wed, 21 Feb 2024 18:10:02 -0800
Message-Id: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Shared (decrypted) pages should never return to the page allocator, or 
future usage of the pages may allow for the contents to be exposed to the 
host. They may also cause the guest to crash if the page is used in way 
disallowed by HW (i.e. for executable code or as a page table).

Normally set_memory() call failures are rare. But on TDX 
set_memory_XXcrypted() involves calls to the untrusted VMM, and an attacker
could fail these calls such that:
 1. set_memory_encrypted() returns an error and leaves the pages fully
    shared.
 2. set_memory_decrypted() returns an error, but the pages are actually
    full converted to shared.

This means that patterns like the below can cause problems:
void *addr = alloc();
int fail = set_memory_decrypted(addr, 1);
if (fail)
        free_pages(addr, 0);

And:
void *addr = alloc();
int fail = set_memory_decrypted(addr, 1);
if (fail) {
        set_memory_encrypted(addr, 1);
        free_pages(addr, 0);
}

Unfortunately these patterns appear in the kernel. And what the 
set_memory() callers should do in this situation is not clear either. They 
shouldn’t use them as shared because something clearly went wrong, but 
they also need to fully reset the pages to private to free them. But, the 
kernel needs the VMMs help to do this and the VMM is already being 
uncooperative around the needed operations. So this isn't guaranteed to 
succeed and the caller is kind of stuck with unusable pages.

The only choice is to panic or leak the pages. The kernel tries not to 
panic if at all possible, so just leak the pages at the call sites. 
Separately there is a patch[0] to warn if the guest detects strange VMM 
behavior around this. It is stalled, so in the mean time I’m proceeding 
with fixing the callers to leak the pages. No additional warnings are 
added, because the plan is to warn in a single place in x86 set_memory() 
code.

This series fixes the cases in the hyperv code.

IMPORTANT NOTE:
I don't have a setup to test tdx hyperv changes. These changes are compile
tested only. Previously Michael Kelley suggested some folks at MS might be
able to help with this.

[0] https://lore.kernel.org/lkml/20240122184003.129104-1-rick.p.edgecombe@intel.com/

Rick Edgecombe (4):
  hv: Leak pages if set_memory_encrypted() fails
  hv: Track decrypted status in vmbus_gpadl
  hv_nstvsc: Don't free decrypted memory
  uio_hv_generic: Don't free decrypted memory

 drivers/hv/channel.c         | 11 ++++++++---
 drivers/hv/connection.c      | 11 +++++++----
 drivers/net/hyperv/netvsc.c  |  7 +++++--
 drivers/uio/uio_hv_generic.c | 12 ++++++++----
 include/linux/hyperv.h       |  1 +
 5 files changed, 29 insertions(+), 13 deletions(-)

-- 
2.34.1


