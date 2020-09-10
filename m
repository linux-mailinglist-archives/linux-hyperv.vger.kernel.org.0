Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8726465D
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Sep 2020 14:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgIJMwA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Sep 2020 08:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgIJMsm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Sep 2020 08:48:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66AC061573;
        Thu, 10 Sep 2020 05:48:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id m6so6599962wrn.0;
        Thu, 10 Sep 2020 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oym1spN1MrhGrKTxXDdFn77YQ+42eoqOllQ1x67s/10=;
        b=EqdufzcG+M4KgXW3lXGx7gNBOnQy1B+d0WtVvh4pP5cFsLifwc5hEQk9w0kZLyrVZK
         UrI7+zRr35kqDAFqvDTLs59gRbkk1hCPzNgdMr3RF0x8wN+Ilp0vxbm+IkAey/ZpZxNj
         4P7nOPIsucc+c2CIR5m7oJxwDfF6ovPQEbSnksOLwhkPfeAkfdUgOJ8MS63cEOxcaiHY
         dcEq1eHy5wO4lGLsr2FFt/0MLa57homk9y15ibdwnzyWG4aE6KEkjdpHIUYi7kW5FZjn
         0aFfS+mF1ynoe4p0beLgVn+sxIAjP43sm7UEcocM1xNtlkf/yC+esax+ekr8uk8W536H
         M2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oym1spN1MrhGrKTxXDdFn77YQ+42eoqOllQ1x67s/10=;
        b=CaTvcqJzqK5yyhrb7yPGpIokQD6KfUrtElWJxKGXFIdJpnOApRYXiIRjuNcuU+gyJG
         J+SaqR0Q1llsmML0mRJ7o46blq5zJwN8FepXNOEnPJ/asWF6lvqtd/Ln6NYcGW2wHydP
         wS1SQXqDw5ES/js2l8+2YnOk4ySb6Ttt4TAOBHWP/zwtBwtX3pauu1X2iPi41huD328E
         CrtoSxBRKJr45r3I62PhXlLutcKR2/zO8DfjJNhUq+6Xwc+Q4ZvvSHy9x/jf/cffUdJU
         62SwOjMiOCOVr2BokU0rN2pZoAy1h1xmF31Wfy73fT7yCnghFgPuRaddBcYkKWUT2ZSR
         qC/Q==
X-Gm-Message-State: AOAM530y+wVYe70UgwZKrvvwDqv4WpqOuCFsDyQ+92KKa5aw4dXmftP7
        g9cZz1Hhmp3VlDySwdtqLwSQeXAqvRM1rfcqywM=
X-Google-Smtp-Source: ABdhPJx0zT5FyynJbchtGgZVzNwWF+iGENi7IGcu9oEZoSRKfGQHuhQEzA7SukKpXowigr0HWS7GPw==
X-Received: by 2002:a05:6000:1003:: with SMTP id a3mr8922788wrx.258.1599742118250;
        Thu, 10 Sep 2020 05:48:38 -0700 (PDT)
Received: from localhost.localdomain (userh459.uk.uudial.com. [194.69.102.86])
        by smtp.gmail.com with ESMTPSA id n21sm3586252wmi.21.2020.09.10.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:48:37 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Andres Beltran <lkmlabelt@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3] hv_utils: Add validation for untrusted Hyper-V values
Date:   Thu, 10 Sep 2020 14:48:16 +0200
Message-Id: <20200910124816.19278-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andres Beltran <lkmlabelt@gmail.com>

For additional robustness in the face of Hyper-V errors or malicious
behavior, validate all values that originate from packets that Hyper-V
has sent to the guest in the host-to-guest ring buffer. Ensure that
invalid values cannot cause indexing off the end of the icversion_data
array in vmbus_prep_negotiate_resp().

Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
Co-developed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
Changes in v3:
  - Add size check for icframe_vercnt and icmsg_vercnt (Saruhan)

