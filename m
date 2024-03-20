Return-Path: <linux-hyperv+bounces-1798-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA5880FE3
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 11:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8021C230D9
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEEB47A66;
	Wed, 20 Mar 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bWx99W+h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA3240C09;
	Wed, 20 Mar 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930592; cv=none; b=fq6izDfGaCgTGFhrUMKBtODqhZMNtQKPV/CGuWNp/8OLC5K2ilmENjAl9RaT/ChxemI6Ubyljbf5zjgDXAbBI/mprTPt33irvVy1NanGtev9A7elS48bsiCClZIZr7pYXe98lOwnwuYDu9/mashisU+0iqe1I0i+N43dPFSIces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930592; c=relaxed/simple;
	bh=JkrcuQxp+R6P8Ax5OswGJdTXT4zGltuGevtq/9LMThE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Zgpk5liUzJe9wn4Tj2zzTdNldVu3K+wWx0T4xp5/+Fb6tIw/ggeLJ/IErSQxgDHt5ymRdurYQkf/SxDbOhUxrP6p36MJRatnAnSYPTDSkrn3+s2Fd19FqWAyJThjCabsM7/85c2yVpkHxYcDYeDJLksMEYLDfKLARzD1qSC0V5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bWx99W+h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 88C6620B74C6;
	Wed, 20 Mar 2024 03:29:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88C6620B74C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710930588;
	bh=GZwlvox7fxMHY0eN6xxnKrmAEKpXL6Xi9iTNKRTzuBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWx99W+hPFwL0PecQ1ZtUFlPR07Unwr9qalQdmQDD2USHlpWOhaITSm8B0cergu8N
	 7nZ4FdCtixH1zKQtIbEIzyCj7QdcPNz9wopa4Oq8biPOTN28uPiK+97C9UOmHXMpOK
	 5A1Kypp7vXjUj27d7ntnZIKZZJzwcT7lUonH2zOE=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: longli@microsoft.com,
	ssengar@microsoft.com
Subject: [PATCH v2 6/7] Drivers: hv: Remove fcopy driver
Date: Wed, 20 Mar 2024 03:29:43 -0700
Message-Id: <1710930584-31180-7-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
References: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

As the new fcopy driver using uio is introduced, remove obsolete driver
and application.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
[V2]
- Added Reviewed-by form Long Li

 drivers/hv/Makefile        |   2 +-
 drivers/hv/hv_fcopy.c      | 427 -------------------------------------
 drivers/hv/hv_util.c       |  12 --
 tools/hv/hv_fcopy_daemon.c | 266 -----------------------
 4 files changed, 1 insertion(+), 706 deletions(-)
 delete mode 100644 drivers/hv/hv_fcopy.c
 delete mode 100644 tools/hv/hv_fcopy_daemon.c

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index d76df5c8c2a9..b992c0ed182b 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -10,7 +10,7 @@ hv_vmbus-y := vmbus_drv.o \
 		 hv.o connection.o channel.o \
 		 channel_mgmt.o ring_buffer.o hv_trace.o
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
-hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_fcopy.o hv_utils_transport.o
+hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 
 # Code that must be built-in
 obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
