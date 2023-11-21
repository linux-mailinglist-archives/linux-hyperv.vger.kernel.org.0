Return-Path: <linux-hyperv+bounces-1008-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D07F3827
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 22:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC9BEB21D1D
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1475B584D2;
	Tue, 21 Nov 2023 21:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH3Ki7Yp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F91A1;
	Tue, 21 Nov 2023 13:20:33 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc2575dfc7so43338975ad.1;
        Tue, 21 Nov 2023 13:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700601633; x=1701206433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xc8GLr7b1Ue8tHqz7t72K+XV3v6lbBa6kVrEMAQXlc=;
        b=AH3Ki7Ypbklah5zvA4Rw7+L1+msM0UouDKBaEA9yq6E3Bj6LijYg0n3tfVqBvVdgad
         j6E0Fc5VaLpyblLo7fqATh0HJCiWHjNMDZUcmFrUNmB8oTtfU89lut/tV3sJimJROBi6
         vEF8V3aJVoC8Ejm7RO+S94QptO9AzuBFItaaT+s4sXmbiTDeJbrAga7uzL+39GY9vFy1
         jEeXEV59DgEEw5mmpj/A2FW6je3Jrz8kPWg7fa8DK+eOrs7rWtu4HsTSwxPLqWiiP4j1
         5vwWXroz0WPhn2Kp+5Nn3hScxuWrBOf/seyZA60CM0Ol3mVl2h2Ay28HY1KfQ4N4xHZT
         rHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601633; x=1701206433;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xc8GLr7b1Ue8tHqz7t72K+XV3v6lbBa6kVrEMAQXlc=;
        b=aYlsyNXrAq145R7xZ1kayRNPIB325AKViEJ03Tg9K5YmEY7PXTRR70RG/q6r8HBhyF
         P/afbDeQjkfwOu5dmx1Uc0E9vijrXeOOsTHRyY83rBP7J3939yccGGL2YULpFb1eIszY
         Awi3fy/BdS1VTsoaPiEMxgutt0nB9YeP5Mgw/gv6Jd1on6TvhECeGoJZL7yKnBiuvY85
         1UV20ZiEWg3wM4QUV8lJuGacD+vd2Lt+gqVJbTt9/jp6T0TEZZ2caWJPZ9SaTTh2V5yO
         aUO+6hHyqV54Pta29T8PoliOezy9UBBhhfMkMH+6iHSMhAYGGSBgb9V1Xa1mjChMxriK
         EZDA==
X-Gm-Message-State: AOJu0YxBya1HC/ZDGFwh8rHT5r1IejeiXkJWTopc231O6P627zVMrbFF
	b/5JFAJvy1owENgLTQPOb5U=
X-Google-Smtp-Source: AGHT+IHM5X1K1llz1VLKg9yvkhT/EXDhe6Mz6grLILsACT3NwCrpJBBQDYHT5we5qKHkDCR9OMYszw==
X-Received: by 2002:a17:902:f542:b0:1ce:5b21:5c34 with SMTP id h2-20020a170902f54200b001ce5b215c34mr508877plf.5.1700601632801;
        Tue, 21 Nov 2023 13:20:32 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001bf52834696sm8281924pll.207.2023.11.21.13.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:20:32 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	luto@kernel.org,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	lstoakes@gmail.com,
	thomas.lendacky@amd.com,
	ardb@kernel.org,
	jroedel@suse.de,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/8] x86/coco: Mark CoCo VM pages not present when changing encrypted state
Date: Tue, 21 Nov 2023 13:20:08 -0800
Message-Id: <20231121212016.1154303-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

In a CoCo VM when a page transitions from encrypted to decrypted, or vice
versa, attributes in the PTE must be updated *and* the hypervisor must
be notified of the change. Because there are two separate steps, there's
a window where the settings are inconsistent.  Normally the code that
initiates the transition (via set_memory_decrypted() or
set_memory_encrypted()) ensures that the memory is not being accessed
during a transition, so the window of inconsistency is not a problem.
However, the load_unaligned_zeropad() function can read arbitrary memory
pages at arbitrary times, which could read a transitioning page during
the window.  In such a case, CoCo VM specific exceptions are taken
(depending on the CoCo architecture in use).  Current code in those
exception handlers recovers and does "fixup" on the result returned by
load_unaligned_zeropad().  Unfortunately, this exception handling can't
work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode)
if the exceptions are routed to the paravisor.  The paravisor can't
do load_unaligned_zeropad() fixup, so the exceptions would need to
be forwarded from the paravisor to the Linux guest, but there are
no architectural specs for how to do that.

Fortunately, there's a simpler way to solve the problem by changing
the core transition code in __set_memory_enc_pgtable() to do the
following:

