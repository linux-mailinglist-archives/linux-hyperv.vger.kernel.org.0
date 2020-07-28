Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1E231422
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jul 2020 22:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgG1UoW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Jul 2020 16:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgG1UoV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Jul 2020 16:44:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEEBC061794;
        Tue, 28 Jul 2020 13:44:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t1so1460692plq.0;
        Tue, 28 Jul 2020 13:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gnWU/+2K8t4cFihSUedxhT7UXvsTI1fKJWaIvCfilNA=;
        b=OCGIGRoNTCQ2iwmCJQ21hQH5makijVa/zW7z7zMRXFfEJkqMMdFXd84254M8WK9duW
         O8jYexGnlNm/nesaPzE2yd7DIJJYW53L1c9Mpgnm1wP2K8W57dSDh4QjqJVEVQzKjUVT
         PCgQLGwPi710pnV5Hyf1C+pXE11tdf29pQJ8fn1a178M1wQedS4oeQtdxxzkUdlAL96t
         1+rBTI5KJ5p913/KyyO0+JuH/KN5soHpmnPtoJiCeS/Pizj7GHVM629yr39aXRk7hPXY
         t056zRCBC6MUJgva3/h6yPlTfTKBYC8IqOJnWbwvEBslZO5FNZ93mPPMmbwMgdipidVt
         EPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gnWU/+2K8t4cFihSUedxhT7UXvsTI1fKJWaIvCfilNA=;
        b=DKJyQ82LXOtkwkojMS0YUupNWdIBmxgVkyrxH+L/XfsulEf01xwxrwQMsFP7j6/mB9
         sNrfyWXeZyrDCOymaxg2WDWDB45mFUwG9DFxHrEWcIjXzitiCS2WGYsoT/mpF7P9Zx0w
         C4l1GthHdnOqSBJ8snn0JmklWlgeRdh5jks2lbI+BEVjHfBGMQoK/p9VhwEoVXsZrnKN
         MYl4pXHqdNIeQFVFabWw38oMQxIRSW5I/ewapllv0wS1NRLQWzE1pjkBbrjAlLNtB82q
         IIxIe+FBq8Bl1F8HaAiby2Kkip1q+o3N3kynvV1dnqgIyZUOrFwYvuKhTN9pyuPk4ajZ
         y8MQ==
X-Gm-Message-State: AOAM531zRXhp+WP9RVCHZQuFkSi3OoCKRorlGg52prf127GwBp1eCMb2
        /XYnzxdQJ2C+XWWPae4aktg=
X-Google-Smtp-Source: ABdhPJwNncq5bPA49+rp8HyfFrsfcabDfZnvccrcTxPpA9a0dDy/DjuLNm6G3FkBuQrwnRNwRSyNrA==
X-Received: by 2002:a17:902:221:: with SMTP id 30mr2759629plc.222.1595969060094;
        Tue, 28 Jul 2020 13:44:20 -0700 (PDT)
Received: from localhost.localdomain ([131.107.147.194])
        by smtp.gmail.com with ESMTPSA id d22sm1525913pfd.42.2020.07.28.13.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 13:44:19 -0700 (PDT)
From:   Andres Beltran <lkmlabelt@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        skarade@microsoft.com, Andres Beltran <lkmlabelt@gmail.com>
Subject: [PATCH] hv_utils: Add validation for untrusted Hyper-V values
Date:   Tue, 28 Jul 2020 16:44:17 -0400
Message-Id: <20200728204417.23912-1-lkmlabelt@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For additional robustness in the face of Hyper-V errors or malicious
behavior, validate all values that originate from packets that Hyper-V
has sent to the guest in the host-to-guest ring buffer. Ensure that
invalid values cannot cause indexing off the end of the icversion_data
array in vmbus_prep_negotiate_resp().

Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
---
 drivers/hv/channel_mgmt.c |  17 ++-
 drivers/hv/hv_fcopy.c     |  35 +++--
 drivers/hv/hv_kvp.c       | 121 +++++++++--------
 drivers/hv/hv_snapshot.c  |  88 +++++++------
 drivers/hv/hv_util.c      | 265 +++++++++++++++++++++++---------------
 include/linux/hyperv.h    |   9 +-
 6 files changed, 327 insertions(+), 208 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 591106cf58fc..fcabf488fa58 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -202,8 +202,8 @@ static u16 hv_get_dev_type(const struct vmbus_channel *channel)
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
@@ -216,9 +216,7 @@ bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp,
 	struct icmsg_negotiate *negop;
 
 	icmsghdrp->icmsgsize = 0x10;
