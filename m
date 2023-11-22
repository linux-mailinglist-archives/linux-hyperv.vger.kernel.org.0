Return-Path: <linux-hyperv+bounces-1019-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171C67F3D2F
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 06:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5150F1C20A18
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 05:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DEEC134;
	Wed, 22 Nov 2023 05:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F46100;
	Tue, 21 Nov 2023 21:12:34 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ce2de8da87so3826076a34.1;
        Tue, 21 Nov 2023 21:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700629953; x=1701234753;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laDzjb5l70fg2Gskg7Mi/doMwFelucFDk++YuwSRGK4=;
        b=pIkNcGnrKNe4K/k3BxUZeNrfGwUgYb6psvUvt7LVCbS314PownuaWxgYIt/iPMOARL
         7xn3oRyPr3F02lheX0+sf1Ps9QKmlDiEkr3GMk7yx+0HQw/NYJmnYO5nVXR3VGEow6Ag
         ekMMbeWg5ocMY11SHgjZezkI2ArPcgxADHVH4NgNGYbnwI1VQ6aCwEupq4aFhDdD4vQW
         7eL/JaR9+u14ubvM5ApkUIoJhs18yM6YPNboOrTM71sgQV4ktULqCtBFwoO3z/az2CKO
         OEkd/mf8u+3tGlxX17RHdnwYc63kXx9gop90FJe8XCLDuq1AOVW4+TLNT0wAQmviZT6V
         aE4Q==
X-Gm-Message-State: AOJu0Yw0W9TMq4hA5q+wWuvsSDLKlT+urierfvcSaJHmMHDYvlrJQBKT
	71aPuGmXdEa/EAVJrCSysyc=
X-Google-Smtp-Source: AGHT+IG1HiM0nFV+shX1uySm+RtazynHGh7WR6gWG/nDW3IM4+sAr0zheaYbTsZYQ8Juq4RZ+50g/A==
X-Received: by 2002:a05:6870:9a96:b0:1ea:8b10:247a with SMTP id hp22-20020a0568709a9600b001ea8b10247amr1754919oab.42.1700629953556;
        Tue, 21 Nov 2023 21:12:33 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id v1-20020aa78081000000b0065a1b05193asm8871509pff.185.2023.11.21.21.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 21:12:33 -0800 (PST)
Date: Wed, 22 Nov 2023 05:12:30 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 6.7-rc3
Message-ID: <ZV2NvuIAgdrc1d1P@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Linus,

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20231121

for you to fetch changes up to 18286883e779fb79b413a7462968ee3f6768f19c:

  x86/hyperv: Use atomic_try_cmpxchg() to micro-optimize hv_nmi_unknown() (2023-11-22 03:47:44 +0000)

----------------------------------------------------------------
hyperv-fixes for 6.7-rc3
 - One fix for the KVP daemon (Ani Sinha)
 - Fix for the detection of E820_TYPE_PRAM in a Gen2 VM (Saurabh Sengar)
 - Micro-optimization for hv_nmi_unknown() (Uros Bizjak)
----------------------------------------------------------------
Ani Sinha (1):
      hv/hv_kvp_daemon: Some small fixes for handling NM keyfiles

Saurabh Sengar (1):
      x86/hyperv: Fix the detection of E820_TYPE_PRAM in a Gen2 VM

Uros Bizjak (1):
      x86/hyperv: Use atomic_try_cmpxchg() to micro-optimize hv_nmi_unknown()

 arch/x86/hyperv/hv_init.c      | 25 +++++++++++++++++++++----
 arch/x86/kernel/cpu/mshyperv.c |  5 ++++-
 tools/hv/hv_kvp_daemon.c       | 20 ++++++++++++--------
 tools/hv/hv_set_ifconfig.sh    |  4 ++--
 4 files changed, 39 insertions(+), 15 deletions(-)

