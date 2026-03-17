Return-Path: <linux-hyperv+bounces-9505-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MDjCfWpuWkhLwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9505-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 20:22:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEA72B17EF
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 20:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59CFC31124FB
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C2531F9B8;
	Tue, 17 Mar 2026 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jj2PQr9C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4F15E5DC;
	Tue, 17 Mar 2026 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775120; cv=none; b=oYMsUebJqRWGy5LyvNq1sHYtR503toRalxzEIPd7UYSR/+zTkOTZUE5v8bDynoYAaN6f+4uIwHKi611uBlvGRUP7yCtCEmUJ1Qi19bi/v44IfH8QQNtfVhqq0TwoyBuzroQ3rzBuzCps/mf5V+dOaeL2Gdy6xpx1v3P/nlTjaTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775120; c=relaxed/simple;
	bh=HHBeQ5I/j2+OyiO+vVB6oHPpJ1nfk/+GUprWxGKldSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bde8D5TIJM4Dyqb2svGq573i9UfWcjdrkiLbUyEP5g+lg5qSn4lHwj+ci2KpUl2IjPmlbJE1ifUZtYcTAmQ3XmU40EEhesWTdZOAm4yRBonzuRoxwT8QBzoKIs7m+EeobcO5f3aNJMhi0gsVzBwLPU46y2j6Y+SCbaDFa7P2VP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jj2PQr9C; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id D35E020B7001; Tue, 17 Mar 2026 12:18:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D35E020B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773775118;
	bh=dEWTfOGEkf8Bh9K4B3YC4fmdRm2eFTdfOERDWQqPHU4=;
	h=From:To:Cc:Subject:Date:From;
	b=Jj2PQr9CGBu7itS6LCts4DPqb80w6dHETVLZHFscgnOKN+xiOkAgZpv/PIIUkdzOb
	 o5A/bELejJHmqr3Gb0fObqSgPqyB2BdaEHUHlrBX/8svkekGYyPI5yPJ9I5W99XPBr
	 rLHznw6tkRg21zqvj7/TTcYhhwJ/CnFcILfZM31I=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH net-next v6 0/3] add ethtool COALESCE_RX_CQE_FRAMES/NSECS and use it in MANA driver
Date: Tue, 17 Mar 2026 12:18:04 -0700
Message-ID: <20260317191826.1346111-1-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9505-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 8CEA72B17EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Haiyang Zhang <haiyangz@microsoft.com>

Add two parameters for drivers supporting Rx CQE Coalescing.

ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
Maximum number of frames that can be coalesced into a CQE or
writeback.

ETHTOOL_A_COALESCE_RX_CQE_NSECS:
Max time in nanoseconds after the first packet arrival in a
coalesced CQE or writeback to be sent.

Also implement it in MANA driver with the new parameter and
counters.


Haiyang Zhang (3):
  net: ethtool: add ethtool COALESCE_RX_CQE_FRAMES/NSECS
  net: mana: Add support for RX CQE Coalescing
  net: mana: Add ethtool counters for RX CQEs in coalesced type

 Documentation/netlink/specs/ethtool.yaml      |  8 ++
 Documentation/networking/ethtool-netlink.rst  | 11 +++
 drivers/net/ethernet/microsoft/mana/mana_en.c | 84 +++++++++++++------
 .../ethernet/microsoft/mana/mana_ethtool.c    | 75 ++++++++++++++++-
 include/linux/ethtool.h                       |  6 +-
 include/net/mana/mana.h                       | 17 +++-
 .../uapi/linux/ethtool_netlink_generated.h    |  2 +
 net/ethtool/coalesce.c                        | 14 +++-
 8 files changed, 181 insertions(+), 36 deletions(-)

-- 
2.34.1