1.  Remove aliasing mappings
2.  Flush the data cache if needed
3.  Remove the PRESENT bit from the PTEs of all transitioning pages
4.  Set/clear the encryption attribute as appropriate
5.  Flush the TLB so the changed encryption attribute isn't visible
6.  Notify the hypervisor of the encryption status change
7.  Add back the PRESENT bit, making the changed attribute visible

With this approach, load_unaligned_zeropad() just takes its normal
page-fault-based fixup path if it touches a page that is transitioning.
As a result, load_unaligned_zeropad() and CoCo VM page transitioning
are completely decoupled.  CoCo VM page transitions can proceed
without needing to handle architecture-specific exceptions and fix
things up. This decoupling reduces the complexity due to separate
TDX and SEV-SNP fixup paths, and gives more freedom to revise and
introduce new capabilities in future versions of the TDX and SEV-SNP
architectures. Paravisor scenarios work properly without needing
to forward exceptions.

Patch 1 handles implications of the hypervisor callbacks in Step 6
needing to do virt-to-phys translations on pages that are temporarily
marked not present.

Patch 2 ensures that Step 7 doesn't generate a TLB flush.  It is a
performance optimization only and is not necessary for correctness.

Patches 3 and 4 handle the case where SEV-SNP does PVALIDATE in
Step 6, which requires a valid virtual address.  But since the
PRESENT bit has been removed from the direct map virtual address,
the PVALIDATE fails.  These patches construct a temporary virtual
address to be used by PVALIDATE.  This code is SEV-SNP only because
the TDX and Hyper-V paravisor flavors operate on physical addresses.

Patches 5 and 6 are the core change that marks the transitioning
pages as not present.  Patch 6 is optional since retaining both
the "prepare" and "finish" callbacks doesn't hurt anything and
there might be an argument for retaining both for future
flexibility.  However, Patch 6 *does* eliminate about 75 lines of
code and comments.

Patch 7 is a somewhat tangential cleanup that removes an unnecessary
wrapper function in the path for doing a transition.

Patch 8 adds comments describing the implications of errors when
doing a transition.  These implications are discussed in the email
thread for the RFC patch[1] and a patch proposed by Rick Edgecombe.
[2][3]

With this change, the #VE and #VC exception handlers should no longer
be triggered for load_unaligned_zeropad() accesses, and the existing
code in those handlers to do the "fixup" shouldn't be needed. But I
have not removed that code in this patch set. Kirill Shutemov wants
to keep the code for TDX #VE, so the code for #VC on the SEV-SNP
side has also been kept.

This patch set is based on the linux-next20231117 code tree.

Changes in v2:
* Added Patches 3 and 4 to deal with the failure on SEV-SNP
  [Tom Lendacky]
* Split the main change into two separate patches (Patch 5 and
  Patch 6) to improve reviewability and to offer the option of
  retaining both hypervisor callbacks.
* Patch 5 moves set_memory_p() out of an #ifdef CONFIG_X86_64
  so that the code builds correctly for 32-bit, even though it
  is never executed for 32-bit [reported by kernel test robot]

[1] https://lore.kernel.org/lkml/1688661719-60329-1-git-send-email-mikelley@microsoft.com/
[2] https://lore.kernel.org/lkml/20231017202505.340906-1-rick.p.edgecombe@intel.com/
[3] https://lore.kernel.org/lkml/20231024234829.1443125-1-rick.p.edgecombe@intel.com/

Michael Kelley (8):
  x86/coco: Use slow_virt_to_phys() in page transition hypervisor
    callbacks
  x86/mm: Don't do a TLB flush if changing a PTE that isn't marked
    present
  x86/mm: Remove "static" from vmap_pages_range()
  x86/sev: Enable PVALIDATE for PFNs without a valid virtual address
  x86/mm: Mark CoCo VM pages not present while changing encrypted state
  x86/mm: Merge CoCo prepare and finish hypervisor callbacks
  x86/mm: Remove unnecessary call layer for __set_memory_enc_pgtable()
  x86/mm: Add comments about errors in
    set_memory_decrypted()/encrypted()

 arch/x86/boot/compressed/sev.c  |   2 +-
 arch/x86/coco/tdx/tdx.c         |  66 +----------------
 arch/x86/hyperv/ivm.c           |  15 ++--
 arch/x86/include/asm/sev.h      |   6 +-
 arch/x86/include/asm/x86_init.h |   4 --
 arch/x86/kernel/sev-shared.c    |  57 ++++++++++++---
 arch/x86/kernel/sev.c           |  43 ++++++-----
 arch/x86/kernel/x86_init.c      |   4 --
 arch/x86/mm/mem_encrypt_amd.c   |  23 +-----
 arch/x86/mm/pat/set_memory.c    | 122 ++++++++++++++++++++++----------
 include/linux/vmalloc.h         |   2 +
 mm/vmalloc.c                    |   2 +-
 12 files changed, 171 insertions(+), 175 deletions(-)

-- 
2.25.1


