Return-Path: <linux-hyperv+bounces-10001-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBoeGFcS02lJdwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10001-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 03:54:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8193A10FC
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 03:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A056300D96B
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 01:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B530F7F3;
	Mon,  6 Apr 2026 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWm3dsAJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A630FF3C
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Apr 2026 01:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775440455; cv=none; b=Jug4nfBCobr52v+6N/PxcmEgfNRkmhO0DmatuYm5q0JK22GOLV6jI87MVRKf/2iwRUy82E1f7/5Q8Ppl/c772tdgaPorL479VNmPnvfvZzOOqkzJo3bQzO2iWwaoemk20IcjOv3UuzElDpYgzB3xs2RFYqDtLd6Wa8iWgvceabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775440455; c=relaxed/simple;
	bh=2UTupawkM/Buasn6mvWU4ZaVvVjcElE7vIbTnBeKfFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iy98N4bdIDp+aRC9UEg8zY4X3uhGANPElNe1LL3hBDM5ZmfGrKd0pxoVzhfKRqNUHaAiSs6e7Onr2E56829lgH8M76N6flb79fHkbyNRVV1ki4bdy9/+/WmflIO5+4Jwz5Vwt7goBG9ULlQa6uoWNDtiYvbj7AnIoqm9GVrHZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWm3dsAJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775440451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2t6NMj+k7e5t6BNImF47zecQxGvOdp4DtM9XCqytqzc=;
	b=KWm3dsAJGECN9Zik/PSrGT/myWZl461Gz4kHKoWHkJaiOTrvBtZUlc2UV3elz8TqYFoINg
	C3WftoxKcUwzY7kwpAD/tprchmNDmOPKzGq6Ur5Esq39QLUNxkyIWswy2efZqucFuNaeoE
	Qy6weVIt0HgZ8Xz7BXzjPptDXCAA3LE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-Edb5DTryP7aHXD7Z2oDFWw-1; Sun,
 05 Apr 2026 21:54:08 -0400
X-MC-Unique: Edb5DTryP7aHXD7Z2oDFWw-1
X-Mimecast-MFC-AGG-ID: Edb5DTryP7aHXD7Z2oDFWw_1775440446
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D747180035C;
	Mon,  6 Apr 2026 01:54:06 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.72.112.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD81C300019F;
	Mon,  6 Apr 2026 01:54:00 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: Li Tian <litian@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: storvsc: Handle PERSISTENT_RESERVE_IN truncation for Hyper-V vFC
Date: Mon,  6 Apr 2026 09:53:44 +0800
Message-ID: <20260406015344.12566-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10001-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[litian@redhat.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB8193A10FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The storvsc driver has become stricter in handling
SRB status codes returned by the Hyper-V host. When using Virtual
Fibre Channel (vFC) passthrough, the host may return
SRB_STATUS_DATA_OVERRUN for PERSISTENT_RESERVE_IN commands if the
allocation length in the CDB does not match the host's expected
response size.

Currently, this status is treated as a fatal error, propagating
Host_status=0x07 [DID_ERROR] to the SCSI mid-layer. This causes
userspace storage utilities (such as sg_persist) to fail with
transport errors, even when the host has actually returned the
requested reservation data in the buffer.

Refactor the existing command-specific workarounds into a new helper
function, storvsc_host_mishandles_cmd(), and add
PERSISTENT_RESERVE_IN to the list of commands where SRB status
errors should be suppressed for vFC devices. This ensures that
the SCSI mid-layer processes the returned data buffer instead of
terminating the command.

Signed-off-by: Li Tian <litian@redhat.com>
---
 drivers/scsi/storvsc_drv.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index ae1abab97835..6977ca8a0658 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1131,6 +1131,26 @@ static void storvsc_command_completion(struct storvsc_cmd_request *cmd_request,
 		kfree(payload);
 }
 
+/*
+ * The current SCSI handling on the host side does not correctly handle:
+ * INQUIRY with page code 0x80, MODE_SENSE / MODE_SENSE_10 with cmd[2] == 0x1c,
+ * and (for FC) MAINTENANCE_IN / PERSISTENT_RESERVE_IN passthrough.
+ */
+static bool storvsc_host_mishandles_cmd(u8 opcode, struct hv_device *device)
+{
+	switch (opcode) {
+	case INQUIRY:
+	case MODE_SENSE:
+	case MODE_SENSE_10:
+		return true;
+	case MAINTENANCE_IN:
+	case PERSISTENT_RESERVE_IN:
+		return hv_dev_is_fc(device);
+	default:
+		return false;
+	}
+}
+
 static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 				  struct vstor_packet *vstor_packet,
 				  struct storvsc_cmd_request *request)
@@ -1141,22 +1161,12 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	stor_pkt = &request->vstor_packet;
 
 	/*
-	 * The current SCSI handling on the host side does
-	 * not correctly handle:
-	 * INQUIRY command with page code parameter set to 0x80
-	 * MODE_SENSE and MODE_SENSE_10 command with cmd[2] == 0x1c
-	 * MAINTENANCE_IN is not supported by HyperV FC passthrough
-	 *
 	 * Setup srb and scsi status so this won't be fatal.
 	 * We do this so we can distinguish truly fatal failues
 	 * (srb status == 0x4) and off-line the device in that case.
 	 */
 
-	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
-	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE) ||
-	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE_10) ||
-	   (stor_pkt->vm_srb.cdb[0] == MAINTENANCE_IN &&
-	   hv_dev_is_fc(device))) {
+	if (storvsc_host_mishandles_cmd(stor_pkt->vm_srb.cdb[0], device)) {
 		vstor_packet->vm_srb.scsi_status = 0;
 		vstor_packet->vm_srb.srb_status = SRB_STATUS_SUCCESS;
 	}
-- 
2.53.0


