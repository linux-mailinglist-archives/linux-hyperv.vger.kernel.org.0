Return-Path: <linux-hyperv+bounces-9424-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLY/MdXzt2mfXQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9424-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:13:09 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E73299417
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 13:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A9A23004436
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85D13939C6;
	Mon, 16 Mar 2026 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KmMzN+L7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387B1DFF0;
	Mon, 16 Mar 2026 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773663173; cv=none; b=TUwQpPWlmIpA6MT44B7TVjqFRxn6uKWJR6ZTsXcoBfKGQyb0GV5qJ5S0FeWJPTlLuIgVqbRVONpjA5eoGvT0RrfasNVDInSTYpj3pW6nEllr3sfe4ZtP3rN1ukbQwAtF5A7IvxAtINJfC/MYzIgo5ntKoYY9GIJi5CQjbss5kv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773663173; c=relaxed/simple;
	bh=7ttwWgKOyWUOOcxX5hFVjj6/N1JzTZZH4T3vIM815XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBiyrofO+83/ashBaOXSEbZxKURbP1kB0KxtomEDxe2h6HC1Uu+3fSHhLFVN1qmJjaTDh6wzYIcl4gpQU4GrO7bf0qX/YsY+quk68WvB2ivhFd4MbUD2Nveuv3cxXKgCoPy6fA4vTeqyO1DvX6teLNN6QCdfzeqKdWfEkXsJybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KmMzN+L7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3BAAB20B710C;
	Mon, 16 Mar 2026 05:12:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BAAB20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773663171;
	bh=6E+dKhZEiGUG0B2R4F9V5NwBD3IvG5yQHAXHWZtspsE=;
	h=From:To:Cc:Subject:Date:From;
	b=KmMzN+L72LBHYNUzHaLuEqLmYUZbFE86Ghb9lbKG5LUyRumq1Pfq+2svrA0+xYFZO
	 icrvijbYw47VQDkU6veDLhVKqlnse8g07r2eqLanFYIkoRzULa0MthPoLVSiv4VasW
	 5uFwpbJrFIVM1RNuHNLwoLRVAHOnsvo3dZAS4584=
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Marc Zyngier <maz@kernel.org>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	ssengar@linux.microsoft.com,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 00/11] Drivers: hv: Add ARM64 support in mshv_vtl
Date: Mon, 16 Mar 2026 12:12:30 +0000
Message-ID: <20260316121241.910764-1-namjain@linux.microsoft.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linux.microsoft.com,outlook.com,vger.kernel.org,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9424-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: E3E73299417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The series intends to add support for ARM64 to mshv_vtl driver.
For this, common Hyper-V code is refactored, necessary support is added,
mshv_vtl_main.c is refactored and then finally support is added in
Kconfig.

Based on commit 1f318b96cc84 ("Linux 7.0-rc3")

Naman Jain (11):
  arch: arm64: Export arch_smp_send_reschedule for mshv_vtl module
  Drivers: hv: Move hv_vp_assist_page to common files
  Drivers: hv: Add support to setup percpu vmbus handler
  Drivers: hv: Refactor mshv_vtl for ARM64 support to be added
  drivers: hv: Export vmbus_interrupt for mshv_vtl module
  Drivers: hv: Make sint vector architecture neutral in MSHV_VTL
  arch: arm64: Add support for mshv_vtl_return_call
  Drivers: hv: mshv_vtl: Move register page config to arch-specific
    files
  Drivers: hv: mshv_vtl: Let userspace do VSM configuration
  Drivers: hv: Add support for arm64 in MSHV_VTL
  Drivers: hv: Kconfig: Add ARM64 support for MSHV_VTL

 arch/arm64/hyperv/Makefile        |   1 +
 arch/arm64/hyperv/hv_vtl.c        | 152 ++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c      |  13 ++
 arch/arm64/include/asm/mshyperv.h |  28 ++++
 arch/arm64/kernel/smp.c           |   1 +
 arch/x86/hyperv/hv_init.c         |  88 +------------
 arch/x86/hyperv/hv_vtl.c          | 130 +++++++++++++++++++
 arch/x86/include/asm/mshyperv.h   |   8 +-
 drivers/hv/Kconfig                |   2 +-
 drivers/hv/hv_common.c            |  99 +++++++++++++++
 drivers/hv/mshv.h                 |   8 --
 drivers/hv/mshv_vtl_main.c        | 205 ++++--------------------------
 drivers/hv/vmbus_drv.c            |   8 +-
 include/asm-generic/mshyperv.h    |  49 +++++++
 include/hyperv/hvgdk_mini.h       |   2 +
 15 files changed, 505 insertions(+), 289 deletions(-)
 create mode 100644 arch/arm64/hyperv/hv_vtl.c


base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
prerequisite-patch-id: 24022ec1fb63bc20de8114eedf03c81bb1086e0e
prerequisite-patch-id: 801f2588d5c6db4ceb9a6705a09e4649fab411b1
prerequisite-patch-id: 581c834aa268f0c54120c6efbc1393fbd9893f49
prerequisite-patch-id: b0b153807bab40860502c52e4a59297258ade0db
prerequisite-patch-id: 2bff6accea80e7976c58d80d847cd33f260a3cb9
prerequisite-patch-id: 296ffbc4f119a5b249bc9c840f84129f5c151139
prerequisite-patch-id: 3b54d121145e743ac5184518df33a1812280ec96
prerequisite-patch-id: 06fc5b37b23ee3f91a2c8c9b9c126fde290834f2
prerequisite-patch-id: 6e8afed988309b03485f5538815ea29c8fa5b0a9
prerequisite-patch-id: 4f1fb1b7e9cfa8a3b1c02fafecdbb432b74ee367
prerequisite-patch-id: 49944347e0b2d93e72911a153979c567ebb7e66b
prerequisite-patch-id: 6dec75498eeae6365d15ac12b5d0a3bd32e9f91c
-- 
2.43.0


