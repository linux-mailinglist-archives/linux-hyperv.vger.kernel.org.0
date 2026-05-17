Return-Path: <linux-hyperv+bounces-10993-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QElvFp2/CWrDnwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-10993-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 15:16:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 058995612AF
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 15:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 080263003354
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410A339023B;
	Sun, 17 May 2026 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="Q+E6UdkE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463138F624;
	Sun, 17 May 2026 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779023426; cv=none; b=HagFA0sj+lNvknMpvTLQ514OJbeCOlSkof1TLQkHVITr/7595z0lqU13f3hi2cRVm/l1HMdlybDp5Y6cc1E0+RElWzwYrJNj/e/BhYa1ZbvBUUs6RRPwCJ9fuCAUtBDW6Dbt4fnnoztNsznHErUAnpMAxKDL8Uvyy5JjEQaav0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779023426; c=relaxed/simple;
	bh=Hm3+jVB2i5Cuf6wmXYLzbvYaURitRGuvFWyb08qrdrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZD1MAgBw4VWAXGH+zMJRKHD3W8Ge/m+htqwCqbBLBpO3j5cKZskxe/W9YSNDZbqSFXOsp96YviepMCufrYPZeSJdKxSTqDlX+nutuMipZz0ePvbDufIObtV6NGLrJzrxWa2BIoQF3ytJRrem3IrhJd0Q9JiCklp+Y8f38fhDGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=Q+E6UdkE; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ldPh9qqiOD6rik1ZyLFqBmBS78przHDh7LwDDhS9xzE=; b=Q+E6UdkEgUfoxzVvgwhf9sA33q
	CaVb7rGxa3G6GrIS5gk5cEPVeqeKdgwsfa3jMOhIkhBIn7Zg++AMXQl11Si/qXmadDPBODzQ5MpDp
	iOuC1ao4ERvsl8wJ9JBwHUvDPAFlEcU2Znzj/Vl0KSIrlTgqH2Yn1m7xJsLJkwOrCO7qJ19JFrtmo
	HGW+dKB2f8YRvWneUDIaExbUs3g+bgZKGY5RPoX110E6t7nbYm8sHnHm9mFjAy5faMpppDI6zAqfV
	MNQ2zof2ZsjqHp8TMxzpnvsTnppgW3SRFGbIP0nYwJtOImZbhuWk9V88pReOiKmk8gWHafrjBHgyv
	G4L4keQg==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wObG1-00H5Ss-1i;
	Sun, 17 May 2026 13:10:14 +0000
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH 1/2] drm/hyperv: validate resolution_count from host VMBus message
Date: Sun, 17 May 2026 14:55:01 +0200
Message-ID: <20260517-drm-hyperv-patch1@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-cover@berkoc.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
X-Rspamd-Queue-Id: 058995612AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	DMARC_POLICY_REJECT(2.00)[berkoc.com : SPF not aligned (strict),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[berkoc.com:s=1984];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10993-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.925];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[berkoc.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:email,berkoc.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: add header
X-Spam: Yes

The synthetic video device receives a SYNTHVID_RESOLUTION_RESPONSE
containing a u8 resolution_count and a u8 default_resolution_index
from the host. The existing check rejects resolution_count == 0 and
rejects an index that is greater or equal to resolution_count, but
does not bound resolution_count itself against the fixed
supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT] array. A host
that returns resolution_count > 64 together with an in-range
default_resolution_index causes the subsequent loop to read past
the array.

Reject any resolution_count that exceeds SYNTHVID_MAX_RESOLUTION_COUNT,
folded into the existing zero-check for one log entry per failure.
This matches the input-validation pattern used by other VMBus parsers
under drivers/hv/ and trims one host-controlled value from the trusted
path.

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Signed-off-by: Berkant Koc <me@berkoc.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 051ecc526832..003bb118d64c 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -391,8 +391,11 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 		return -ETIMEDOUT;
 	}
 
-	if (msg->resolution_resp.resolution_count == 0) {
-		drm_err(dev, "No supported resolutions\n");
+	if (msg->resolution_resp.resolution_count == 0 ||
+	    msg->resolution_resp.resolution_count >
+	    SYNTHVID_MAX_RESOLUTION_COUNT) {
+		drm_err(dev, "Invalid resolution count: %d\n",
+			msg->resolution_resp.resolution_count);
 		return -ENODEV;
 	}
 
-- 
2.47.3


