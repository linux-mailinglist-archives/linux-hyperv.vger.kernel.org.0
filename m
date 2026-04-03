Return-Path: <linux-hyperv+bounces-9961-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI0tH5+uz2kjzQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9961-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 14:12:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9117393F4C
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 14:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01EC730626F7
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E7D2D77F5;
	Fri,  3 Apr 2026 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VGRZVRmQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8005B34B194;
	Fri,  3 Apr 2026 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218188; cv=none; b=kB0amESjbgqcnwTdEG4yyiL9YJMWoXKuCm9ieMLaILz7jqIqZCDLDEyOTEY6Z64U5vEg0wKSJd4Z2GZMIo0e/U6mq4byWEy8KH+jrVli0+LAIJzbW2MmOV9FQKVXwwOp8GLNeznKNMHtWHVm2+iVr1MFOe1J4JeGQHiWjBA1N+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218188; c=relaxed/simple;
	bh=YYDYm4S7nHjSSy9rQXrUmj5T3h3mRo6RF5nyXftKLbE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BYCRttiPr/6yDj61cw2zSv2bPPaeUUDI8izfYbdIhsT+iuqd3EgnwE8694vLCjc0vv1CpeoQUIEY5mu8W6NsKePqPKc2sYcRcKK9hpRQ2/vrDPuTUsz1+qV+nf3uJzprpA9VZ24qDIP/4gYW5TeqnJa1SFOtsrcub5XKpB+brck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VGRZVRmQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from sahil.mshome.net (unknown [4.213.232.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 34E1C20B710C;
	Fri,  3 Apr 2026 05:09:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 34E1C20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775218186;
	bh=Vuxgk6ql5X6By2TYEOWqLh2LkbnCZf6KxtJii1TfRXs=;
	h=From:To:Subject:Date:From;
	b=VGRZVRmQdsf72a0TKNvRovPA3iCQoA0sYnJKOesrVawlnS8fbC8x31YAiIeES7FRz
	 Y2JaIdtEeFZzuWf8GJ+J7ZjbSQ5af5P+l2W5WTC5RPlCq4pElezsqeKqFuHS8eXoKO
	 cZ3YhcvX/CHmUTmwWeD18QtCtaoKgjduqZoXG/ws=
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	dan.j.williams@intel.com,
	mhklinux@outlook.com,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: hv: Fix double ida_free in hv_pci_probe error path
Date: Fri,  3 Apr 2026 05:09:29 -0700
Message-ID: <20260403120933.466259-1-sahilchandna@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9961-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,google.com,intel.com,outlook.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sahilchandna@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: D9117393F4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If hv_pci_probe() fails after storing the domain number in
hbus->bridge->domain_nr, there is a call to free this domain_nr via
pci_bus_release_emul_domain_nr(), however, during cleanup, the bridge
release callback pci_release_host_bridge_dev() also frees the domain_nr
causing ida_free to be called on same ID twice and triggering following
warning:

  ida_free called for id=28971 which is not allocated.
  WARNING: lib/idr.c:594 at ida_free+0xdf/0x160, CPU#0: kworker/0:2/198
  Call Trace:
   pci_bus_release_emul_domain_nr+0x17/0x20
   pci_release_host_bridge_dev+0x4b/0x60
   device_release+0x3b/0xa0
   kobject_put+0x8e/0x220
   devm_pci_alloc_host_bridge_release+0xe/0x20
   devres_release_all+0x9a/0xd0
   device_unbind_cleanup+0x12/0xa0
   really_probe+0x1c5/0x3f0
   vmbus_add_channel_work+0x135/0x1a0

Fix this by letting pci core handle the free domain_nr and remove
the explicit free called in pci-hyperv driver.

Fixes: bcce8c74f1ce ("PCI: Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms")
Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 2c7a406b4ba8..5616ad5d2a8f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3778,7 +3778,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 					   hbus->bridge->domain_nr);
 	if (!hbus->wq) {
 		ret = -ENOMEM;
-		goto free_dom;
+		goto free_bus;
 	}

 	hdev->channel->next_request_id_callback = vmbus_next_request_id;
@@ -3874,8 +3874,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	vmbus_close(hdev->channel);
 destroy_wq:
 	destroy_workqueue(hbus->wq);
-free_dom:
-	pci_bus_release_emul_domain_nr(hbus->bridge->domain_nr);
 free_bus:
 	kfree(hbus);
 	return ret;
--
2.53.0


