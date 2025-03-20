Return-Path: <linux-hyperv+bounces-4644-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F5A6A62C
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 13:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE37517A242
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 12:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C492222A4;
	Thu, 20 Mar 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qJ12vaz+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721D221D9C;
	Thu, 20 Mar 2025 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473346; cv=none; b=EzRNtC7vThJyQDYOnHWFQCEdL5l1lV7NZRIJvOL1CRMjPtlYgT/gXlcMPCRx3+Q+Va3NR6ZR60pUfYoe1mzVy4VWHhXEIeeBaTDeaUhY9SUszyoyUq3kC1iQ/O2Jx7YS1m94gtwcIGKH3XpGHlvi5NfIe/DnRhHNkqU9FNDU5/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473346; c=relaxed/simple;
	bh=yr2VP1SFwavyKZDLZk3rukZ5hhJQgQD+oSD6OfoWRL8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=gTn7rwiXOXVl0O4HFiSKhI5R61+BCKngfC7BrQwLKpVhnN0VzJdxuaIsBwzDE1faAYC8bZfc8JsX546SmZKqhTLL2+5APEnmfLHU3PV0VLWJ24tXvl1YPewBT1QvlbbRwY1r4vEU6LfWbGpMdtkHCOXOGxTKmxrvhxLfDgwuwX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qJ12vaz+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 8D4B42116B4C; Thu, 20 Mar 2025 05:22:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D4B42116B4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742473344;
	bh=KB6XNoqPV3XEJzdzP5NjdFolbV9vWqPV5BXVtSpm75Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qJ12vaz+Un/0eNCpZlZK6vvE9QkvOJ+ACHPIhbcrAQoVg+Ftc5z8sWy3sJfMz57u9
	 67Jb/M9H3lC4HzRgEL+hjejBXZt0lBSdpJf6saKXBtmM82AgBQpf1+hwJqEj3KUIEw
	 9V3SbEJ5LzFGL+MfnGVYDy3LNXsR1QZoMdfmjbNU=
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
Subject: [PATCH 1/3] net: mana: Add speed support in mana_get_link_ksettings
Date: Thu, 20 Mar 2025 05:22:19 -0700
Message-Id: <1742473341-15262-2-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
References: <1742473341-15262-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add support for speed in mana ethtool get_link_ksettings
operation. This feature is not supported by all hardware.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 42 +++++++++++++++++++
 .../ethernet/microsoft/mana/mana_ethtool.c    |  6 +++
 include/net/mana/mana.h                       | 17 ++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index aa1e47233fe5..5fa8e1e2ff9a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1161,6 +1161,48 @@ static int mana_cfg_vport_steering(struct mana_port_context *apc,
 	return err;
 }
 
+int mana_query_link_cfg(struct mana_port_context *apc)
+{
+	struct net_device *ndev = apc->ndev;
+	struct mana_query_link_config_req req = {};
+	struct mana_query_link_config_resp resp = {};
+	int err;
+
+	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_LINK_CONFIG,
+			     sizeof(req), sizeof(resp));
+
+	req.vport = apc->port_handle;
+
+	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
+				sizeof(resp));
+
+	if (err) {
+		netdev_err(ndev, "Failed to query link config: %d\n", err);
+		goto out;
+	}
+
+	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_LINK_CONFIG,
+				   sizeof(resp));
+
+	if (err || resp.hdr.status) {
+		netdev_err(ndev, "Failed to query link config: %d, 0x%x\n", err,
+			   resp.hdr.status);
+		if (!err)
+			err = -EPROTO;
+		goto out;
+	}
+
+	if (resp.qos_unconfigured) {
+		err = -EINVAL;
+		goto out;
+	}
+	apc->speed = resp.link_speed;
+	return 0;
+
+out:
+	return err;
+}
+
 int mana_create_wq_obj(struct mana_port_context *apc,
 		       mana_handle_t vport,
 		       u32 wq_type, struct mana_obj_spec *wq_spec,
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index c419626073f5..48234a738d26 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -427,6 +427,12 @@ static int mana_set_ringparam(struct net_device *ndev,
 static int mana_get_link_ksettings(struct net_device *ndev,
 				   struct ethtool_link_ksettings *cmd)
 {
+	struct mana_port_context *apc = netdev_priv(ndev);
+	int err;
+
+	err = mana_query_link_cfg(apc);
+
+	cmd->base.speed = (err) ? SPEED_UNKNOWN : apc->speed;
 	cmd->base.duplex = DUPLEX_FULL;
 	cmd->base.port = PORT_OTHER;
 
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 0d00b24eacaf..5f039ce99ade 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -468,6 +468,8 @@ struct mana_port_context {
 
 	u16 port_idx;
 
+	u32 speed;
+
 	bool port_is_up;
 	bool port_st_save; /* Saved port state */
 
@@ -497,6 +499,7 @@ struct bpf_prog *mana_xdp_get(struct mana_port_context *apc);
 void mana_chn_setxdp(struct mana_port_context *apc, struct bpf_prog *prog);
 int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf);
 void mana_query_gf_stats(struct mana_port_context *apc);
+int mana_query_link_cfg(struct mana_port_context *apc);
 int mana_pre_alloc_rxbufs(struct mana_port_context *apc, int mtu, int num_queues);
 void mana_pre_dealloc_rxbufs(struct mana_port_context *apc);
 
@@ -523,6 +526,7 @@ enum mana_command_code {
 	MANA_FENCE_RQ		= 0x20006,
 	MANA_CONFIG_VPORT_RX	= 0x20007,
 	MANA_QUERY_VPORT_CONFIG	= 0x20008,
+	MANA_QUERY_LINK_CONFIG	= 0x2000A,
 
 	/* Privileged commands for the PF mode */
 	MANA_REGISTER_FILTER	= 0x28000,
@@ -531,6 +535,19 @@ enum mana_command_code {
 	MANA_DEREGISTER_HW_PORT	= 0x28004,
 };
 
+/* Query Link Configuration*/
+struct mana_query_link_config_req {
+	struct gdma_req_hdr hdr;
+	mana_handle_t vport;
+}; /* HW DATA */
+
+struct mana_query_link_config_resp {
+	struct gdma_resp_hdr hdr;
+	u32 link_speed;
+	bool qos_unconfigured;
+	u8 reserved[3];
+}; /* HW DATA */
+
 /* Query Device Configuration */
 struct mana_query_device_cfg_req {
 	struct gdma_req_hdr hdr;
-- 
2.34.1


