Return-Path: <linux-hyperv+bounces-10714-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEnaAlbO/WnujQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10714-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 13:51:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5F4F5F82
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FE263014BE3
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504737187E;
	Fri,  8 May 2026 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gsq6wGoa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490B221CA13;
	Fri,  8 May 2026 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241081; cv=none; b=vD5NenBRU75om9HkyxhVmL7n3OkCeKnoBK1n+e2FtUw0sQPUx9mollhDCqgS8c5RGG39+gZFpqr9VyTY393D8SrrLq4uK6elakzo/tRiZcKmadpROhGIVxJeRiLtbin1W843AQsU5WcUpHMkLXAYYcXAPs4s8sgp4riE7WTZtUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241081; c=relaxed/simple;
	bh=BVDRy3vn9tvWWKftLcLBe2wYSyTSKeIhQV5YDNfbNKw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GlAMKV+kHFZGBldX7auI/LdDt1h4M+v5yCGvGetFxuiGkY6KgQNVIaxmEB/lc+BRkK9XhNFxSoTyAUQ8SGGWv42S4RE9knXjeQ7cRgxns2fJGeH9St1I6f70iMw5x2V0C7iOz/Wv/zE9MsN4y1LGhE8ofm3gsfg9FdYv2tacgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gsq6wGoa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id F40BC20B7165;
	Fri,  8 May 2026 04:51:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F40BC20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778241076;
	bh=8tqDB0zTwSaasV60ItLuDpEFtnqAE01a82viokRlBkI=;
	h=From:To:Subject:Date:From;
	b=gsq6wGoaEuliv1bNgl3NH7zTlNGR8shRfKjenw7s7+bp9a1DqlagDf2x1Ai6NLir+
	 zPMTtbonYB0tIlNIRmt0UNrJqv4YWTCk7JovZAZNjt5NW84FXI7Y/9RPNIaecw2XuA
	 +ZT5wsamanUvivYMBjdEbwImTw4U16q8scR+LViE=
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
	yury.norov@gmail.com
Subject: [PATCH v8 0/2] net: mana: add ethtool private flag for full-page RX buffers
Date: Fri,  8 May 2026 04:46:33 -0700
Message-ID: <20260508115100.488506-1-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73C5F4F5F82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	TAGGED_FROM(0.00)[bounces-10714-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

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


