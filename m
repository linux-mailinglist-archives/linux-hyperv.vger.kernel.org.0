Return-Path: <linux-hyperv+bounces-1705-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9680D8784B7
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 17:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC072845FA
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBAA481C0;
	Mon, 11 Mar 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErpYGxfm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9F2B9AD;
	Mon, 11 Mar 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173788; cv=none; b=P0im28Ph/rZAarbreqo1HbOGanUvYOA68WxyTv6qtlN5SXfqfqo7AytntfUPFpUzjPA21BS1f7LS2YMxQL61ZV9iD3y7pP1bd5UjnV3hK6lIBZ3nyUcSHUjHf00Z2gBZuvNcY3h7w4qrssmX7pZyPmGuIlcOQ5oQTCfVDqfvhF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173788; c=relaxed/simple;
	bh=u41R1/z/aMOcSfYC5FfDMYjUC+WpOX9ZGT07yO69ORc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GAV6Z/+t3sGvfPBW6eJbVj7mkeRacM33a2LovvJ52WzqBnEb2yAOQSiAD7eQKj+gbr+qmkWEw9iXfK6WZbg00hrPDmejnb9S4iRZPAVxJ0EzumBCxGoVkENICeEfM7ftb2OFSyiloQkT6HEsnD9kXAHaumRtBNB1kULBvOqU5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErpYGxfm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e676ea4e36so2262315b3a.3;
        Mon, 11 Mar 2024 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173784; x=1710778584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AMRNASf24/etkhelqi2/rcH+v+7JaskxvtUiwcImk8=;
        b=ErpYGxfmbozvl1V6lJZgdbl02MSX/by+nwVrDpbQ2wOhcWRE2KWfMrIyvhccICFouW
         e1ZLaexU4LhhjAhvMkiiNdnxL6Hr22F00iQp04oCkCkq+jnyob4a2//GpMlkXT6Rl60T
         vB34iap7Jo9ErQzLO/+y0koMMYdt+/IzcX1Tie/YD0FxPrULoR568UubTjA9PBIDmRqn
         E2XnjwAdXhAu02Z1SKOlE4J+STRZPi4K5fwvlT5qUQdk6ynaw7kO1PxeemXNpdoZDAxH
         kOQQnCJlzjszVDVRS3UYsKkUpviAiKeISj9tLW+Q4pnGyZ0pSfTBgwRSTBLqjl6AY+8U
         7mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173784; x=1710778584;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AMRNASf24/etkhelqi2/rcH+v+7JaskxvtUiwcImk8=;
        b=rRFCdfHIiw18+Pf6nPSfCt/xf5lCGWTxZNCUJxeEto+hEBE80tVyOFeHpU9fxe1LGP
         3yh2K2EwVM5BFOA8S8H5UuAJ6fxo1wh3FuuZXF46I8cVD2Q6QBWoc2P5QWCN+r9cDKtK
         hlVxkhq1mMwmJx8xXNQqkla1Stmviju2TQLPvczCsTWiUqz1/WINAJ+V1PcKqx4FS36Z
         3oITDYK7GeiNYIBQ6ULYf0QczSaHHQmqVI2iY3XfwWIZqkXXJpN6Uty2lAYwIjZyo7x+
         EGzatVOZ9COlYxk4i5lguNw1Z1sIKKlju1ApEbVRIc7iNk6PsDNN0NIe2kFuZ/0zF54T
         q9tw==
X-Forwarded-Encrypted: i=1; AJvYcCW8raGoOPjjwKJdf+SHDdIV8Mi+OwWqb2+41SHauSMw1d4/hLRbguwKfSZZRi9deKLa7UshLP97K8IAzoWqRerfWGbfmABkOHQdWjwn0O0LXGPn8oD2A0Qvt9mlHAyofdrjBO9NWokKy+hCrHmXj4ZxRGF9sv11WAyzPO49qbAIjv5h
X-Gm-Message-State: AOJu0YzgO8VF85ALUaCDQwB5EDeBR8YqbJWphKNQ4RlK4+7E038u21YI
	5oapsLciiR0j0CZOL+i90OMIlXkEJSASHW2MiEjujd0qwU7FYi+6
