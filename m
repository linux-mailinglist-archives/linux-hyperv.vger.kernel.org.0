Return-Path: <linux-hyperv+bounces-9574-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFiqAbRbvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9574-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:25:24 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C382D20C3
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 623B1302960A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6593F7E8B;
	Thu, 19 Mar 2026 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byoJb4WK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535C387368
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951919; cv=none; b=kGBgr7M4wN38G3Jj2t153i46rBc6pePp6AF8V9uwQwub50GZLMkn5RjRT4NDk3MdGmRkZYBHtMbum7ysYUs/rf4uZeUwhUs3qI03MNKP/Ca6PvECK1sqxm68cXM7bWNF96AW7XpqYJ+hcibicbDvkej35fnAIse4FP7AdXrtK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951919; c=relaxed/simple;
	bh=rf9C9hNgxWx2kMLhpGO21VXiqOAsEUYHcjwCPuzzl9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POTIJwY+KI7sKoxm6PKieyJ5897GefI8su+79sNH4qwt7L9KN1wv33o6nhuwAmhBh2ty5kA3CJNddv9lf4+VZITUrSCSCDFhnbSpIUAVHwCZ6HjaDa87RSUYQR2Z5z18ULwNihV+95sBoJpn2ag1cJCl/OBkRStEoaG31i/kV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byoJb4WK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48538c5956bso12088985e9.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951915; x=1774556715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xJZuo2ZZgXft86owpVORMUXvi8FA22p3zGYoG+woB0=;
        b=byoJb4WKtfk8ZgAU33EqlQQggPRuC6luZAVBDneWQSwlNgpgkb0FS+Q3u0JQ643aI1
         DsNq/pADGxwp+fPSErtW0nASuFTxB5CRa4mmBb+hstfULqhxKJbIEhdnH5aeCMofXfmS
         Qv6dYjHXygijn0CSLrcqiskZ4lqknslhiWcEl0yUGajGIPshx3Ef7NGGxu+cNDSU2Key
         4+Z0Pb0pHYVRvaYmgP5rxf0rd3f2s2QJoZ7wgWtf6Ni3cdB6XxGHy+SkikWXc7jkOIlp
         H1gbRZabjmUlf945zYr2HqEkATCVPCZ/eN8LAtR+hPW7DBGYTqh3JL7VQj46Pcs4f9ev
         aCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951915; x=1774556715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xJZuo2ZZgXft86owpVORMUXvi8FA22p3zGYoG+woB0=;
        b=ZfoAxP5EQg92U2hFbaz6Z68aNnTbM8h0j5msxhESGWPazV7YWkyevF6B84cm4BEZD8
         aVSZxrdLzFegdVUFtDB4igqgrHXF14c5flh9jR8UHDsvxa3CCZeg1/qCAFytzRC1drkk
         SXYrjSojCuBVtLTZa8dmV+KMJ5ga305oYUDmzginUp0+SazYDg/4rGajiavp2BPDPoDd
         mPMECyymF7ohWdqZNo55pGlZyGZgWlGfDPI0qPRyQLROn9o68dnEbvS98pPsfxw63Phn
         3nclMzKpO8VIOs2+tcieUV1iA3YzO/pTM9SdmnoSeVhaA+WbvZ+Pgg4Na2fFlN33bysS
         +EFw==
X-Gm-Message-State: AOJu0Yx0+/oJOYZJvMwIgn0fx5Tkn+D/lDBpnlEuo0iG+7r8abZjlOmT
	5qaeWsan1B7S90QbqYhTby+6mKkAbqSB9dqK4bwRPMa2NztdOEzsSClXFAGkkBe0PgQ=
