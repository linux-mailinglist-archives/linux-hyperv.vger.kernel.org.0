Return-Path: <linux-hyperv+bounces-3773-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2230A1DBE3
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jan 2025 19:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DD53A54DE
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jan 2025 18:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59096186284;
	Mon, 27 Jan 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VRTphsOm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBAD19BBA;
	Mon, 27 Jan 2025 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001408; cv=none; b=qqQW9WcicPGIlKlTyDmqsfHIKlxs6VQmdar8PDfKD55HK+izAij9i0X7Ub2jEsgnT+ehMLFRLdF8mvQQmLY/UGwm7BBHsQAUbcDRsnRSaCTvpc6aBX80HwpRg3zfNht7FSH2TN7613gTacyGIyRUpXOVtN8qDYHv7/80en+NohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001408; c=relaxed/simple;
	bh=4l6OFXCgFhGXGIvJ6mjzpfj9TaidCW2uSZ1Yb2FhpXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=na/NOY0nwmw53LhQnSj7luVsI4nKTmZxIUEaR1LwMJ6QbydV/aKyGYIvNa5Yui2VKh3srj2gVJ9oJeKvl19Jq24hS0/Wj2EkdXRUb0cs4Gpm+aWjMikFdXl2+NnYzBJ1Sh2vNpNmHTo8p/W6XkvervYouYHRNyglEqwMEFjQbt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VRTphsOm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.corp.microsoft.com (unknown [184.146.177.43])
	by linux.microsoft.com (Postfix) with ESMTPSA id CC7C22037160;
	Mon, 27 Jan 2025 10:10:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC7C22037160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738001406;
	bh=OCsOWbNsecDFm9GW9GbNOzJRwIOWFmyqy35e7by3a1k=;
	h=From:To:Cc:Subject:Date:From;
	b=VRTphsOmSsGHdxyZdRtbVPu9MEUaa5KSKYdr9KrFptB5Xd/Nm6qsh855hNH5wvmIp
	 YAtYblVpo4+6EXF9m+YnFWtRLQdA2kP8B9MEre49XnUIbKuNa4bePVDmAPQdkgBGD/
	 OP7lLw341VV5ENhDGsoHT5YeSE5L2DC6i7M0t/J0=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	stable@vger.kernel.org,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/hv: select PCI_HYPERV if PCI is enabled
Date: Mon, 27 Jan 2025 13:09:47 -0500
Message-ID: <20250127180947.123174-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should select PCI_HYPERV here, otherwise it's possible for devices to
not show up as expected, at least not in an orderly manner.

Cc: stable@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/hv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 862c47b191af..6ee75b3f0fa6 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -9,6 +9,7 @@ config HYPERV
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
+	select PCI_HYPERV if PCI
 	help
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
-- 
2.47.1


