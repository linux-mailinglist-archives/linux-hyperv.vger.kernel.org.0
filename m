Return-Path: <linux-hyperv+bounces-11659-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5SFZDVUqPGomkwgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11659-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jun 2026 21:04:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB66C0DAE
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jun 2026 21:04:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mWhqujJn;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11659-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11659-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5163D301DCC2
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jun 2026 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21EE3033CC;
	Wed, 24 Jun 2026 19:04:50 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71164257ACF;
	Wed, 24 Jun 2026 19:04:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327890; cv=none; b=IvcQTi0OWUAPDTDE0fXPbiVhMGuQzx9JALIdQgXrl8PSbdApKG2IAWG5T4B5KMyHlI1/CA3SVKqgxsOGzXE1jAthUeReNJlCb2jRYlCQH34ak2fRTvrwS0ctqH3FYPbLOOjruT0cOcba5614JROX4Hm0FXQE/+Bty2GsO+YDKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327890; c=relaxed/simple;
	bh=vWW6oB+8MobKlBwbZ9yxRW7VSq3Ff9/ZGhi6GvBYzuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5gDohCqH+62B1HtBm0GMBUPbK0S8JKJnCptzq+w2TZvRFuIg0GymDrgghWg74QLo/6SU4WS0k76IVnfSmSJnqGdZPf9Y/0GdT7HPUR779GkpA8loZzp6riwvAyt7RH6sTW0SpqDV6EN5akZUlSU4LMupXGS+Xze7Yn/PxMcbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWhqujJn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4531F000E9;
	Wed, 24 Jun 2026 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782327889;
	bh=WQrrLlVzR1h90c9gB55sV1tPGGmAV9HxoaXr8Jt3fOw=;
	h=From:To:Cc:Subject:Date;
	b=mWhqujJnVsd9DTaNJlMkUG0p1m5v/DujR9lEikzsX15bF4uxAp8q1dADY3jP+Slyf
	 PEcHqPV/tZ4eIs/AA8GcMg1ziZPg4Cg+nBv3oE1UMjjKrbKdMi+fQe6JSSTeXuw0st
	 5KyljGybcsoy1YDfT19k2DOIDArWozqGvlPXB4oxN7YDUIQcUe48XfKJ2W3qSibwnK
	 QA00Dq3vNrJqzlZDyh9GWnxVCE5UuQvfz3qoOixl33TE2E45/EIwXUq0jISsOCIYlr
	 y7/XIju90VJbffkm5qBLIAXXfMK9+t9194bqoca+nhtT6Ukrx4UykSOhots4M6haNm
	 K5ISG6E7R+WNw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	joshwash@google.com,
	hramamurthy@google.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	jordanrhee@google.com,
	jacob.e.keller@intel.com,
	nktgrg@google.com,
	debarghyak@google.com,
	mohsin.bashr@gmail.com,
	ernis@linux.microsoft.com,
	sdf@fomichev.me,
	gal@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH net] net: ethtool: keep rtnl_lock for ops using ethtool_op_get_link()
Date: Wed, 24 Jun 2026 12:04:39 -0700
Message-ID: <20260624190439.2521219-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11659-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:leitao@debian.org,m:joshwash@google.com,m:hramamurthy@google.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:alexanderduyck@fb.com,m:kernel-team@meta.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:jordanrhee@google.com,m:jacob.e.keller@intel.com,m:nktgrg@google.com,m:debarghyak@google.com,m:mohsin.bashr@gmail.com,m:ernis@linux.microsoft.com,m:sdf@fomichev.me,m:gal@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,debian.org,intel.com,nvidia.com,fb.com,meta.com,microsoft.com,gmail.com,linux.microsoft.com,fomichev.me];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85AB66C0DAE

Breno reports following splats on mlx5:

  RTNL: assertion failed at net/core/dev.c (2241)
  WARNING: net/core/dev.c:2241 at netif_state_change+0xed/0x130, CPU#5: ethtool/1335
  RIP: 0010:netif_state_change+0xf9/0x130
  Call Trace:
    <TASK>
     __linkwatch_sync_dev+0xea/0x120
     ethtool_op_get_link+0xe/0x20
     __ethtool_get_link+0x26/0x40
     linkstate_prepare_data+0x51/0x200
     ethnl_default_doit+0x213/0x470
     genl_family_rcv_msg_doit+0xdd/0x110

Looks like I missed ethtool_op_get_link() trying to sync linkwatch,
which needs rtnl_lock. Not all drivers do this - bnxt doesn't,
it just returns the link state, so add an opt-in bit.