X-Gm-Gg: ATEYQzzNqy9kgLAEWl1cOHBptEDDWbA5A41bO70vz3OOdENxb672jYfQPCE9vFlxJUr
	l174CT/Vft0H0sEX0vyCphDJl77Y78Irkn11RV5/f3Ox6ZsM9EVCybESW0SrsJI/AJdvz5HR+Ed
	rys8humEfGqNrYT53dGd/G1PEEy4JyaY7RqXtfozCcBA8NE6BJLqVymoUbpYUqAIFlB+jY9kccZ
	MidWdW4+X4F9FX9kNKFGqcDTMpYTOZOau+WYoKXAAB/g5/mWRNjMTtCaqHy8oA3HpTCuO6qzd2X
	+ImHAKIECIta5sNi9JXSeakNLtQhl+C0dOhOeIQ1FXm6Ke/jHJ7hsEETLrrMrNfmM3YgStbnwaQ
	AsB7jbmt/qjoTh8jbYQQlGRmqhZIoiTP0/1qdmHA3WGG4CSqnRX6OG92w9fryvFrMw7/8dnqYDT
	HNi0bhstCbHb4sUD74UGATHeCbqGNkjBSE9FbG0DX4VVP9pEhV
X-Received: by 2002:a05:600c:3e10:b0:485:3428:774c with SMTP id 5b1f17b1804b1-486fe8b0073mr11988675e9.4.1773951914869;
        Thu, 19 Mar 2026 13:25:14 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:14 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 02/55] drivers: hv: dxgkrnl: Add VMBus message support, initialize VMBus channels.
Date: Thu, 19 Mar 2026 20:24:16 +0000
Message-ID: <20260319202509.63802-3-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9574-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.933];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,libdxcore.so:url]
X-Rspamd-Queue-Id: 72C382D20C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement support for sending/receiving VMBus messages between
the host and the guest.

Initialize the VMBus channels and notify the host about IO space
settings of the VMBus global channel.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h   |  14 ++
 drivers/hv/dxgkrnl/dxgmodule.c |   9 +-
 drivers/hv/dxgkrnl/dxgvmbus.c  | 318 +++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h  |  67 +++++++
 drivers/hv/dxgkrnl/ioctl.c     |  24 +++
 drivers/hv/dxgkrnl/misc.h      |  72 ++++++++
 include/uapi/misc/d3dkmthk.h   |  34 ++++
 7 files changed, 536 insertions(+), 2 deletions(-)
 create mode 100644 drivers/hv/dxgkrnl/ioctl.c
 create mode 100644 drivers/hv/dxgkrnl/misc.h

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index f7900840d1ed..52b9e82c51e6 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -28,6 +28,8 @@
 #include <linux/hyperv.h>
 #include <uapi/misc/d3dkmthk.h>
 #include <linux/version.h>
+#include "misc.h"
+#include <uapi/misc/d3dkmthk.h>
 
 struct dxgadapter;
 
@@ -100,6 +102,13 @@ static inline struct dxgglobal *dxggbl(void)
 	return dxgdrv.dxgglobal;
 }
 
+int dxgglobal_init_global_channel(void);
+void dxgglobal_destroy_global_channel(void);
+struct vmbus_channel *dxgglobal_get_vmbus(void);
+struct dxgvmbuschannel *dxgglobal_get_dxgvmbuschannel(void);
+int dxgglobal_acquire_channel_lock(void);
+void dxgglobal_release_channel_lock(void);
+
 struct dxgprocess {
 	/* Placeholder */
 };
@@ -130,6 +139,11 @@ static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
 #define DXGK_VMBUS_INTERFACE_VERSION			40
 #define DXGK_VMBUS_LAST_COMPATIBLE_INTERFACE_VERSION	16
 
+void dxgvmb_initialize(void);
+int dxgvmb_send_set_iospace_region(u64 start, u64 len);
+
+int ntstatus2int(struct ntstatus status);
+
 #ifdef DEBUG
 
 void dxgk_validate_ioctls(void);
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index de02edc4d023..e55639dc0adc 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -260,6 +260,13 @@ int dxgglobal_init_global_channel(void)
 		goto error;
 	}
 