Changes in v2:
  - Use ratelimited form of kernel logging to print error messages

 drivers/hv/channel_mgmt.c |  24 +++-
 drivers/hv/hv_fcopy.c     |  36 +++--
 drivers/hv/hv_kvp.c       | 122 +++++++++--------
 drivers/hv/hv_snapshot.c  |  89 +++++++------
 drivers/hv/hv_util.c      | 267 +++++++++++++++++++++++---------------
 include/linux/hyperv.h    |   9 +-
 6 files changed, 339 insertions(+), 208 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 591106cf58fc0..f831f91a1541c 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -190,6 +190,7 @@ static u16 hv_get_dev_type(const struct vmbus_channel *channel)
  * vmbus_prep_negotiate_resp() - Create default response for Negotiate message
  * @icmsghdrp: Pointer to msg header structure
  * @buf: Raw buffer channel data
+ * @buflen: Length of the raw buffer channel data.
  * @fw_version: The framework versions we can support.
  * @fw_vercnt: The size of @fw_version.
  * @srv_version: The service versions we can support.
@@ -202,8 +203,8 @@ static u16 hv_get_dev_type(const struct vmbus_channel *channel)
  * Set up and fill in default negotiate response message.
  * Mainly used by Hyper-V drivers.
  */
-bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp,
-				u8 *buf, const int *fw_version, int fw_vercnt,
+bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp, u8 *buf,
+				u32 buflen, const int *fw_version, int fw_vercnt,
 				const int *srv_version, int srv_vercnt,
 				int *nego_fw_version, int *nego_srv_version)
 {
@@ -215,10 +216,14 @@ bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp,
 	bool found_match = false;
 	struct icmsg_negotiate *negop;
 
+	/* Check that there's enough space for icframe_vercnt, icmsg_vercnt */
+	if (buflen < ICMSG_HDR + offsetof(struct icmsg_negotiate, reserved)) {
+		pr_err_ratelimited("Invalid icmsg negotiate\n");
+		return false;
+	}
+
 	icmsghdrp->icmsgsize = 0x10;
-	negop = (struct icmsg_negotiate *)&buf[
-		sizeof(struct vmbuspipe_hdr) +
-		sizeof(struct icmsg_hdr)];
+	negop = (struct icmsg_negotiate *)&buf[ICMSG_HDR];
 
 	icframe_major = negop->icframe_vercnt;
 	icframe_minor = 0;
@@ -226,6 +231,15 @@ bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp,
 	icmsg_major = negop->icmsg_vercnt;
 	icmsg_minor = 0;
 
+	/* Validate negop packet */
+	if (icframe_major > IC_VERSION_NEGOTIATION_MAX_VER_COUNT ||
+	    icmsg_major > IC_VERSION_NEGOTIATION_MAX_VER_COUNT ||
+	    ICMSG_NEGOTIATE_PKT_SIZE(icframe_major, icmsg_major) > buflen) {
+		pr_err_ratelimited("Invalid icmsg negotiate - icframe_major: %u, icmsg_major: %u\n",
+				   icframe_major, icmsg_major);
+		goto fw_error;
+	}
+
 	/*
 	 * Select the framework version number we will
 	 * support.
diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
index 5040d7e0cd9e9..59ce85e00a028 100644
--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -235,15 +235,27 @@ void hv_fcopy_onchannelcallback(void *context)
 	if (fcopy_transaction.state > HVUTIL_READY)
 		return;
 
-	vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 2, &recvlen,
-			 &requestid);
-	if (recvlen <= 0)
+	if (vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 2, &recvlen, &requestid)) {
+		pr_err_ratelimited("Fcopy request received. Could not read into recv buf\n");
 		return;
+	}
+
+	if (!recvlen)
+		return;
+
+	/* Ensure recvlen is big enough to read header data */
+	if (recvlen < ICMSG_HDR) {
+		pr_err_ratelimited("Fcopy request received. Packet length too small: %d\n",
+				   recvlen);
+		return;
+	}
 
 	icmsghdr = (struct icmsg_hdr *)&recv_buffer[
 			sizeof(struct vmbuspipe_hdr)];
+
 	if (icmsghdr->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-		if (vmbus_prep_negotiate_resp(icmsghdr, recv_buffer,
+		if (vmbus_prep_negotiate_resp(icmsghdr,
+				recv_buffer, recvlen,
 				fw_versions, FW_VER_COUNT,
 				fcopy_versions, FCOPY_VER_COUNT,
 				NULL, &fcopy_srv_version)) {
@@ -252,10 +264,14 @@ void hv_fcopy_onchannelcallback(void *context)
 				fcopy_srv_version >> 16,
 				fcopy_srv_version & 0xFFFF);
 		}
-	} else {
-		fcopy_msg = (struct hv_fcopy_hdr *)&recv_buffer[
-				sizeof(struct vmbuspipe_hdr) +
-				sizeof(struct icmsg_hdr)];
+	} else if (icmsghdr->icmsgtype == ICMSGTYPE_FCOPY) {
+		/* Ensure recvlen is big enough to contain hv_fcopy_hdr */
+		if (recvlen < ICMSG_HDR + sizeof(struct hv_fcopy_hdr)) {
+			pr_err_ratelimited("Invalid Fcopy hdr. Packet length too small: %u\n",
+					   recvlen);
+			return;
+		}
+		fcopy_msg = (struct hv_fcopy_hdr *)&recv_buffer[ICMSG_HDR];
 
 		/*
 		 * Stash away this global state for completing the
@@ -280,6 +296,10 @@ void hv_fcopy_onchannelcallback(void *context)
 		schedule_delayed_work(&fcopy_timeout_work,
 				      HV_UTIL_TIMEOUT * HZ);
 		return;
+	} else {
+		pr_err_ratelimited("Fcopy request received. Invalid msg type: %d\n",
+				   icmsghdr->icmsgtype);
+		return;
 	}
 	icmsghdr->icflags = ICMSGHDRFLAG_TRANSACTION | ICMSGHDRFLAG_RESPONSE;
 	vmbus_sendpacket(channel, recv_buffer, recvlen, requestid,
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index e74b144b8f3d4..46d171abb47d8 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -662,71 +662,87 @@ void hv_kvp_onchannelcallback(void *context)
 	if (kvp_transaction.state > HVUTIL_READY)
 		return;
 
-	vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 4, &recvlen,
-			 &requestid);
-
-	if (recvlen > 0) {
-		icmsghdrp = (struct icmsg_hdr *)&recv_buffer[
-			sizeof(struct vmbuspipe_hdr)];
-
-		if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-			if (vmbus_prep_negotiate_resp(icmsghdrp,
-				 recv_buffer, fw_versions, FW_VER_COUNT,
-				 kvp_versions, KVP_VER_COUNT,
-				 NULL, &kvp_srv_version)) {
-				pr_info("KVP IC version %d.%d\n",
-					kvp_srv_version >> 16,
-					kvp_srv_version & 0xFFFF);
-			}
-		} else {
-			kvp_msg = (struct hv_kvp_msg *)&recv_buffer[
-				sizeof(struct vmbuspipe_hdr) +
-				sizeof(struct icmsg_hdr)];
+	if (vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 4, &recvlen, &requestid)) {
+		pr_err_ratelimited("KVP request received. Could not read into recv buf\n");
+		return;
+	}
 
-			/*
-			 * Stash away this global state for completing the
-			 * transaction; note transactions are serialized.
-			 */
+	if (!recvlen)
+		return;
 
-			kvp_transaction.recv_len = recvlen;
-			kvp_transaction.recv_req_id = requestid;
-			kvp_transaction.kvp_msg = kvp_msg;
+	/* Ensure recvlen is big enough to read header data */
+	if (recvlen < ICMSG_HDR) {
+		pr_err_ratelimited("KVP request received. Packet length too small: %d\n",
+				   recvlen);
+		return;
+	}
 
-			if (kvp_transaction.state < HVUTIL_READY) {
-				/* Userspace is not registered yet */
-				kvp_respond_to_host(NULL, HV_E_FAIL);
-				return;
-			}
-			kvp_transaction.state = HVUTIL_HOSTMSG_RECEIVED;
+	icmsghdrp = (struct icmsg_hdr *)&recv_buffer[sizeof(struct vmbuspipe_hdr)];
+
+	if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
+		if (vmbus_prep_negotiate_resp(icmsghdrp,
+				recv_buffer, recvlen,
+				fw_versions, FW_VER_COUNT,
+				kvp_versions, KVP_VER_COUNT,
+				NULL, &kvp_srv_version)) {
+			pr_info("KVP IC version %d.%d\n",
+				kvp_srv_version >> 16,
+				kvp_srv_version & 0xFFFF);
+		}
+	} else if (icmsghdrp->icmsgtype == ICMSGTYPE_KVPEXCHANGE) {
+		/*
+		 * recvlen is not checked against sizeof(struct kvp_msg) because kvp_msg contains
+		 * a union of structs and the msg type received is not known. Code using this
+		 * struct should provide validation when accessing its fields.
+		 */
+		kvp_msg = (struct hv_kvp_msg *)&recv_buffer[ICMSG_HDR];
 
-			/*
-			 * Get the information from the
-			 * user-mode component.
-			 * component. This transaction will be
-			 * completed when we get the value from
-			 * the user-mode component.
-			 * Set a timeout to deal with
-			 * user-mode not responding.
-			 */
-			schedule_work(&kvp_sendkey_work);
-			schedule_delayed_work(&kvp_timeout_work,
-					      HV_UTIL_TIMEOUT * HZ);
+		/*
+		 * Stash away this global state for completing the
+		 * transaction; note transactions are serialized.
+		 */
 
-			return;
+		kvp_transaction.recv_len = recvlen;
+		kvp_transaction.recv_req_id = requestid;
+		kvp_transaction.kvp_msg = kvp_msg;
 
+		if (kvp_transaction.state < HVUTIL_READY) {
+			/* Userspace is not registered yet */
+			kvp_respond_to_host(NULL, HV_E_FAIL);
+			return;
 		}
+		kvp_transaction.state = HVUTIL_HOSTMSG_RECEIVED;
 
-		icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION
-			| ICMSGHDRFLAG_RESPONSE;
+		/*
+		 * Get the information from the
+		 * user-mode component.
+		 * component. This transaction will be
+		 * completed when we get the value from
+		 * the user-mode component.
+		 * Set a timeout to deal with
+		 * user-mode not responding.
+		 */
+		schedule_work(&kvp_sendkey_work);
+		schedule_delayed_work(&kvp_timeout_work,
+					HV_UTIL_TIMEOUT * HZ);
 
-		vmbus_sendpacket(channel, recv_buffer,
-				       recvlen, requestid,
-				       VM_PKT_DATA_INBAND, 0);
+		return;
 
-		host_negotiatied = NEGO_FINISHED;
-		hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);
+	} else {
+		pr_err_ratelimited("KVP request received. Invalid msg type: %d\n",
+				   icmsghdrp->icmsgtype);
+		return;
 	}
 
+	icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION
+		| ICMSGHDRFLAG_RESPONSE;
+
+	vmbus_sendpacket(channel, recv_buffer,
+			 recvlen, requestid,
+			 VM_PKT_DATA_INBAND, 0);
+
+	host_negotiatied = NEGO_FINISHED;
+	hv_poll_channel(kvp_transaction.recv_channel, kvp_poll_wrapper);
 }
 
 static void kvp_on_reset(void)
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 783779e4cc1a5..2267bd4c34725 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -298,49 +298,64 @@ void hv_vss_onchannelcallback(void *context)
 	if (vss_transaction.state > HVUTIL_READY)
 		return;
 