-	negop = (struct icmsg_negotiate *)&buf[
-		sizeof(struct vmbuspipe_hdr) +
-		sizeof(struct icmsg_hdr)];
+	negop = (struct icmsg_negotiate *)&buf[ICMSG_HDR];
 
 	icframe_major = negop->icframe_vercnt;
 	icframe_minor = 0;
@@ -226,6 +224,15 @@ bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp,
 	icmsg_major = negop->icmsg_vercnt;
 	icmsg_minor = 0;
 
+	/* Validate negop packet */
+	if (icframe_major > IC_VERSION_NEGOTIATION_MAX_VER_COUNT ||
+	    icmsg_major > IC_VERSION_NEGOTIATION_MAX_VER_COUNT ||
+	    ICMSG_NEGOTIATE_PKT_SIZE(icframe_major, icmsg_major) > buflen) {
+		pr_err("Invalid icmsg negotiate - icframe_major: %u, icmsg_major: %u",
+		       icframe_major, icmsg_major);
+		goto fw_error;
+	}
+
 	/*
 	 * Select the framework version number we will
 	 * support.
diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
index 5040d7e0cd9e..a9330abe83b2 100644
--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -235,15 +235,26 @@ void hv_fcopy_onchannelcallback(void *context)
 	if (fcopy_transaction.state > HVUTIL_READY)
 		return;
 
-	vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 2, &recvlen,
-			 &requestid);
-	if (recvlen <= 0)
+	if (vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 2, &recvlen, &requestid)) {
+		pr_info("Fcopy request received. Could not read into recv buf\n");
 		return;
+	}
+
+	if (!recvlen)
+		return;
+
+	/* Ensure recvlen is big enough to read header data */
+	if (recvlen < ICMSG_HDR) {
+		pr_info("Fcopy request received. Packet length too small: %d\n", recvlen);
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
@@ -252,10 +263,14 @@ void hv_fcopy_onchannelcallback(void *context)
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
+			pr_info("Invalid Fcopy hdr. Packet length too small: %u\n",
+				recvlen);
+			return;
+		}
+		fcopy_msg = (struct hv_fcopy_hdr *)&recv_buffer[ICMSG_HDR];
 
 		/*
 		 * Stash away this global state for completing the
@@ -280,6 +295,10 @@ void hv_fcopy_onchannelcallback(void *context)
 		schedule_delayed_work(&fcopy_timeout_work,
 				      HV_UTIL_TIMEOUT * HZ);
 		return;
+	} else {
+		pr_info("Fcopy request received. Invalid msg type: %d\n",
+			icmsghdr->icmsgtype);
+		return;
 	}
 	icmsghdr->icflags = ICMSGHDRFLAG_TRANSACTION | ICMSGHDRFLAG_RESPONSE;
 	vmbus_sendpacket(channel, recv_buffer, recvlen, requestid,
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index e74b144b8f3d..cfcadaba2b98 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -662,71 +662,86 @@ void hv_kvp_onchannelcallback(void *context)
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
+		pr_info("KVP request received. Could not read into recv buf\n");
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
+		pr_info("KVP request received. Packet length too small: %d\n", recvlen);
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
+		pr_info("KVP request received. Invalid msg type: %d\n",
+			icmsghdrp->icmsgtype);
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
index 783779e4cc1a..c07926ca1b65 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -298,49 +298,63 @@ void hv_vss_onchannelcallback(void *context)
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
+		pr_info("VSS request received. Could not read into recv buf\n");
+		return;
+	}
+
+	if (!recvlen)
+		return;
+
+	/* Ensure recvlen is big enough to read header data */
+	if (recvlen < ICMSG_HDR) {
+		pr_info("VSS request received. Packet length too small: %d\n", recvlen);
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
+			pr_info("Invalid VSS msg. Packet length too small: %u\n",
+				recvlen);
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
+		pr_info("VSS request received. Invalid msg type: %d\n",
+			icmsghdrp->icmsgtype);
+		return;
 	}
 