+	ret = dxgvmb_send_set_iospace_region(dxgglobal->mmiospace_base,
+					     dxgglobal->mmiospace_size);
+	if (ret < 0) {
+		DXG_ERR("send_set_iospace_region failed");
+		goto error;
+	}
+
 	hv_set_drvdata(dxgglobal->hdev, dxgglobal);
 
 error:
@@ -429,8 +436,6 @@ static void dxgglobal_destroy(struct dxgglobal *dxgglobal)
 		if (dxgglobal->vmbus_registered)
 			vmbus_driver_unregister(&dxgdrv.vmbus_drv);
 
-		dxgglobal_destroy_global_channel();
-
 		if (dxgglobal->pci_registered)
 			pci_unregister_driver(&dxgdrv.pci_drv);
 
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index deb880e34377..a4365739826a 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -40,6 +40,121 @@ struct dxgvmbuspacket {
 	bool completed;
 };
 
+struct dxgvmb_ext_header {
+	/* Offset from the start of the message to DXGKVMB_COMMAND_BASE */
+	u32		command_offset;
+	u32		reserved;
+	struct winluid	vgpu_luid;
+};
+
+#define VMBUSMESSAGEONSTACK	64
+
+struct dxgvmbusmsg {
+/* Points to the allocated buffer */
+	struct dxgvmb_ext_header	*hdr;
+/* Points to dxgkvmb_command_vm_to_host or dxgkvmb_command_vgpu_to_host */
+	void				*msg;
+/* The vm bus channel, used to pass the message to the host */
+	struct dxgvmbuschannel		*channel;
+/* Message size in bytes including the header and the payload */
+	u32				size;
+/* Buffer used for small messages */
+	char				msg_on_stack[VMBUSMESSAGEONSTACK];
+};
+
+struct dxgvmbusmsgres {
+/* Points to the allocated buffer */
+	struct dxgvmb_ext_header	*hdr;
+/* Points to dxgkvmb_command_vm_to_host or dxgkvmb_command_vgpu_to_host */
+	void				*msg;
+/* The vm bus channel, used to pass the message to the host */
+	struct dxgvmbuschannel		*channel;
+/* Message size in bytes including the header, the payload and the result */
+	u32				size;
+/* Result buffer size in bytes */
+	u32				res_size;
+/* Points to the result within the allocated buffer */
+	void				*res;
+};
+
+static int init_message(struct dxgvmbusmsg *msg,
+			struct dxgprocess *process, u32 size)
+{
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	bool use_ext_header = dxgglobal->vmbus_ver >=
+			      DXGK_VMBUS_INTERFACE_VERSION;
+
+	if (use_ext_header)
+		size += sizeof(struct dxgvmb_ext_header);
+	msg->size = size;
+	if (size <= VMBUSMESSAGEONSTACK) {
+		msg->hdr = (void *)msg->msg_on_stack;
+		memset(msg->hdr, 0, size);
+	} else {
+		msg->hdr = vzalloc(size);
+		if (msg->hdr == NULL)
+			return -ENOMEM;
+	}
+	if (use_ext_header) {
+		msg->msg = (char *)&msg->hdr[1];
+		msg->hdr->command_offset = sizeof(msg->hdr[0]);
+	} else {
+		msg->msg = (char *)msg->hdr;
+	}
+	msg->channel = &dxgglobal->channel;
+	return 0;
+}
+
+static void free_message(struct dxgvmbusmsg *msg, struct dxgprocess *process)
+{
+	if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
+		vfree(msg->hdr);
+}
+
+/*
+ * Helper functions
+ */
+
+int ntstatus2int(struct ntstatus status)
+{
+	if (NT_SUCCESS(status))
+		return (int)status.v;
+	switch (status.v) {
+	case STATUS_OBJECT_NAME_COLLISION:
+		return -EEXIST;
+	case STATUS_NO_MEMORY:
+		return -ENOMEM;
+	case STATUS_INVALID_PARAMETER:
+		return -EINVAL;
+	case STATUS_OBJECT_NAME_INVALID:
+	case STATUS_OBJECT_NAME_NOT_FOUND:
+		return -ENOENT;
+	case STATUS_TIMEOUT:
+		return -EAGAIN;
+	case STATUS_BUFFER_TOO_SMALL:
+		return -EOVERFLOW;
+	case STATUS_DEVICE_REMOVED:
+		return -ENODEV;
+	case STATUS_ACCESS_DENIED:
+		return -EACCES;
+	case STATUS_NOT_SUPPORTED:
+		return -EPERM;
+	case STATUS_ILLEGAL_INSTRUCTION:
+		return -EOPNOTSUPP;
+	case STATUS_INVALID_HANDLE:
+		return -EBADF;
+	case STATUS_GRAPHICS_ALLOCATION_BUSY:
+		return -EINPROGRESS;
+	case STATUS_OBJECT_TYPE_MISMATCH:
+		return -EPROTOTYPE;
+	case STATUS_NOT_IMPLEMENTED:
+		return -EPERM;
+	default:
+		return -EINVAL;
+	}
+}
+
 int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev)
 {
 	int ret;
@@ -86,7 +201,210 @@ void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch)
 	}
 }
 