deleted file mode 100644
index 922d83eb7ddf..000000000000
--- a/drivers/hv/hv_fcopy.c
+++ /dev/null
@@ -1,427 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * An implementation of file copy service.
- *
- * Copyright (C) 2014, Microsoft, Inc.
- *
- * Author : K. Y. Srinivasan <ksrinivasan@novell.com>
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/nls.h>
-#include <linux/workqueue.h>
-#include <linux/hyperv.h>
-#include <linux/sched.h>
-#include <asm/hyperv-tlfs.h>
-
-#include "hyperv_vmbus.h"
-#include "hv_utils_transport.h"
-
-#define WIN8_SRV_MAJOR		1
-#define WIN8_SRV_MINOR		1
-#define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 | WIN8_SRV_MINOR)
-
-#define FCOPY_VER_COUNT 1
-static const int fcopy_versions[] = {
-	WIN8_SRV_VERSION
-};
-
-#define FW_VER_COUNT 1
-static const int fw_versions[] = {
-	UTIL_FW_VERSION
-};
-
-/*
- * Global state maintained for transaction that is being processed.
- * For a class of integration services, including the "file copy service",
- * the specified protocol is a "request/response" protocol which means that
- * there can only be single outstanding transaction from the host at any
- * given point in time. We use this to simplify memory management in this
- * driver - we cache and process only one message at a time.
- *
- * While the request/response protocol is guaranteed by the host, we further
- * ensure this by serializing packet processing in this driver - we do not
- * read additional packets from the VMBUs until the current packet is fully
- * handled.
- */
-
-static struct {
-	int state;   /* hvutil_device_state */
-	int recv_len; /* number of bytes received. */
-	struct hv_fcopy_hdr  *fcopy_msg; /* current message */
-	struct vmbus_channel *recv_channel; /* chn we got the request */
-	u64 recv_req_id; /* request ID. */
-} fcopy_transaction;
-
-static void fcopy_respond_to_host(int error);
-static void fcopy_send_data(struct work_struct *dummy);
-static void fcopy_timeout_func(struct work_struct *dummy);
-static DECLARE_DELAYED_WORK(fcopy_timeout_work, fcopy_timeout_func);
-static DECLARE_WORK(fcopy_send_work, fcopy_send_data);
-static const char fcopy_devname[] = "vmbus/hv_fcopy";
-static u8 *recv_buffer;
-static struct hvutil_transport *hvt;
-/*
- * This state maintains the version number registered by the daemon.
- */
-static int dm_reg_value;
-
-static void fcopy_poll_wrapper(void *channel)
-{
-	/* Transaction is finished, reset the state here to avoid races. */
-	fcopy_transaction.state = HVUTIL_READY;
-	tasklet_schedule(&((struct vmbus_channel *)channel)->callback_event);
-}
-
-static void fcopy_timeout_func(struct work_struct *dummy)
-{
-	/*
-	 * If the timer fires, the user-mode component has not responded;
-	 * process the pending transaction.
-	 */
-	fcopy_respond_to_host(HV_E_FAIL);
-	hv_poll_channel(fcopy_transaction.recv_channel, fcopy_poll_wrapper);
-}
-
-static void fcopy_register_done(void)
-{
-	pr_debug("FCP: userspace daemon registered\n");
-	hv_poll_channel(fcopy_transaction.recv_channel, fcopy_poll_wrapper);
-}
-
-static int fcopy_handle_handshake(u32 version)
-{
-	u32 our_ver = FCOPY_CURRENT_VERSION;
-
-	switch (version) {
-	case FCOPY_VERSION_0:
-		/* Daemon doesn't expect us to reply */
-		dm_reg_value = version;
-		break;
-	case FCOPY_VERSION_1:
-		/* Daemon expects us to reply with our own version */
-		if (hvutil_transport_send(hvt, &our_ver, sizeof(our_ver),
-		    fcopy_register_done))
-			return -EFAULT;
-		dm_reg_value = version;
-		break;
-	default:
-		/*
-		 * For now we will fail the registration.
-		 * If and when we have multiple versions to
-		 * deal with, we will be backward compatible.
-		 * We will add this code when needed.
-		 */
-		return -EINVAL;
-	}
-	pr_debug("FCP: userspace daemon ver. %d connected\n", version);
-	return 0;
-}
-
-static void fcopy_send_data(struct work_struct *dummy)
-{
-	struct hv_start_fcopy *smsg_out = NULL;
-	int operation = fcopy_transaction.fcopy_msg->operation;
-	struct hv_start_fcopy *smsg_in;
-	void *out_src;
-	int rc, out_len;
-
-	/*
-	 * The  strings sent from the host are encoded in
-	 * utf16; convert it to utf8 strings.
-	 * The host assures us that the utf16 strings will not exceed
-	 * the max lengths specified. We will however, reserve room
-	 * for the string terminating character - in the utf16s_utf8s()
-	 * function we limit the size of the buffer where the converted
-	 * string is placed to W_MAX_PATH -1 to guarantee
-	 * that the strings can be properly terminated!
-	 */
-
-	switch (operation) {
-	case START_FILE_COPY:
-		out_len = sizeof(struct hv_start_fcopy);
-		smsg_out = kzalloc(sizeof(*smsg_out), GFP_KERNEL);
-		if (!smsg_out)
-			return;
-
-		smsg_out->hdr.operation = operation;
-		smsg_in = (struct hv_start_fcopy *)fcopy_transaction.fcopy_msg;
-
-		utf16s_to_utf8s((wchar_t *)smsg_in->file_name, W_MAX_PATH,
-				UTF16_LITTLE_ENDIAN,
-				(__u8 *)&smsg_out->file_name, W_MAX_PATH - 1);
-
-		utf16s_to_utf8s((wchar_t *)smsg_in->path_name, W_MAX_PATH,
-				UTF16_LITTLE_ENDIAN,
-				(__u8 *)&smsg_out->path_name, W_MAX_PATH - 1);
-
-		smsg_out->copy_flags = smsg_in->copy_flags;
-		smsg_out->file_size = smsg_in->file_size;
-		out_src = smsg_out;
-		break;
-
-	case WRITE_TO_FILE:
-		out_src = fcopy_transaction.fcopy_msg;
-		out_len = sizeof(struct hv_do_fcopy);
-		break;
-	default:
-		out_src = fcopy_transaction.fcopy_msg;
-		out_len = fcopy_transaction.recv_len;
-		break;
-	}
-
-	fcopy_transaction.state = HVUTIL_USERSPACE_REQ;
-	rc = hvutil_transport_send(hvt, out_src, out_len, NULL);
-	if (rc) {
-		pr_debug("FCP: failed to communicate to the daemon: %d\n", rc);
-		if (cancel_delayed_work_sync(&fcopy_timeout_work)) {
-			fcopy_respond_to_host(HV_E_FAIL);
-			fcopy_transaction.state = HVUTIL_READY;
-		}
-	}
-	kfree(smsg_out);
-}
-
-/*
- * Send a response back to the host.
- */
-
-static void
-fcopy_respond_to_host(int error)
-{
-	struct icmsg_hdr *icmsghdr;
-	u32 buf_len;
-	struct vmbus_channel *channel;
-	u64 req_id;
-
-	/*
-	 * Copy the global state for completing the transaction. Note that
-	 * only one transaction can be active at a time. This is guaranteed
-	 * by the file copy protocol implemented by the host. Furthermore,
-	 * the "transaction active" state we maintain ensures that there can
-	 * only be one active transaction at a time.
-	 */
-
-	buf_len = fcopy_transaction.recv_len;
-	channel = fcopy_transaction.recv_channel;
-	req_id = fcopy_transaction.recv_req_id;
-
-	icmsghdr = (struct icmsg_hdr *)
-			&recv_buffer[sizeof(struct vmbuspipe_hdr)];
-
-	if (channel->onchannel_callback == NULL)
-		/*
-		 * We have raced with util driver being unloaded;
-		 * silently return.
-		 */
-		return;
-
-	icmsghdr->status = error;
-	icmsghdr->icflags = ICMSGHDRFLAG_TRANSACTION | ICMSGHDRFLAG_RESPONSE;
-	vmbus_sendpacket(channel, recv_buffer, buf_len, req_id,
-				VM_PKT_DATA_INBAND, 0);
-}
-
-void hv_fcopy_onchannelcallback(void *context)
-{
-	struct vmbus_channel *channel = context;
-	u32 recvlen;
-	u64 requestid;
-	struct hv_fcopy_hdr *fcopy_msg;
-	struct icmsg_hdr *icmsghdr;
-	int fcopy_srv_version;
-
-	if (fcopy_transaction.state > HVUTIL_READY)
-		return;
-
-	if (vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 2, &recvlen, &requestid)) {
-		pr_err_ratelimited("Fcopy request received. Could not read into recv buf\n");
-		return;
-	}
-
-	if (!recvlen)
-		return;
-
-	/* Ensure recvlen is big enough to read header data */
-	if (recvlen < ICMSG_HDR) {
-		pr_err_ratelimited("Fcopy request received. Packet length too small: %d\n",
-				   recvlen);
-		return;
-	}
-
-	icmsghdr = (struct icmsg_hdr *)&recv_buffer[
-			sizeof(struct vmbuspipe_hdr)];
-
-	if (icmsghdr->icmsgtype == ICMSGTYPE_NEGOTIATE) {
-		if (vmbus_prep_negotiate_resp(icmsghdr,
-				recv_buffer, recvlen,
-				fw_versions, FW_VER_COUNT,
-				fcopy_versions, FCOPY_VER_COUNT,
-				NULL, &fcopy_srv_version)) {
-
-			pr_info("FCopy IC version %d.%d\n",
-				fcopy_srv_version >> 16,
-				fcopy_srv_version & 0xFFFF);
-		}
-	} else if (icmsghdr->icmsgtype == ICMSGTYPE_FCOPY) {
-		/* Ensure recvlen is big enough to contain hv_fcopy_hdr */
-		if (recvlen < ICMSG_HDR + sizeof(struct hv_fcopy_hdr)) {
-			pr_err_ratelimited("Invalid Fcopy hdr. Packet length too small: %u\n",
-					   recvlen);
-			return;
-		}
-		fcopy_msg = (struct hv_fcopy_hdr *)&recv_buffer[ICMSG_HDR];
-
-		/*
-		 * Stash away this global state for completing the
-		 * transaction; note transactions are serialized.
-		 */
-
-		fcopy_transaction.recv_len = recvlen;
-		fcopy_transaction.recv_req_id = requestid;
-		fcopy_transaction.fcopy_msg = fcopy_msg;
-
-		if (fcopy_transaction.state < HVUTIL_READY) {
-			/* Userspace is not registered yet */
-			fcopy_respond_to_host(HV_E_FAIL);
-			return;
-		}
-		fcopy_transaction.state = HVUTIL_HOSTMSG_RECEIVED;
-
-		/*
-		 * Send the information to the user-level daemon.
-		 */
-		schedule_work(&fcopy_send_work);
-		schedule_delayed_work(&fcopy_timeout_work,
-				      HV_UTIL_TIMEOUT * HZ);
-		return;
-	} else {
-		pr_err_ratelimited("Fcopy request received. Invalid msg type: %d\n",
-				   icmsghdr->icmsgtype);
-		return;
-	}
-	icmsghdr->icflags = ICMSGHDRFLAG_TRANSACTION | ICMSGHDRFLAG_RESPONSE;
-	vmbus_sendpacket(channel, recv_buffer, recvlen, requestid,
-			VM_PKT_DATA_INBAND, 0);
-}
-
-/* Callback when data is received from userspace */
-static int fcopy_on_msg(void *msg, int len)
-{
-	int *val = (int *)msg;
-
-	if (len != sizeof(int))
-		return -EINVAL;
-
-	if (fcopy_transaction.state == HVUTIL_DEVICE_INIT)
-		return fcopy_handle_handshake(*val);
-
-	if (fcopy_transaction.state != HVUTIL_USERSPACE_REQ)
-		return -EINVAL;
-
-	/*
-	 * Complete the transaction by forwarding the result
-	 * to the host. But first, cancel the timeout.
-	 */
-	if (cancel_delayed_work_sync(&fcopy_timeout_work)) {
-		fcopy_transaction.state = HVUTIL_USERSPACE_RECV;
-		fcopy_respond_to_host(*val);
-		hv_poll_channel(fcopy_transaction.recv_channel,
-				fcopy_poll_wrapper);
-	}
-
-	return 0;
-}
-
-static void fcopy_on_reset(void)
-{
-	/*
-	 * The daemon has exited; reset the state.
-	 */
-	fcopy_transaction.state = HVUTIL_DEVICE_INIT;
-
-	if (cancel_delayed_work_sync(&fcopy_timeout_work))
-		fcopy_respond_to_host(HV_E_FAIL);
-}
-
-int hv_fcopy_init(struct hv_util_service *srv)
-{
-	recv_buffer = srv->recv_buffer;
-	fcopy_transaction.recv_channel = srv->channel;
-	fcopy_transaction.recv_channel->max_pkt_size = HV_HYP_PAGE_SIZE * 2;
-
-	/*
-	 * When this driver loads, the user level daemon that
-	 * processes the host requests may not yet be running.
-	 * Defer processing channel callbacks until the daemon
-	 * has registered.
-	 */
-	fcopy_transaction.state = HVUTIL_DEVICE_INIT;
-
-	hvt = hvutil_transport_init(fcopy_devname, 0, 0,
-				    fcopy_on_msg, fcopy_on_reset);
-	if (!hvt)
-		return -EFAULT;
-
-	return 0;
-}
-
-static void hv_fcopy_cancel_work(void)
-{
-	cancel_delayed_work_sync(&fcopy_timeout_work);
-	cancel_work_sync(&fcopy_send_work);
-}
-
-int hv_fcopy_pre_suspend(void)
-{
-	struct vmbus_channel *channel = fcopy_transaction.recv_channel;
-	struct hv_fcopy_hdr *fcopy_msg;
-
-	/*
-	 * Fake a CANCEL_FCOPY message for the user space daemon in case the
-	 * daemon is in the middle of copying some file. It doesn't matter if
-	 * there is already a message pending to be delivered to the user
-	 * space since we force fcopy_transaction.state to be HVUTIL_READY, so
-	 * the user space daemon's write() will fail with EINVAL (see
-	 * fcopy_on_msg()), and the daemon will reset the device by closing
-	 * and re-opening it.
-	 */
-	fcopy_msg = kzalloc(sizeof(*fcopy_msg), GFP_KERNEL);
-	if (!fcopy_msg)
-		return -ENOMEM;
-
-	tasklet_disable(&channel->callback_event);
-
-	fcopy_msg->operation = CANCEL_FCOPY;
-
-	hv_fcopy_cancel_work();
-
-	/* We don't care about the return value. */
-	hvutil_transport_send(hvt, fcopy_msg, sizeof(*fcopy_msg), NULL);
-
-	kfree(fcopy_msg);
-
-	fcopy_transaction.state = HVUTIL_READY;
-
-	/* tasklet_enable() will be called in hv_fcopy_pre_resume(). */
-	return 0;
-}
-
-int hv_fcopy_pre_resume(void)
-{
-	struct vmbus_channel *channel = fcopy_transaction.recv_channel;
-
-	tasklet_enable(&channel->callback_event);
-
-	return 0;
-}
-
-void hv_fcopy_deinit(void)
-{
-	fcopy_transaction.state = HVUTIL_DEVICE_DYING;
-
-	hv_fcopy_cancel_work();
-
-	hvutil_transport_destroy(hvt);
-}
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 9c97c4065fe7..c4f525325790 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -154,14 +154,6 @@ static struct hv_util_service util_vss = {
 	.util_deinit = hv_vss_deinit,
 };
 
