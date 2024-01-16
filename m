Return-Path: <linux-hyperv+bounces-1436-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807CB82E7DF
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 03:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5051C2276E
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551B917EF;
	Tue, 16 Jan 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGx6EA+Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D710FA;
	Tue, 16 Jan 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cd51c0e8ebso4534947a12.3;
        Mon, 15 Jan 2024 18:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705371629; x=1705976429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f7Z1mtPltzcSBEq804G8TTNx6jfdkFZ1S3I87AVOGno=;
        b=lGx6EA+QvkC4z8t/Wq0IhYU6tOEGZoHK9G0Pnm8E5cZiqEsUUNwvyrd7q86JliSwFS
         3KSFZv5KhWsVCpcP/O3aMA4WILGmLBEqyBkmspumM5e8A+Mj03pUFH76D6YBYR4uXYKs
         KoxPmyFOQ1tyJ7sbeHgWC7Q3T0SAJvLOM1bRCOTPqVNHELaFQPtmPrdVfXiLKQV2CAm6
         TeRy0c9rew8/Wlyo8hdYBYg+GxH9mHSdHsID7iV7K47VsqeDaIi0W0RTcHxELvB1pfI5
         tbyieN4VoSn4PkUFC8fK/dYzTX/5aSHifOkUHJb/35XjD5EjbKCZA2hYbIaTVH95TtQ2
         Z2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705371629; x=1705976429;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7Z1mtPltzcSBEq804G8TTNx6jfdkFZ1S3I87AVOGno=;
        b=nTkgKFdAAdwjwFTkJ8oLdEV/OvS0wPhdpNrQ+zm+IOLI7fDL3L4EMhvfwi4IVzXTBc
         UAabeW9ucShFSq39atiUTiliNplKbVL7tNefEIT0pIhvZScGMh996ZnRv5o/uc90r5H+
         pIgwlh4TeJl7Gjfq1Wc3t22C7GxITsdctVGeCaXeinzguUHlvfDE7BGk6u26S9k9i6zi
         h5coi5WONqmUyPiKvCGtK0EIsDJ9f2THOyxRefxme1cUs5OtNIw6ixIZlLNgnKdT0HkZ
         t4caFCA8zPJDHV+55MHMPsamcR8RF6Bskf6SJ9LhJU8tNcTlICWJimvbrQqpGm9nbfoM
         0lcg==
X-Gm-Message-State: AOJu0YxwWIkG1aRDImOids/Mkun1O5pwEj7MCOfhTq4rRM0QinVhPqYA
	pzLkJBgSFbAM60IMfCLrsuE=
X-Google-Smtp-Source: AGHT+IFpEHkY0yoYeAhv8uuFIshSZ9ztV2gY9fMSrDRyVFa67Pg8mi4Mlid+vf3l1tJRX6tt5cPILg==
X-Received: by 2002:a05:6a21:9181:b0:19a:d952:e21e with SMTP id tp1-20020a056a21918100b0019ad952e21emr1489772pzb.50.1705371629082;
        Mon, 15 Jan 2024 18:20:29 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001d1d1ef8be5sm8193379plb.173.2024.01.15.18.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 18:20:28 -0800 (PST)
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
Subject: [PATCH v4 0/3] x86/hyperv: Mark CoCo VM pages not present when changing encrypted state
Date: Mon, 15 Jan 2024 18:20:05 -0800
Message-Id: <20240116022008.1023398-1-mhklinux@outlook.com>
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

Changes in v4:
* Patch 1: Updated comment in slow_virt_to_phys() to reduce the
  likelihood of the comment becoming stale.  The new comment
  describes the requirement to work with leaf PTE not present,
  but doesn't directly reference the CoCo hypervisor callbacks.
  [Rick Edgecombe]
* Patch 1: Decomposed a complex line-wrapped statement into
  multiple statements for ease of understanding. No functional
  change compared with v3. [Kirill Shutemov]
* Patch 3: Fixed handling of memory allocation errors. [Rick
  Edgecombe]

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

 arch/x86/hyperv/ivm.c             | 65 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/set_memory.h |  1 +
 arch/x86/mm/pat/set_memory.c      | 24 +++++++-----
 3 files changed, 75 insertions(+), 15 deletions(-)

-- 
2.25.1


