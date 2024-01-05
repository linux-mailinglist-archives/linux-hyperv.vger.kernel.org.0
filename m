Return-Path: <linux-hyperv+bounces-1378-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD2C825A24
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jan 2024 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B81B21A9E
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jan 2024 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D613735EE3;
	Fri,  5 Jan 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQkpRGa7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E9347B0;
	Fri,  5 Jan 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d4df66529bso10891055ad.1;
        Fri, 05 Jan 2024 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704479440; x=1705084240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GhZC869aJnqNJACUr8BJ3n7gkdmfHBpgiLz8gKtgcrw=;
        b=FQkpRGa7QXWxwOGJUT7kgcirjLaKvIEVpTiQLCyN1zBj2q9i0f9oqE1MG1wlVELs18
         IkSn/SWGPINemAFDPcdeL3XokFhv3Ah1ygy7XiF5SAufGsDM9bks2OLRx/M7oN3T7bsS
         mS3VHoTmgcbN4FVAlv0RNmUDFhihnyDbU5LQUpTU53tiPw4PEOHqpDZ3qn4rY5ph6WmR
         4ZAEVhxzvD/46HYNX13WOL84FYKqS6WtQmYZ/zuywsZjJVN77bpTaNyD9HTy3Erep/xt
         ZwH9D6wD2rgV4ioggsqAYXZrGpmOGgPHU6qWWKZOgXMJMdIW1wx9hdSGksf7fNiMThyL
         +Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479440; x=1705084240;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhZC869aJnqNJACUr8BJ3n7gkdmfHBpgiLz8gKtgcrw=;
        b=Y9MAeC+tkvWF3i81Uznx6nxVStofWIRrmdQeTRnwuQzqS5ijzsZkoXYDnFGIMqnj2t
         6bNFQIY3R/vnhNwYf3jFOxZySVOuBz6QFDNbLOeXFc5r22oIc1K5wY0GzycfoBnTQRck
         Wvz8tHW7jNFkJuX1uzy6PCQCOdblqsyrLGY3EvNOEUvv6/Mr3/VX4kfyy2M2q4XpyCMF
         tVoAim0xefSdUYKhdnbTkAo+VxrxsFklosozTUAgAt42qLqB1dFoOyIic7Xf0vcc0Pta
         jnC62n58K0vpX1Spxs8QOg2MB6ywQixMutaMzs9H/XIk7fyjT8WwJLPzpfOnD3mOC4G3
         CFhQ==
X-Gm-Message-State: AOJu0YxrsNhbYY5jaM5QWeVnurZrCc8w3UEUjZQFm4TZ8jO147eKBOhq
	7wz2K7pKbjNxYPGpe59twgg=
X-Google-Smtp-Source: AGHT+IHXiqb2zLOL212dF7sFCdw/skkZ7ndS0GC2Iw301HIGKXy9MO1ye5sBWak1F9zIaebZIH9sdw==
X-Received: by 2002:a17:90a:51a2:b0:28c:76b:7cf7 with SMTP id u31-20020a17090a51a200b0028c076b7cf7mr2000773pjh.21.1704479439684;
        Fri, 05 Jan 2024 10:30:39 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a195700b002868abc0e6dsm1687293pjh.11.2024.01.05.10.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:30:39 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com,
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
Subject: [PATCH v3 0/3] x86/hyperv: Mark CoCo VM pages not present when changing encrypted state
Date: Fri,  5 Jan 2024 10:30:22 -0800
Message-Id: <20240105183025.225972-1-mhklinux@outlook.com>
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

In a CoCo VM, when transitioning memory from encrypted to decrypted, or
vice versa, the caller of set_memory_encrypted() or set_memory_decrypted()
is responsible for ensuring the memory isn't in use and isn't referenced
while the transition is in progress.  The transition has multiple steps,
and the memory is in an inconsistent state until all steps are complete.
A reference while the state is inconsistent could result in an exception
that can't be cleanly fixed up.

However, the kernel load_unaligned_zeropad() mechanism could cause a stray
reference that can't be prevented by the caller of set_memory_encrypted()
or set_memory_decrypted(), so there's specific code to handle this case.
But a CoCo VM running on Hyper-V may be configured to run with a paravisor,
with the #VC or #VE exception routed to the paravisor. There's no
architectural way to forward the exceptions back to the guest kernel, and
in such a case, the load_unaligned_zeropad() specific code doesn't work.

To avoid this problem, mark pages as "not present" while a transition
is in progress. If load_unaligned_zeropad() causes a stray reference, a
normal page fault is generated instead of #VC or #VE, and the
page-fault-based fixup handlers for load_unaligned_zeropad() resolve the
reference. When the encrypted/decrypted transition is complete, mark the
pages as "present" again.

This version of the patch series marks transitioning pages "not present"
only when running as a Hyper-V guest with a paravisor. Previous
versions[1] marked transitioning pages "not present" regardless of the
hypervisor and regardless of whether a paravisor is in use.  That more
general use had the benefit of decoupling the load_unaligned_zeropad()
fixup from CoCo VM #VE and #VC exception handling.  But the implementation
was problematic for SEV-SNP because the SEV-SNP hypervisor callbacks
require a valid virtual address, not a physical address like with TDX and
the Hyper-V paravisor.  Marking the transitioning pages "not present"
causes the virtual address to not be valid, and the PVALIDATE
instruction in the SEV-SNP callback fails. Constructing a temporary
virtual address for this purpose is slower and adds complexity that
negates the benefits of the more general use. So this version narrows
the applicability of the approach to just where it is required
because of the #VC and #VE exceptions being routed to a paravisor.

The previous version minimized the TLB flushing done during page
transitions between encrypted and decrypted. Because this version
marks the pages "not present" in hypervisor specific callbacks and
not in __set_memory_enc_pgtable(), doing such optimization is more
difficult to coordinate. But the page transitions are not a hot path,
so this version eschews optimization of TLB flushing in favor of
simplicity.

Since this version no longer touches __set_memory_enc_pgtable(),
I've also removed patches that add comments about error handling
in that function.  Rick Edgecombe has proposed patches to improve
that error handling, and I'll leave those comments to Rick's
patches.

Patch 1 handles implications of the hypervisor callbacks needing
to do virt-to-phys translations on pages that are temporarily
marked not present.

Patch 2 makes the existing set_memory_p() function available for
use in the hypervisor callbacks.

Patch 3 is the core change that marks the transitioning pages
as not present.

This patch set is based on the linux-next20240103 code tree.

Changes in v3:
* Major rework and simplification per discussion above.

Changes in v2:
* Added Patches 3 and 4 to deal with the failure on SEV-SNP
  [Tom Lendacky]
* Split the main change into two separate patches (Patch 5 and
  Patch 6) to improve reviewability and to offer the option of
  retaining both hypervisor callbacks.
* Patch 5 moves set_memory_p() out of an #ifdef CONFIG_X86_64
  so that the code builds correctly for 32-bit, even though it
  is never executed for 32-bit [reported by kernel test robot]

[1] https://lore.kernel.org/lkml/20231121212016.1154303-1-mhklinux@outlook.com/

Michael Kelley (3):
  x86/hyperv: Use slow_virt_to_phys() in page transition hypervisor
    callback
  x86/mm: Regularize set_memory_p() parameters and make non-static
  x86/hyperv: Make encrypted/decrypted changes safe for
    load_unaligned_zeropad()

 arch/x86/hyperv/ivm.c             | 58 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/set_memory.h |  1 +
 arch/x86/mm/pat/set_memory.c      | 25 +++++++------
 3 files changed, 70 insertions(+), 14 deletions(-)

-- 
2.25.1


