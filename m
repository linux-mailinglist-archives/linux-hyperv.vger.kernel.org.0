Return-Path: <linux-hyperv+bounces-4953-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47379A915EC
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 09:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D86B3AF082
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 07:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C12253FF;
	Thu, 17 Apr 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HQhlwyIc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8769722423C;
	Thu, 17 Apr 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876642; cv=none; b=gVaqrh5YdFmvXujON0ykpnDYpcGoqe97kSmjLxv0PJeBFwRssrHsfRZEXV/xfAmyXB8lE+4uyNPChxUbRygG0w3h2qXgjNXy9knmolzz3noXFbyMyTo1IUO8c6uOfOUDC9u2tAc2rpOEB6t8rQH0aq83GU3Kt7FkxfNT9mu13tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876642; c=relaxed/simple;
	bh=69IV9j1CnaWOQX9Nu+KovtxIy/CCWYCi7b9fxKJN8C0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=s4vlHs5MCPwF03KDIWhP6WakzEfJ3Th1Z+rKoxe8nYaOmf9gs8nMyqzukYsLfgbgvIY/T2JnV7abrpQbXEjsaNDT+ZS60rwKxg9vGzCg+luHYRoJcHEyaY8VFNM72daKKq9RxF9Z6tkLs7or0crURTxCApcAIt9wiuWoCqFYXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HQhlwyIc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 2D2B921199C8; Thu, 17 Apr 2025 00:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D2B921199C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744876639;
	bh=ikqgemc/xaYJTjIbCudC8PpR3P2K//U5qVWjUkDNlzE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HQhlwyIcsCxvmh8MFQgZ22wFHR/rxqDnkodAKIyUlf/uo256Xh3VK+U09oX7q4WxP
	 kDs1lsZ2d8VYpegjjmEnXPHttGcgpgm/qu/gnOBzUNPSH+mjDR0wDPsA9bv1HSBn9k
	 1LjlkcaMdiHNpOJLOXj6yTjGViHCt48ogzCp7LuI=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	kent.overstreet@linux.dev,
	brett.creeley@amd.com,
	schakrabarti@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	rosenp@gmail.com,
	paulros@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH 2/3] net: mana: Add sched HTB offload support
Date: Thu, 17 Apr 2025 00:57:09 -0700
Message-Id: <1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Introduce support for HTB qdisc offload in the mana ethernet
controller. This controller can offload only one HTB leaf.
The HTB leaf supports clamping the bandwidth for egress traffic.
It uses the function mana_set_bw_clamp(), which internally calls
a HWC command to the hardware to set the speed.

The minimum bandwidth is 100 Mbps, and only multiples of 100 Mbps
are handled by the hardware. When the HTB leaf/root is deleted,
the speed will be reset to maximum bandwidth supported by the SKU.

This feature is not supported by all hardware.

Steps to configure speed:

Add the root qdisc
$tc qdisc add dev enP30832s1 root handle 1: htb offload

Add the class with required rate
$tc class add dev enP30832s1 parent 1: classid 1:1 htb rate 1000mbit

Display class details
$tc class show dev enP30832s1 classid 1:1
>class htb 1:1 root prio 0 rate 1Gbit ceil 1Gbit 
>burst 1375b cburst 1375b  offload

Display port information using ethtool
$ethtool enP30832s1
>Settings for enP30832s1:
        Supported ports: [  ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: 1000Mb/s
        Duplex: Full
        Auto-negotiation: off
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Link detected: yes

Delete class
$tc class del dev enP30832s1 classid 1:1

Delete root qdisc (If used alone, also deletes the attached class)
$tc qdisc del dev enP30832s1 root

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 138 ++++++++++++++++++
 include/net/mana/mana.h                       |  19 +++
 2 files changed, 157 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ba550fc7ece0..5b62f1443716 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -16,10 +16,13 @@
 #include <net/netdev_lock.h>
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
+#include <net/pkt_cls.h>
 
 #include <net/mana/mana.h>
 #include <net/mana/mana_auxiliary.h>
 
+#define MIN_BANDWIDTH 100
+
 static DEFINE_IDA(mana_adev_ida);
 
 static int mana_adev_idx_alloc(void)
@@ -719,6 +722,99 @@ static int mana_change_mtu(struct net_device *ndev, int new_mtu)
 	return err;
 }
 
