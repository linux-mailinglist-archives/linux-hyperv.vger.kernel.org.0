Return-Path: <linux-hyperv+bounces-8939-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6kThABZ0m2lWzwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8939-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Feb 2026 22:24:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D984A1706B2
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Feb 2026 22:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 225E93006B4E
	for <lists+linux-hyperv@lfdr.de>; Sun, 22 Feb 2026 21:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D32B20DD75;
	Sun, 22 Feb 2026 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BSwc8IGy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF011A2C04;
	Sun, 22 Feb 2026 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771795474; cv=none; b=dmuUICgjCqzVNOPpdrj0s/rTNu+TIsUP8b7lFonAzWDA6uPS+Bn3kMrmFJ4Tby6mZrRQZTM/34GeyrNY7ZJMNh5C47goz2IzJFCxJMXoYYHXtifBNpnoH8Jk5r+y14P05TD0Snw/YJVO9UpOBy6ictB/eMeBP1mvCVP6IDv41lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771795474; c=relaxed/simple;
	bh=bkgGI2WMJRUrC6413r99xgdbIc0+f+gsulT3sQyzjYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQKNwCxd3wH2Y2pNskGQw5NCV/W/xNZ623Qmhl02+dTYKpHgWXpWk5lIHERvLJXes2+4Q2JHXk5davTFncQEwsGWrVlbC4OWN4PPPcG8ckVk6uJXOktD6kbiCrq1T6y90nQKrCuXCxSdprhs55JQkqX+pcR5lPYldzHZEr4QSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BSwc8IGy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id C5AEB20B6F00; Sun, 22 Feb 2026 13:24:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5AEB20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771795466;
	bh=Cu9vE1o/2Xdjq6JTuKE+z+eMXOB+YTsvz8yR1vX+7Zc=;
	h=From:To:Cc:Subject:Date:From;
	b=BSwc8IGybxHSGkEOrdo8uvHOdRLVVIqIt0fY6NdFCO4XSVTLElTy+h/wnjhv/Usn4
	 1dLgFB0TuenW3gpaCWl1rg2WPS9erk3qXTdI5ZE54Uc7l6OkjLP9ORptyU1mWn8KdG
	 OFVhSj8KR+Omgc5tEVGhMYnJdeR2GFdKwXD+KJNE=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: haiyangz@microsoft.com,
	paulros@microsoft.com
Subject: [PATCH net-next] net: ethtool: add COALESCE_RX_CQE_FRAMES/NSECS parameters
Date: Sun, 22 Feb 2026 13:23:17 -0800
Message-ID: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8939-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,bootlin.com,nvidia.com,pengutronix.de,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D984A1706B2
X-Rspamd-Action: no action

From: Haiyang Zhang <haiyangz@microsoft.com>

Add two parameters for drivers supporting Rx CQE Coalescing.

ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
Maximum number of frames that can be coalesced into a CQE.

ETHTOOL_A_COALESCE_RX_CQE_NSECS:
Time out value in nanoseconds after the first packet arrival in a
coalesced CQE to be sent.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 Documentation/netlink/specs/ethtool.yaml       |  8 ++++++++
 Documentation/networking/ethtool-netlink.rst   | 10 ++++++++++
 include/linux/ethtool.h                        |  6 +++++-
 include/uapi/linux/ethtool_netlink_generated.h |  2 ++
 net/ethtool/coalesce.c                         | 14 +++++++++++++-
 5 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 0a2d2343f79a..951d98f6bb12 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -861,6 +861,12 @@ attribute-sets:
         name: tx-profile
         type: nest
         nested-attributes: profile
+      -
+        name: rx-cqe-frames
+        type: u32
+      -
+        name: rx-cqe-nsecs
+        type: u32
 
   -
     name: pause-stat
@@ -2244,6 +2250,8 @@ operations:
             - tx-aggr-time-usecs
             - rx-profile
             - tx-profile
+            - rx-cqe-frames
+            - rx-cqe-nsecs
       dump: *coalesce-get-op
     -
       name: coalesce-set
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index af56c304cef4..a3e78b69fd07 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1072,6 +1072,8 @@ Kernel response contents:
   ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
   ``ETHTOOL_A_COALESCE_RX_PROFILE``            nested  profile of DIM, Rx
   ``ETHTOOL_A_COALESCE_TX_PROFILE``            nested  profile of DIM, Tx
+  ``ETHTOOL_A_COALESCE_RX_CQE_FRAMES``         u32     max packets, Rx CQE
+  ``ETHTOOL_A_COALESCE_RX_CQE_NSECS``          u32     delay (ns), Rx CQE
   ===========================================  ======  =======================
 
 Attributes are only included in reply if their value is not zero or the
@@ -1105,6 +1107,12 @@ well with frequent small-sized URBs transmissions.
 to DIM parameters, see `Generic Network Dynamic Interrupt Moderation (Net DIM)
 <https://www.kernel.org/doc/Documentation/networking/net_dim.rst>`_.
 
+Rx CQE coalescing allows multiple received packets to be coalesced into a single
+Completion Queue Entry (CQE). ``ETHTOOL_A_COALESCE_RX_CQE_FRAMES`` describes the
+maximum number of frames that can be coalesced into a CQE.
+``ETHTOOL_A_COALESCE_RX_CQE_NSECS`` describes max time in nanoseconds after the
+first packet arrival in a coalesced CQE to be sent.
+
 COALESCE_SET
 ============
 