-	vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 2, &recvlen,
-			 &requestid);
-
-	if (recvlen > 0) {
-		icmsghdrp = (struct icmsg_hdr *)&recv_buffer[
-			sizeof(struct vmbuspipe_hdr)];
-
-		if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-			if (vmbus_prep_negotiate_resp(icmsghdrp,
-				 recv_buffer, fw_versions, FW_VER_COUNT,
-				 vss_versions, VSS_VER_COUNT,
-				 NULL, &vss_srv_version)) {
-
-				pr_info("VSS IC version %d.%d\n",
-					vss_srv_version >> 16,
-					vss_srv_version & 0xFFFF);
-			}
-		} else {
-			vss_msg = (struct hv_vss_msg *)&recv_buffer[
-				sizeof(struct vmbuspipe_hdr) +
-				sizeof(struct icmsg_hdr)];
-
-			/*
-			 * Stash away this global state for completing the
-			 * transaction; note transactions are serialized.
-			 */
-
-			vss_transaction.recv_len = recvlen;
-			vss_transaction.recv_req_id = requestid;
-			vss_transaction.msg = (struct hv_vss_msg *)vss_msg;
-
-			schedule_work(&vss_handle_request_work);
+	if (vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 2, &recvlen, &requestid)) {
+		pr_err_ratelimited("VSS request received. Could not read into recv buf\n");
+		return;
+	}
+
+	if (!recvlen)
+		return;
+
+	/* Ensure recvlen is big enough to read header data */
+	if (recvlen < ICMSG_HDR) {
+		pr_err_ratelimited("VSS request received. Packet length too small: %d\n",
+				   recvlen);
+		return;
+	}
+
+	icmsghdrp = (struct icmsg_hdr *)&recv_buffer[sizeof(struct vmbuspipe_hdr)];
+
+	if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
+		if (vmbus_prep_negotiate_resp(icmsghdrp,
+				recv_buffer, recvlen,
+				fw_versions, FW_VER_COUNT,
+				vss_versions, VSS_VER_COUNT,
+				NULL, &vss_srv_version)) {
+
+			pr_info("VSS IC version %d.%d\n",
+				vss_srv_version >> 16,
+				vss_srv_version & 0xFFFF);
+		}
+	} else if (icmsghdrp->icmsgtype == ICMSGTYPE_VSS) {
+		/* Ensure recvlen is big enough to contain hv_vss_msg */
+		if (recvlen < ICMSG_HDR + sizeof(struct hv_vss_msg)) {
+			pr_err_ratelimited("Invalid VSS msg. Packet length too small: %u\n",
+					   recvlen);
 			return;
 		}
+		vss_msg = (struct hv_vss_msg *)&recv_buffer[ICMSG_HDR];
+
+		/*
+		 * Stash away this global state for completing the
+		 * transaction; note transactions are serialized.
+		 */
 
-		icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION
-			| ICMSGHDRFLAG_RESPONSE;
+		vss_transaction.recv_len = recvlen;
+		vss_transaction.recv_req_id = requestid;
+		vss_transaction.msg = (struct hv_vss_msg *)vss_msg;
 
-		vmbus_sendpacket(channel, recv_buffer,
-				       recvlen, requestid,
-				       VM_PKT_DATA_INBAND, 0);
+		schedule_work(&vss_handle_request_work);
+		return;
+	} else {
+		pr_err_ratelimited("VSS request received. Invalid msg type: %d\n",
+				   icmsghdrp->icmsgtype);
+		return;
 	}
 
