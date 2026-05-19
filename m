Return-Path: <linux-hyperv+bounces-11145-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGd4AfJzD2r4MQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11145-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:06:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D75AC050
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 23:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15F1A302ACF4
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 20:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E015400DEB;
	Thu, 21 May 2026 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="B1OLPmwh";
	dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="d1hyWEgK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7636CDE0;
	Thu, 21 May 2026 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396997; cv=none; b=L7+ra3jy7G+xL1zsm9dXcg3DOGc6As8ioSDewCMv09JxigTpxRai6ciSDCRwFYp8sZD+4j8s+F8LhLXqRCVOcmFmOp7/y/NiKiFuIq2gPaW1G/1HRS2CxAowpvvRNnWKKFzTlCfIwnAHPFTBD/J/3ZcO0/yCxxI/pwn295GNjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396997; c=relaxed/simple;
	bh=P6NHnSBS7A5nCK7EBrwNsszRWgG5h0L9aT882bgvnGI=;
	h=Message-ID:In-Reply-To:References:From:To:Cc:Date:Subject; b=PzStq6m3L50GHIknmywAV/cqP6Xwzo4SWHEkQMJbskk/9dFhpqT1X8rgYhLjeIkHxQgtzWdjm+eaDCisMHTCNK+KFuUU9yxDQeXEK/mQw9rr4orUd9ldo/cwwxKz8pKSnaDO7z77UiO/aeAXh4CBeo9vkudESpH+xeZcih1YLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=B1OLPmwh; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=d1hyWEgK; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Subject:Date:Cc:To:From:References:In-Reply-To:Message-ID:Sender:
	Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IwxizOZe2KuLhYlTxGDJy2jH2w3o7dBZIW4lsDZsoTg=; b=B1OLPmwhXKjq85FtxUHJcdH6Vf
	EW9dQqZkqhW1+QbS3DF5HdUEeNSKr6kyp+xTMRhD8/D125gA8SOy36A9x2i7Anfhi40dF7G9/x8gV
	8pXITHzjRyb8kO3iY4xzV1SNykVYk4oO732p2B9EJNRc8sPxgXSY7Kr78NrdGD2577fFzmYl47FeH
	LJ9nXOgTkdoaKu/lpatf4j8J3hI4+uoLBHrSkPKg2HEzUdnEXYjDKxgaX2q+xJABdBdswmtz4IQah
	7mK877oq+N196m6Mu1hUgGb3ZY+dBaHFR5cD24KgrD0nd9qnOSfri2EzymWeDlKlOFGM01YCxCNiI
	Ei3IBcvg==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wQART-00DejJ-0h;
	Thu, 21 May 2026 20:56:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=berkoc.com;
 i=@berkoc.com; q=dns/txt; s=me; t=1779396980; h=message-id : date :
 subject : cc : to : from : sender : reply-to;
 bh=IwxizOZe2KuLhYlTxGDJy2jH2w3o7dBZIW4lsDZsoTg=;
 b=d1hyWEgKkxROdKjkzMI4lbAsEGVG4crHSbzmk/coBsotlt5JWglMQ6viwp/71/S3IN/t0
 H1Cv7l1jJPVVLxArwN0/Yi4Ov7oiTeralv8jYOf99I9H9XnivsycSabFq3Nd03lzaLk+AJ2
 Z2HOwWu027Cj/yF/gRx8TxFkrtzEcwEDyx5ibAlYeQWkx4A0nfKHlcfbZVH0WHQnfKZ32Pl
 5I+PLnlWia7soGG2KnQuu19X+JlB/dYxxda4mZWSBFpkocPLWi21s3DzSrk/Y7TRuaaJDAH
 gNOzraUKUK0c0+6qtEZ7p7k6W2BjJhP0OhsKaJePBg/HfY9Ew2FFJyhg+knA==