X-Google-Smtp-Source: AGHT+IE8Qf0qy9YfHTX5yZH+MvkpBowKO2nlgBRR4/DNOeI2LZr0IiapRKmZUPnBWkeXc9ZQ9NbneQ==
X-Received: by 2002:a05:6a20:d387:b0:1a2:f4fd:b1cb with SMTP id iq7-20020a056a20d38700b001a2f4fdb1cbmr1033665pzb.55.1710173784131;
        Mon, 11 Mar 2024 09:16:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id m22-20020a056a00081600b006e52ce4ee2fsm4576325pfk.20.2024.03.11.09.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:16:23 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: rick.p.edgecombe@intel.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	elena.reshetova@intel.com
Subject: [PATCH 0/5] Handle set_memory_XXcrypted() errors in Hyper-V
Date: Mon, 11 Mar 2024 09:15:53 -0700
Message-Id: <20240311161558.1310-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Shared (decrypted) pages should never be returned to the page allocator,
lest future usage of the pages store data that should not be exposed to
the host. They may also cause the guest to crash if the page is used in
a way disallowed by HW (i.e. for executable code or as a page table).

Normally set_memory() call failures are rare. But in CoCo VMs
set_memory_XXcrypted() may involve calls to the untrusted host, and an
attacker could fail these calls such that:
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
kernel needs the host's help to do this and the host is already being
uncooperative around the needed operations. So this isn't guaranteed to
succeed and the caller is kind of stuck with unusable pages.

The only choice is to panic or leak the pages. The kernel tries not to
panic if at all possible, so just leak the pages at the call sites.
Separately there is a patch[1] to warn if the guest detects strange host
behavior around this. It is stalled, so in the mean time I’m proceeding
with fixing the callers to leak the pages. No additional warnings are
added, because the plan is to warn in a single place in x86 set_memory()
code.

This series fixes the cases in the Hyper-V code.

This is the non-RFC/RFT version of Rick Edgecombe's previous series.[2]
Rick asked me to do this version based on my comments and the testing
I did. I've tested most of the error paths by hacking
set_memory_encrypted() to fail, and observing /proc/vmallocinfo and
/proc/buddyinfo to confirm that the memory is leaked as expected
instead of freed.

Changes in this version:
* Expanded commit message references to "TDX" to be "CoCo VMs" since
  set_memory_encrypted() could fail in other configurations, such as
  Hyper-V CoCo guests running with a paravisor on SEV-SNP processors.
* Changed "Subject:" prefixes to match historical practice in Hyper-V
  related source files
* Patch 1: Added handling of set_memory_decrypted() failure
* Patch 2: Changed where the "decrypted" flag is set so that
  error cases not related to set_memory_encrypted() are handled
  correctly
* Patch 2: Fixed the polarity of the test for set_memory_encrypted()
  failing
* Added Patch 5 to the series to properly handle free'ing of
  ring buffer memory
* Fixed a few typos throughout

[1] https://lore.kernel.org/lkml/20240122184003.129104-1-rick.p.edgecombe@intel.com/
[2] https://lore.kernel.org/linux-hyperv/20240222021006.2279329-1-rick.p.edgecombe@intel.com/

Michael Kelley (1):
  Drivers: hv: vmbus: Don't free ring buffers that couldn't be
    re-encrypted

Rick Edgecombe (4):
  Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
  Drivers: hv: vmbus: Track decrypted status in vmbus_gpadl
  hv_netvsc: Don't free decrypted memory
  uio_hv_generic: Don't free decrypted memory

 drivers/hv/channel.c         | 16 ++++++++++++----
 drivers/hv/connection.c      | 11 +++++++----
 drivers/net/hyperv/netvsc.c  |  7 +++++--
 drivers/uio/uio_hv_generic.c | 12 ++++++++----
 include/linux/hyperv.h       |  1 +
 5 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.25.1


