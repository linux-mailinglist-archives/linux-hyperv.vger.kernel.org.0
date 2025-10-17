Return-Path: <linux-hyperv+bounces-7256-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68842BEBE01
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 23:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2635E16CD
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 21:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004B2E2DD4;
	Fri, 17 Oct 2025 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gf1kCdOI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA572D97B9;
	Fri, 17 Oct 2025 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738311; cv=none; b=uyEw9rATNiIYgEHgwKDlQCbU8cRK0+OnFwNPHGIXfefeatALb30XbcGh0ehdVHejnIru+XHzY3ET00pJLiUOrP7+uKz9BCLFyTiSxp1dHYxCv0Cz2gMBDeZFrUNnHfvt9hYjWuQsst92USvPg8K4r2EOkBG+aSVgChnQTXKjuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738311; c=relaxed/simple;
	bh=haJvKve6BaJY+bsjN3+KJCpLmZ68RIK1Ud7VhoQz9Pc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HP2wZcbmuMzhCC0wMZYsFBTfXKfc6qg10p3gheg5mRZqLYM/laoudqk9cS8VpgeIkWG85iMoAK2QY5CVJvBT1NaEpBSWnIcBoO1rBK2Z11sNFZ+zMtGzLprp3/RPV81dTMAn4tmzCIzOwaclFwTFq60ExQno3s3TqZh5dV+QF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gf1kCdOI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 0394A2017275; Fri, 17 Oct 2025 14:58:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0394A2017275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760738310;
	bh=SfToauKBlwiwuWfObFCUGjtNlLtxMPKEwMNX5NsqqcU=;
	h=From:To:Cc:Subject:Date:From;
	b=Gf1kCdOIDmEr2p0UjEx0xaPZa/FAcJq1LoVMoENBeEwc8bz5scnMpUrTwPHUdPTK8
	 scS5amCY3kihFwvsnqKv9Ymc02rQnwhqlM4BcjtY6npDnHatfWTuiOm7AmspfN32yu
	 3YzDKVVKq80uDtEQsXoATuAHTDhUDFb8J3GvO2c8=
From: longli@linux.microsoft.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH] Hyper-V: add myself as maintainer
Date: Fri, 17 Oct 2025 14:58:14 -0700
Message-Id: <1760738294-32142-1-git-send-email-longli@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Also include MANA RDMA driver in the Hyper-V maintained list.

Signed-off-by: Long Li <longli@microsoft.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8a770714101..6912af480f9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11399,6 +11399,7 @@ M:	"K. Y. Srinivasan" <kys@microsoft.com>
 M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Wei Liu <wei.liu@kernel.org>
 M:	Dexuan Cui <decui@microsoft.com>
+M:	Long Li <longli@microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
@@ -11416,6 +11417,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
 F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
+F:	drivers/infiniband/hw/mana/
 F:	drivers/input/serio/hyperv-keyboard.c
 F:	drivers/iommu/hyperv-iommu.c
 F:	drivers/net/ethernet/microsoft/
@@ -11435,6 +11437,7 @@ F:	include/hyperv/hvhdk_mini.h
 F:	include/linux/hyperv.h
 F:	include/net/mana
 F:	include/uapi/linux/hyperv.h
+F:	include/uapi/rdma/mana-abi.h
 F:	net/vmw_vsock/hyperv_transport.c
 F:	tools/hv/
 
-- 
2.34.1


