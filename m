Return-Path: <linux-hyperv+bounces-10324-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOnfEcMT6mmytQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10324-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:42:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E7345223B
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A123F300406C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5D3ED5B5;
	Thu, 23 Apr 2026 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AGSGwzpn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFFA1D6DB5;
	Thu, 23 Apr 2026 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948139; cv=none; b=Pz5ESn3mvPsP5MDgE7nN6ZdFHOw+eTBsUh0dWHPTJejPwWUeqjv3R52VYAuERZQofzX72Z2OnbwwTL3HtF+PEfVB8n10ZklUrRfFbT5hBWuTa1lqu4IOKUnkrnBpGEvDa9ILHhBbHKMx6g6qnqmTbxEqVKeWtTn1UiHRmDyVS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948139; c=relaxed/simple;
	bh=Vgj24s9696zJBAVdUi9THjoSD0kpubPlii50eml5bcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IQQbbKnfhYC7QnABYMfPsU45AkG5yKeK6S04AFHAw8pcHVyVmvE4QM97XueIgoVHxOTz/Fiz/CZcd2zrz4wBXsQVkqUfUEiItrw7LEsW0J0bjeULszOmu0TiXzCvLlgijqz7mgbQO6qrRHLNjtyWAwR8quf8f1HSEP5MthayDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AGSGwzpn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id B04AF20B7165;
	Thu, 23 Apr 2026 05:42:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B04AF20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948138;
	bh=nTetde5U51KiR0eBV+LXcTB7GkxgrKWa+3floMLhHNY=;
	h=From:To:Cc:Subject:Date:From;
	b=AGSGwzpn5SgYbJuozOHPeZnNYZQ9uldpmU9A4lC05mLwq5usd/PIzxpuo5lFM9Sfq
	 Xipd4Nv8Nh8GqNV4AwN6AnGqg9CPyCH0gsyxjRn+rL9ykb0o2w2fyRDuy3g6JYa3hP
	 95HqlLPXYHJi9PzX/wV6jI4WAvQWWXbN/Eu9+Ec8=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	vdso@mailbox.org,
	ssengar@linux.microsoft.com
Subject: [PATCH v2 00/15] Add arm64 support in MSHV_VTL
Date: Thu, 23 Apr 2026 12:41:50 +0000
Message-ID: <20260423124206.2410879-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10324-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,vger.kernel.org,lists.infradead.org,mailbox.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: F3E7345223B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The series adds support for ARM64 to mshv_vtl driver.
For this, common Hyper-V code is refactored, necessary support is added,
mshv_vtl_main.c is refactored and then finally support is added in
Kconfig.

Changes since v1:
https://lore.kernel.org/all/20260316121241.910764-1-namjain@linux.microsoft.com/

Patch 1: arm64: smp: Export arch_smp_send_reschedule for mshv_vtl module
* Changed prefix in subject (Michael)
* Sashiko - no issues

Patch 2:
* Add #include <linux/io.h> in hv_common.c (Michael)
* Remove ms_hyperv.hints change from non TDX case,
  as it won't matter in failure case (Michael)
* Add ms_hyperv.hints &=
  ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED for TDX
  case, to maintain parity with existing code.
  (Sashiko)
* Handle synic_eventring_tail -ENOMEM issue by
  returning early (Michael|Sashiko)
* Only 4k page is used here, so add dependency on
  PAGE_SIZE_4KB for MSHV_VTL as well in a later
  Kconfig patch (Sashiko|Michael)
* Use HV_HYP_PAGE_SIZE instead of PAGE_SIZE to avoid
  page size mismatch issues (Sashiko)
* s/"vmalloc_to_pfn(*hvp)"/
  "page_to_hvpfn(vmalloc_to_page(*hvp))" in
  hv_common.c (Sashiko|Michael)
* s/GFP_KERNEL/flags in __vmalloc. (Sashiko|Michael)
* Limit code to 80 lines in hv_common_cpu_init (Mukesh R.)
* Move arch based definition of
  HV_VP_ASSIST_PAGE_ADDRESS_SHIFT to
  hvgdk_mini.h (Michael)
* Added a comment about x64 vmalloc_to_pfn(*hvp)) (Michael)
* Move remaining hv_vp_assist_page code from
  arch/x86/include/asm/mshyperv.h to
  include/asm-generic/mshyperv.h (Michael)
* s/HV_SYN_REG_VP_ASSIST_PAGE/HV_MSR_VP_ASSIST_PAGE (Michael)

Patch 3:
* Rework the code and remove these new APIs. Move
  the vmbus_handler global variable and
  hv_setup_vmbus_handler()/hv_remove_vmbus_handler()
  from arch/x86 to drivers/hv/hv_common.c so that
  the same APIs can be used to setup per-cpu vmbus
  handlers as well for arm64. (Michael)

