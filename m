Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189422284C4
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jul 2020 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgGUQFj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Jul 2020 12:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgGUQFj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Jul 2020 12:05:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0850C0619DA
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Jul 2020 09:05:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so10465477plr.2
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Jul 2020 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X76qDdvqpY4nYWZrENAHgAtFIsqrQGQH3lKvBOm1pNA=;
        b=YHbY+bB7w+LIQELxXvSqTfqeyBXTHWIdwQ+MiYbvaC79ApWPrJxf7gOf5o/3VDqfTF
         PoZuQXdqT6jImKy4+YUXCp/JICHZDi+Z1ediPsb6gxWqA8wI86VzeSoIOTTzDkEzOpKx
         nyjN7ifWqKUrBOuZW1nvgvWOb57IePorLdIR+b6/Zf1ibMfOBZjGYuPHNNAXiyhbrAg6
         rHHtWhPIPKy2c3IQxedlshUwT2MCnOR2Gt/FjLTtLYIA8RHifqQ+qNjz0PxcZ9QHu2V4
         0IXhhYm3MhY5m683IxZJkkrbhwhjl89/MEzEc209B46bsgzKm7AYwWYd/qzlqMXQFQDb
         uEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X76qDdvqpY4nYWZrENAHgAtFIsqrQGQH3lKvBOm1pNA=;
        b=n1G8Mz+5dCVaCwkl1W6Xsr12wpeknXAyeqTfAHjgv+Qh2mwBwMG2BuWzT/RjZkWkiu
         6hZTMayV1ppySfnteL5af4xhkb25h2SScelHVqnHmd1c2zCMKmuU+rV+oE9iruovfSIO
         ek6QsHhxrEhJS+8/vwkwTDPZsSXGpTZG4Nw/Z81luwVMr4dKbAAxK9Kmq0bGLzkdCkOk
         aDqKG9OpFuL9eh61b2taNwpY69gmbT42E1TlqmFGFoKhjYACm7xFcBtybjJss6Zgw9kl
         Ayc1juEgG5w5zaL9iletj6nPwB6nBlzlAxtFFp16/MRbgGvF2429uBHW9P8n/zA2VG9o
         9eAw==
X-Gm-Message-State: AOAM531Bn8qIqfQ57U05R+FsOFbu4QBCo0OqqpON7BF843j3UnRcoefj
        2AmNtWHjoRxWs6ovMx4Lp/U3vg==
X-Google-Smtp-Source: ABdhPJyG7RWJXLtDMWc9ARapBWFFyLqlOMjao2PUJ3NWA2A72SPkZFVRbDqubQQSDJMwHZi7l/bLrQ==
X-Received: by 2002:a17:90a:748c:: with SMTP id p12mr5327243pjk.115.1595347538417;
        Tue, 21 Jul 2020 09:05:38 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id i13sm3620963pjd.33.2020.07.21.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:05:38 -0700 (PDT)
Date:   Tue, 21 Jul 2020 09:05:28 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Sriram Krishnan <srirakr2@cisco.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, mbumgard@cisco.com,
        ugm@cisco.com, nimm@cisco.com, xe-linux-external@cisco.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] hv_netvsc: add support for vlans in AF_PACKET mode
Message-ID: <20200721090528.2c9f104d@hermes.lan>
In-Reply-To: <20200721071404.70230-1-srirakr2@cisco.com>
References: <20200721071404.70230-1-srirakr2@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 21 Jul 2020 12:44:03 +0530
Sriram Krishnan <srirakr2@cisco.com> wrote:

> +	/* When using AF_PACKET we need to drop VLAN header from
> +	 * the frame and update the SKB to allow the HOST OS
> +	 * to transmit the 802.1Q packet
> +	 */
> +	if (skb->protocol == htons(ETH_P_8021Q)) {
> +		u16 vlan_tci = 0;
Unnecessary initialization.

> +		skb_reset_mac_header(skb);
> +		if (eth_type_vlan(eth_hdr(skb)->h_proto)) {
> +			int pop_err;
> +			pop_err = __skb_vlan_pop(skb, &vlan_tci);
> +			if (likely(pop_err == 0)) {
> +				__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
> +				/* Update the NDIS header pkt lengths */
> +				packet->total_data_buflen -= VLAN_HLEN;
> +				rndis_msg->msg_len = packet->total_data_buflen;
> +				rndis_msg->msg.pkt.data_len = packet->total_data_buflen;
> +			} else {
> +				netdev_err(net, "Pop vlan err %x\n", pop_err);
> +				goto drop;
> +			}
> +		}
> +	}

Printing error messages is good for debugging but bad IRL.
Users ignore it, or it overflows the log buffer.

A better alternative would be to add a counter to netvsc_ethtool_stats.
Something like:

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index abda736e7c7d..2181d4538ab7 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -897,6 +897,7 @@ struct netvsc_ethtool_stats {
 	unsigned long rx_no_memory;
 	unsigned long stop_queue;
 	unsigned long wake_queue;
+	unsigned long vlan_error;
 };
 
 struct netvsc_ethtool_pcpu_stats {
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 6267f706e8ee..89568276e653 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -605,6 +605,28 @@ static int netvsc_xmit(struct sk_buff *skb, struct net_device *net, bool xdp_tx)
 		*hash_info = hash;
 	}
 
+	/* When using AF_PACKET we need to drop VLAN header from
+	 * the frame and update the SKB to allow the HOST OS
+	 * to transmit the 802.1Q packet
+	 */
+	if (skb->protocol == htons(ETH_P_8021Q)) {
+		skb_reset_mac_header(skb);
+		if (eth_type_vlan(eth_hdr(skb)->h_proto)) {
+			u16 vlan_tci;
+
+			if (unlikely(__skb_vlan_pop(skb, &vlan_tci) != 0)) {
+				++net_device_ctx->eth_stats.vlan_error;
+				goto drop;
+			}
+
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
+			/* Update the NDIS header pkt lengths */
+			packet->total_data_buflen -= VLAN_HLEN;
+			rndis_msg->msg_len = packet->total_data_buflen;
+			rndis_msg->msg.pkt.data_len = packet->total_data_buflen;
+		}
+	}
+
 	if (skb_vlan_tag_present(skb)) {
 		struct ndis_pkt_8021q_info *vlan;
 
@@ -1427,6 +1449,7 @@ static const struct {
 	{ "rx_no_memory", offsetof(struct netvsc_ethtool_stats, rx_no_memory) },
 	{ "stop_queue", offsetof(struct netvsc_ethtool_stats, stop_queue) },
 	{ "wake_queue", offsetof(struct netvsc_ethtool_stats, wake_queue) },
+	{ "vlan_error", offsetof(struct netvsc_ethtool_stats, vlan_error) },
 }, pcpu_stats[] = {
 	{ "cpu%u_rx_packets",
 		offsetof(struct netvsc_ethtool_pcpu_stats, rx_packets) },

	
