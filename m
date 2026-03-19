Return-Path: <linux-hyperv+bounces-9619-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD2XMDNevGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9619-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:36:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6972D23CB
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 765C530B9B6B
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCCD402BA3;
	Thu, 19 Mar 2026 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSMGK9jH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DDB401A21
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951970; cv=none; b=PP+9IA9q8HuuT/Cg7IkFXGaACPqHCGUqviKgQqILt8/PXROYgaOlh5y6hqw+B3vPiSPtNyPnIEnBjjDjO94kkrYQ4HDFA/vcOUl/qx6l/oGNJjiJ/5hfGf2pTXGm0a9F5s+eHXJ5luwjKwWWHEz81crcDDaEF91ti55KII7u8k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951970; c=relaxed/simple;
	bh=aGsCqTmbio2gk0tJU8PH4eYhSnMzryFGj3iv/ce5q64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F41uuXRKNVBO7RHh7K2u5DyjLFB+4PE7oslwm4wQ3nVyKpE+PqPxHua5XqRiVcqyJqiJHde0ZdqT870/sPWG5rt1UTIzUB6Kr76xqXzfvMtt8PvhbaUxcxP8pzS3h2aVR86wmr7+JCHR0Fg+rC3dBdBT6FaQva5om3bFsgA6M2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSMGK9jH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso1003294f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951966; x=1774556766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L59fd8D5hkyMG2nQhO698xghueZKtfuG5YRQ+ujsUlI=;
        b=RSMGK9jHPDnRXNiCSjUMrGkKSJFzZPMFaq4eJCIt9D7cFkqSTfkur/gji7W9GxVTM6
         LeXzvqdtq6jEd1LHbKMN2sku6V7mzVcY/lcPZ+2/oefxtZkR4iFApzJRgbm04Y4DsLlF
         +GRt6UIybe2gjz/RVGREklULtAV+f7W5g1tdlOmmoz3L8CQDNAQqkXRRsrAjottAlhfZ
         2m08amXqv6QdebZyD7E0Arl7z0U+xkQM2cD/ZLEgTgcXjRGShWzI9axoAGwY4SaK54Qw
         TRVv1keIBmyY+VQMr4j+OVz+sWKoHeMxIzkIgpKLbxb8f+O5tqB7B/cAHaw/BaoApO0/
         KY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951966; x=1774556766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L59fd8D5hkyMG2nQhO698xghueZKtfuG5YRQ+ujsUlI=;
        b=F2w9y/PDgGXuR+Z5kJJHQpVK6Kq2kTbbrhXVfrNTrD9JDc+/Zng92O+wqTp79Od58E
         TzMKehuTs4TDQRZWyBGwMmhXZ1tJGPn1lHj/zf3XSHxZ+QZaK1u4YSmRZMgXo8gIJrxj
         AjbX2fU9quhoqb9+B6FT1LK2kuMVwo1e80uT/yGe0vTo2rWCuaLsiNv7+fLLDTENmXfa
         LF05W0fJssxfhhrAWRfofY/5ggGSRzcG8l62dSKg0vWo5dt7ESMESoikeaJpc3dr6/hm
         +xZY6wXnqb/ZNk+mN34+eHuADTo8zP+wHlE6QvbI/aZ8JfohFpqANTZnn6BaEwvvZ2LE
         xE0w==
X-Gm-Message-State: AOJu0YxpGy37ETZW7tTzL2ZaaSfNaO1b9nlQefzsTKCkI7gKJZ7pqD4g
	6o48Z8MWIA4Z/ueRFkd1ZGl6FIHfLokUn+DRU6msPwyvOBP++5R02SnEoZ2zW/S1fbI=
X-Gm-Gg: ATEYQzzs2RADKHMUUIR0/buBcJbk1TBeMbY5Ti2YZuswqcIIgZCk4BxqUPnVjZQsjYF
	pGx5rkM0bhZe0Zeq/UdnF7zeVtbaNZYnJnUj7OpyXGQlHqv9a2x0REaVGyrvL6m3rCpwySSemTq
	6CskrGOhl0syd/WYlaztpvqt57PNdHXb6o8uF1XM6YhNl93T1ZsTGDImVC/m9sCZHheCDzTVAO6
	oCBhXTzc/p3RQepNBHOn9rs7aVuTEfCYSiREr8mFM2+dXXXyWVaBMeMGETju9hoRuMLKu0h0fmD
	Uh1ssUHpVG2Qb1gzGgp5avvbLTIgJ3KZgbq587FtvdF66ozd0pEw8s6DPw4wz4Um2/sF+aklsjz
	xJE+1aFAesah3ov2Q7UaaKBLQcfF1nttOiSGxDTnchLc80yvO4/+hXmzhxHYPyJLdVfVNPd37l/
	dnSG02RqHY7efrpvFWqAR1v4B3dFmSpmhtaixjR4ESkUDLFm+q
X-Received: by 2002:a5d:5d85:0:b0:43b:49a1:8ace with SMTP id ffacd0b85a97d-43b6427b2e1mr1272743f8f.51.1773951966444;
        Thu, 19 Mar 2026 13:26:06 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:05 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 47/55] drivers: hv: dxgkrnl: Retry sending a VM bus packet when there is no place in the ring buffer
Date: Thu, 19 Mar 2026 20:25:01 +0000
Message-ID: <20260319202509.63802-48-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9619-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: 3E6972D23CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

When D3DKMT requests are sent too quickly, the VM bus ring buffer could be
full when a message is submitted. The change adds sleep and re-try count
to handle this condition.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgvmbus.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 67f55f4bf41d..467e7707c8c7 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -420,6 +420,7 @@ int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
 	struct dxgvmbuspacket *packet = NULL;
 	struct dxgkvmb_command_vm_to_host *cmd1;
 	struct dxgkvmb_command_vgpu_to_host *cmd2;
+	int try_count = 0;
 
 	if (cmd_size > DXG_MAX_VM_BUS_PACKET_SIZE ||
 	    result_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
@@ -453,9 +454,19 @@ int dxgvmb_send_sync_msg(struct dxgvmbuschannel *channel,
 	list_add_tail(&packet->packet_list_entry, &channel->packet_list_head);
 	spin_unlock_irq(&channel->packet_list_mutex);
 
-	ret = vmbus_sendpacket(channel->channel, command, cmd_size,
-			       packet->request_id, VM_PKT_DATA_INBAND,
-			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	do {
+		ret = vmbus_sendpacket(channel->channel, command, cmd_size,
+				packet->request_id, VM_PKT_DATA_INBAND,
+				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+		/*
+		 * -EAGAIN is returned when the VM bus ring buffer if full.
+		 * Wait 2ms to allow the host to process messages and try again.
+		 */
+		if (ret == -EAGAIN) {
+			usleep_range(1000, 2000);
+			try_count++;
+		}
+	} while (ret == -EAGAIN && try_count < 50);
 	if (ret) {
 		DXG_ERR("vmbus_sendpacket failed: %x", ret);
 		spin_lock_irq(&channel->packet_list_mutex);