Patch 4:
* Sashiko's comments are generic and outside the
  scope of the refactoring this patch is doing.
  Will take it up separately.

Patch 6:
* Sashiko's comment regarding race condition is false positive.
* Regarding memory leak on cpu offline - online -
  beyond the scope of this series, I will fix it
  separately.

Patch 7:
* Subject s/"arch: arm64:"/"arm64: hyperv:" (Michael)
* Changed commit msg as per Michael's suggestion
* Add kernel_neon_begin(), kernel_neon_end() calls (Sashiko)
* Removed Note prefix from comments (Michael)
* Added compile time check for cpu context to be
  within 1024 bytes of mshv_vtl_run
* Moved the declarations of mshv_vtl_return_call to generic file

Patch 8:
* Split the patch into three patches - number 8-10 (Michael)
* Moved hv_vtl_configure_reg_page declaration to asm-generic header
* Sashiko's other reviews are for existing code,
  I will take them separately

Patch 9: (now patch 11)
No changes required for Sashiko's comments as most
of such controls are intentionally designated to
OpenVMM to keep kernel driver simpler.

Patch 10: (now patch 13)
* Remove hv_setup_percpu_vmbus_handler invocations,
  after redesign in previous patchsets (Michael)
* Simplified mshv_vtl_get_vsm_regs() by moving arch
  specific code (for x86) to hv_vtl -
  mshv_vtl_return_call_init(). This removes arch
  checks in mshv_vtl driver. Add a separate patch
  for this (now patch 12)
* Other Sachiko's reviews are related to existing
  code - can be taken up separately

Patch 11 (now patch 15):
* Only 4k page is supported, so add dependency on
  PAGE_SIZE_4KB for MSHV_VTL (Sashiko|Mihael)
* Remove "Kconfig: " from subject line. (Michael)

New patch 14:
Add a Kconfig dependency on 4K PAGE_SIZE for
MSHV_VTL to manage assumptions in MSHV_VTL driver

Change prefix in subjects as per below naming convention:
mshv_vtl_main changes - "mshv_vtl: "
arch/arm64 Hyper-V changes - "arm64: hyperv: "
arch/x86 Hyper-V changes - "x86/hyperv: "

Add Reviewed-by on already reviewed patches.

Naman Jain (15):
  arm64: smp: Export arch_smp_send_reschedule for mshv_vtl module
  Drivers: hv: Move hv_vp_assist_page to common files
  Drivers: hv: Move vmbus_handler to common code
  mshv_vtl: Refactor the driver for ARM64 support to be added
  Drivers: hv: Export vmbus_interrupt for mshv_vtl module
  mshv_vtl: Make sint vector architecture neutral
  arm64: hyperv: Add support for mshv_vtl_return_call
  Drivers: hv: Move hv_call_(get|set)_vp_registers() declarations
  Drivers: hv: mshv_vtl: Move hv_vtl_configure_reg_page() to x86
  arm64: hyperv: Add hv_vtl_configure_reg_page() stub
  mshv_vtl: Let userspace do VSM configuration
  mshv_vtl: Move VSM code page offset logic to x86 files
  mshv_vtl: Add remaining support for arm64
  Drivers: hv: Add 4K page dependency in MSHV_VTL
  Drivers: hv: Add ARM64 support for MSHV_VTL in Kconfig

 arch/arm64/hyperv/Makefile        |   1 +
 arch/arm64/hyperv/hv_vtl.c        | 165 ++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h |  25 ++++
 arch/arm64/kernel/smp.c           |   1 +
 arch/x86/hyperv/hv_init.c         |  88 +------------
 arch/x86/hyperv/hv_vtl.c          | 149 ++++++++++++++++++++-
 arch/x86/include/asm/mshyperv.h   |  21 +--
 arch/x86/kernel/cpu/mshyperv.c    |  12 --
 drivers/hv/Kconfig                |   7 +-
 drivers/hv/hv_common.c            | 103 ++++++++++++++-
 drivers/hv/mshv.h                 |   8 --
 drivers/hv/mshv_vtl.h             |   3 +
 drivers/hv/mshv_vtl_main.c        | 208 +++---------------------------
 drivers/hv/vmbus_drv.c            |  18 +--
 include/asm-generic/mshyperv.h    |  62 +++++++++
 include/hyperv/hvgdk_mini.h       |   6 +-
 16 files changed, 550 insertions(+), 327 deletions(-)
 create mode 100644 arch/arm64/hyperv/hv_vtl.c

-- 
2.43.0


