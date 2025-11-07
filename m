Return-Path: <linux-hyperv+bounces-7470-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B305C41CD7
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 23:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A38B4E46A4
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 22:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF8F2E03E6;
	Fri,  7 Nov 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ldRtmr8V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C62EBDF0;
	Fri,  7 Nov 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762553832; cv=none; b=jaFL+4JqqNmWunxzv7WpbUZSHGNyxSdmE7HyAFi68lsjepiiAQAdK8mnZyxZr8ifhk265Vzk206jxllOa5EsAo4JBeQtO1VOCiMQQVMK+VC8MHFcOON2a+a6f54jc6pnUkLAZuCHnuWKWoPa/cpR904JGYSofjs8Xzfp/RqGf9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762553832; c=relaxed/simple;
	bh=UNQkSdjzAfLy7V0Ul1SWZkO73Cx03JFj5gVUGBp6Vig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsNFVxbSjm3+Bu9/fQgQUDtaDrr3ANyvSR9rYueL3crGEIuwGtzxaQNGWtdUymrEcK4+a7I7bYlWaGtwvzaIippY0wu4XbccaZPPry01OynUMiJYf688HcrWiNjkYse6l8JGujXZn8iTRisKeooa2+lxmlk7vatDHnUcBN+RLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ldRtmr8V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 689D720314A6;
	Fri,  7 Nov 2025 14:17:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 689D720314A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762553830;
	bh=vuT5qxMTJIwro/wE0kKEkYAYw926ChhRVzHqBGuBObA=;
	h=From:To:Cc:Subject:Date:From;
	b=ldRtmr8Vy/xnjVRjj19MbPOqarFW0EFcEIBaEM3Dt//ks9hF5/bingeyZVZC4N7k8
	 PY3g02Z42rv53pPKKMne6+KpexRYeEuouJqpEF3Ur/LA6n2bnx2DiVqK3oF3poRpkH
	 lyVkjuiT6/MGb9cCTfeh/5ozviv8dH3FfInqLPnw=
From: Praveen K Paladugu <prapal@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Cc: anbelski@linux.microsoft.com,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	skinsburskii@linux.microsoft.com,
	mhklinux@outlook.com
Subject: [PATCH v4 0/3] Add support for clean shutdown with MSHV
Date: Fri,  7 Nov 2025 16:16:46 -0600
Message-ID: <20251107221700.45957-1-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for clean shutdown of the root partition when running on
MSHV Hypervisor.

v4:
 - Adopted machine_ops to order invoking HV_ENTER_SLEEP_STATE as the
   last step in shutdown sequence.
 - This ensures rest of the cleanups are done before powering off
 
v3:
 - Dropped acpi_sleep handlers as they are not used on mshv
 - Applied ordering for hv_reboot_notifier
 - Fixed build issues on i386, arm64 architectures

v2:
  - Addressed review comments from v1.
  - Moved all sleep state handling methods under CONFIG_ACPI stub
  - - This fixes build issues on non-x86 architectures.

Praveen K Paladugu (3):
  hyperv: Add definitions for MSHV sleep state configuration
  hyperv: Use reboot notifier to configure sleep state
  hyperv: Cleanly shutdown root partition with MSHV

 arch/x86/hyperv/hv_init.c       |  9 +++
 arch/x86/include/asm/mshyperv.h |  4 ++
 drivers/hv/mshv_common.c        | 99 +++++++++++++++++++++++++++++++++
 include/hyperv/hvgdk_mini.h     |  4 +-
 include/hyperv/hvhdk_mini.h     | 33 +++++++++++
 5 files changed, 148 insertions(+), 1 deletion(-)

-- 
2.51.0


