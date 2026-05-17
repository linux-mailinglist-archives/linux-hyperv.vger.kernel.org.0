Return-Path: <linux-hyperv+bounces-10997-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BKWJATQCWreqgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-10997-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 16:26:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC331561A0F
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 16:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66254300C037
	for <lists+linux-hyperv@lfdr.de>; Sun, 17 May 2026 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9A3B47F3;
	Sun, 17 May 2026 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="fu9d1BKu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D78E3B840F;
	Sun, 17 May 2026 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027379; cv=none; b=h4I0V3wZ1ipDHAaEGM8mLiDK6CuneXGbyScHYMvZqtgklMBISMQbb33A9gSJYKxhP13AAPM26O+nYZec1UEWML/ukUOqkHY8TaQ0hOndMZuuk5PiLnO0bINs1mEyk0Q9I8P9evUWMW0Zp3MRbZBwdx53tumCb2MppXDXtserxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027379; c=relaxed/simple;
	bh=odM2YlQPz4z+Xbldmx3UAYOUP4AUgiktv9wgjCikjyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEc33JkIlhaJXhC5P+I63lNwbrL6QCmJK438WPNrZax3gaJX9vv4OboJS6vy6grIKVwe8LBkVTHCoEXJ2PH8RtdVqrZZg+bAfuFPcufKWCIlzf3FdtW1hQfOiDJM139nNIqiv3TPVaTCDTzBDOJJzUmv84rFyXF8XFUSs9A7sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=fu9d1BKu; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gTqRY6sQfKZTTJNrPsag8pd2dprTtNMTjuf+gLE+BZk=; b=fu9d1BKuMdBjtrqIvVOiANgRiE
	4QKyasC9whyRqUh2xU0NBLLeXTjYfE9oMuLVYJEeisQ2QOGNx4O/fi+h1NGRXxxm/suDMJONWLoO7
	tCNnqP+D525EUzpXvy7EZxdC/lRIRfHWBVODG/Sq5lUbl/Kc8rWsZSz+qn0laVlhqju0nxqDSXF7/
	9y7oLQM2UCyqI2vUc0+M3Agh5K/l8HTaZX8QhBMPQH5Wrw8nfszmVHjnnbwDnb5TNLOpOlC6HmSpU
	FV/9/t01dRQSW858P2h28v63VdyJf+ui9GPRgboNw+drgUFLwvkMzVdvQ3qiamzZokjzi937lWVnY
	duKN8bog==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wOcHU-00HFWk-1I;
	Sun, 17 May 2026 14:15:49 +0000
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Deepak Rawat <drawat.floss@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/hyperv: validate resolution_count and harden VSP request paths
Date: Sun, 17 May 2026 16:25:01 +0200
Message-ID: <20260517-drm-hyperv-patch1-v2@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-cover-v2@berkoc.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
 <20260517-drm-hyperv-patch1@berkoc.com>
 <20260517134926.B4179C2BCB0@smtp.kernel.org>
 <20260517-drm-hyperv-cover-v2@berkoc.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: git-send-email/2.47.3
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
X-Rspamd-Queue-Id: EC331561A0F
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
	TAGGED_FROM(0.00)[bounces-10997-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,microsoft.com,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[berkoc.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: add header
X-Spam: Yes

The synthetic video device parses a SYNTHVID_RESOLUTION_RESPONSE that
contains a u8 resolution_count and a u8 default_resolution_index. The
existing check rejects resolution_count == 0 and an index greater or
equal to resolution_count, but does not bound resolution_count itself
against the fixed supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT]
array. A host that returns resolution_count > 64 together with an
in-range default_resolution_index causes the subsequent loop to read
past the array. Reject any resolution_count that exceeds the array
bound, folded into the existing zero-check so a single log entry
remains per failure.

When that bounds check (or any later failure in
hyperv_get_supported_resolution()) returns an error, the caller in
hyperv_connect_vsp() previously logged a warning and continued without
populating hv->screen_width_max / hv->screen_height_max / preferred_*.
hyperv_mode_config_init() then set dev->mode_config.max_width and
max_height to 0, which makes drm_internal_framebuffer_create() reject
every userspace framebuffer with -EINVAL. Populate the fields with the
WIN8 defaults that the pre-WIN10 branch already uses so a failed
resolution probe degrades to a usable display instead of disabling it.

The driver also issues three sequential VSP requests (negotiate
version, update VRAM location, get supported resolution) that share a
single hv->wait completion. None of the call sites call
reinit_completion() between requests. If wait_for_completion_timeout()
returns 0 but a delayed response later triggers complete(&hv->wait) in
the receive callback, the next request's wait can consume that stale
completion, return immediately, and parse stale data out of
hv->init_buf. Call reinit_completion() before each send so every
request waits for its own response.

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Signed-off-by: Berkant Koc <me@berkoc.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 051ecc526832..3b5065fe06e4 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -223,6 +223,7 @@ static int hyperv_negotiate_version(struct hv_device *hdev, u32 ver)
 	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
 		sizeof(struct synthvid_version_req);
 	msg->ver_req.version = ver;
+	reinit_completion(&hv->wait);
 	hyperv_sendpacket(hdev, msg);
 
 	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
@@ -257,6 +258,7 @@ int hyperv_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp)
 	msg->vram.user_ctx = vram_pp;
 	msg->vram.vram_gpa = vram_pp;
 	msg->vram.is_vram_gpa_specified = 1;
+	reinit_completion(&hv->wait);
 	hyperv_sendpacket(hdev, msg);
 
 	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
@@ -383,6 +385,7 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 		sizeof(struct synthvid_supported_resolution_req);
 	msg->resolution_req.maximum_resolution_count =
 		SYNTHVID_MAX_RESOLUTION_COUNT;
+	reinit_completion(&hv->wait);
 	hyperv_sendpacket(hdev, msg);
 
 	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
@@ -391,8 +394,11 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
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
 
@@ -506,8 +512,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 
 	if (hyperv_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
 		ret = hyperv_get_supported_resolution(hdev);
-		if (ret)
+		if (ret) {
 			drm_err(dev, "Failed to get supported resolution from host, use default\n");
+			hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
+			hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
+			hv->preferred_width = SYNTHVID_WIDTH_WIN8;
+			hv->preferred_height = SYNTHVID_HEIGHT_WIN8;
+		}
 	} else {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
 		hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
-- 
2.47.3