Reported-by: Breno Leitao <leitao@debian.org>
Fixes: 45079e00133e ("net: ethtool: optionally skip rtnl_lock on Netlink path for GET ops")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: joshwash@google.com
CC: hramamurthy@google.com
CC: anthony.l.nguyen@intel.com
CC: przemyslaw.kitszel@intel.com
CC: saeedm@nvidia.com
CC: tariqt@nvidia.com
CC: mbloch@nvidia.com
CC: leon@kernel.org
CC: alexanderduyck@fb.com
CC: kernel-team@meta.com
CC: kys@microsoft.com
CC: haiyangz@microsoft.com
CC: wei.liu@kernel.org
CC: decui@microsoft.com
CC: longli@microsoft.com
CC: jordanrhee@google.com
CC: jacob.e.keller@intel.com
CC: nktgrg@google.com
CC: debarghyak@google.com
CC: leitao@debian.org
CC: mohsin.bashr@gmail.com
CC: ernis@linux.microsoft.com
CC: sdf@fomichev.me
CC: gal@nvidia.com
CC: linux-rdma@vger.kernel.org
CC: linux-hyperv@vger.kernel.org
---
 include/linux/ethtool.h                                 | 2 ++
 net/ethtool/common.h                                    | 4 ++++
 drivers/net/ethernet/google/gve/gve_ethtool.c           | 3 ++-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c          | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c        | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c | 4 +++-
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c         | 3 ++-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c      | 3 ++-
 9 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 1b834e2a522e..5d491a98265e 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -942,6 +942,7 @@ struct kernel_ethtool_ts_info {
 #define ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM	BIT(5)
 #define ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM	BIT(6)
 #define ETHTOOL_OP_NEEDS_RTNL_RSS		BIT(7)
+#define ETHTOOL_OP_NEEDS_RTNL_GLINK		BIT(8)
 
 /**
  * struct ethtool_ops - optional netdev operations
@@ -978,6 +979,7 @@ struct kernel_ethtool_ts_info {
  *	 - phylink helpers (note that phydev is currently unsupported!)
  *	 - netdev_update_features()
  *	 - netif_set_real_num_tx_queues()
+ *	 - ethtool_op_get_link() (syncs link watch under rtnl_lock)
  *
  * @get_drvinfo: Report driver/device information. Modern drivers no
  *	longer have to implement this callback. Most fields are
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 2b3847f00801..4e5356e26f40 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -113,6 +113,8 @@ ethtool_nl_msg_needs_rtnl(const struct net_device *dev, u8 cmd)
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM;
 	case ETHTOOL_MSG_RSS_SET:
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
+	case ETHTOOL_MSG_LINKSTATE_GET:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GLINK;
 	case ETHTOOL_MSG_TSCONFIG_GET:
 	case ETHTOOL_MSG_TSCONFIG_SET:
 		/* tsconfig calls ndos (ndo_hwtstamp_set/get), not ethtool ops.
@@ -159,6 +161,8 @@ ethtool_ioctl_needs_rtnl(const struct net_device *dev, u32 ethcmd)
 	case ETHTOOL_SRXFH:
 	case ETHTOOL_SRXFHINDIR:
 		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_RSS;
+	case ETHTOOL_GLINK:
+		return ops->op_needs_rtnl & ETHTOOL_OP_NEEDS_RTNL_GLINK;
 	}
 	return false;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 7cc22916852f..8199738ba979 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -984,7 +984,8 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 				 ETHTOOL_RING_USE_RX_BUF_LEN,
 	.op_needs_rtnl = ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
-			 ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
+			 ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
+			 ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.get_drvinfo = gve_get_drvinfo,
 	.get_strings = gve_get_strings,
 	.get_sset_count = gve_get_sset_count,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index a615d599b88e..e7cf12eaa268 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1855,6 +1855,7 @@ static const struct ethtool_ops iavf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
 	.supported_input_xfrm	= RXH_XFRM_SYM_XOR,
+	.op_needs_rtnl		= ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.get_drvinfo		= iavf_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_ringparam		= iavf_get_ringparam,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 2f5b626ba33f..112926d07634 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -2721,7 +2721,8 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 	.rxfh_max_num_contexts	= MLX5E_MAX_NUM_RSS,
 	.op_needs_rtnl		= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
 				  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
-				  ETHTOOL_OP_NEEDS_RTNL_SPFLAGS,
+				  ETHTOOL_OP_NEEDS_RTNL_SPFLAGS |
+				  ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 1a8a19f980d3..c8b76d301c92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -419,7 +419,8 @@ static const struct ethtool_ops mlx5e_rep_ethtool_ops = {
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
 	.op_needs_rtnl	   = ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
-			     ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
+			     ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
+			     ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.get_drvinfo	   = mlx5e_rep_get_drvinfo,
 	.get_link	   = ethtool_op_get_link,
 	.get_strings       = mlx5e_rep_get_strings,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 9b3b32408c64..01ddc3def9ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -286,7 +286,8 @@ const struct ethtool_ops mlx5i_ethtool_ops = {
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE,
 	.op_needs_rtnl	    = ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
-			      ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
+			      ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
+			      ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.get_drvinfo        = mlx5i_get_drvinfo,
 	.get_strings        = mlx5i_get_strings,
 	.get_sset_count     = mlx5i_get_sset_count,
@@ -309,6 +310,7 @@ const struct ethtool_ops mlx5i_ethtool_ops = {
 };
 
 const struct ethtool_ops mlx5i_pkey_ethtool_ops = {
+	.op_needs_rtnl	    = ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.get_drvinfo        = mlx5i_get_drvinfo,
 	.get_link           = ethtool_op_get_link,
 	.get_ts_info        = mlx5i_get_ts_info,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index cb34fc166ef9..0e47088ec44b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -2024,7 +2024,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 					  ETHTOOL_OP_NEEDS_RTNL_GPAUSEPARAM |
 					  ETHTOOL_OP_NEEDS_RTNL_SPAUSEPARAM |
 					  ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
-					  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
+					  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
+					  ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.get_drvinfo			= fbnic_get_drvinfo,
 	.get_regs_len			= fbnic_get_regs_len,
 	.get_regs			= fbnic_get_regs,
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 94e658d07a27..881df597d7f9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -597,7 +597,8 @@ static int mana_get_link_ksettings(struct net_device *ndev,
 const struct ethtool_ops mana_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_CQE_FRAMES,
 	.op_needs_rtnl		= ETHTOOL_OP_NEEDS_RTNL_SCHANNELS |
-				  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM,
+				  ETHTOOL_OP_NEEDS_RTNL_SRINGPARAM |
+				  ETHTOOL_OP_NEEDS_RTNL_GLINK,
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
 	.get_strings		= mana_get_strings,
-- 
2.54.0