@@ -1143,6 +1151,8 @@ Request contents:
   ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
   ``ETHTOOL_A_COALESCE_RX_PROFILE``            nested  profile of DIM, Rx
   ``ETHTOOL_A_COALESCE_TX_PROFILE``            nested  profile of DIM, Tx
+  ``ETHTOOL_A_COALESCE_RX_CQE_FRAMES``         u32     max packets, Rx CQE
+  ``ETHTOOL_A_COALESCE_RX_CQE_NSECS``          u32     delay (ns), Rx CQE
   ===========================================  ======  =======================
 
 Request is rejected if it attributes declared as unsupported by driver (i.e.
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 798abec67a1b..25ccd2d5d4dc 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -332,6 +332,8 @@ struct kernel_ethtool_coalesce {
 	u32 tx_aggr_max_bytes;
 	u32 tx_aggr_max_frames;
 	u32 tx_aggr_time_usecs;
+	u32 rx_cqe_frames;
+	u32 rx_cqe_nsecs;
 };
 
 /**
@@ -380,7 +382,9 @@ bool ethtool_convert_link_mode_to_legacy_u32(u32 *legacy_u32,
 #define ETHTOOL_COALESCE_TX_AGGR_TIME_USECS	BIT(26)
 #define ETHTOOL_COALESCE_RX_PROFILE		BIT(27)
 #define ETHTOOL_COALESCE_TX_PROFILE		BIT(28)
-#define ETHTOOL_COALESCE_ALL_PARAMS		GENMASK(28, 0)
+#define ETHTOOL_COALESCE_RX_CQE_FRAMES		BIT(29)
+#define ETHTOOL_COALESCE_RX_CQE_NSECS		BIT(30)
+#define ETHTOOL_COALESCE_ALL_PARAMS		GENMASK(30, 0)
 
 #define ETHTOOL_COALESCE_USECS						\
 	(ETHTOOL_COALESCE_RX_USECS | ETHTOOL_COALESCE_TX_USECS)
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 556a0c834df5..efc6e4ade77b 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -371,6 +371,8 @@ enum {
 	ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,
 	ETHTOOL_A_COALESCE_RX_PROFILE,
 	ETHTOOL_A_COALESCE_TX_PROFILE,
+	ETHTOOL_A_COALESCE_RX_CQE_FRAMES,
+	ETHTOOL_A_COALESCE_RX_CQE_NSECS,
 
 	__ETHTOOL_A_COALESCE_CNT,
 	ETHTOOL_A_COALESCE_MAX = (__ETHTOOL_A_COALESCE_CNT - 1)
diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 3e18ca1ccc5e..349bb02c517a 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -118,6 +118,8 @@ static int coalesce_reply_size(const struct ethnl_req_info *req_base,
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_BYTES */
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_MAX_FRAMES */
 	       nla_total_size(sizeof(u32)) +	/* _TX_AGGR_TIME_USECS */
+	       nla_total_size(sizeof(u32)) +	/* _RX_CQE_FRAMES */
+	       nla_total_size(sizeof(u32)) +	/* _RX_CQE_NSECS */
 	       total_modersz * 2;		/* _{R,T}X_PROFILE */
 }
 
@@ -269,7 +271,11 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES,
 			     kcoal->tx_aggr_max_frames, supported) ||
 	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS,
-			     kcoal->tx_aggr_time_usecs, supported))
+			     kcoal->tx_aggr_time_usecs, supported) ||
+	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_CQE_FRAMES,
+			     kcoal->rx_cqe_frames, supported) ||
+	    coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_CQE_NSECS,
+			     kcoal->rx_cqe_nsecs, supported))
 		return -EMSGSIZE;
 
 	if (!req_base->dev || !req_base->dev->irq_moder)
@@ -338,6 +344,8 @@ const struct nla_policy ethnl_coalesce_set_policy[] = {
 	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS] = { .type = NLA_U32 },
+	[ETHTOOL_A_COALESCE_RX_CQE_FRAMES] = { .type = NLA_U32 },
+	[ETHTOOL_A_COALESCE_RX_CQE_NSECS] = { .type = NLA_U32 },
 	[ETHTOOL_A_COALESCE_RX_PROFILE] =
 		NLA_POLICY_NESTED(coalesce_profile_policy),
 	[ETHTOOL_A_COALESCE_TX_PROFILE] =
@@ -570,6 +578,10 @@ __ethnl_set_coalesce(struct ethnl_req_info *req_info, struct genl_info *info,
 			 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES], &mod);
 	ethnl_update_u32(&kernel_coalesce.tx_aggr_time_usecs,
 			 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS], &mod);
+	ethnl_update_u32(&kernel_coalesce.rx_cqe_frames,
+			 tb[ETHTOOL_A_COALESCE_RX_CQE_FRAMES], &mod);
+	ethnl_update_u32(&kernel_coalesce.rx_cqe_nsecs,
+			 tb[ETHTOOL_A_COALESCE_RX_CQE_NSECS], &mod);
 
 	if (dev->irq_moder && dev->irq_moder->profile_flags & DIM_PROFILE_RX) {
 		ret = ethnl_update_profile(dev, &dev->irq_moder->rx_profile,
-- 
2.34.1


