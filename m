Return-Path: <linux-hyperv+bounces-10077-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM83C4AP1mmxAwgAu9opvQ
	(envelope-from <linux-hyperv+bounces-10077-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 10:19:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E983B8E58
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B98B3053DD0
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2026 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555F39D6DA;
	Wed,  8 Apr 2026 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cXtdaSC9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B2336D50D;
	Wed,  8 Apr 2026 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635948; cv=none; b=kbp52AhR5xIbqb3M8C369dzOeah29ElGQMqqTKdyMBgYlNQzvGrrmO/2EvvPV1THIdbyai6+Jo6gW7EYEwCritXeu2zwP4KN7UhLPwlAG8qBb33CrEy21FhBJdevYB+Msg98j/Nc9A0XUgWUA8c+JvvB0eaPnDBr+DY6EUkiGJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635948; c=relaxed/simple;
	bh=v5NUvzBVJQv5miMXeTChPGnjog+O/7WBCs04W0A37ko=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SdF3+ExXgBELc/piQ6VgyHMv7yAfeOEMNqy3QbEb01L5ePyWGAQAyqFoX+R6tf1Fbd3fNBPJ2Chbu1knAcXRo6dOCXR0Fi2YXEUVJGe6aQaF8ClPNmQBbfZouPMi1zBpXtSFAu807g3reEPM30lOqQSCH5+HIrY0KY/RQXCikM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cXtdaSC9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 185DB20B7007; Wed,  8 Apr 2026 01:12:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 185DB20B7007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775635947;
	bh=YM7wtdiaaKkJ/QF6fYo0ZONMYwoTKOc7Ty9QCMZpjXM=;
	h=From:To:Subject:Date:From;
	b=cXtdaSC9fQ4tgdcLhBvkKIfZl/QuJlIEEaP9V7bb7Nuy8IzFiEDUNbch7o6TgyYst
	 VSKrojl90yk0fkMsWU+q8f55JaZzWOeQyWNcJ1N4vNUkBQg8hYPy8pmmZCed2VAttF
	 I95Qag81ra11KcPXPS8nN7pfCebh+DhcaBYoHUQE=
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
	ernis@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	kees@kernel.org,
	kotaranov@microsoft.com,
	yury.norov@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: mana: Fix debugfs directory naming and file lifecycle
Date: Wed,  8 Apr 2026 01:12:18 -0700
Message-ID: <20260408081224.302308-1-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10077-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 83E983B8E58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes two pre-existing debugfs issues in the MANA driver.

Patch 1 fixes the per-device debugfs directory naming to use the unique
PCI BDF address via pci_name(), avoiding a potential NULL pointer
dereference when pdev->slot is NULL (e.g. VFIO passthrough, nested KVM)
and preventing name collisions across multiple PFs or VFs.

Patch 2 moves the current_speed debugfs file creation from
mana_probe_port() to mana_init_port() so it survives detach/attach
cycles triggered by MTU changes or XDP program changes.

Erni Sri Satya Vennela (2):
  net: mana: Use pci_name() for debugfs directory naming
  net: mana: Move current_speed debugfs file to mana_init_port()

 drivers/net/ethernet/microsoft/mana/gdma_main.c | 7 ++-----
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.34.1


