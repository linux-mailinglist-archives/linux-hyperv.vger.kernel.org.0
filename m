Return-Path: <linux-hyperv+bounces-7125-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A20D2BBFBEC
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Oct 2025 01:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258123C0AC1
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385711DF254;
	Mon,  6 Oct 2025 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NPU1eynB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A1D19C553;
	Mon,  6 Oct 2025 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759792106; cv=none; b=q5UstBkLUzLivVjTYnAa7UO4JWpYqD4COGaYRxyQHE3Hun7TChcDT3hqZZPJUNM1ezMdb0zz2wtwHPiuPGKTddvUG1JRzdPh/PiKnNwU5jr+aETsSnfuv0zB1UhYS6GTLX/PM1lQWbtWTg2ZcGUI1Foq1m158y129SFS4HY8PC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759792106; c=relaxed/simple;
	bh=32XhgNuIe6nna7GM6qZXkNekiqn6KBFRtHhBHOSbqYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uu5TOPaCBzkvYSZKGliQowKeIMc+fAAr/HEmijWp3l5F+McLbYbEBaIV2lkXX2QYodE8f4yRvtzWJjDUknGqIr3OqvVxI2ngFSk5i1tblx9EyjvsccaoQzQfE5+PVAgaGpKrdDpiPFvaEHX9de1u+qOVzwJifc9bcfIzzU6W3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NPU1eynB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [20.114.54.184])
	by linux.microsoft.com (Postfix) with ESMTPSA id 276BA211CDF4;
	Mon,  6 Oct 2025 16:08:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 276BA211CDF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759792104;
	bh=IghjqehkXutd1eWf9eHKK42hacxrqmNrwOS6epBUceI=;
	h=From:To:Cc:Subject:Date:From;
	b=NPU1eynBuIFhx7czgy2jWP5/qcAZAvcu7ODTp1JE5oFAGEeFnOLXIUejk5nTu7mCN
	 u7QLJRwlPHC5eLFHCaiBKnWXADhxGELEqpLTeGfmKXjd2YYD6LoMULeXAceVE2X4q9
	 nuOJC9dPSiFfQ3I5whd8bC8tUhJfP2F1/465vyuI=
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Subject: [PATCH v2] Drivers: hv: Use better errno matches for HV_STATUS values
Date: Mon,  6 Oct 2025 23:08:08 +0000
Message-ID: <20251006230821.275642-1-easwar.hariharan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a better mapping of hypervisor status codes to errno values and
disambiguate the catch-all -EIO value. While here, remove the duplicate
INVALID_LP_INDEX and INVALID_REGISTER_VALUES hypervisor status entries.

Fixes: 3817854ba89201 ("hyperv: Log hypercall status codes as strings")
Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
Changes in v2: Change more values, delete duplicated entries
v1: https://lore.kernel.org/all/20251002221347.402320-1-easwar.hariharan@linux.microsoft.com/
---
 drivers/hv/hv_common.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 49898d10fafff..bb32471a53d68 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -758,32 +758,30 @@ static const struct hv_status_info hv_status_infos[] = {
 	_STATUS_INFO(HV_STATUS_SUCCESS,				0),
 	_STATUS_INFO(HV_STATUS_INVALID_HYPERCALL_CODE,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_HYPERCALL_INPUT,		-EINVAL),
-	_STATUS_INFO(HV_STATUS_INVALID_ALIGNMENT,		-EIO),
+	_STATUS_INFO(HV_STATUS_INVALID_ALIGNMENT,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_PARAMETER,		-EINVAL),
-	_STATUS_INFO(HV_STATUS_ACCESS_DENIED,			-EIO),
-	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_STATE,		-EIO),
-	_STATUS_INFO(HV_STATUS_OPERATION_DENIED,		-EIO),
+	_STATUS_INFO(HV_STATUS_ACCESS_DENIED,			-EACCES),
+	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_STATE,		-EINVAL),
+	_STATUS_INFO(HV_STATUS_OPERATION_DENIED,		-EACCES),
 	_STATUS_INFO(HV_STATUS_UNKNOWN_PROPERTY,		-EIO),
-	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
+	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-ERANGE),
 	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
 	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
 	_STATUS_INFO(HV_STATUS_INVALID_PORT_ID,			-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_CONNECTION_ID,		-EINVAL),
-	_STATUS_INFO(HV_STATUS_INSUFFICIENT_BUFFERS,		-EIO),
-	_STATUS_INFO(HV_STATUS_NOT_ACKNOWLEDGED,		-EIO),
-	_STATUS_INFO(HV_STATUS_INVALID_VP_STATE,		-EIO),
+	_STATUS_INFO(HV_STATUS_INSUFFICIENT_BUFFERS,		-ENOBUFS),
+	_STATUS_INFO(HV_STATUS_NOT_ACKNOWLEDGED,		-EBUSY),
+	_STATUS_INFO(HV_STATUS_INVALID_VP_STATE,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_NO_RESOURCES,			-EIO),
 	_STATUS_INFO(HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED,	-EIO),
 	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EINVAL),
-	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EIO),
-	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EIO),
 	_STATUS_INFO(HV_STATUS_OPERATION_FAILED,		-EIO),
-	_STATUS_INFO(HV_STATUS_TIME_OUT,			-EIO),
+	_STATUS_INFO(HV_STATUS_TIME_OUT,			-ETIMEDOUT),
 	_STATUS_INFO(HV_STATUS_CALL_PENDING,			-EIO),
-	_STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,		-EIO),
+	_STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,		-EBUSY),
 #undef _STATUS_INFO
 };
 
-- 
2.43.0


