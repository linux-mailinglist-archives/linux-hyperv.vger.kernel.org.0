Return-Path: <linux-hyperv+bounces-2464-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DCB9115E3
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 00:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371B61C21E3D
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Jun 2024 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFE714038F;
	Thu, 20 Jun 2024 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IbjvhQ6u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3A5142620;
	Thu, 20 Jun 2024 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923852; cv=none; b=FpHzV5jYSdNLeoYOEE0H+NdyWkn2EJZrChePb5JeVTvJchxDlGWpkeGDWevuQidnGBSRh8RJqQx4sauIXbdJkmEtlbdDDZ3KJO7KHzX33s7k5msJl8Y9pEy32qG0PwaUWW70+n9IHmK2PmEcE0UWyNsBr9+oqafKk1TT2v5GkDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923852; c=relaxed/simple;
	bh=VJPOlX00dUt99DcDuBNz1VrZR8IgOs/eoSQILnJR6Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQiiUaq+8iecN9vfPEz3UHORWknW5w1wMKsmE54C7Gkp6WkpZfdri2hZRvZ5lz46O9DDt/9j3vF1zmFHHybBoE3BthKrsJA0EC7PVUPJiiq2/6kGXQb0JBGj8xETsTfq7pSL+6kdJBuoqI2RzCjXWm9jG5GTgYETw+b/F05ZcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IbjvhQ6u; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rachel-ThinkStation-P330-Tiny.corp.microsoft.com (unknown [131.107.1.243])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A03C20B7004;
	Thu, 20 Jun 2024 15:50:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A03C20B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718923844;
	bh=XGeL9cfPxtaNWgoZ4WtQTlGBhjNfZnTxWsx41eKwQBY=;
	h=From:To:Cc:Subject:Date:From;
	b=IbjvhQ6ux/NpadInHkYPdzJkYFqgNIYcY6YEjFXDIJoGoqedQjH4r3OIJsAhjyKqY
	 DLiAbJQkks6NkfjXXbJBFzuBN++0EEIsnwlswedjM8ElniAyDSZP36+E1GaEi5JWN6
	 bvuWJDgebaAEDdfaKwTqZ9PKLnj+lTlwUIeyoxNs=
From: Rachel Menge <rachelmenge@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	chrco@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	Rachel Menge <rachelmenge@linux.microsoft.com>
Subject: [PATCH] Drivers: hv: Remove deprecated hv_fcopy declarations
Date: Thu, 20 Jun 2024 18:50:40 -0400
Message-Id: <20240620225040.700563-1-rachelmenge@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are lingering hv_fcopy declarations which do not have definitions.
The fcopy driver was removed in commit ec314f61e4fc ("Drivers: hv: Remove
fcopy driver").

Therefore, remove the hv_fcopy declarations which are no longer needed
or defined.

Fixes: ec314f61e4fc ("Drivers: hv: Remove fcopy driver")
Signed-off-by: Rachel Menge <rachelmenge@linux.microsoft.com>
---
 drivers/hv/hyperv_vmbus.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 76ac5185a01a..d2856023d53c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -380,12 +380,6 @@ void hv_vss_deinit(void);
 int hv_vss_pre_suspend(void);
 int hv_vss_pre_resume(void);
 void hv_vss_onchannelcallback(void *context);
-
-int hv_fcopy_init(struct hv_util_service *srv);
-void hv_fcopy_deinit(void);
-int hv_fcopy_pre_suspend(void);
-int hv_fcopy_pre_resume(void);
-void hv_fcopy_onchannelcallback(void *context);
 void vmbus_initiate_unload(bool crash);
 
 static inline void hv_poll_channel(struct vmbus_channel *channel,
-- 
2.34.1