+static int mana_tc_htb_handle_leaf_queue(struct mana_port_context *mpc,
+					 struct tc_htb_qopt_offload *opt,
+					 bool alloc)
+{
+	u32 rate, old_speed;
+	int err;
+
+	if (opt->command == TC_HTB_LEAF_ALLOC_QUEUE) {
+		if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
+			NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
+			return -EINVAL;
+		} else if (mpc->classid) {
+			NL_SET_ERR_MSG_MOD(opt->extack, "Cannot create multiple classes");
+			return -EOPNOTSUPP;
+		}
+		mpc->classid = opt->classid;
+	}
+
+	rate = div_u64(opt->rate, 1000) << 3; //Convert Bps to Kbps
+	rate = div_u64(rate, 1000);	      //Convert Kbps to Mbps
+
+	/*Get current speed*/
+	err = mana_query_link_cfg(mpc);
+	old_speed = (err) ? SPEED_UNKNOWN : mpc->speed;
+
+	if (!err) {
+		if (alloc) {
+			/*Support only multiples of 100Mbps for rate parameter*/
+			rate = max(rate, MIN_BANDWIDTH);
+			rate = rounddown(rate, MIN_BANDWIDTH);
+
+			err = mana_set_bw_clamp(mpc, rate, TRI_STATE_TRUE);
+			mpc->speed = (err) ? old_speed : rate;
+		} else {
+			err = mana_set_bw_clamp(mpc, rate, TRI_STATE_FALSE);
+			mpc->classid = (err) ? : 0;
+		}
+	}
+
+	return err;
+}
+
+static int mana_create_tc_htb(struct mana_port_context *mpc)
+{
+	int err;
+
+	/*Check for hardware support*/
+	err = mana_query_link_cfg(mpc);
+	if (err == -EINVAL)
+		netdev_info(mpc->ndev, "QoS is not configured yet\n");
+
+	return err;
+}
+
+static int mana_tc_setup_htb(struct mana_port_context *mpc,
+			     struct tc_htb_qopt_offload *opt)
+{
+	int err;
+
+	switch (opt->command) {
+	case TC_HTB_CREATE:
+		err = mana_create_tc_htb(mpc);
+		return err;
+	case TC_HTB_NODE_MODIFY:
+	case TC_HTB_LEAF_ALLOC_QUEUE:
+		err = mana_tc_htb_handle_leaf_queue(mpc, opt, 1);
+		return err;
+	case TC_HTB_DESTROY:
+	case TC_HTB_LEAF_DEL:
+	case TC_HTB_LEAF_DEL_LAST:
+	case TC_HTB_LEAF_DEL_LAST_FORCE:
+		return mana_tc_htb_handle_leaf_queue(mpc, opt, 0);
+	case TC_HTB_LEAF_QUERY_QUEUE:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int mana_setup_tc(struct net_device *dev, enum tc_setup_type type,
+			 void *type_data)
+{
+	struct mana_port_context *mpc = netdev_priv(dev);
+
+	switch (type) {
+	case TC_SETUP_QDISC_HTB:
+		return mana_tc_setup_htb(mpc, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops mana_devops = {
 	.ndo_open		= mana_open,
 	.ndo_stop		= mana_close,
@@ -729,6 +825,7 @@ static const struct net_device_ops mana_devops = {
 	.ndo_bpf		= mana_bpf,
 	.ndo_xdp_xmit		= mana_xdp_xmit,
 	.ndo_change_mtu		= mana_change_mtu,
+	.ndo_setup_tc		= mana_setup_tc,
 };
 
 static void mana_cleanup_port_context(struct mana_port_context *apc)
@@ -1198,6 +1295,46 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 	return err;
 }
 
+int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
+		      int enable_clamping)
+{
+	struct mana_set_bw_clamp_resp resp = {};
+	struct mana_set_bw_clamp_req req = {};
+	struct net_device *ndev = apc->ndev;
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_SET_BW_CLAMP,
+			     sizeof(req), sizeof(resp));
+	req.vport = apc->port_handle;
+	req.link_speed = speed;
+	req.enable_clamping = enable_clamping;
+
+	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
+				sizeof(resp));
+
+	if (err) {
+		netdev_err(ndev, "Failed to set bandwidth clamp for speed %u, err = %d",
+			   speed, err);
+		return err;
+	}
+
+	err = mana_verify_resp_hdr(&resp.hdr, MANA_SET_BW_CLAMP,
+				   sizeof(resp));
+
+	if (err || resp.hdr.status) {
+		netdev_err(ndev, "Failed to set bandwidth clamp: %d, 0x%x\n", err,
+			   resp.hdr.status);
+		if (!err)
+			err = -EPROTO;
+		return err;
+	}
+
+	if (resp.qos_unconfigured)
+		netdev_info(ndev, "QoS is unconfigured\n");
+
+	return 0;
+}
+
 int mana_create_wq_obj(struct mana_port_context *apc,
 		       mana_handle_t vport,
 		       u32 wq_type, struct mana_obj_spec *wq_spec,
@@ -2942,6 +3079,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	ndev->hw_features |= NETIF_F_RXCSUM;
 	ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
 	ndev->hw_features |= NETIF_F_RXHASH;
+	ndev->hw_features |= NETIF_F_HW_TC;
 	ndev->features = ndev->hw_features | NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX;
 	ndev->vlan_features = ndev->features;
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 63193613c185..69687dfe7540 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -469,6 +469,8 @@ struct mana_port_context {
 	u16 port_idx;
 
 	u32 speed;
+	/*HTB class parameters*/
+	u16 classid;
 
 	bool port_is_up;
 	bool port_st_save; /* Saved port state */
@@ -500,6 +502,8 @@ void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
 void mana_query_gf_stats(struct mana_port_context *apc);
 int mana_query_link_cfg(struct mana_port_context *apc);
+int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed,
+		      int enable_clamping);
 int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
 
@@ -527,6 +531,7 @@ enum mana_command_code {
 	MANA_CONFIG_VPORT_RX	= 0x20007,
 	MANA_QUERY_VPORT_CONFIG	= 0x20008,
 	MANA_QUERY_LINK_CONFIG	= 0x2000A,
+	MANA_SET_BW_CLAMP	= 0x2000B,
 
 	/* Privileged commands for the PF mode */
 	MANA_REGISTER_FILTER	= 0x28000,
@@ -548,6 +553,20 @@ struct mana_query_link_config_resp {
 	u8 reserved[3];
 }; /* HW DATA */
 
+/* Set Bandwidth Clamp*/
+struct mana_set_bw_clamp_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t vport;
+	enum TRI_STATE enable_clamping;
+	u32 link_speed;
+}; /* HW DATA */
+
+struct mana_set_bw_clamp_resp {
+	struct gdma_resp_hdr hdr;
+	u8 qos_unconfigured;
+	u8 reserved[7];
+}; /* HW DATA */
+
 /* Query Device Configuration */
 struct mana_query_device_cfg_req {
 	struct gdma_req_hdr hdr;
-- 
2.34.1


