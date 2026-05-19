Return-Path: <linux-hyperv+bounces-11144-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Xu4dA/JzD2obMgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11144-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:06:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C15615AC04F
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EF46303514F
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 20:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829A8400DEB;
	Thu, 21 May 2026 20:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="Q2hQrtm/";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="i4ycK9WD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A43A7822;
	Thu, 21 May 2026 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396977; cv=none; b=DSspuYIxIXI50X6TvEVm82B2fMKOS5pZN8/n6tGT4C+b9nDXjUkIPhTfA+6YdUaYUvKwk8OFq5m0qYelCIARq7O51frHprdwVLv2EMYYT5azwdoH7pIAibMavXAKo842V3Gm0OdXntEEw161x+wgNH5D4qHrm0cwjULvm7YUCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396977; c=relaxed/simple;
	bh=ILuFrIOgTO8y5W1rv5THOEIkmcdLmOdqUeFLjCyS2Xs=;
	h=Message-ID:In-Reply-To:References:From:To:Cc:Date:Subject; b=ODmYeD3efzLNHlDTweg8Eo/i4H2Gej6tkKsJl8EQv88TtCCaWmuZpduRliit7SzbeXaXGXWzfZCMMwOom4IeR0en8efjaB0qOBVupiQdxGqxq+VLN2flakRhKOmc0sdfJmMfskwghWwXl7blcpSaoH6gOr76AyuVGbFya9frUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=Q2hQrtm/; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=i4ycK9WD; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Subject:Date:Cc:To:From:References:In-Reply-To:Message-ID:Sender:
	Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yEgrKS1yuvRt1SapJoA7ktrpyTmlvnKNqxmZJDoUF6o=; b=Q2hQrtm/Yd/XPUQk8cStEXveZK
	kmNwLA64ysvTfH/wbylPTAJ8GVEi7VM56N48DYUfRVjBklZKCNLi4g+fzUtsX7nShaX22itc1dPcT
	uir4jzkrhyUIy5jxAdOD7RPicn/hUqIOxCNaPKgqMwA0ZsWYF301y71US1MQL1ra6O5XJCkBeIxbM
	CAH7NZzMiAjH/TVQtfD0Nh4GttVGJGbocQTshKGWf3nmLoQqdJUx3VvUtpwpB5iZ/kkwmbCCvXEWR
	e2JDPBL/YHXZM1az5Xvt5MH/J6IgmVJlI1kCtKMqGU4jgNkC7/560FUDnIgAvdpR/qX6CopVlx7s5
	wOe7NnlA==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wQAR5-00DeeU-0C;
	Thu, 21 May 2026 20:56:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779396954; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=yEgrKS1yuvRt1SapJoA7ktrpyTmlvnKNqxmZJDoUF6o=;
 b=i4ycK9WD+KWb16+raZso9u4MMcCvs/jsdjN1qG4kxsglffqRfD03u5Cz4RpFBWBOWOAhg
 epPcqmHwxwV6FpeMJEGE4reBDj/pjew8Mlqk/jTLjSEEOIeP3rnw055FJY1eKdFMVOk39XJ
 nOIhyZjyxr6yrrORELMfnAPB+jKEReWOrMv6hCJRHXKrGkbilmH/pGjJFmLFiMSnE6RIbq3
 yWaN/vASXa8T+Vh2aYSpwnwgmQmoiYkEFG1NiAcxKRK0sSsdWDmC5GR4Dwy7jzlgbtq8HRS
 wxuM7l5xVeAnNWePXIK/a3nBwzAs137ML+uLI0kvUj8691Wm79VmmodnMsYA==
Message-ID: <6945b22419c7d404b4954a113de2ac9c900dba93.1779396074.git.me@berkoc.com>
In-Reply-To: <cover.1779396074.git.me@berkoc.com>
References: <cover.1779396074.git.me@berkoc.com>
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, K. Y. Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Date: Tue, 19 May 2026 22:08:17 +0200
Subject: [PATCH v4 1/2] drm/hyperv: validate resolution_count and fix WIN8
 fallback
X-Spam-Score: -0.2 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [6.64 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email,berkoc.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DATE_IN_PAST(1.00)[48];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[berkoc.com:s=me];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_MIXED(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-11144-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[berkoc.com,quarantine];
	R_DKIM_REJECT(0.00)[berkoc.com:s=1984];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[berkoc.com:-,berkoc.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:email,berkoc.com:mid,berkoc.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Queue-Id: C15615AC04F
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

A SYNTHVID_RESOLUTION_RESPONSE with resolution_count > 64 walks past
the supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT] array in the
parse loop. Bound resolution_count against the array size, folded
into the existing zero-check.

When the WIN10 resolution probe fails, the caller in
hyperv_connect_vsp() left hv->screen_*_max / preferred_* unpopulated,
which sets mode_config.max_width / max_height to 0 and makes
drm_internal_framebuffer_create() reject every userspace framebuffer
with -EINVAL. The pre-WIN10 branch had the same gap for
preferred_width / preferred_height. Use a single post-probe fallback
guarded by screen_width_max == 0 so both paths converge on the WIN8
defaults.

Signed-off-by: Berkant Koc <me@berkoc.com>
Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 051ecc526..c3d0ff229 100644
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
 
@@ -508,9 +511,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 		ret = hyperv_get_supported_resolution(hdev);
 		if (ret)
 			drm_err(dev, "Failed to get supported resolution from host, use default\n");
-	} else {
+	}
+
+	if (!hv->screen_width_max) {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
 		hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
+		hv->preferred_width = SYNTHVID_WIDTH_WIN8;
+		hv->preferred_height = SYNTHVID_HEIGHT_WIN8;
 	}
 
 	hv->mmio_megabytes = hdev->channel->offermsg.offer.mmio_megabytes;
-- 
2.47.3