+	icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION |
+		ICMSGHDRFLAG_RESPONSE;
+	vmbus_sendpacket(channel, recv_buffer, recvlen, requestid,
+			 VM_PKT_DATA_INBAND, 0);
 }
 
 static void vss_on_reset(void)
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 92ee0fe4c919e..f78840b98fe61 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -195,73 +195,91 @@ static void shutdown_onchannelcallback(void *context)
 
 	struct icmsg_hdr *icmsghdrp;
 
-	vmbus_recvpacket(channel, shut_txf_buf,
-			 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
+	if (vmbus_recvpacket(channel, shut_txf_buf, HV_HYP_PAGE_SIZE, &recvlen, &requestid)) {
+		pr_err_ratelimited("Shutdown request received. Could not read into shut txf buf\n");
+		return;
+	}
 
-	if (recvlen > 0) {
-		icmsghdrp = (struct icmsg_hdr *)&shut_txf_buf[
-			sizeof(struct vmbuspipe_hdr)];
+	if (!recvlen)
+		return;
 
-		if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-			if (vmbus_prep_negotiate_resp(icmsghdrp, shut_txf_buf,
-					fw_versions, FW_VER_COUNT,
-					sd_versions, SD_VER_COUNT,
-					NULL, &sd_srv_version)) {
-				pr_info("Shutdown IC version %d.%d\n",
-					sd_srv_version >> 16,
-					sd_srv_version & 0xFFFF);
-			}
-		} else {
-			shutdown_msg =
-				(struct shutdown_msg_data *)&shut_txf_buf[
-					sizeof(struct vmbuspipe_hdr) +
-					sizeof(struct icmsg_hdr)];
+	/* Ensure recvlen is big enough to read header data */
+	if (recvlen < ICMSG_HDR) {
+		pr_err_ratelimited("Shutdown request received. Packet length too small: %d\n",
+				   recvlen);
+		return;
+	}
 
-			/*
-			 * shutdown_msg->flags can be 0(shut down), 2(reboot),
-			 * or 4(hibernate). It may bitwise-OR 1, which means
-			 * performing the request by force. Linux always tries
-			 * to perform the request by force.
-			 */
-			switch (shutdown_msg->flags) {
-			case 0:
-			case 1:
-				icmsghdrp->status = HV_S_OK;
-				work = &shutdown_work;
-				pr_info("Shutdown request received -"
-					    " graceful shutdown initiated\n");
-				break;
-			case 2:
-			case 3:
-				icmsghdrp->status = HV_S_OK;
-				work = &restart_work;
-				pr_info("Restart request received -"
-					    " graceful restart initiated\n");
-				break;
-			case 4:
-			case 5:
-				pr_info("Hibernation request received\n");
-				icmsghdrp->status = hibernation_supported ?
-					HV_S_OK : HV_E_FAIL;
-				if (hibernation_supported)
-					work = &hibernate_context.work;
-				break;
-			default:
-				icmsghdrp->status = HV_E_FAIL;
-				pr_info("Shutdown request received -"
-					    " Invalid request\n");
-				break;
-			}
+	icmsghdrp = (struct icmsg_hdr *)&shut_txf_buf[sizeof(struct vmbuspipe_hdr)];
+
+	if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
+		if (vmbus_prep_negotiate_resp(icmsghdrp,
+				shut_txf_buf, recvlen,
+				fw_versions, FW_VER_COUNT,
+				sd_versions, SD_VER_COUNT,
+				NULL, &sd_srv_version)) {
+			pr_info("Shutdown IC version %d.%d\n",
+				sd_srv_version >> 16,
+				sd_srv_version & 0xFFFF);
+		}
+	} else if (icmsghdrp->icmsgtype == ICMSGTYPE_SHUTDOWN) {
+		/* Ensure recvlen is big enough to contain shutdown_msg_data struct */
+		if (recvlen < ICMSG_HDR + sizeof(struct shutdown_msg_data)) {
+			pr_err_ratelimited("Invalid shutdown msg data. Packet length too small: %u\n",
+					   recvlen);
+			return;
 		}
 
-		icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION
-			| ICMSGHDRFLAG_RESPONSE;
-
-		vmbus_sendpacket(channel, shut_txf_buf,
-				       recvlen, requestid,
-				       VM_PKT_DATA_INBAND, 0);
+		shutdown_msg = (struct shutdown_msg_data *)&shut_txf_buf[ICMSG_HDR];
+
+		/*
+		 * shutdown_msg->flags can be 0(shut down), 2(reboot),
+		 * or 4(hibernate). It may bitwise-OR 1, which means
+		 * performing the request by force. Linux always tries
+		 * to perform the request by force.
+		 */
+		switch (shutdown_msg->flags) {
+		case 0:
+		case 1:
+			icmsghdrp->status = HV_S_OK;
+			work = &shutdown_work;
+			pr_info("Shutdown request received -"
+					" graceful shutdown initiated\n");
+			break;
+		case 2:
+		case 3:
+			icmsghdrp->status = HV_S_OK;
+			work = &restart_work;
+			pr_info("Restart request received -"
+					" graceful restart initiated\n");
+			break;
+		case 4:
+		case 5:
+			pr_info("Hibernation request received\n");
+			icmsghdrp->status = hibernation_supported ?
+				HV_S_OK : HV_E_FAIL;
+			if (hibernation_supported)
+				work = &hibernate_context.work;
+			break;
+		default:
+			icmsghdrp->status = HV_E_FAIL;
+			pr_info("Shutdown request received -"
+					" Invalid request\n");
+			break;
+		}
+	} else {
+		icmsghdrp->status = HV_E_FAIL;
+		pr_err_ratelimited("Shutdown request received. Invalid msg type: %d\n",
+				   icmsghdrp->icmsgtype);
 	}
 
+	icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION
+		| ICMSGHDRFLAG_RESPONSE;
+
+	vmbus_sendpacket(channel, shut_txf_buf,
+			 recvlen, requestid,
+			 VM_PKT_DATA_INBAND, 0);
+
 	if (work)
 		schedule_work(work);
 }
