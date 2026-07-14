Return-Path: <linux-hyperv+bounces-11978-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TuPFKGisVmoBAAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11978-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 23:38:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F94275904C
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 23:38:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b="f/266yHL";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11978-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11978-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3292300C014
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 21:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F77429CE8;
	Tue, 14 Jul 2026 21:38:46 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA82427FB7;
	Tue, 14 Jul 2026 21:38:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065126; cv=none; b=Yvg3HnTuky0DPdyvpv0TGHNLyi+6NL6/ptzbsKQBsrFtV/ykRIaLk7qlO96C/MChkwdveMaZ6PJ/RNvHAmncfU8oMoY1WBo+xJMMc8Id9juKo/HI+oklVTXqGaqs2FKS1CSBpl+K7jAVlslA1+HWZMJqMY9mFY6b0AZ3OZHLzeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065126; c=relaxed/simple;
	bh=LyMk90AI2HhCYbmR+aCfz1lgeZkGy1WwxgnkWAY+EMs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=BqAKi5kt04qiRH6zQa1ZDmx4rPf0Vj9f8IT9SvR7umooqsTZEacOMg9fKP21Rky76eihGUb5XJiideMIfEfNLJALmq2/ItPja+ZM7EsIyMB6a7uitbCm96uZNQc63HEzKj05b5aG8+DXxm5FfopAlswru0UKtlsC9eB3mEImuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f/266yHL; arc=none smtp.client-ip=13.77.154.182
Received: from UbuntuVM-22.efytirfs5hsengjwslc1ligxab.xx.internal.cloudapp.net (unknown [20.112.67.58])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4E17120B7167;
	Tue, 14 Jul 2026 14:38:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E17120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784065116;
	bh=RvEKKqpa4rW3YTV9dB86jJrSS9TW/pfSgVsL8emLIMc=;
	h=From:To:Subject:Date:From;
	b=f/266yHL0ltYsLTZHeAVUVYyILLK8Vk36FmuVvAT6LcvLXniZI7CWg4R4A7rbsuRm
	 57TvA8l7SrOrH+6yW6PgmApGiz2ByuEAKlTvx0nl9gAavKPY/J1SYdshvWmPk8wYJm
	 7Fr7L0RHVPAIugZqjZTto6Hk2u0V+iwXzioj+52I=
From: Hardik Garg <hargar@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: add VTL2 redirect connection ID
Date: Tue, 14 Jul 2026 21:38:38 +0000
Message-Id: <20260714213838.3367103-1-hargar@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11978-lists,linux-hyperv=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hargar@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hargar@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F94275904C

VMBus sends CHANNELMSG_INITIATE_CONTACT through a Hyper-V message
connection ID. Older protocol versions use VMBUS_MESSAGE_CONNECTION_ID,
while protocol version 5.0 and newer normally use
VMBUS_MESSAGE_CONNECTION_ID_4.

When the Linux VMBus driver runs at VTL2, the VMBus control plane may
be reached through a VMBus relay instead of the standard host endpoint.
In that setup the relay listens on the redirect message connection ID,
and an Initiate Contact message sent to the standard ID is not delivered
to the control plane.

The connection ID selects the Hyper-V message port used to reach the
VMBus control plane. If Linux uses the wrong port, the host does not
receive the Initiate Contact message.

For Linux running at VTL2 with VMBus protocol 5.0 or newer, try the
redirect connection ID first. In VTL2, the redirect connection ID is the
VMBus relay endpoint. If the relay is present, it accepts Initiate
Contact and completes the normal version-response handshake. Systems
without the relay reject the redirect ID synchronously with
HV_STATUS_INVALID_CONNECTION_ID, allowing fallback to
VMBUS_MESSAGE_CONNECTION_ID_4.

Return a distinct error for an invalid Initiate Contact connection ID so
this fallback does not mask other post-message failures or
protocol-version rejections. For older protocol versions, and for Linux
below VTL2, keep the existing connection ID selection.

Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
 drivers/hv/connection.c   | 76 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/hv/hyperv_vmbus.h |  2 ++
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 1fe3573ae52a4..eb871f87a819d 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -71,7 +71,19 @@ module_param(max_version, uint, S_IRUGO);
 MODULE_PARM_DESC(max_version,
 		 "Maximal VMBus protocol version which can be negotiated");
 
