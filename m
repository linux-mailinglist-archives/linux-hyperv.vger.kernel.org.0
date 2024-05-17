Return-Path: <linux-hyperv+bounces-2157-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A28C87D3
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC7E1C2230A
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B165BAC1;
	Fri, 17 May 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FtCvrHL3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF15B1E9;
	Fri, 17 May 2024 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955597; cv=none; b=gceHemCFQL61eGNNgcoywFSYcA7GDPtAV6CuRMYAr0PM0qjlUpVQEYqT9eCAd5K8McZ6vKUYSaGNQ5dkW38tBzdbc3uWKEowg85t02uxBNPGVDtWlmx1fts4Vq3Dx/Nj0pTo0AOPqWRyJnpXlQUiTCd5lKJqyreXmLcazG++muU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955597; c=relaxed/simple;
	bh=qdA+03KUUXrXT1TuR3oQCBn2z6vx7qFJuNLOGkZcBqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZInZ50UZ9ww6hhHDG0ZqmnRydybz+fPxfPRXAJmVVc9tEmn91c06i7Za+A2ArIJ+5mDDSNdwrt8flidydYAJeWz8JpdLJYO+W2iPPelL8VgFF6BLJQRDyiLqU+lS4l2FyCGmbt4mMnW7Qx/GwNcwtUQhodIM37eI2P8Xvh0MfWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FtCvrHL3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715955595; x=1747491595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qdA+03KUUXrXT1TuR3oQCBn2z6vx7qFJuNLOGkZcBqs=;
  b=FtCvrHL3GQYmxWI0MPCBgfkDxoS3O6ceuAD8wOJdkgG6AlIoKr5/itOf
   NL0FTpe8H0uw4ovB+5SFd4sYAhfIEW0iGJp4QJAaZLH4t+6/hsNb7pcR/
   Pcr7/hcsvn4hnOujDE4Di0rPoV3FWkOuEcXuSWFx9XVJfTgeITJaMU6Tl
   iI5DZFWOg/3c1neOihhYzTETxa4wiwHSSpVU1G5254D+yxgu28hj+DPzi
   3731sz4WfEkZDCfbOglwOTAh4S3Sb/I1PgndZ8C25E+PVD9a8UyjR+TeC
   uUz61FPjiKiD5KEBTZu0DAi8TxhTPmnp8gfE1+W55xvFA3QxraeDOPiT7
   g==;
X-CSE-ConnectionGUID: /Esa/iugTg2Ciqgi6JjTAw==
X-CSE-MsgGUID: nFPruNq6SJ+L4aBwPEG9gQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="22808550"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="22808550"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 07:19:55 -0700
X-CSE-ConnectionGUID: pUPJyHyVRUGTE9+FDhsMig==
X-CSE-MsgGUID: mfRJ+xSfS/+hypUxdYOegA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31944605"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 17 May 2024 07:19:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 83A2319E; Fri, 17 May 2024 17:19:49 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 00/20] x86/tdx: Rewrite TDCALL wrappers
Date: Fri, 17 May 2024 17:19:18 +0300
Message-ID: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sean noticing that the TDCALL wrappers were generating a lot of awful
code.

TDCALL calls are centralized into a few megawrappers that take the
struct tdx_module_args as input. Most of the call sites only use a few
arguments, but they have to zero out unused fields in the structure to
avoid data leaks to the VMM. This leads to the compiler generating
inefficient code: dozens of instructions per call site to clear unused
fields of the structure.

This issue can be avoided by using more targeted wrappers.

After the rewrite code size is cut by ~3K:

add/remove: 7/15 grow/shrink: 1/17 up/down: 212/-3502 (-3290)

Please take a look. I would appreciate any feedback.

Kirill A. Shutemov (20):
  x86/tdx: Introduce tdvmcall_trampoline()
  x86/tdx: Add macros to generate TDVMCALL wrappers
  x86/tdx: Convert port I/O handling to use new TDVMCALL macros
  x86/tdx: Convert HLT handling to use new TDVMCALL_0()
  x86/tdx: Convert MSR read handling to use new TDVMCALL_1()
  x86/tdx: Convert MSR write handling to use new TDVMCALL_0()
  x86/tdx: Convert CPUID handling to use new TDVMCALL_4()
  x86/tdx: Convert MMIO handling to use new TDVMCALL macros
  x86/tdx: Convert MAP_GPA hypercall to use new TDVMCALL macros
  x86/tdx: Convert GET_QUOTE hypercall to use new TDVMCALL macros
  x86/tdx: Rewrite tdx_panic() without __tdx_hypercall()
  x86/tdx: Rewrite tdx_kvm_hypercall() without __tdx_hypercall()
  x86/tdx: Rewrite hv_tdx_hypercall() without __tdx_hypercall()
  x86/tdx: Add macros to generate TDCALL wrappers
  x86/tdx: Convert PAGE_ACCEPT tdcall to use new TDCALL_0() macro
  x86/tdx: Convert VP_INFO tdcall to use new TDCALL_5() macro
  x86/tdx: Convert VM_RD/VM_WR tdcalls to use new TDCALL macros
  x86/tdx: Convert VP_VEINFO_GET tdcall to use new TDCALL_5() macro
  x86/tdx: Convert MR_REPORT tdcall to use new TDCALL_0() macro
  x86/tdx: Remove old TDCALL wrappers

 arch/x86/boot/compressed/tdx.c    |  32 +---
 arch/x86/coco/tdx/tdcall.S        | 145 ++++++++++-----
 arch/x86/coco/tdx/tdx-shared.c    |  26 +--
 arch/x86/coco/tdx/tdx.c           | 298 ++++++++----------------------
 arch/x86/hyperv/ivm.c             |  33 +---
 arch/x86/include/asm/shared/tdx.h | 159 +++++++++++-----
 arch/x86/include/asm/tdx.h        |   2 +
 arch/x86/virt/vmx/tdx/tdxcall.S   |  29 +--
 tools/objtool/noreturns.h         |   2 +-
 9 files changed, 322 insertions(+), 404 deletions(-)

-- 
2.43.0