@@ -361,50 +379,71 @@ static void timesync_onchannelcallback(void *context)
 	struct ictimesync_ref_data *refdata;
 	u8 *time_txf_buf = util_timesynch.recv_buffer;
 
-	vmbus_recvpacket(channel, time_txf_buf,
-			 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
+	if (vmbus_recvpacket(channel, time_txf_buf, HV_HYP_PAGE_SIZE, &recvlen, &requestid)) {
+		pr_err_ratelimited("Timesync request received. Could not read into time txf buf\n");
+		return;
+	}
 
-	if (recvlen > 0) {
-		icmsghdrp = (struct icmsg_hdr *)&time_txf_buf[
-				sizeof(struct vmbuspipe_hdr)];
+	if (!recvlen)
+		return;
 
-		if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-			if (vmbus_prep_negotiate_resp(icmsghdrp, time_txf_buf,
-						fw_versions, FW_VER_COUNT,
-						ts_versions, TS_VER_COUNT,
-						NULL, &ts_srv_version)) {
-				pr_info("TimeSync IC version %d.%d\n",
-					ts_srv_version >> 16,
-					ts_srv_version & 0xFFFF);
+	/* Ensure recvlen is big enough to read header data */
+	if (recvlen < ICMSG_HDR) {
+		pr_err_ratelimited("Timesync request received. Packet length too small: %d\n",
+				   recvlen);
+		return;
+	}
+
+	icmsghdrp = (struct icmsg_hdr *)&time_txf_buf[sizeof(struct vmbuspipe_hdr)];
+
+	if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
+		if (vmbus_prep_negotiate_resp(icmsghdrp,
+					time_txf_buf, recvlen,
+					fw_versions, FW_VER_COUNT,
+					ts_versions, TS_VER_COUNT,
+					NULL, &ts_srv_version)) {
+			pr_info("TimeSync IC version %d.%d\n",
+				ts_srv_version >> 16,
+				ts_srv_version & 0xFFFF);
+		}
+	} else if (icmsghdrp->icmsgtype == ICMSGTYPE_TIMESYNC) {
+		if (ts_srv_version > TS_VERSION_3) {
+			/* Ensure recvlen is big enough to read ictimesync_ref_data */
+			if (recvlen < ICMSG_HDR + sizeof(struct ictimesync_ref_data)) {
+				pr_err_ratelimited("Invalid ictimesync ref data. Length too small: %u\n",
+						   recvlen);
+				return;
 			}
+			refdata = (struct ictimesync_ref_data *)&time_txf_buf[ICMSG_HDR];
+
+			adj_guesttime(refdata->parenttime,
+					refdata->vmreferencetime,
+					refdata->flags);
 		} else {
-			if (ts_srv_version > TS_VERSION_3) {
-				refdata = (struct ictimesync_ref_data *)
-					&time_txf_buf[
-					sizeof(struct vmbuspipe_hdr) +
-					sizeof(struct icmsg_hdr)];
-
-				adj_guesttime(refdata->parenttime,
-						refdata->vmreferencetime,
-						refdata->flags);
-			} else {
-				timedatap = (struct ictimesync_data *)
-					&time_txf_buf[
-					sizeof(struct vmbuspipe_hdr) +
-					sizeof(struct icmsg_hdr)];
-				adj_guesttime(timedatap->parenttime,
-					      hv_read_reference_counter(),
-					      timedatap->flags);
+			/* Ensure recvlen is big enough to read ictimesync_data */
+			if (recvlen < ICMSG_HDR + sizeof(struct ictimesync_data)) {
+				pr_err_ratelimited("Invalid ictimesync data. Length too small: %u\n",
+						   recvlen);
+				return;
 			}
+			timedatap = (struct ictimesync_data *)&time_txf_buf[ICMSG_HDR];
+
+			adj_guesttime(timedatap->parenttime,
+					hv_read_reference_counter(),
+					timedatap->flags);
 		}
+	} else {
+		icmsghdrp->status = HV_E_FAIL;
+		pr_err_ratelimited("Timesync request received. Invalid msg type: %d\n",
+				   icmsghdrp->icmsgtype);
+	}
 
-		icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION
-			| ICMSGHDRFLAG_RESPONSE;
+	icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION
+		| ICMSGHDRFLAG_RESPONSE;
 
-		vmbus_sendpacket(channel, time_txf_buf,
-				recvlen, requestid,
-				VM_PKT_DATA_INBAND, 0);
-	}
+	vmbus_sendpacket(channel, time_txf_buf,
+			 recvlen, requestid,
+			 VM_PKT_DATA_INBAND, 0);
 }
 
 /*
@@ -423,18 +462,28 @@ static void heartbeat_onchannelcallback(void *context)
 
 	while (1) {
 
-		vmbus_recvpacket(channel, hbeat_txf_buf,
-				 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
+		if (vmbus_recvpacket(channel, hbeat_txf_buf, HV_HYP_PAGE_SIZE,
+				     &recvlen, &requestid)) {
+			pr_err_ratelimited("Heartbeat request received. Could not read into hbeat txf buf\n");
+			return;
+		}
 
 		if (!recvlen)
 			break;
 
+		/* Ensure recvlen is big enough to read header data */
+		if (recvlen < ICMSG_HDR) {
+			pr_err_ratelimited("Hearbeat request received. Packet length too small: %d\n",
+					   recvlen);
+			break;
+		}
+
 		icmsghdrp = (struct icmsg_hdr *)&hbeat_txf_buf[
 				sizeof(struct vmbuspipe_hdr)];
 
 		if (icmsghdrp->icmsgtype == ICMSGTYPE_NEGOTIATE) {
 			if (vmbus_prep_negotiate_resp(icmsghdrp,
-					hbeat_txf_buf,
+					hbeat_txf_buf, recvlen,
 					fw_versions, FW_VER_COUNT,
 					hb_versions, HB_VER_COUNT,
 					NULL, &hb_srv_version)) {
@@ -443,13 +492,23 @@ static void heartbeat_onchannelcallback(void *context)
 					hb_srv_version >> 16,
 					hb_srv_version & 0xFFFF);
 			}
-		} else {
-			heartbeat_msg =
-				(struct heartbeat_msg_data *)&hbeat_txf_buf[
-					sizeof(struct vmbuspipe_hdr) +
-					sizeof(struct icmsg_hdr)];
+		} else if (icmsghdrp->icmsgtype == ICMSGTYPE_HEARTBEAT) {
+			/*
+			 * Ensure recvlen is big enough to read seq_num. Reserved area is not
+			 * included in the check as the host may not fill it up entirely
+			 */
+			if (recvlen < ICMSG_HDR + sizeof(u64)) {
+				pr_err_ratelimited("Invalid heartbeat msg data. Length too small: %u\n",
+						   recvlen);
+				break;
+			}
+			heartbeat_msg = (struct heartbeat_msg_data *)&hbeat_txf_buf[ICMSG_HDR];
 
 			heartbeat_msg->seq_num += 1;
+		} else {
+			icmsghdrp->status = HV_E_FAIL;
+			pr_err_ratelimited("Heartbeat request received. Invalid msg type: %d\n",
+					   icmsghdrp->icmsgtype);
 		}
 
 		icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 32c03643577b4..8774a4f848cdd 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1423,6 +1423,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
 #define ICMSGTYPE_SHUTDOWN		3
 #define ICMSGTYPE_TIMESYNC		4
 #define ICMSGTYPE_VSS			5
