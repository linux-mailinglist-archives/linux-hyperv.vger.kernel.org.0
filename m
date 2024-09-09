Return-Path: <linux-hyperv+bounces-2988-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC819970AE2
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 03:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CD71C20ACA
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 01:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A8184F;
	Mon,  9 Sep 2024 01:04:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62C11712
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Sep 2024 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725843884; cv=none; b=CK7t7qDr5tE/KMo6QXJ/G4BQORwO4oXdVdclPR5X/T6trvZNyoWg3iVXwRbr12MBi0rQ1JvL0P9TWsFoAgLk/YWsK0fw4KL/BwYftqmSXCAhJZROkD40Xm6MVRPvnheaAPgyyuXKrr1UD9Gvoq1mwD+QE2McoSBMQSN7dyiCj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725843884; c=relaxed/simple;
	bh=M+HKgPBe9W3UJNXQzgv3PIFiWymxIuxZ5ktkdIqjAyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ncOxFn7df3Cy43EoaaIc5kfRTkBvz9o+CyO7xy5HVk/gF/+OsKp8VKwpcW6FyYEojNfCeWZsquIVcBJm12zPlCyl13enrzaaQoqsJeGxHW2uUyAUkvgKicJlJBf6VOHdi64nHRH5hwFa8ya5Kj7EaVyGD2ZiTEoDfK0hT8x1T9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso3018504a12.2
        for <linux-hyperv@vger.kernel.org>; Sun, 08 Sep 2024 18:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725843882; x=1726448682;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChXoS+CLnp0koYKbH7gCiQ6dG2fbjxwg6PynQJNCJkY=;
        b=NV09eK8ZtWthxxURdE6hZeLDfaANs/lp2uS40FiXDUL/zZGmzwKJECRM6u7Wcvr9zc
         /2vU9WtsW9mq3cTjvrXOaJfYVeeKRiCiR0Bpxs2bNGof+i7JI4xze6dUoSmyXnDB6f1X
         RkpE7ePQmzppUN1EYDhyi66dW8Re90G+HUmNYoiyZc6NtDezmoI8POkMTpchSZ4oVy2g
         B6W0blJ5HNKjbyWZf7mQZ+t7KQgj6hzz0m6kkfzq5YZh74GV8tDql1sNtrDeDtSPuvcf
         1xSR3xZlD3krSYVd014P92/j4AmOjnoL56OXcC5vaBaJI6yKunpt5AE+8S/ZxeSFNg9z
         +vfg==
X-Forwarded-Encrypted: i=1; AJvYcCWJIxE6rLM8SSdGv6zRVNUNSukMXJc9QWWfYGNT90G+q3XpI2gEz6BEtlAliNnN9cuKH5jE7Jyx5uqgkdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdzsrAnntW0ZihsatkAPap6Q2gc30cVp/AUBdDboOecpDepFd
	WhzSDvZfXW1FydtPImg+Fzh6ilSGZXmXHswEZMbG/nA8NFX0dvq76c05ww==
X-Google-Smtp-Source: AGHT+IHWhwFmSgpbe1EPASuzXqAGhnfSkhJf+Q6zXHv7rVQ/PkECV7pd+Hd790rvRiHDuRjnhEdNAQ==
X-Received: by 2002:a17:90a:f48e:b0:2d8:7a3b:730d with SMTP id 98e67ed59e1d1-2dad501408fmr10518856a91.21.1725843881741;
        Sun, 08 Sep 2024 18:04:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c59c9sm3278959a91.24.2024.09.08.18.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 18:04:41 -0700 (PDT)
Date: Mon, 9 Sep 2024 01:04:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for v6.11-rc8
Message-ID: <Zt5JlnHqc6ubskR3@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 831bcbcead6668ebf20b64fdb27518f1362ace3a:

  Drivers: hv: Cosmetic changes for hv.c and balloon.c (2024-06-06 06:03:29 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240908

for you to fetch changes up to 895384881ec960aa4c602397a69f0a44a8169405:

  hv: vmbus: Constify struct kobj_type and struct attribute_group (2024-09-05 15:04:49 +0000)

----------------------------------------------------------------
hyperv-fixes for 6.11-rc8
 - Add an overview of Confidential Computing VM support (Michael Kelley)
 - Use lapic timer in a TDX VM without paravisor (Dexuan Cui)
 - Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency
   (Michael Kelley)
 - Fix a kexec crash due to VP assist page corruption (Anirudh
   Rayabharam)
 - Python3 compatibility fix for lsvmbus (Anthony Nandaa)
 - Misc fixes (Rachel Menge, Roman Kisel, zhang jiao, Hongbo Li)
----------------------------------------------------------------
Anirudh Rayabharam (Microsoft) (1):
      x86/hyperv: fix kexec crash due to VP assist page corruption

Anthony Nandaa (1):
      tools: hv: lsvmbus: change shebang to use python3

Dexuan Cui (1):
      clocksource: hyper-v: Use lapic timer in a TDX VM without paravisor

Hongbo Li (1):
      hv: vmbus: Constify struct kobj_type and struct attribute_group

Michael Kelley (2):
      Documentation: hyperv: Add overview of Confidential Computing VM support
      x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency

Rachel Menge (1):
      Drivers: hv: Remove deprecated hv_fcopy declarations

Roman Kisel (1):
      Drivers: hv: vmbus: Fix the misplaced function description

zhang jiao (1):
      tools: hv: rm .*.cmd when make clean

 Documentation/virt/hyperv/coco.rst  | 260 ++++++++++++++++++++++++++++++++++++
 Documentation/virt/hyperv/index.rst |   1 +
 arch/x86/hyperv/hv_init.c           |   5 +-
 arch/x86/include/asm/mshyperv.h     |   1 -
 arch/x86/kernel/cpu/mshyperv.c      |  21 ++-
 drivers/clocksource/hyperv_timer.c  |  16 ++-
 drivers/hv/hv.c                     |   6 +-
 drivers/hv/hyperv_vmbus.h           |   6 -
 drivers/hv/vmbus_drv.c              |   4 +-
 tools/hv/Makefile                   |   2 +-
 tools/hv/lsvmbus                    |   2 +-
 11 files changed, 302 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/virt/hyperv/coco.rst
 mode change 100644 => 100755 tools/hv/lsvmbus

