Return-Path: <linux-hyperv+bounces-9804-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKcdKBluxWl1+AQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9804-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 18:34:17 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48271339325
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 18:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D85A2306B159
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE5423162;
	Thu, 26 Mar 2026 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MHKva2tI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7097421EE5;
	Thu, 26 Mar 2026 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546270; cv=none; b=M/iIu/agwBan15lEV5QqUI9T+nX77R1+S7ThnDhC60ac2amSydxoaHhkVILbaX+2ou7hGHQJ5w/TsRwaoOMnY0BwCdOYw4doDXvsGNZ4jexnTHDA5RW+y6HCTJ2UW/2k2AoETE8Em+ceignWC3SvKPWIaTs3MsPCRsKMmEbpWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546270; c=relaxed/simple;
	bh=UGjIEZbjcXuAUyCk/TZyfTyRY2/0pBcB6DD8go4Uaa0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SHqtV/+gxe+g9SzcubYRfix0wKXlREaeE8Jbcqu7upgSEZiQinKLErdDFyBqwae8zaiJhqiYLO/5BmvxO21bX8bxJpy5PbCGSFJsyM6Z3G3e1Fy5Jl0PO9Ong86wNqWqjRKeav0SEcSuj7g9aXntBrdcMV870aSVz1cZwB3gAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MHKva2tI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3C32C20B7128; Thu, 26 Mar 2026 10:31:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C32C20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774546265;
	bh=WgiY0Cr10/koC/gjn73ozCFl/yXO3PvbCI7F7cJ9NW8=;
	h=From:To:Subject:Date:From;
	b=MHKva2tIvwvqngWORA+HxUMEuM62SYE27K7EFzkjSp8iDv6QuIlfyMgvuKmgI3Kz7
	 odRtNRc0K5wK5QXZNUGIJ4qU3mo8F72PUYFbreGByM7S1kEm7PoJMViLjZuLpl8efS
	 +B83cSfTIAUn69lrdM/L5y/7Phy9zWZbx91TSD8A=
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
Subject: [PATCH net-next] net: mana: hardening: Validate adapter_mtu from MANA_QUERY_DEV_CONFIG
Date: Thu, 26 Mar 2026 10:30:56 -0700
Message-ID: <20260326173101.2010514-1-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9804-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[19];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48271339325
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As a part of MANA hardening for CVM, validate the adapter_mtu value
returned from the MANA_QUERY_DEV_CONFIG HWC command.

The adapter_mtu value is used to compute ndev->max_mtu via:
gc->adapter_mtu - ETH_HLEN. If hardware returns a bogus adapter_mtu
smaller than ETH_HLEN (e.g. 0), the unsigned subtraction wraps to a
huge value, silently allowing oversized MTU settings.

Add a validation check to reject adapter_mtu values below
ETH_MIN_MTU + ETH_HLEN, returning -EPROTO to fail the device
configuration early with a clear error message.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b39e8b920791..bd07d17a6017 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1207,10 +1207,16 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 
 	*max_num_vports = resp.max_num_vports;
 
-	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2)
+	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2) {
+		if (resp.adapter_mtu < ETH_MIN_MTU + ETH_HLEN) {
+			dev_err(dev, "Adapter MTU too small: %u\n",
+				resp.adapter_mtu);
+			return -EPROTO;
+		}
 		gc->adapter_mtu = resp.adapter_mtu;
-	else
+	} else {
 		gc->adapter_mtu = ETH_FRAME_LEN;
+	}
 
 	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V3)
 		*bm_hostmode = resp.bm_hostmode;
-- 
2.34.1


