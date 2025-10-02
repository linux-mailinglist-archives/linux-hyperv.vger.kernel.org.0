Return-Path: <linux-hyperv+bounces-7063-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B3BBB5885
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Oct 2025 00:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23E344E1D19
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64349255F28;
	Thu,  2 Oct 2025 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TiBvKpiF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4122248B8;
	Thu,  2 Oct 2025 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443237; cv=none; b=kLi34XqzhzTKpmQj//NeVSQORQfC5G0M95+uL47iILPyM+rR82DXCTzV0P/cqyQnpNLGDDiPU0AP0cgOPy1U+owUXtnNodmqlW6qvU29wLDKGJ01tiPeKqVacz1Fz0CbHtRE0rKNHDfx15AMkLv8Ec1TuYRAQWE6bZl/LeBoSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443237; c=relaxed/simple;
	bh=cNyZfaHRAtBiM6ChyARK8j7JXWckFx2ubOClF1GslBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=re5fLUhTAbQFG6O6cGdFqii77xnIRNIBZA2vUe6MfTsbaMH7qj0o9lqeq/1HlWsUhfZytRch71b1nvduHIALHrMnMU0GaiHYAWs9IJmQ11X03zcc4npZi+yG3xqt247qyEp1hypGo53kThVFhjhcoDRICEJc4jC30i90gfwPR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TiBvKpiF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [20.114.54.184])
	by linux.microsoft.com (Postfix) with ESMTPSA id 54919211B7D2;
	Thu,  2 Oct 2025 15:13:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54919211B7D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759443235;
	bh=YDXkBkJeHK2r2pFOu4alh3QcyTEkp7b9JynN1gNUbCM=;
	h=From:To:Cc:Subject:Date:From;
	b=TiBvKpiFgdEUoyul/vgxp4juELp7hq/F4PS8weI9MzC80NgnWS7L5goJNUAvesMbU
	 akO0wtQSSJOEI76IH0TUKT4Ug/9E0DMcdrsPE5BVY/bZgxyXrSmgDI6L/irMuD2tZK
	 X1A7MPSonfckl4aZlVTK0q+pf9FgDVRBB2iCf4j4=
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Subject: [PATCH] Drivers: hv: Use -ETIMEDOUT for HV_STATUS_TIME_OUT instead of -EIO
Date: Thu,  2 Oct 2025 22:13:46 +0000
Message-ID: <20251002221347.402320-1-easwar.hariharan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the -ETIMEDOUT errno value as the correct 1:1 match for the
hypervisor timeout status

Fixes: 3817854ba89201 ("hyperv: Log hypercall status codes as strings")
Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
 drivers/hv/hv_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 49898d10fafff..9b51b67d54cc8 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -781,7 +781,7 @@ static const struct hv_status_info hv_status_infos[] = {
 	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EIO),
 	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EIO),
 	_STATUS_INFO(HV_STATUS_OPERATION_FAILED,		-EIO),
-	_STATUS_INFO(HV_STATUS_TIME_OUT,			-EIO),
+	_STATUS_INFO(HV_STATUS_TIME_OUT,			-ETIMEDOUT),
 	_STATUS_INFO(HV_STATUS_CALL_PENDING,			-EIO),
 	_STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,		-EIO),
 #undef _STATUS_INFO
-- 
2.43.0