+	icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION |
+		ICMSGHDRFLAG_RESPONSE;
+	vmbus_sendpacket(channel, recv_buffer, recvlen, requestid,
+			 VM_PKT_DATA_INBAND, 0);
 }
 
 static void vss_on_reset(void)
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 92ee0fe4c919..8b5d54d9db4d 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -195,73 +195,90 @@ static void shutdown_onchannelcallback(void *context)
 
 	struct icmsg_hdr *icmsghdrp;
 
-	vmbus_recvpacket(channel, shut_txf_buf,
-			 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
+	if (vmbus_recvpacket(channel, shut_txf_buf, HV_HYP_PAGE_SIZE, &recvlen, &requestid)) {
+		pr_info("Shutdown request received. Could not read into shut txf buf\n");
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
+		pr_info("Shutdown request received. Packet length too small: %d\n", recvlen);
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
+			pr_info("Invalid shutdown msg data. Packet length too small: %u\n",
+				recvlen);
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
+		pr_info("Shutdown request received. Invalid msg type: %d\n",
+			icmsghdrp->icmsgtype);
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
@@ -361,50 +378,70 @@ static void timesync_onchannelcallback(void *context)
 	struct ictimesync_ref_data *refdata;
 	u8 *time_txf_buf = util_timesynch.recv_buffer;
 
-	vmbus_recvpacket(channel, time_txf_buf,
-			 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
+	if (vmbus_recvpacket(channel, time_txf_buf, HV_HYP_PAGE_SIZE, &recvlen, &requestid)) {
+		pr_info("Timesync request received. Could not read into time txf buf\n");
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
+		pr_info("Timesync request received. Packet length too small: %d\n", recvlen);
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
+				pr_info("Invalid ictimesync ref data. Length too small: %u\n",
+					recvlen);
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
+				pr_info("Invalid ictimesync data. Length too small: %u\n",
+					recvlen);
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
+		pr_info("Timesync request received. Invalid msg type: %d\n",
+			icmsghdrp->icmsgtype);
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
@@ -423,18 +460,28 @@ static void heartbeat_onchannelcallback(void *context)
 
 	while (1) {
 
-		vmbus_recvpacket(channel, hbeat_txf_buf,
-				 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
+		if (vmbus_recvpacket(channel, hbeat_txf_buf, HV_HYP_PAGE_SIZE,
+				     &recvlen, &requestid)) {
+			pr_info("Heartbeat request received. Could not read into hbeat txf buf\n");
+			return;
+		}
 
 		if (!recvlen)
 			break;
 
+		/* Ensure recvlen is big enough to read header data */
+		if (recvlen < ICMSG_HDR) {
+			pr_info("Hearbeat request received. Packet length too small: %d\n",
+				recvlen);
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
@@ -443,13 +490,23 @@ static void heartbeat_onchannelcallback(void *context)
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
+				pr_info("Invalid heartbeat msg data. Length too small: %u\n",
+					recvlen);
+				break;
+			}
+			heartbeat_msg = (struct heartbeat_msg_data *)&hbeat_txf_buf[ICMSG_HDR];
 
 			heartbeat_msg->seq_num += 1;
+		} else {
+			icmsghdrp->status = HV_E_FAIL;
+			pr_info("Heartbeat request received. Invalid msg type: %d\n",
+				icmsghdrp->icmsgtype);
 		}
 
 		icmsghdrp->icflags = ICMSGHDRFLAG_TRANSACTION
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d8194924983d..3661eb2f765b 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1422,6 +1422,7 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size);
 #define ICMSGTYPE_SHUTDOWN		3
 #define ICMSGTYPE_TIMESYNC		4
 #define ICMSGTYPE_VSS			5
+#define ICMSGTYPE_FCOPY			7
 
 #define ICMSGHDRFLAG_TRANSACTION	1
 #define ICMSGHDRFLAG_REQUEST		2
@@ -1465,6 +1466,12 @@ struct icmsg_hdr {
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
@@ -1520,7 +1527,7 @@ struct hyperv_service_callback {
 };
 
 #define MAX_SRV_VER	0x7ffffff
-extern bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp, u8 *buf,
+extern bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp, u8 *buf, u32 buflen,
 				const int *fw_version, int fw_vercnt,
 				const int *srv_version, int srv_vercnt,
 				int *nego_fw_version, int *nego_srv_version);
-- 
2.25.1