-static struct hv_util_service util_fcopy = {
-	.util_cb = hv_fcopy_onchannelcallback,
-	.util_init = hv_fcopy_init,
-	.util_pre_suspend = hv_fcopy_pre_suspend,
-	.util_pre_resume = hv_fcopy_pre_resume,
-	.util_deinit = hv_fcopy_deinit,
-};
-
 static void perform_shutdown(struct work_struct *dummy)
 {
 	orderly_poweroff(true);
@@ -700,10 +692,6 @@ static const struct hv_vmbus_device_id id_table[] = {
 	{ HV_VSS_GUID,
 	  .driver_data = (unsigned long)&util_vss
 	},
-	/* File copy GUID */
-	{ HV_FCOPY_GUID,
-	  .driver_data = (unsigned long)&util_fcopy
-	},
 	{ },
 };
 
diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
deleted file mode 100644
index 16d629b22c25..000000000000
--- a/tools/hv/hv_fcopy_daemon.c
+++ /dev/null
@@ -1,266 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * An implementation of host to guest copy functionality for Linux.
- *
- * Copyright (C) 2014, Microsoft, Inc.
- *
- * Author : K. Y. Srinivasan <kys@microsoft.com>
- */
-
-
-#include <sys/types.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include <linux/hyperv.h>
-#include <linux/limits.h>
-#include <syslog.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <getopt.h>
-
-static int target_fd;
-static char target_fname[PATH_MAX];
-static unsigned long long filesize;
-
-static int hv_start_fcopy(struct hv_start_fcopy *smsg)
-{
-	int error = HV_E_FAIL;
-	char *q, *p;
-
-	filesize = 0;
-	p = (char *)smsg->path_name;
-	snprintf(target_fname, sizeof(target_fname), "%s/%s",
-		 (char *)smsg->path_name, (char *)smsg->file_name);
-
-	syslog(LOG_INFO, "Target file name: %s", target_fname);
-	/*
-	 * Check to see if the path is already in place; if not,
-	 * create if required.
-	 */
-	while ((q = strchr(p, '/')) != NULL) {
-		if (q == p) {
-			p++;
-			continue;
-		}
-		*q = '\0';
-		if (access((char *)smsg->path_name, F_OK)) {
-			if (smsg->copy_flags & CREATE_PATH) {
-				if (mkdir((char *)smsg->path_name, 0755)) {
-					syslog(LOG_ERR, "Failed to create %s",
-						(char *)smsg->path_name);
-					goto done;
-				}
-			} else {
-				syslog(LOG_ERR, "Invalid path: %s",
-					(char *)smsg->path_name);
-				goto done;
-			}
-		}
-		p = q + 1;
-		*q = '/';
-	}
-
-	if (!access(target_fname, F_OK)) {
-		syslog(LOG_INFO, "File: %s exists", target_fname);
-		if (!(smsg->copy_flags & OVER_WRITE)) {
-			error = HV_ERROR_ALREADY_EXISTS;
-			goto done;
-		}
-	}
-
-	target_fd = open(target_fname,
-			 O_RDWR | O_CREAT | O_TRUNC | O_CLOEXEC, 0744);
-	if (target_fd == -1) {
-		syslog(LOG_INFO, "Open Failed: %s", strerror(errno));
-		goto done;
-	}
-
-	error = 0;
-done:
-	if (error)
-		target_fname[0] = '\0';
-	return error;
-}
-
-static int hv_copy_data(struct hv_do_fcopy *cpmsg)
-{
-	ssize_t bytes_written;
-	int ret = 0;
-
-	bytes_written = pwrite(target_fd, cpmsg->data, cpmsg->size,
-				cpmsg->offset);
-
-	filesize += cpmsg->size;
-	if (bytes_written != cpmsg->size) {
-		switch (errno) {
-		case ENOSPC:
-			ret = HV_ERROR_DISK_FULL;
-			break;
-		default:
-			ret = HV_E_FAIL;
-			break;
-		}
-		syslog(LOG_ERR, "pwrite failed to write %llu bytes: %ld (%s)",
-		       filesize, (long)bytes_written, strerror(errno));
-	}
-
-	return ret;
-}
-
-/*
- * Reset target_fname to "" in the two below functions for hibernation: if
- * the fcopy operation is aborted by hibernation, the daemon should remove the
- * partially-copied file; to achieve this, the hv_utils driver always fakes a
- * CANCEL_FCOPY message upon suspend, and later when the VM resumes back,
- * the daemon calls hv_copy_cancel() to remove the file; if a file is copied
- * successfully before suspend, hv_copy_finished() must reset target_fname to
- * avoid that the file can be incorrectly removed upon resume, since the faked
- * CANCEL_FCOPY message is spurious in this case.
- */
-static int hv_copy_finished(void)
-{
-	close(target_fd);
-	target_fname[0] = '\0';
-	return 0;
-}
-static int hv_copy_cancel(void)
-{
-	close(target_fd);
-	if (strlen(target_fname) > 0) {
-		unlink(target_fname);
-		target_fname[0] = '\0';
-	}
-	return 0;
-
-}
-
-void print_usage(char *argv[])
-{
-	fprintf(stderr, "Usage: %s [options]\n"
-		"Options are:\n"
-		"  -n, --no-daemon        stay in foreground, don't daemonize\n"
-		"  -h, --help             print this help\n", argv[0]);
-}
-
-int main(int argc, char *argv[])
-{
-	int fcopy_fd = -1;
-	int error;
-	int daemonize = 1, long_index = 0, opt;
-	int version = FCOPY_CURRENT_VERSION;
-	union {
-		struct hv_fcopy_hdr hdr;
-		struct hv_start_fcopy start;
-		struct hv_do_fcopy copy;
-		__u32 kernel_modver;
-	} buffer = { };
-	int in_handshake;
-
-	static struct option long_options[] = {
-		{"help",	no_argument,	   0,  'h' },
-		{"no-daemon",	no_argument,	   0,  'n' },
-		{0,		0,		   0,  0   }
-	};
-
-	while ((opt = getopt_long(argc, argv, "hn", long_options,
-				  &long_index)) != -1) {
-		switch (opt) {
-		case 'n':
-			daemonize = 0;
-			break;
-		case 'h':
-		default:
-			print_usage(argv);
-			exit(EXIT_FAILURE);
-		}
-	}
-
-	if (daemonize && daemon(1, 0)) {
-		syslog(LOG_ERR, "daemon() failed; error: %s", strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-
-	openlog("HV_FCOPY", 0, LOG_USER);
-	syslog(LOG_INFO, "starting; pid is:%d", getpid());
-
-reopen_fcopy_fd:
-	if (fcopy_fd != -1)
-		close(fcopy_fd);
-	/* Remove any possible partially-copied file on error */
-	hv_copy_cancel();
-	in_handshake = 1;
-	fcopy_fd = open("/dev/vmbus/hv_fcopy", O_RDWR);
-
-	if (fcopy_fd < 0) {
-		syslog(LOG_ERR, "open /dev/vmbus/hv_fcopy failed; error: %d %s",
-			errno, strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-
-	/*
-	 * Register with the kernel.
-	 */
-	if ((write(fcopy_fd, &version, sizeof(int))) != sizeof(int)) {
-		syslog(LOG_ERR, "Registration failed: %s", strerror(errno));
-		exit(EXIT_FAILURE);
-	}
-
-	while (1) {
-		/*
-		 * In this loop we process fcopy messages after the
-		 * handshake is complete.
-		 */
-		ssize_t len;
-
-		len = pread(fcopy_fd, &buffer, sizeof(buffer), 0);
-		if (len < 0) {
-			syslog(LOG_ERR, "pread failed: %s", strerror(errno));
-			goto reopen_fcopy_fd;
-		}
-
-		if (in_handshake) {
-			if (len != sizeof(buffer.kernel_modver)) {
-				syslog(LOG_ERR, "invalid version negotiation");
-				exit(EXIT_FAILURE);
-			}
-			in_handshake = 0;
-			syslog(LOG_INFO, "kernel module version: %u",
-			       buffer.kernel_modver);
-			continue;
-		}
-
-		switch (buffer.hdr.operation) {
-		case START_FILE_COPY:
-			error = hv_start_fcopy(&buffer.start);
-			break;
-		case WRITE_TO_FILE:
-			error = hv_copy_data(&buffer.copy);
-			break;
-		case COMPLETE_FCOPY:
-			error = hv_copy_finished();
-			break;
-		case CANCEL_FCOPY:
-			error = hv_copy_cancel();
-			break;
-
-		default:
-			error = HV_E_FAIL;
-			syslog(LOG_ERR, "Unknown operation: %d",
-				buffer.hdr.operation);
-
-		}
-
-		/*
-		 * pwrite() may return an error due to the faked CANCEL_FCOPY
-		 * message upon hibernation. Ignore the error by resetting the
-		 * dev file, i.e. closing and re-opening it.
-		 */
-		if (pwrite(fcopy_fd, &error, sizeof(int), 0) != sizeof(int)) {
-			syslog(LOG_ERR, "pwrite failed: %s", strerror(errno));
-			goto reopen_fcopy_fd;
-		}
-	}
-}
-- 
2.34.1


