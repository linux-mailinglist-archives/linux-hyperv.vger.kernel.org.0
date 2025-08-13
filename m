Return-Path: <linux-hyperv+bounces-6528-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1BEB252EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Aug 2025 20:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E63625B95
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Aug 2025 18:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AE62D542A;
	Wed, 13 Aug 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mWrUALt3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451ED19F424;
	Wed, 13 Aug 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109269; cv=none; b=SieB24VbTJI6lwNQ5gDfcTKTo1Qj/xLAd7jwWe3XBsfeJPsH6EII1IMlJNC5ZkTUMTtGW2cwTyfBzhORxTb5z9m5XupZL8EeKm/Zry0zUGX03pYI7tA3h4R3Gtv6G/VfGLgJBZT6Ovi5DEcLLDQ1cU35Fs5ohV7GxUQXcvmWR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109269; c=relaxed/simple;
	bh=846L2+wRwbpVBV8ISFT9I6Sl5n4RsK9xhcfXRllaVNY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Gpx/3m8U7Bye7Bbp+twN/bV2MPIiD9nU9/EALK8kVRWMGoj1RV04joK7R0vdw1sIQQ9caYqO64PDzJnV4m8FEciZDA6mv8aQyTKAMW7ln3RCwMyPvec1KBnbef3AvO367DU4I+pJDpaYqOgF0UQaXAk0rwEJG1+322d9Ko+c7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mWrUALt3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 7E0DD2015E4F; Wed, 13 Aug 2025 11:21:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E0DD2015E4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755109261;
	bh=u8/iK/QY+uPxZyfY30n8vKflh0t0ibTXJMyJRTsEY+I=;
	h=From:To:Cc:Subject:Date:From;
	b=mWrUALt3bNiCdaUmulEIgz/MtsswXsiv8UCW+JPEAnR8T8y1ag93z4H6HgQhApyKw
	 VqGiwT782SEiZSMYDBFcmjMLER4w18vDXW8/hPof1nkul0yyvKUL37xXja4zY2gZRs
	 eJktdYEcIAG5y3Zrs3zGzDuNzSI7zHnE8jI4D/4c=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH] hyperv: Add missing field to hv_output_map_device_interrupt
Date: Wed, 13 Aug 2025 11:20:57 -0700
Message-Id: <1755109257-6893-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This field is unused, but the correct structure size is needed
when computing the amount of space for the output argument to
reside, so that it does not cross a page boundary.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 include/hyperv/hvhdk_mini.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 42e7876455b5..858f6a3925b3 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -301,6 +301,7 @@ struct hv_input_map_device_interrupt {
 /* HV_OUTPUT_MAP_DEVICE_INTERRUPT */
 struct hv_output_map_device_interrupt {
 	struct hv_interrupt_entry interrupt_entry;
+	u64 ext_status_deprecated[5];
 } __packed;
 
 /* HV_INPUT_UNMAP_DEVICE_INTERRUPT */
-- 
2.34.1