Message-ID: <6e5d1d57a3afc4c5ea0d2a3d62be58c90741a869.1779396074.git.me@berkoc.com>
In-Reply-To: <cover.1779396074.git.me@berkoc.com>
References: <cover.1779396074.git.me@berkoc.com>
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, K. Y. Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Date: Tue, 19 May 2026 22:08:53 +0200
Subject: [PATCH v4 2/2] drm/hyperv: validate VMBus packet size in receive
 callback
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
	TAGGED_FROM(0.00)[bounces-11145-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[berkoc.com,quarantine];
	R_DKIM_REJECT(0.00)[berkoc.com:s=1984];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[berkoc.com:-,berkoc.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:email,berkoc.com:mid,berkoc.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C35D75AC050
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

hyperv_receive_sub() reads msg->vid_hdr.type and dispatches into one
of four message-type branches without knowing how many bytes the host
wrote into hv->recv_buf. The completion path then runs
memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE), so the consumer that
wakes on wait_for_completion_timeout() can read up to 16 KiB of
residue from a prior message as if it were the response payload.

Pass bytes_recvd into hyperv_receive_sub() and reject any packet that
does not cover the pipe + synthvid header. For the three
completion-driving types (SYNTHVID_VERSION_RESPONSE,
SYNTHVID_RESOLUTION_RESPONSE, SYNTHVID_VRAM_LOCATION_ACK) require the
type-specific payload before memcpy/complete, and apply the same rule
to SYNTHVID_FEATURE_CHANGE before reading is_dirt_needed.

SYNTHVID_RESOLUTION_RESPONSE is variable length: the host fills
resolution_count entries, not the full SYNTHVID_MAX_RESOLUTION_COUNT
array. Validate the fixed prefix first so resolution_count can be
read, bound it against the array, then require only the count-sized
array, so the shorter responses the host actually sends are accepted.

Only run the sub-handler when vmbus_recvpacket() returned success. The
memcpy length is bytes_recvd, which is bounded by VMBUS_MAX_PACKET_SIZE
only on a successful receive; on -ENOBUFS vmbus_recvpacket() instead
reports the required length, which can exceed hv->recv_buf, so copying
bytes_recvd would read and write past the 16 KiB buffers. Gating on the
success return keeps the copy bounded.

Rejected packets are reported via drm_err_ratelimited() rather than
silently dropped, matching the CoCo-hardened pattern in
hv_kvp_onchannelcallback().

Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Signed-off-by: Berkant Koc <me@berkoc.com>
Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 63 +++++++++++++++++++++--
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index c3d0ff229..48054b607 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -420,26 +420,81 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 	return 0;
 }
 
-static void hyperv_receive_sub(struct hv_device *hdev)
+static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
 {
 	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg *msg;
+	size_t hdr_size;
 
 	if (!hv)
 		return;
 
+	hdr_size = sizeof(struct pipe_msg_hdr) +
+		   sizeof(struct synthvid_msg_hdr);
+	if (bytes_recvd < hdr_size) {
+		drm_err_ratelimited(&hv->dev,
+				    "synthvid packet too small for header: %u\n",
+				    bytes_recvd);
+		return;
+	}
+
 	msg = (struct synthvid_msg *)hv->recv_buf;
 
 	/* Complete the wait event */
 	if (msg->vid_hdr.type == SYNTHVID_VERSION_RESPONSE ||
 	    msg->vid_hdr.type == SYNTHVID_RESOLUTION_RESPONSE ||
 	    msg->vid_hdr.type == SYNTHVID_VRAM_LOCATION_ACK) {
-		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
+		size_t need = hdr_size;
+
+		switch (msg->vid_hdr.type) {
+		case SYNTHVID_VERSION_RESPONSE:
+			need += sizeof(struct synthvid_version_resp);
+			break;
+		case SYNTHVID_RESOLUTION_RESPONSE:
+			/*
+			 * The resolution response is variable length: the host
+			 * fills resolution_count entries, not the full
+			 * SYNTHVID_MAX_RESOLUTION_COUNT array. Require the fixed
+			 * prefix first so resolution_count can be read, then
+			 * demand exactly the count-sized array.
+			 */
+			need += offsetof(struct synthvid_supported_resolution_resp,
+					 supported_resolution);
+			if (bytes_recvd < need)
+				break;
+			if (msg->resolution_resp.resolution_count >
+			    SYNTHVID_MAX_RESOLUTION_COUNT) {
+				drm_err_ratelimited(&hv->dev,
+						    "synthvid resolution count too large: %u\n",
+						    msg->resolution_resp.resolution_count);
+				return;
+			}
+			need += msg->resolution_resp.resolution_count *
+				sizeof(struct hvd_screen_info);
+			break;
+		case SYNTHVID_VRAM_LOCATION_ACK:
+			need += sizeof(struct synthvid_vram_location_ack);
+			break;
+		}
+		if (bytes_recvd < need) {
+			drm_err_ratelimited(&hv->dev,
+					    "synthvid packet too small for type %u: %u < %zu\n",
+					    msg->vid_hdr.type, bytes_recvd, need);
+			return;
+		}
+		memcpy(hv->init_buf, msg, bytes_recvd);
 		complete(&hv->wait);
 		return;
 	}
 
 	if (msg->vid_hdr.type == SYNTHVID_FEATURE_CHANGE) {
+		if (bytes_recvd < hdr_size +
+		    sizeof(struct synthvid_feature_change)) {
+			drm_err_ratelimited(&hv->dev,
+					    "synthvid feature change packet too small: %u\n",
+					    bytes_recvd);
+			return;
+		}
 		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
 		if (hv->dirt_needed)
 			hyperv_hide_hw_ptr(hv->hdev);
@@ -464,9 +519,9 @@ static void hyperv_receive(void *ctx)
 		ret = vmbus_recvpacket(hdev->channel, recv_buf,
 				       VMBUS_MAX_PACKET_SIZE,
 				       &bytes_recvd, &req_id);
-		if (bytes_recvd > 0 &&
+		if (!ret && bytes_recvd > 0 &&
 		    recv_buf->pipe_hdr.type == PIPE_MSG_DATA)
-			hyperv_receive_sub(hdev);
+			hyperv_receive_sub(hdev, bytes_recvd);
 	} while (bytes_recvd > 0 && ret == 0);
 }
 
-- 
2.47.3


