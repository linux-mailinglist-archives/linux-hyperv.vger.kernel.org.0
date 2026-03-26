Return-Path: <linux-hyperv+bounces-9806-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICEhG9ZyxWkU+QQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9806-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 18:54:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FBA3398E7
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 18:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A04F31125F4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 17:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781643A5429;
	Thu, 26 Mar 2026 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WvqBVBOx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4423A451A;
	Thu, 26 Mar 2026 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547304; cv=none; b=MOwIR0SM3GJkg1+l1/eu1AGTJ99bENi7n1pIT74wWLeD1zFvk0OcZInoX0/8xjS5l558c5KnYCsQaG3Ng61Z0Ogf8ijLnL22A/8QcIOXaxAINLiLym5i61rleqUJqC5I3CczyKObKJieJFvhuEoT2FY2006wzTni8upUKVR8JJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547304; c=relaxed/simple;
	bh=Spfrc7xiW4BA9CAyRt0iOJ1XbGZXrdcqquieIJSA2ho=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tM1mP4IxkaTaSQQadw2lEX5AdXxCP9AnQZMBnN+2bXunOIIEqOLwWTEG35iOjZih0jf0XitZzQy2WRi30pmg1GmtTfk2cwV9YhsQGqoxngMEXQlyfgE4Al+eFOPyhr1PTHHQNch+AQndQek3LzqVxHwLchLMbnw+vtdqieMEJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WvqBVBOx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4CA0F20B6F01; Thu, 26 Mar 2026 10:48:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4CA0F20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774547297;
	bh=RpsmEtJjCHNHxM9n1Tj3ykG2i55dggmqPR8BNacT0jY=;
	h=From:To:Subject:Date:From;
	b=WvqBVBOxryGZ4gCkRwhNkMLZ3V1X76HfLaGAOWO4CZit2RPkK/NkhwPbKnzR9T335
	 x5TWW8zKAUynfYDgteMFrkK4CUg/8KDysDekv1ffD+TUpb/dXPh8b9ZHQrLWyh66GT
	 nX817WWxzPWL75OYoM8Wp2D1EGpVKnXQNhgr4/4o=
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
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mana: hardening: Reject zero max_num_queues from MANA_QUERY_VPORT_CONFIG
Date: Thu, 26 Mar 2026 10:48:10 -0700
Message-ID: <20260326174815.2012137-1-ernis@linux.microsoft.com>
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
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9806-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: A0FBA3398E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As a part of MANA hardening for CVM, validate that max_num_sq and
max_num_rq returned by MANA_QUERY_VPORT_CONFIG are not zero. These
values flow into apc->num_queues, which is used as an allocation count
and loop bound. A zero value would result in zero-size allocations and
incorrect driver behavior.

Return -EPROTO if either value is zero.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b39e8b920791..a4197b4b0597 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1249,6 +1249,12 @@ static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
 
 	*max_sq = resp.max_num_sq;
 	*max_rq = resp.max_num_rq;
+
+	if (*max_sq == 0 || *max_rq == 0) {
+		netdev_err(apc->ndev, "Invalid max queues from vPort config\n");
+		return -EPROTO;
+	}
+
 	if (resp.num_indirection_ent > 0 &&
 	    resp.num_indirection_ent <= MANA_INDIRECT_TABLE_MAX_SIZE &&
 	    is_power_of_2(resp.num_indirection_ent)) {
-- 
2.34.1


