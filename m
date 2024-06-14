Return-Path: <linux-hyperv+bounces-2416-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E1D9088E8
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 12:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75ED291D96
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5351946B9;
	Fri, 14 Jun 2024 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGckCWdP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A1192B91;
	Fri, 14 Jun 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359159; cv=none; b=RyCCjUPhxTtI/ZldebliK2LyJbCZmOD5bwX07k1KVoIooOjbP8V2SuFAKWAcd/5OR7MyaC9WdRufwzQfwMkswIsRp83S1F0q924/IdTaPpKh7E4nwC9HpvCMm+7xz9pWaP7hmcJmq/lKvYUraifWTPLTCq3cUWzSMwG05Lu3fYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359159; c=relaxed/simple;
	bh=+geMXDmdsxY3QYfKxlpxd6Ea9icre7mi5WZps0TSdvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pjqen8bmpBNieVJFFneZ/TNZMuEnW+Z+N6YOM2RFIFdcJSFpWSkrffPJE40jaSkM1WVV1jGriqPQewytQEzRN5Ou91wwu8mO6c32irB7rK8Tir5+z+uVvpCsrwEXp7L22tkuF2qi9L+R1ApB2GKkerp7gIyevYiw+MLWWnVTsp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGckCWdP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359158; x=1749895158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+geMXDmdsxY3QYfKxlpxd6Ea9icre7mi5WZps0TSdvs=;
  b=NGckCWdPhK6PtCzg6vNIULovTSQVyutyRB2yAuaFDjE3fvgHRvSf8VSa
   srDeaplxUcfVEBcMWV+tvEMlQ6uSJv116bmUkY6Ck6KFVHr/Jic1W8lCR
   3NFGnZhXsM3Nvq99k7SezN9j3dMhP47epYBZEfVMotoNxhWam3IwTXXbM
   w5H8YgWk0A1/oa+JEeJrC4c7kf1QJO8hhmV40h9e7C6Mbn65yxBS1fBZB
   RRII3JN38BQvS6r0PWEtjxy8HtomMqqsN477gA5CsN4xoNqgMgnE8mHKk
   vIYdMWjJ24Mn335SExOCizpXCuMTbvYXkEO4qkNkddO9aqiNL4ekDRQy+
   g==;
X-CSE-ConnectionGUID: nqrYDMzXScOh8+/fNbP4Cw==
X-CSE-MsgGUID: XArBg/4QQ1GX/KtaJ1qWSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15466649"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15466649"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:59:15 -0700
X-CSE-ConnectionGUID: ETqWasRuS7C7WSAgu/6PSg==
X-CSE-MsgGUID: 34eKCLNORKqKc+x+Gz5hXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="77929995"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 14 Jun 2024 02:59:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8AE992764; Fri, 14 Jun 2024 12:59:08 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv12 02/19] x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
Date: Fri, 14 Jun 2024 12:58:47 +0300
Message-ID: <20240614095904.1345461-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_mp_wake_mailbox_paddr and acpi_mp_wake_mailbox initialized once
during ACPI MADT init and never changed.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 7f164d38bd0b..cf79ea6f3007 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -6,10 +6,10 @@
 #include <asm/processor.h>
 
 /* Physical address of the Multiprocessor Wakeup Structure mailbox */
-static u64 acpi_mp_wake_mailbox_paddr;
+static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
 
 /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
 
 static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
-- 
2.43.0


