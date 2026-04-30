Return-Path: <linux-hyperv+bounces-10520-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDvaANYV82llxAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10520-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 10:41:58 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D949F54B
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 10:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1488A302C92E
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF623FE350;
	Thu, 30 Apr 2026 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f5TZtCI2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB613A1682;
	Thu, 30 Apr 2026 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777538220; cv=none; b=JVmqZpfedTPZjpCH31+GBVPFFbi1TEpuYIaIv3VtJUoPmwSqN7LtcKz96bqPo8lFHoxTt9NIPzDY/GXyp/BfcBJAR2xZYHO9u/N3ieNOe6YPfBeBdhSh/4eBqSanzQcwiLuPIV/I8ylTCEY9bGzsQpcOusS/oFP1jts5noHFToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777538220; c=relaxed/simple;
	bh=MozMMJs8fS8PLP0Djdx/pRPBejh+q+ODpmtZRJFKZ6Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DQKqHy9Gkjpnhqqvou8V0ywvj2+gWPSFRGOa4n/yORs/SqCEXTsSo63iJ2VkLNuo+BrusCMdL4H3cJV4EMIOLDxm9rdi9JloQ9st+P3ERg0GnPcXWj72wPDaHgkvFWpgZQFHR14Wx+V5fL5ofAo1D03Dil/D/JsHy+flSdGwJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f5TZtCI2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3A36F20B7171; Thu, 30 Apr 2026 01:36:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A36F20B7171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777538219;
	bh=BXdR6zC2INdeS+kRaeghfM0RXrRs2D/9qDuarIYdiho=;
	h=From:To:Subject:Date:From;
	b=f5TZtCI2hhRZNrZ4OBSKg/y0SiDVtVqt26BEU3B2VD+St/HbEmLewaZzRTKKW9l59
	 kE1Wm0l/17nGpK/QwS88zCJLDqv+TgbuYaFhnhdGzfGDlQY/GvaroQSxYZYIPavOer
	 RookomLwPyjQ9MAk/OLz8UMQ9AsJROBbY7pQ6XGI=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	ernis@linux.microsoft.com,
	yury.norov@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: mana: hardening: Reject zero max_num_queues from GDMA_QUERY_MAX_RESOURCES
Date: Thu, 30 Apr 2026 01:36:21 -0700
Message-ID: <20260430083627.1873757-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D4D949F54B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10520-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

In a CVM environment, hardware responses cannot be trusted. The
GDMA_QUERY_MAX_RESOURCES command returns resource limits used to
determine the maximum number of queues.

In mana_gd_query_max_resources(), gc->max_num_queues is initialized
from num_online_cpus() and successively clamped by the hardware-reported
max_eq, max_cq, max_sq, max_rq, and num_msix_usable values. If any of
these hardware values is zero, gc->max_num_queues becomes zero and the
function returns success. This leads to a confusing failure later when
alloc_etherdev_mq() is called with zero queues, returning NULL and
producing a misleading -ENOMEM error.

Add an explicit zero check for gc->max_num_queues after all clamping
steps and return -ENOSPC for a clear early failure, consistent with the
existing gc->num_msix_usable <= 1 guard.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v2:
* Rebase to latest main.
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 098fbda0d128..f3316e929175 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -194,6 +194,9 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	if (gc->max_num_queues > gc->num_msix_usable - 1)
 		gc->max_num_queues = gc->num_msix_usable - 1;
 
+	if (gc->max_num_queues == 0)
+		return -ENOSPC;
+
 	return 0;
 }
 
-- 
2.34.1