-int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
+/* Connection IDs to try for VTL2 VMBus protocol 5.0 and newer. */
+static const u32 connection_ids[] = {
+	VMBUS_MESSAGE_CONNECTION_ID_REDIRECT,
+	VMBUS_MESSAGE_CONNECTION_ID_4,
+};
+
+/*
+ * Send one CHANNELMSG_INITIATE_CONTACT attempt.
+ * The caller supplies the message connection ID and owns retry/fallback
+ * policy.
+ */
+static int vmbus_try_connection_id(struct vmbus_channel_msginfo *msginfo,
+				   u32 version, u32 connection_id)
 {
 	int ret = 0;
 	struct vmbus_channel_initiate_contact *msg;
@@ -87,7 +99,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 
 	/*
 	 * VMBus protocol 5.0 (VERSION_WIN10_V5) and higher require that we must
-	 * use VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate Contact Message,
+	 * use connection_id for the Initiate Contact Message,
 	 * and for subsequent messages, we must use the Message Connection ID
 	 * field in the host-returned Version Response Message. And, with
 	 * VERSION_WIN10_V5 and higher, we don't use msg->interrupt_page, but we
@@ -99,7 +111,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 	if (version >= VERSION_WIN10_V5) {
 		msg->msg_sint = VMBUS_MESSAGE_SINT;
 		msg->msg_vtl = ms_hyperv.vtl;
-		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
+		vmbus_connection.msg_conn_id = connection_id;
 	} else {
 		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
 		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
@@ -161,6 +173,51 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 	return ret;
 }
 
+/*
+ * Negotiate the given VMBus protocol version with the host.
+ * Protocol-specific connection ID policy is handled here so the single-try
+ * helper stays simple.
+ */
+int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
+{
+	int ret;
+	size_t j;
+
+	/*
+	 * The redirect ID is not a speculative endpoint. If the VMBus relay is
+	 * present, it accepts INITIATE_CONTACT and completes the normal version
+	 * response. Systems without the relay reject the ID synchronously, so
+	 * negotiation falls back to VMBUS_MESSAGE_CONNECTION_ID_4.
+	 */
+	if (version >= VERSION_WIN10_V5 && ms_hyperv.vtl >= 2) {
+		for (j = 0; j < ARRAY_SIZE(connection_ids); j++) {
+			ret = vmbus_try_connection_id(msginfo, version,
+						      connection_ids[j]);
+			if (vmbus_connection.conn_state == CONNECTED)
+				return 0;
+
+			if (ret == -ETIMEDOUT)
+				return ret;
+
+			if (connection_ids[j] ==
+			    VMBUS_MESSAGE_CONNECTION_ID_REDIRECT &&
+			    ret == -ENXIO)
+				continue;
+
+			return ret;
+		}
+		return ret;
+	}
+
+	/*
+	 * Non-redirect path. Protocol 5.0+ below VTL2 uses the standard
+	 * v5 connection ID; pre-v5 ignores the supplied ID and uses the
+	 * legacy connection ID.
+	 */
+	return vmbus_try_connection_id(msginfo, version,
+				       VMBUS_MESSAGE_CONNECTION_ID_4);
+}
+
 /*
  * vmbus_connect - Sends a connect request on the partition service connection
  */
@@ -455,17 +507,14 @@ int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
 		switch (ret) {
 		case HV_STATUS_INVALID_CONNECTION_ID:
 			/*
-			 * See vmbus_negotiate_version(): VMBus protocol 5.0
-			 * and higher require that we must use
-			 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate
-			 * Contact message, but on old hosts that only
-			 * support VMBus protocol 4.0 or lower, here we get
-			 * HV_STATUS_INVALID_CONNECTION_ID and we should
-			 * return an error immediately without retrying.
+			 * Let negotiation distinguish an unusable
+			 * endpoint from other failures.
+			 *
+			 * Other messages keep retry behavior.
 			 */
 			hdr = buffer;
 			if (hdr->msgtype == CHANNELMSG_INITIATE_CONTACT)
-				return -EINVAL;
+				return -ENXIO;
 			/*
 			 * We could get this if we send messages too
 			 * frequently.
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 49a72a4f3f6a7..951bdebdc0526 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -109,6 +109,8 @@ struct hv_input_post_message {
 enum {
 	VMBUS_MESSAGE_CONNECTION_ID	= 1,
 	VMBUS_MESSAGE_CONNECTION_ID_4	= 4,
+	/* VMBus relay port used for INITIATE_CONTACT probing. */
+	VMBUS_MESSAGE_CONNECTION_ID_REDIRECT = 0x800074,
 	VMBUS_MESSAGE_PORT_ID		= 1,
 	VMBUS_EVENT_CONNECTION_ID	= 2,
 	VMBUS_EVENT_PORT_ID		= 2,
-- 
2.34.1

