Return-Path: <linux-hyperv+bounces-9928-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GS9EgC1zmlVpgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9928-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:27:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E147538D12B
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 060A73031DD3
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA09837C11C;
	Thu,  2 Apr 2026 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pal8Txrr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32453AF64E;
	Thu,  2 Apr 2026 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154429; cv=none; b=A4wC0PYFbW+AMFlH+0Gv513qWUrr6deLr5rRgTGSiTQ5knKS/QQGrH3lxoGOUVVvhVrM/dMFCL2Hlyy1OWWuftQQyNSnVrzhigmaoObxFYKa8az249qfEmw7dCks5IKQxGh1pa96WiSF2o8AikbayqG0vREdtucfWawl7KmepUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154429; c=relaxed/simple;
	bh=KzU3a+qY2RMRjxtFX+QuS9zwg+1sk4SxZk5DsmWH+Q8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OGroX5vPxFN0r69Q0RuQp4smKYQrmd8s8XOm0O4y1L54Nm+28w9JSN/YVpEGeOsD1CViNLsudCNlGCcKKOCx3LKVn7l+3fqGoYh+roEukELRbOVypKuQgcuhzaOriF9iewlN1AH+Nv8lPH8LdIBp+XaoVPS0uRC+DICZHlzh+XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pal8Txrr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C2BA820B710C; Thu,  2 Apr 2026 11:27:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2BA820B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775154427;
	bh=VgEBMHJDmpH/96qhmT/uMvhRJUALWNkXudRmhpEO0AA=;
	h=From:To:Subject:Date:From;
	b=pal8TxrrtR+c4m8Rd87DCodt2YhHW1CQoh5C+ehzwtIVpHvEkmmGKfvTWesCO72/K
	 EA0lu37SUUJWnXrUC889gUTcTnrqHo6dp7QJ/VhQG0PfZ69ZB/NJJB8iEq23SetMlV
	 n0wk/LLGHEkIVvrgJELLkDVFSKkPJKtPP9znG/MA=
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
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	yury.norov@gmail.com,
	kees@kernel.org,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 0/3] net: mana: debugfs fixes and diagnostic info
Date: Thu,  2 Apr 2026 11:26:54 -0700
Message-ID: <20260402182704.2474739-1-ernis@linux.microsoft.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9928-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: E147538D12B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series first fixes two pre-existing debugfs issues in the MANA
driver, then adds new debugfs entries for hardware diagnostic info.

Patch 1 fixes the per-device debugfs directory naming to use the unique
PCI BDF address via pci_name(), avoiding a potential NULL pointer
dereference when pdev->slot is NULL and preventing name collisions
across multiple PFs or VFs.

Patch 2 moves the current_speed debugfs file creation from
mana_probe_port() to mana_init_port() so it survives detach/attach
cycles triggered by MTU changes or XDP program changes.

Patch 3 adds new debugfs entries exposing hardware configuration and
diagnostic information (device capabilities, vPort config, steering
parameters) and consolidates debugfs directory lifecycle into
mana_gd_setup()/mana_gd_cleanup_device().
---
Changes in v5:
* Create new patchset including all the the patches.
Changes in v4:
* Rebase and fix conflicts.
Changes in v3:
* Rename mana_gd_cleanup to mana_gd_cleanup_device.
* Add creation of debugfs entries in mana_gd_setup.
* Add removal of debugfs entries in mana_gd_cleanup_device.
* Remove bm_hostmode and num_vports from debugfs in mana_remove itself,
  because "ac" gets freed before debugfs_remove_recursive, to avoid
  Use-After-Free error.
* Add "goto out:" in mana_cfg_vport_steering to avoid populating apc
  values when resp.hdr.status is not NULL.
Changes in v2:
* Add debugfs_remove_recursice for gc>mana_pci_debugfs in
  mana_gd_suspend to handle multiple duplicates creation in
  mana_gd_setup and mana_gd_resume path.
* Move debugfs creation for num_vports and bm_hostmode out of
  if(!resuming) condition since we have to create it again even for
  resume.
* Recreate mana_pci_debugfs in mana_gd_resume.
---
Erni Sri Satya Vennela (3):
  net: mana: Use pci_name() for debugfs directory naming
  net: mana: Move current_speed debugfs file to mana_init_port()
  net: mana: Expose hardware diagnostic info via debugfs

 .../net/ethernet/microsoft/mana/gdma_main.c   | 62 ++++++++++---------
 drivers/net/ethernet/microsoft/mana/mana_en.c | 37 ++++++++++-
 include/net/mana/gdma.h                       |  1 +
 include/net/mana/mana.h                       |  8 +++
 4 files changed, 76 insertions(+), 32 deletions(-)

-- 
2.34.1


