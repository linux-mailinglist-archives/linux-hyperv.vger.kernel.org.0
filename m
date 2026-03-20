Return-Path: <linux-hyperv+bounces-9632-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP0WD+s8vWkH8AIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9632-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 13:26:19 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4466F2DA2AA
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 13:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE552306FCEE
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 12:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FE3AC0EE;
	Fri, 20 Mar 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KOXWIuGk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D73ACA6F;
	Fri, 20 Mar 2026 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009279; cv=none; b=gIKCheWJ/1qtmBEtfEbp7MRnTU10GSA6iIdRJujTEZngIDNCKL4Rx250ZPDnS/FzKYB6fgg8L8VOy+d86ktcUCwIYeww+DCXfOrNltegR9mfKr3095AMwJCswKItE2Y/yOvrYmfj76vNnMSjNmUNkVqTULVm1lMAdW1/l6z4ZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009279; c=relaxed/simple;
	bh=4j5D3JUKWrkjypiioycjRrgazfW4eGjtyd7+18VftzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gz23nRrpT93ieG7JBioENiY1SxYxrj9K5nDPiipp5Xw0xiAbIhDABnuyGfX5R2d31Dr78Rzaklc+vjVvyExuaCQHhNh82rn4qguE3d5HeUewlLVtZWfF3rYAjSQ+XypNwXNCNUryHr/F40X2a+LmUsaM9SsJK9RVJMgQP21dZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KOXWIuGk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 954FD20B710C; Fri, 20 Mar 2026 05:21:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 954FD20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774009277;
	bh=HHWlJ0UaeVgkTh4f4inG7ulP8ZOO5aEjTyrrRmJDfqM=;
	h=From:To:Cc:Subject:Date:From;
	b=KOXWIuGkDQIW+S4tuTvWIqkQsytmkIefTt3Jl7ARcF9DD5sg2doPfrfPAwyPG7wZS
	 u1aAslAJJqjbGV/IhxnYRNt1VDedyonmepnlb5Ye/n4QadbjWo8ByMLZNn3jlxNz0Y
	 w99rETnkLtMjMqoGnvvPfaneUuQ58KMh+cPgYOMo=
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
	shirazsaleem@microsoft.com,
	kotaranov@microsoft.com,
	yury.norov@gmail.com,
	kees@kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH net-next] net: mana: Use at least SZ_4K in doorbell ID range check
Date: Fri, 20 Mar 2026 05:21:01 -0700
Message-ID: <20260320122107.1560839-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9632-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.945];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4466F2DA2AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mana_gd_ring_doorbell() accesses doorbell offsets up to 0xFF8 + 8 = 4KB
within a doorbell page. When db_page_size is zero, the validation check
in mana_gd_register_device() reduces to:
  db_page_off + 0 > bar0_size
which passes, even though mana_gd_ring_doorbell() will access
[db_page_off, db_page_off + 4KB) and may go beyond BAR0.

Use max(SZ_4K, db_page_size) in the range check so that a zero or
unexpectedly small db_page_size still results in a rejection when the
doorbell page would fall outside BAR0.

Fixes: 89fe91c65992 ("net: mana: hardening: Validate doorbell ID from GDMA_REGISTER_DEVICE response")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 2ba1fa3336f9..49ea3dcbf74a 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -4,6 +4,7 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
 #include <linux/utsname.h>
 #include <linux/version.h>
 #include <linux/msi.h>
@@ -1255,6 +1256,7 @@ int mana_gd_register_device(struct gdma_dev *gd)
 	struct gdma_context *gc = gd->gdma_context;
 	struct gdma_register_device_resp resp = {};
 	struct gdma_general_req req = {};
+	u64 db_page_sz;
 	int err;
 
 	gd->pdid = INVALID_PDID;
@@ -1278,8 +1280,14 @@ int mana_gd_register_device(struct gdma_dev *gd)
 	 *   addr = db_page_base + db_page_size * db_id
 	 *        = (bar0_va + db_page_off) + (db_page_size * db_id)
 	 * So we need: db_page_off + db_page_size * (db_id + 1) <= bar0_size
+	 *
+	 * mana_gd_ring_doorbell() always accesses [offset, offset + 4KB),
+	 * so use at least SZ_4K to catch a zero or small db_page_size.
 	 */
-	if (gc->db_page_off + gc->db_page_size * ((u64)resp.db_id + 1) > gc->bar0_size) {
+	db_page_sz = max_t(u64, SZ_4K, gc->db_page_size);
+
+	if (gc->db_page_off + db_page_sz * ((u64)resp.db_id + 1) >
+	    gc->bar0_size) {
 		dev_err(gc->dev, "Doorbell ID %u out of range\n", resp.db_id);
 		return -EPROTO;
 	}
-- 
2.34.1


