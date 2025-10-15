Return-Path: <linux-hyperv+bounces-7218-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A09BDC0D1
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Oct 2025 03:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C21D83569C8
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Oct 2025 01:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813052FBE00;
	Wed, 15 Oct 2025 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mzpMDwdO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E672FF174;
	Wed, 15 Oct 2025 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493029; cv=none; b=GsS0USbgER0+3rX0Y2gjMrT+uPgsnTBcuvH4HINwz+lKyS0x/kxMsES8n0TyCui4yj9pHAiVMBmjKJZsLsm6QQuFWRgkjQK8d+TfDtfY+0K4Js7q7Pyc7D8BKhwtyOWnfRXRm1OVQVHgTHo1bERk9x0CIjD7D/n1UHvPOKAGIOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493029; c=relaxed/simple;
	bh=VctG1DOpvekujaJCcbS4UM3FlSZNBEgyayPZ48U4Pbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aiRi3i8eriDa7R8TVuMtmuEqwVNzhbeqrQSZ/7cZGlmGK2wPZFPXyG6Zf2iWdfhxbYmZ54elO5SZB1F+LouQSgeLRCgPsGE2bb7oPDkn+bs9xvN3G3KVjsMkljk/I6TqDSpvlutxRcr1+i97cxPxGjleSv6JfwfbBEo5JlcwnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mzpMDwdO; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760493023; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GBOWHzpLqdiqANdVhAP/vDnqO40E3jmyK6pHau4P2Z8=;
	b=mzpMDwdOsvjl0jOr4/rAS8c1Wzhj6ZeM8MWXIyQQHG1jn7J8iUIacBY3JuxcZPluCIpd/b8+F9WG/iIhYtctuz75QTZa9cDTC4iLv9m6JMxmTHBuF88+udF5fvc58wvDxcXN79DQyu3LmpCSb4HuC4Gd4coCrTNobeVXuYlQ9U8=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WqEHRNj_1760493017 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 09:50:22 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: kys@microsoft.com
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] arch/x86: mshyperv: Remove duplicate asm/msr.h header
Date: Wed, 15 Oct 2025 09:50:14 +0800
Message-ID: <20251015015014.3636204-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./arch/x86/kernel/cpu/mshyperv.c: asm/msr.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26164
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 80a641a6ac48..6802d89ca790 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -31,7 +31,6 @@
 #include <asm/msr.h>
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
-#include <asm/msr.h>
 #include <asm/numa.h>
 #include <asm/svm.h>
 
-- 
2.43.5


