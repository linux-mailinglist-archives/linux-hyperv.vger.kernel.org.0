Return-Path: <linux-hyperv+bounces-11641-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DBItCsDZNGoRigYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11641-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 07:55:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B48B6A401C
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 07:55:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=CVomVZZI;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11641-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11641-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40803306C6E9
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2026 05:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9284D3451C1;
	Fri, 19 Jun 2026 05:54:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5DD344D8D;
	Fri, 19 Jun 2026 05:53:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848440; cv=none; b=knRDxJ2Qdtm4BRyRqjPCoCy8mjpXYO8Dbck2fmeijyrtfBSvg+nApQnWmUvpG3t5XlIwKF2JsENqJHa2cX8h4Y8IMUVi5fn62/KoWc/qWTHJ6BjgtWqO//waFWuPDStwVsrAvlHjjG76uQHxqSCFijBVZ3FPv8i8aze5fvipvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848440; c=relaxed/simple;
	bh=/GYwtyj4OiwSnfQ1NkHHQpVoUWEX0p5XIzUtXUf6Fgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ijG1aRlm2p9kO6V/SYSfTUeMa1pf5wuxIDxQagb18sUZUfcaG2xVd0MyHuOi9iE/mK3FABmWo0lZ025WLaHwVD9EuOhfpTqB/uQ7I5DhMwN4rKrJIUIoFn+0AioP5E6w02jHSiDwHHzGXozL55I/1tXKoOa6x9C/lQwcwf36T+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CVomVZZI; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 7786820B7168; Thu, 18 Jun 2026 22:53:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7786820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781848432;
	bh=djzZlvhhSVxdzxt5Tfjo+wj0N0UWQ5SDaG8r7yyi7oQ=;
	h=From:To:Subject:Date:From;
	b=CVomVZZIgStxfhkcyelsx9ZfoAg2ofDMrPEhYWSHWom7owo3p61oBd2gr0gP4/nL/
	 WgrexreV8oAx/lrUxeSAH5kloCBvk+TwuHrnTu9RLDrqbsm3LRYhEtoY/dORLIV8H8
	 pEN93sDZvrjyJvXoWBx1Wl4EmWpPMI2JXwzNL/UA=
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
	dipayanroy@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	jacob.e.keller@intel.com,
	ernis@linux.microsoft.com,
	horms@kernel.org,
	gargaditya@linux.microsoft.com,
	kees@kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net] net: mana: Fall back to standard MTU when PF reports adapter_mtu of 0
Date: Thu, 18 Jun 2026 22:53:38 -0700
Message-ID: <20260619055348.467224-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11641-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dipayanroy@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:jacob.e.keller@intel.com,m:ernis@linux.microsoft.com,m:horms@kernel.org,m:gargaditya@linux.microsoft.com,m:kees@kernel.org,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.microsoft.com:dkim,linux.microsoft.com:mid,linux.microsoft.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B48B6A401C

Commit d7709812e13d ("net: mana: hardening: Validate adapter_mtu from
MANA_QUERY_DEV_CONFIG") rejected any adapter_mtu value smaller than
ETH_MIN_MTU + ETH_HLEN, including 0, returning -EPROTO and failing
mana_probe().

Some older PF firmware versions still in the field report
adapter_mtu as 0 in the MANA_QUERY_DEV_CONFIG response. With the
hardening check in place, the MANA VF driver now fails to load on
those hosts, breaking networking entirely for guests.

MANA hardware always supports the standard Ethernet MTU. Treat a
reported adapter_mtu of 0 as "the PF did not advertise a value" and
fall back to ETH_FRAME_LEN, the same value used for the pre-V2
message version path. Only jumbo frames remain unavailable until
the PF reports a valid MTU.

Other small-but-nonzero bogus values are still rejected, preserving
the original protection against the unsigned-subtraction wrap that
would otherwise let ndev->max_mtu underflow to a huge value.

Fixes: d7709812e13d ("net: mana: hardening: Validate adapter_mtu from MANA_QUERY_DEV_CONFIG")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_bpf.c |  3 ++-
 drivers/net/ethernet/microsoft/mana/mana_en.c  | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
index b5e9bb184a1d..53308e139cbe 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
@@ -237,7 +237,8 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
 		bpf_prog_put(old_prog);
 
 	if (prog)
-		ndev->max_mtu = MANA_XDP_MTU_MAX;
+		ndev->max_mtu = min_t(unsigned int, MANA_XDP_MTU_MAX,
+				      gc->adapter_mtu - ETH_HLEN);
 	else
 		ndev->max_mtu = gc->adapter_mtu - ETH_HLEN;
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 87862b0434c7..7438ea6b3f26 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1233,12 +1233,24 @@ int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,
 	*max_num_vports = resp.max_num_vports;
 
 	if (resp.hdr.response.msg_version >= GDMA_MESSAGE_V2) {
-		if (resp.adapter_mtu < ETH_MIN_MTU + ETH_HLEN) {
+		if (resp.adapter_mtu == 0) {
+			/*
+			 * Some older PF firmware versions report an
+			 * adapter_mtu of 0. MANA hardware always supports the
+			 * standard Ethernet MTU, so fall back to ETH_FRAME_LEN.
+			 * Jumbo frames will not be available in this case.
+			 */
+			dev_info(dev,
+				 "PF reported adapter_mtu of 0, falling back to %u (jumbo frames disabled)\n",
+				 ETH_FRAME_LEN);
+			gc->adapter_mtu = ETH_FRAME_LEN;
+		} else if (resp.adapter_mtu < ETH_MIN_MTU + ETH_HLEN) {
 			dev_err(dev, "Adapter MTU too small: %u\n",
 				resp.adapter_mtu);
 			return -EPROTO;
+		} else {
+			gc->adapter_mtu = resp.adapter_mtu;
 		}
-		gc->adapter_mtu = resp.adapter_mtu;
 	} else {
 		gc->adapter_mtu = ETH_FRAME_LEN;
 	}
-- 
2.34.1