+#define ICMSGTYPE_FCOPY			7
 
 #define ICMSGHDRFLAG_TRANSACTION	1
 #define ICMSGHDRFLAG_REQUEST		2
@@ -1466,6 +1467,12 @@ struct icmsg_hdr {
 	u8 reserved[2];
 } __packed;
 
+#define IC_VERSION_NEGOTIATION_MAX_VER_COUNT 100
+#define ICMSG_HDR (sizeof(struct vmbuspipe_hdr) + sizeof(struct icmsg_hdr))
+#define ICMSG_NEGOTIATE_PKT_SIZE(icframe_vercnt, icmsg_vercnt) \
+	(ICMSG_HDR + offsetof(struct icmsg_negotiate, icversion_data) + \
+	 (((icframe_vercnt) + (icmsg_vercnt)) * sizeof(struct ic_version)))
+
 struct icmsg_negotiate {
 	u16 icframe_vercnt;
 	u16 icmsg_vercnt;
@@ -1521,7 +1528,7 @@ struct hyperv_service_callback {
 };
 
 #define MAX_SRV_VER	0x7ffffff
-extern bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp, u8 *buf,
+extern bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp, u8 *buf, u32 buflen,
 				const int *fw_version, int fw_vercnt,
 				const int *srv_version, int srv_vercnt,
 				int *nego_fw_version, int *nego_srv_version);
-- 
2.25.1

