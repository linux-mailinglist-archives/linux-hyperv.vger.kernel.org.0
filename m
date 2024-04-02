Return-Path: <linux-hyperv+bounces-1901-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C589573B
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1255B1C228FC
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12D513AA2E;
	Tue,  2 Apr 2024 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L4r7T8rm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A813958B;
	Tue,  2 Apr 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068835; cv=none; b=IVLQW/lwC3rRFBCccXoWimsgJBQGQXVUd124ZogdclQ4vVgYqNt2NNOsxDQwXb3wr5rBImygfNhLAOxPT8KUb9PgrwCJC+pElpvgFZsWpucBr2OXUdw0loWi31cAAXVtBt2O/CNdX5AHG8NN+BF/WYCNEu/G7NYPq2lKkUgP9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068835; c=relaxed/simple;
	bh=1hJbsqhoLnBielyur7kmAgd+m/zUyjW+WQucPoT35FI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sDwH5af8Rj9/yuYB7cYk6OyApWmg+Dib7DA4LAUM8iKvsmumvzObZreHtMw8xdTt1PTrusLr83TBxORhppuVeIMySpa1W5PyUixczeXdup2jqagbSnNeQt7TVgthUcHJ7u4IhK3eBou8iRltJ7/XSisop7FdETaPN/7Nij6hy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L4r7T8rm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1858020E8BDC;
	Tue,  2 Apr 2024 07:40:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1858020E8BDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712068834;
	bh=0DUB2Rr6vStJKVui5qUb+UVcqr9kyUH/Bvk23LcaMYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4r7T8rmdmyf6sHV+mcELv1sGeEjohTE64/mG/b9xla015hLstlbhSV+3nGYWOvdR
	 NFibaKw4Nsz/S6zkHlw+yL7DMKSZWSZQvF8K9Ib6hlVKX7XWHFNV2uvCw5DQtNtupp
	 jsbToVf62PzwwlHJUHkn3zeYlJZFTavttIZy/e9c=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH v2 1/4] x86/hyperv/vtl: Correct parse_smp_cfg assignment
Date: Tue,  2 Apr 2024 07:40:27 -0700
Message-Id: <1712068830-4513-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712068830-4513-1-git-send-email-ssengar@linux.microsoft.com>
References: <1712068830-4513-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

VTL platform uses DeviceTree for fetching SMP configuration, assign
the correct parsing function 'x86_dtb_parse_smp_config' for it to
parse_smp_cfg.

Fixes: c22e19cd2c8a ("x86/hyperv/vtl: Prepare for separate mpparse callbacks")
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 5c7de79423b8..3efd0e03b916 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -34,7 +34,7 @@ void __init hv_vtl_init_platform(void)
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg = x86_init_noop;
-	x86_init.mpparse.parse_smp_cfg = x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
 
 	x86_platform.get_wallclock = get_rtc_noop;
 	x86_platform.set_wallclock = set_rtc_noop;
-- 
2.34.1


