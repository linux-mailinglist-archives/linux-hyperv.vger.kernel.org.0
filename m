Return-Path: <linux-hyperv+bounces-8744-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DG6Op3khGlf6QMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8744-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:42:37 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2BEF686F
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B116E3018289
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7133033CA;
	Thu,  5 Feb 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UXqTyuwU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3E3002DD;
	Thu,  5 Feb 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316942; cv=none; b=MP0eCNBz/8TEuLW8V3bqtmH+/xr9NfvRBUa20FMKXpr/xqzpvU7GYSfhJfXdnCwJ4dcgO7j9c7YsQvgCpc+Manchdxep5ufVis/6l/gUwbqVaCUO756oApGom5W0iJ43+X0epWn+ayVK0ZJJooai1N4i53TPY/1kCvBkulGrQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316942; c=relaxed/simple;
	bh=u1N6TgAIMcli2GpJfX4YV2R9GlbggYTrvFVM7XAvORs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jH+9+qmQmr8stcqOl63l4mUDHHs1MAUZyGATQjEtHxPU2ObCUNgG9OKnqP+9a4G6jI82SvY8dOl8YbJpeN7g1Iau7XtXxzDc+c63ZRwHPPqVALx9/T+86bQUvwo9pHRzisPdOskLR9Bq9wI3uH4/IOjMT+pC/jQ4cFzizH4bu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UXqTyuwU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id D9E4F20B7168;
	Thu,  5 Feb 2026 10:42:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9E4F20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770316941;
	bh=sGUqEnpiQ78WlOj8vX6irR7sbN4sYuJPAdW4DhyfSY4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UXqTyuwUlU6xGAeqj7IsXX4Tvm16O3Ycl1Be5tbyE36ddrJEYJgkw8qW9biUbCu4H
	 iHizhST9OuW7dc5p6arUtKzpAsHbp1RG3GAJnJjDfjiMkPJ/uvPv/J0Eix7v2tLou9
	 41qZ1cMU409dTIVzMzAOhqxBCTk+YzF3od6kaJDo=
Subject: [PATCH v3 3/4] mshv: Handle insufficient contiguous memory hypervisor
 status
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Feb 2026 18:42:21 +0000
Message-ID: 
 <177031694144.186911.9296387721615544854.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-8744-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 7B2BEF686F
X-Rspamd-Action: no action

The HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY status indicates that the
hypervisor lacks sufficient contiguous memory for its internal allocations.

When this status is encountered, allocate and deposit
HV_MAX_CONTIGUOUS_ALLOCATION_PAGES contiguous pages to the hypervisor.
HV_MAX_CONTIGUOUS_ALLOCATION_PAGES is defined in the hypervisor headers, a
deposit of this size will always satisfy the hypervisor's requirements.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_common.c      |    1 +
 drivers/hv/hv_proc.c        |    4 ++++
 include/hyperv/hvgdk_mini.h |    1 +
 include/hyperv/hvhdk_mini.h |    2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index f1c17fb60dc1..f20596276662 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -793,6 +793,7 @@ static const struct hv_status_info hv_status_infos[] = {
 	_STATUS_INFO(HV_STATUS_UNKNOWN_PROPERTY,		-EIO),
 	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
 	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
+	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
 	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 53622e5886b8..181f6d02bce3 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -118,6 +118,9 @@ int hv_deposit_memory_node(int node, u64 partition_id,
 	switch (hv_result(hv_status)) {
 	case HV_STATUS_INSUFFICIENT_MEMORY:
 		break;
+	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
+		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
+		break;
 	default:
 		hv_status_err(hv_status, "Unexpected!\n");
 		return -ENOMEM;
@@ -130,6 +133,7 @@ bool hv_result_needs_memory(u64 status)
 {
 	switch (hv_result(status)) {
 	case HV_STATUS_INSUFFICIENT_MEMORY:
+	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
 		return true;
 	}
 	return false;
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 30fbbde81c5c..99ea0d03e657 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -38,6 +38,7 @@ struct hv_u128 {
 #define HV_STATUS_INVALID_LP_INDEX		    0x41
 #define HV_STATUS_INVALID_REGISTER_VALUE	    0x50
 #define HV_STATUS_OPERATION_FAILED		    0x71
+#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY    0x75
 #define HV_STATUS_TIME_OUT			    0x78
 #define HV_STATUS_CALL_PENDING			    0x79
 #define HV_STATUS_VTL_ALREADY_ENABLED		    0x86
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index c0300910808b..091c03e26046 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -7,6 +7,8 @@
 
 #include "hvgdk_mini.h"
 
+#define HV_MAX_CONTIGUOUS_ALLOCATION_PAGES	8
+
 /*
  * Doorbell connection_info flags.
  */



