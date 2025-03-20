Return-Path: <linux-hyperv+bounces-4645-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB24BA6A62F
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 13:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBD91889CC4
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79D4224228;
	Thu, 20 Mar 2025 12:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p/p8SwWs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57525221F39;
	Thu, 20 Mar 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473347; cv=none; b=fP8ynhXBZWEpeoBFp93m0FX+qFW0P8YmhKKIXXkG8/VN8seMHITulzXHv3u2i/+I+rLnVmyBoKuZX1C4qBYlLtuVTsSJQReJdtBSHMsitnSzX4onL2g5Cn9/WFNWdu5HKem8x8y2tvBHfc43uJBuo2t8ToSB7QgkjoA0NpbZLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473347; c=relaxed/simple;
	bh=4Xlrz8OTPOnn/0Z1PaocUUGP9A0UGMay1iJ4eIfY/iM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=O29aYg0qQPpXGkeLE3hj3r/YpY5IXaeh2OI/OPh69zCj+vE/p6O5Wq3VjBOOQuZE/HjZYiAR9CPq3NpQwWldcpcJqxWkk584TUcoUQ9xnDHAosv6namp59M55hNbjT0Tr+6OOCpitZbilgWj2RZBMmvPei4IMceAyJLIjHQ6zgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p/p8SwWs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id D68A42116B4D; Thu, 20 Mar 2025 05:22:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D68A42116B4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742473345;
	bh=Xwxv70u6KUTpUivc/cEfPVEIJqdCmQM54B7jfFV6qdE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p/p8SwWsmZCDFo2MMYaq+sQR56H0RR7SUZLZeXBo0Ta0usOz2s/iBqtUoBxNOMe1T
	 QTtRiruH2pF8qtZ/ss9bBATRObpTahhF0ahmMGARlcKuKPHThlkCSiyKPiS4LWF71H
	 XyJXLjD7SyYVHYE/pVK3Hz+N0InWDqaNYlBe9qsw=
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
	brett.creeley@amd.com,
	ernis@linux.microsoft.com,
	surenb@google.com,
	schakrabarti@linux.microsoft.com,
	kent.overstreet@linux.dev,
	shradhagupta@linux.microsoft.com,
	erick.archer@outlook.com,
	rosenp@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH 2/3] net: mana: Implement set_link_ksettings in ethtool for speed
Date: Thu, 20 Mar 2025 05:22:20 -0700
Message-Id: <1742473341-15262-3-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add support for ethtool_set_link_ksettings for mana.
Set speed information of the port using ethtool. This
feature is not supported by all hardware.

Before the change:
$ethtool -s enP30832s1 speed 100
>netlink error: Operation not supported
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
        Speed: Unknown!
        Duplex: Full
        Auto-negotiation: off
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Link detected: yes

After the change:
$ethtool -s enP30832s1 speed 100
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
        Speed: 100Mb/s
        Duplex: Full
        Auto-negotiation: off
        Port: Other
        PHYAD: 0
        Transceiver: internal
        Link detected: yes

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 39 +++++++++++++++++++
 .../ethernet/microsoft/mana/mana_ethtool.c    | 13 +++++++
 include/net/mana/mana.h                       | 16 ++++++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 5fa8e1e2ff9a..bcc273427423 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1203,6 +1203,45 @@ int mana_query_link_cfg(struct mana_port_context *apc)
 	return err;
 }
 
+int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed)
+{
+	struct mana_set_bw_clamp_req req = {};
+	struct mana_set_bw_clamp_resp resp = {};
+	struct net_device *ndev = apc->ndev;
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_SET_BW_CLAMP,
+			     sizeof(req), sizeof(resp));
+	req.vport = apc->port_handle;
+	req.link_speed = speed;
+	req.enable_clamping = TRI_STATE_TRUE;
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
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 48234a738d26..b29d0fe0a201 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -439,6 +439,18 @@ static int mana_get_link_ksettings(struct net_device *ndev,
 	return 0;
 }
 
+static int mana_set_link_ksettings(struct net_device *ndev,
+				   const struct ethtool_link_ksettings *cmd)
+{
+	struct mana_port_context *apc = netdev_priv(ndev);
+	int err;
+
+	err = mana_set_bw_clamp(apc, cmd->base.speed);
+
+	apc->speed = (err) ? apc->speed : cmd->base.speed;
+	return 0;
+}
+
 const struct ethtool_ops mana_ethtool_ops = {
 	.get_ethtool_stats	= mana_get_ethtool_stats,
 	.get_sset_count		= mana_get_sset_count,
@@ -453,5 +465,6 @@ const struct ethtool_ops mana_ethtool_ops = {
 	.get_ringparam          = mana_get_ringparam,
 	.set_ringparam          = mana_set_ringparam,
 	.get_link_ksettings	= mana_get_link_ksettings,
+	.set_link_ksettings	= mana_set_link_ksettings,
 	.get_link		= ethtool_op_get_link,
 };
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 5f039ce99ade..b4c66ce9ee3a 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -500,6 +500,7 @@ void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
 void mana_query_gf_stats(struct mana_port_context *apc);
 int mana_query_link_cfg(struct mana_port_context *apc);
+int mana_set_bw_clamp(struct mana_port_context *apc, u32 speed);
 int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
 
@@ -527,6 +528,7 @@ enum mana_command_code {
 	MANA_CONFIG_VPORT_RX	= 0x20007,
 	MANA_QUERY_VPORT_CONFIG	= 0x20008,
 	MANA_QUERY_LINK_CONFIG	= 0x2000A,
+	MANA_SET_BW_CLAMP	= 0x2000B,
 
 	/* Privileged commands for the PF mode */
 	MANA_REGISTER_FILTER	= 0x28000,
@@ -548,6 +550,20 @@ struct mana_query_link_config_resp {
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
+	bool qos_unconfigured;
+	u8 reserved[7];
+}; /* HW DATA */
+
 /* Query Device Configuration */
 struct mana_query_device_cfg_req {
 	struct gdma_req_hdr hdr;
-- 
2.34.1


