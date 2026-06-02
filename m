Return-Path: <linux-hyperv+bounces-11453-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l5WHO3c+H2pIjAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11453-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Jun 2026 22:35:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 446CB631C48
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Jun 2026 22:35:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=COpxiILT;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11453-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11453-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89EC0302570A
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jun 2026 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02A2372ECB;
	Tue,  2 Jun 2026 20:28:34 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E7033E37C;
	Tue,  2 Jun 2026 20:28:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432114; cv=none; b=PoSRUtO6pYGzb3aFeFw6I3peMTEaQJbQcn/lEQ2W8CoEtqgBLXaLFBZwDjOR+1n527UcYR7+0EU76sQw7LRpgNtnTldcZI7ZAV3zEdHQe3vZ4LtMNAEkPFxpYVeFq65PYy1BvOrhi1H1dSUccNUepfZvVo7cqmk3twq4DSZleMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432114; c=relaxed/simple;
	bh=Plo61R0wVLq4edCT+/7Pun99AajpNZemLOEe4ysWbDk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Tc+5E/zwoMwogLXwidSigwm6wDWPf4HT9AlSSFALe60Ps2sBCilVE3EfagUdcoW5xvuiN2GMzH5mvgosUQ4kzorp7pPQOvKlgnAkNCoKh2bueFJuUZs4MM1TlVatn1Z6G8066HvTQdYMt8mg9YwEKUJUQZNs1Q2+xWbRWUjRRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=COpxiILT; arc=none smtp.client-ip=13.77.154.182
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C3A8E20B7168;
	Tue,  2 Jun 2026 13:28:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3A8E20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780432098;
	bh=zKPgc7o/cO39Mrr7K8b5Y3O77m9kimvl/mzHX7cGfYA=;
	h=From:To:Subject:Date:From;
	b=COpxiILT5h+TBCiMhOibS0mXeMn7NFgVzaVJT4rPFa2sby+YGWZMrFfCf/GudzvZM
	 IMa4pXslYipGk0MjfLb+zZdgF2FvqI6juh/aZwBUheMc153cxCo+7DyR+MEja9kC1P
	 EpymxeyDGhw644J5wUWwrPE/CHU6O1l2j22HnmPU=
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stephen@networkplumber.org,
	jacob.e.keller@intel.com,
	dipayanroy@microsoft.com,
	leitao@debian.org,
	kees@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	sdf@fomichev.me,
	yury.norov@gmail.com,
	pavan.chebbi@broadcom.com
Subject: [PATCH net-next v10 0/2] net: mana: add ethtool private flag for full-page RX buffers
Date: Tue,  2 Jun 2026 13:24:37 -0700
Message-ID: <20260602202801.1873742-1-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11453-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:ernis@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:stephen@networkplumber.org,m:jacob.e.keller@intel.com,m:dipayanroy@microsoft.com,m:leitao@debian.org,m:kees@kernel.org,m:john.fastabend@gmail.com,m:hawk@kernel.org,m:bpf@vger.kernel.org,m:daniel@iogearbox.net,m:ast@kernel.org,m:sdf@fomichev.me,m:yury.norov@gmail.com,m:pavan.chebbi@broadcom.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.microsoft.com:mid,linux.microsoft.com:from_mime,linux.microsoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 446CB631C48

On some ARM64 platforms with 4K PAGE_SIZE, utilizing page_pool
fragments for allocation in the RX refill path (~2kB buffer per fragment)
causes 15-20% throughput regression under high connection counts
(>16 TCP streams at 180+ Gbps). Using full-page buffers on these
platforms shows no regression and restores line-rate performance.

This behavior is observed on a single platform; other platforms
perform better with page_pool fragments, indicating this is not a
page_pool issue but platform-specific.

This series adds an ethtool private flag "full-page-rx" to let the
user opt in to one RX buffer per page:

  ethtool --set-priv-flags eth0 full-page-rx on

There is no behavioral change by default. The flag can be persisted
via udev rule for affected platforms.

This series depends on the following fixes now merged in net-next:
  17bfe0a8c014 ("net: mana: add NULL guards in teardown path to prevent panic")
  5b05aa36ee24 ("net: mana: skip redundant detach on already-detached port")

Changes in v10:
  - Rebased on net-next which now includes the prerequisite fixes.
  - Recovery logic in mana_set_priv_flags() leverages the idempotent
    mana_detach() from the merged fixes.
Changes in v9:
  - Added correct tree.
Changes in v8:
  - Fixed queue_reset_work recovery by restoring port_is_up before
    scheduling reset so the handler can properly re-attach.
  - Simplified "err && schedule_port_reset" to "schedule_port_reset".
Changes in v7:
  - Rebased onto net-next.
  - Retained private flag approach after David Wei's testing on
    Grace (ARM64) confirmed that fragment mode outperforms
    full-page mode on other platforms, validating this is a
    single-platform workaround rather than a generic issue.
Changes in v6:
  - Added missed maintainers.
Changes in v5:
  - Split prep refactor into separate patch (patch 1/2)
Changes in v4:
  - Dropping the smbios string parsing and add ethtool priv flag
    to reconfigure the queues with full page rx buffers.
Changes in v3:
  - changed u8* to char*
Changes in v2:
  - separate reading string index and the string, remove inline.

Dipayaan Roy (2):
  net: mana: refactor mana_get_strings() and mana_get_sset_count() to
    use switch
  net: mana: force full-page RX buffers via ethtool private flag

 drivers/net/ethernet/microsoft/mana/mana_en.c |  22 ++-
 .../ethernet/microsoft/mana/mana_ethtool.c    | 178 +++++++++++++++---
 include/net/mana/mana.h                       |   8 +
 3 files changed, 177 insertions(+), 31 deletions(-)

-- 
2.43.0


