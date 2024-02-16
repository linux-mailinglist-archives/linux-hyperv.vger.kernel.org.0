Return-Path: <linux-hyperv+bounces-1547-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F9B857ED3
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Feb 2024 15:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9BE1F219E7
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Feb 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E3C12C808;
	Fri, 16 Feb 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FOAOy004"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7127012C804;
	Fri, 16 Feb 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092614; cv=none; b=nNukKsAAS6TGUCmBVy8iu/iJxCLeM+Yn7J92uinhKe+fCvepyLlR1efuYgHaXXbcAkApxIa6BYfbf21QGdgn+ljluM8TyhY57F3j21N+h7zzLk6qKrLriPDoi563hhOcjooddIjgNBFAMG9pZ0BDNfxZylT56eigBcjGR1rvTGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092614; c=relaxed/simple;
	bh=AXKxcLqkqUbREUhKhjXJPqaX/qrI1VmYgEN0lW7ndqY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=S1VVTua2myDUyxTE4ZC3RUQ5riR2H8ZdfPe9sZ3aSJQrpzY4Pp5pRo4l4BmJIgfeYbItZ4YiMfLXV42eYFZ1L47Dd5d+pyJFqJsCbWNQyV5+/7vFG9YtDK+OmYV3WP1Ao+U39w6bDki2QZz8FKDnLjPjG6ZdrtP63bfQi2aqync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FOAOy004; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 78FF6207FD20;
	Fri, 16 Feb 2024 06:10:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 78FF6207FD20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708092607;
	bh=6rsdWrOQEu5DA9icbqeKHZVhT7pOiFjvnQjJDFTZo0Q=;
	h=From:To:Cc:Subject:Date:From;
	b=FOAOy004sRjynlkJXyFzMeBRzs8ykw3cFaOgzn/JpyDWVFtd7KK4Ah+Pp5d2Zt3yo
	 1MLKJ5lj6kKVIMQPVBkN0CqaGCSGxs6OfhUN0J516difF6/OXtPuhNysIzjSEtoo84
	 iUJb43BnlYXakK0KX2yNR6b34M/+oH3nBjaqyRuw=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH] Drivers: hv: Kconfig: select CPUMASK_OFFSTACK for Hyper-V
Date: Fri, 16 Feb 2024 06:10:03 -0800
Message-Id: <1708092603-14504-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

CPUMASK_OFFSTACK must be set to have NR_CPUS_RANGE_END value greater than
512, which eventually allows NR_CPUS > 512.

CPUMASK_OFFSTACK can also be enabled by setting MAXSMP=y, but that will
set NR_CPUS=8192. This is not accurate for Hyper-V, because maximum number
of vCPU supported by Hyper-V today is 2048. Thus, enabling MAXSMP increase
the vmlinux size unnecessary.

This option allows NR_CPUS=2048 which saves around 1MB of vmlinux size for
Hyper-V.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/hv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 0024210..bc3f496 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -9,6 +9,7 @@ config HYPERV
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
+	select CPUMASK_OFFSTACK
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
-- 
1.8.3.1