+static void command_vm_to_host_init1(struct dxgkvmb_command_vm_to_host *command,
+				     enum dxgkvmb_commandtype_global type)
+{
+	command->command_type = type;
+	command->process.v = 0;
+	command->command_id = 0;
+	command->channel_type = DXGKVMB_VM_TO_HOST;
+}
+
+static void process_inband_packet(struct dxgvmbuschannel *channel,
+				  struct vmpacket_descriptor *desc)
+{
+	u32 packet_length = hv_pkt_datalen(desc);
+	struct dxgkvmb_command_host_to_vm *packet;
+
+	if (packet_length < sizeof(struct dxgkvmb_command_host_to_vm)) {
+		DXG_ERR("Invalid global packet");
+	} else {
+		packet = hv_pkt_data(desc);
+		DXG_TRACE("global packet %d",
+			packet->command_type);
+		switch (packet->command_type) {
+		case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
+		case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
+			break;
+		case DXGK_VMBCOMMAND_SENDWNFNOTIFICATION:
+			break;
+		default:
+			DXG_ERR("unexpected host message %d",
+				packet->command_type);
+		}
+	}
+}
+
+static void process_completion_packet(struct dxgvmbuschannel *channel,
+				      struct vmpacket_descriptor *desc)
+{
+	struct dxgvmbuspacket *packet = NULL;
+	struct dxgvmbuspacket *entry;
+	u32 packet_length = hv_pkt_datalen(desc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&channel->packet_list_mutex, flags);
+	list_for_each_entry(entry, &channel->packet_list_head,
+			    packet_list_entry) {
+		if (desc->trans_id == entry->request_id) {
+			packet = entry;
+			list_del(&packet->packet_list_entry);
+			packet->completed = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&channel->packet_list_mutex, flags);
+	if (packet) {
+		if (packet->buffer_length) {
+			if (packet_length < packet->buffer_length) {
+				DXG_TRACE("invalid size %d Expected:%d",
+					packet_length,
+					packet->buffer_length);
+				packet->status = -EOVERFLOW;
+			} else {
+				memcpy(packet->buffer, hv_pkt_data(desc),
+				       packet->buffer_length);
+			}
+		}
+		complete(&packet->wait);
+	} else {
+		DXG_ERR("did not find packet to complete");
+	}
+}
+
 /* Receive callback for messages from the host */
 void dxgvmbuschannel_receive(void *ctx)
 {
+	struct dxgvmbuschannel *channel = ctx;
+	struct vmpacket_descriptor *desc;
+	u32 packet_length = 0;
+
+	foreach_vmbus_pkt(desc, channel->channel) {
+		packet_length = hv_pkt_datalen(desc);
+		DXG_TRACE("next packet (id, size, type): %llu %d %d",
+			desc->trans_id, packet_length, desc->type);
+		if (desc->type == VM_PKT_COMP) {
+			process_completion_packet(channel, desc);
+		} else {
+			if (desc->type != VM_PKT_DATA_INBAND)
+				DXG_ERR("unexpected packet type");
+			else
+				process_inband_packet(channel, desc);
+		}
+	}
+}
+
+int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
+			 void *command,
+			 u32 cmd_size,
+			 void *result,
+			 u32 result_size)
+{
+	int ret;
+	struct dxgvmbuspacket *packet = NULL;
+
+	if (cmd_size > DXG_MAX_VM_BUS_PACKET_SIZE ||
+	    result_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		DXG_ERR("%s invalid data size", __func__);
+		return -EINVAL;
+	}
+
+	packet = kmem_cache_alloc(channel->packet_cache, 0);
+	if (packet == NULL) {
+		DXG_ERR("kmem_cache_alloc failed");
+		return -ENOMEM;
+	}
+
+	packet->request_id = atomic64_inc_return(&channel->packet_request_id);
+	init_completion(&packet->wait);
+	packet->buffer = result;
+	packet->buffer_length = result_size;
+	packet->status = 0;
+	packet->completed = false;
+	spin_lock_irq(&channel->packet_list_mutex);
+	list_add_tail(&packet->packet_list_entry, &channel->packet_list_head);
+	spin_unlock_irq(&channel->packet_list_mutex);
+
+	ret = vmbus_sendpacket(channel->channel, command, cmd_size,
+			       packet->request_id, VM_PKT_DATA_INBAND,
+			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	if (ret) {
+		DXG_ERR("vmbus_sendpacket failed: %x", ret);
+		spin_lock_irq(&channel->packet_list_mutex);
+		list_del(&packet->packet_list_entry);
+		spin_unlock_irq(&channel->packet_list_mutex);
+		goto cleanup;
+	}
+
+	DXG_TRACE("waiting completion: %llu", packet->request_id);
+	ret = wait_for_completion_killable(&packet->wait);
+	if (ret) {
+		DXG_ERR("wait_for_completion failed: %x", ret);
+		spin_lock_irq(&channel->packet_list_mutex);
+		if (!packet->completed)
+			list_del(&packet->packet_list_entry);
+		spin_unlock_irq(&channel->packet_list_mutex);
+		goto cleanup;
+	}
+	DXG_TRACE("completion done: %llu %x",
+		packet->request_id, packet->status);
+	ret = packet->status;
+
+cleanup:
+
+	kmem_cache_free(channel->packet_cache, packet);
+	if (ret < 0)
+		DXG_TRACE("Error: %x", ret);
+	return ret;
+}
+
+static int
+dxgvmb_send_sync_msg_ntstatus(struct dxgvmbuschannel *channel,
+			      void *command, u32 cmd_size)
+{
+	struct ntstatus status;
+	int ret;
+
+	ret = dxgvmb_send_sync_msg(channel, command, cmd_size,
+				   &status, sizeof(status));
+	if (ret >= 0)
+		ret = ntstatus2int(status);
+	return ret;
+}
+
+/*
+ * Global messages to the host
+ */
+
+int dxgvmb_send_set_iospace_region(u64 start, u64 len)
+{
+	int ret;
+	struct dxgkvmb_command_setiospaceregion *command;
+	struct dxgvmbusmsg msg;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	ret = init_message(&msg, NULL, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	command_vm_to_host_init1(&command->hdr,
+				 DXGK_VMBCOMMAND_SETIOSPACEREGION);
+	command->start = start;
+	command->length = len;
+	ret = dxgvmb_send_sync_msg_ntstatus(&dxgglobal->channel, msg.hdr,
+					    msg.size);
+	if (ret < 0)
+		DXG_ERR("send_set_iospace_region failed %x", ret);
+
+	dxgglobal_release_channel_lock();
+cleanup:
+	free_message(&msg, NULL);
+	if (ret)
+		DXG_TRACE("Error: %d", ret);
+	return ret;
 }
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 6cdca5e03d1f..b1bdd6039b73 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -16,4 +16,71 @@
 
 #define DXG_MAX_VM_BUS_PACKET_SIZE	(1024 * 128)
 
+enum dxgkvmb_commandchanneltype {
+	DXGKVMB_VGPU_TO_HOST,
+	DXGKVMB_VM_TO_HOST,
+	DXGKVMB_HOST_TO_VM
+};
+
+/*
+ *
+ * Commands, sent to the host via the guest global VM bus channel
+ * DXG_GUEST_GLOBAL_VMBUS
+ *
+ */
+
+enum dxgkvmb_commandtype_global {
+	DXGK_VMBCOMMAND_VM_TO_HOST_FIRST	= 1000,
+	DXGK_VMBCOMMAND_CREATEPROCESS	= DXGK_VMBCOMMAND_VM_TO_HOST_FIRST,
+	DXGK_VMBCOMMAND_DESTROYPROCESS		= 1001,
+	DXGK_VMBCOMMAND_OPENSYNCOBJECT		= 1002,
+	DXGK_VMBCOMMAND_DESTROYSYNCOBJECT	= 1003,
+	DXGK_VMBCOMMAND_CREATENTSHAREDOBJECT	= 1004,
+	DXGK_VMBCOMMAND_DESTROYNTSHAREDOBJECT	= 1005,
+	DXGK_VMBCOMMAND_SIGNALFENCE		= 1006,
+	DXGK_VMBCOMMAND_NOTIFYPROCESSFREEZE	= 1007,
+	DXGK_VMBCOMMAND_NOTIFYPROCESSTHAW	= 1008,
+	DXGK_VMBCOMMAND_QUERYETWSESSION		= 1009,
+	DXGK_VMBCOMMAND_SETIOSPACEREGION	= 1010,
+	DXGK_VMBCOMMAND_COMPLETETRANSACTION	= 1011,
+	DXGK_VMBCOMMAND_SHAREOBJECTWITHHOST	= 1021,
+	DXGK_VMBCOMMAND_INVALID_VM_TO_HOST
+};
+
+/*
+ * Commands, sent by the host to the VM
+ */
+enum dxgkvmb_commandtype_host_to_vm {
+	DXGK_VMBCOMMAND_SIGNALGUESTEVENT,
+	DXGK_VMBCOMMAND_PROPAGATEPRESENTHISTORYTOKEN,
+	DXGK_VMBCOMMAND_SETGUESTDATA,
+	DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE,
+	DXGK_VMBCOMMAND_SENDWNFNOTIFICATION,
+	DXGK_VMBCOMMAND_INVALID_HOST_TO_VM
+};
+
+struct dxgkvmb_command_vm_to_host {
+	u64				command_id;
+	struct d3dkmthandle		process;
+	enum dxgkvmb_commandchanneltype	channel_type;
+	enum dxgkvmb_commandtype_global	command_type;
+};
+
+struct dxgkvmb_command_host_to_vm {
+	u64					command_id;
+	struct d3dkmthandle			process;
+	u32					channel_type	: 8;
+	u32					async_msg	: 1;
+	u32					reserved	: 23;
+	enum dxgkvmb_commandtype_host_to_vm	command_type;
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_setiospaceregion {
+	struct dxgkvmb_command_vm_to_host hdr;
+	u64				start;
+	u64				length;
+	u32				shared_page_gpadl;
+};
+
 #endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
new file mode 100644
index 000000000000..23ecd15b0cd7
--- /dev/null
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2022, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Ioctl implementation
+ *
+ */
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/anon_inodes.h>
+#include <linux/mman.h>
+
+#include "dxgkrnl.h"
+#include "dxgvmbus.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"dxgk: " fmt
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
new file mode 100644
index 000000000000..4c6047c32a20
--- /dev/null
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2022, Microsoft Corporation.
+ *
+ * Author:
+ *   Iouri Tarassov <iourit@linux.microsoft.com>
+ *
+ * Dxgkrnl Graphics Driver
+ * Misc definitions
+ *
+ */
+
+#ifndef _MISC_H_
+#define _MISC_H_
+
+extern const struct d3dkmthandle zerohandle;
+
+/*
+ * Synchronization lock hierarchy.
+ *
+ * The higher enum value, the higher is the lock order.
+ * When a lower lock ois held, the higher lock should not be acquired.
+ *
+ * channel_lock
+ * device_mutex
+ */
+
+/*
+ * Some of the Windows return codes, which needs to be translated to Linux
+ * IOCTL return codes. Positive values are success codes and need to be
+ * returned from the driver IOCTLs. libdxcore.so depends on returning
+ * specific return codes.
+ */
+#define STATUS_SUCCESS					((int)(0))
+#define	STATUS_OBJECT_NAME_INVALID			((int)(0xC0000033L))
+#define	STATUS_DEVICE_REMOVED				((int)(0xC00002B6L))
+#define	STATUS_INVALID_HANDLE				((int)(0xC0000008L))
+#define	STATUS_ILLEGAL_INSTRUCTION			((int)(0xC000001DL))
+#define	STATUS_NOT_IMPLEMENTED				((int)(0xC0000002L))
+#define	STATUS_PENDING					((int)(0x00000103L))
+#define	STATUS_ACCESS_DENIED				((int)(0xC0000022L))
+#define	STATUS_BUFFER_TOO_SMALL				((int)(0xC0000023L))
+#define	STATUS_OBJECT_TYPE_MISMATCH			((int)(0xC0000024L))
+#define	STATUS_GRAPHICS_ALLOCATION_BUSY			((int)(0xC01E0102L))
+#define	STATUS_NOT_SUPPORTED				((int)(0xC00000BBL))
+#define	STATUS_TIMEOUT					((int)(0x00000102L))
+#define	STATUS_INVALID_PARAMETER			((int)(0xC000000DL))
+#define	STATUS_NO_MEMORY				((int)(0xC0000017L))
+#define	STATUS_OBJECT_NAME_COLLISION			((int)(0xC0000035L))
+#define STATUS_OBJECT_NAME_NOT_FOUND			((int)(0xC0000034L))
+
+
+#define NT_SUCCESS(status)				(status.v >= 0)
+
+#ifndef DEBUG
+
+#define DXGKRNL_ASSERT(exp)
+
+#else
+
+#define DXGKRNL_ASSERT(exp)	\
+do {				\
+	if (!(exp)) {		\
+		dump_stack();	\
+		BUG_ON(true);	\
+	}			\
+} while (0)
+
+#endif /* DEBUG */
+
+#endif /* _MISC_H_ */
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 5d973604400c..2ea04cc02a1f 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -14,6 +14,40 @@
 #ifndef _D3DKMTHK_H
 #define _D3DKMTHK_H
 
+/*
+ * This structure matches the definition of D3DKMTHANDLE in Windows.
+ * The handle is opaque in user mode. It is used by user mode applications to
+ * represent kernel mode objects, created by dxgkrnl.
+ */
+struct d3dkmthandle {
+	union {
+		struct {
+			__u32 instance	:  6;
+			__u32 index	: 24;
+			__u32 unique	: 2;
+		};
+		__u32 v;
+	};
+};
+
+/*
+ * VM bus messages return Windows' NTSTATUS, which is integer and only negative
+ * value indicates a failure. A positive number is a success and needs to be
+ * returned to user mode as the IOCTL return code. Negative status codes are
+ * converted to Linux error codes.
+ */
+struct ntstatus {
+	union {
+		struct {
+			int code	: 16;
+			int facility	: 13;
+			int customer	: 1;
+			int severity	: 2;
+		};
+		int v;
+	};
+};
+
 /*
  * Matches the Windows LUID definition.
  * LUID is a locally unique identifier (similar to GUID, but not global),

