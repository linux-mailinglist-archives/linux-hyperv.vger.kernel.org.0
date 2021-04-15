Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE70B3613D9
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Apr 2021 23:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhDOVIN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Apr 2021 17:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhDOVIN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Apr 2021 17:08:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA070C061574
        for <linux-hyperv@vger.kernel.org>; Thu, 15 Apr 2021 14:07:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so8583012pja.5
        for <linux-hyperv@vger.kernel.org>; Thu, 15 Apr 2021 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HftWZnccBzP01eluEQiPxFKbZi9Y6kknhs11IWeFnvM=;
        b=NRvO3JOF8esPh7/WWkaX8usLVRSwsRys7YWh93NwFRddFNjL48k1rv9EHsnby5dv04
         kYHVjh/ZHUyXCgAzGLfn7VWfk2NBxw3Q8otRYaShP4NqstdYEUq/RNE9dqnxIEZbPF9H
         IfTxHNzYLHNYjAECWkPJWbtiy3yh4kow8p71RFx1TtXsLxi2vxXExkzbv16OOrihFzNr
         37qV+2AICtA+AGb9EQbNJCEKW8cl2jypQLut7Xb2RYvFIiUkFmf6x26JXOUXtR1wUEKv
         ARouBx2K+KXbP//OX1crmWeSBLkJQlQgQT7HPXWRtaH7l4xyUoG2WD59i/ADlDwvtfOt
         ZXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HftWZnccBzP01eluEQiPxFKbZi9Y6kknhs11IWeFnvM=;
        b=NW/K9bqvqL948k/fG8UCs6TF5L6uOj9inGR45n4dyqr/batexN1teL3ZIp+1YvKhIQ
         NIBinHkGEj6WO5D9CK4rH1Ivmp3/O9mk5u47bzW8i4zvEgpvVeWZ7kmRKOKutScDAJGr
         LPwd+tleO+Dq4TmZN+oEdJrgVQXLz5t8RXIHSf3CXaeunhNxNfVkqp5PLl6SZodOWW1c
         PF91c2nzfiB7XS0+jeCJuL770nQGG2f7+0pa73DTrvEGfr8xzxLU8cIBfD9oRvn3J3/i
         fvRmkSyuu7fTNAwSJ6SPVQLq++spx55w4PThsvvmB6obuhU9FjmBRRYAeDcefr8HKhO9
         4yIA==
X-Gm-Message-State: AOAM532JbGDXxUbH2wYwhPL6+mgE4f3m/BrbqFke+KOsKUYPuki7+0+D
        wPcMEg2upqImxPtsVNEhO4ROfg==
X-Google-Smtp-Source: ABdhPJxIfjaIzEemvHUaeH9feCNZBRnIZBbDTyHH5eWcVFuZoEsFzhsCpvLoN1Y+4JC4uNcJLeUhuw==
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr6219384pjb.46.1618520869084;
        Thu, 15 Apr 2021 14:07:49 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id q63sm3391636pjq.17.2021.04.15.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:07:48 -0700 (PDT)
Date:   Thu, 15 Apr 2021 14:07:40 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     davem@davemloft.net, kuba@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        liuwe@microsoft.com, netdev@vger.kernel.org, leon@kernel.org,
        andrew@lunn.ch, bernd@petrovitsch.priv.at, rdunlap@infradead.org,
        shacharr@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v6 net-next] net: mana: Add a driver for Microsoft Azure
 Network Adapter (MANA)
Message-ID: <20210415140740.7fac720e@hermes.local>
In-Reply-To: <20210415054519.12944-1-decui@microsoft.com>
References: <20210415054519.12944-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 14 Apr 2021 22:45:19 -0700
Dexuan Cui <decui@microsoft.com> wrote:

> +static int mana_query_vport_cfg(struct mana_port_context *apc, u32 vport_index,
> +				u32 *max_sq, u32 *max_rq, u32 *num_indir_entry)
> +{
> +	struct mana_query_vport_cfg_resp resp = {};
> +	struct mana_query_vport_cfg_req req = {};
> +	int err;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_QUERY_VPORT_CONFIG,
> +			     sizeof(req), sizeof(resp));
> +
> +	req.vport_index = vport_index;
> +
> +	err = mana_send_request(apc->ac, &req, sizeof(req), &resp,
> +				sizeof(resp));
> +	if (err)
> +		return err;
> +
> +	err = mana_verify_resp_hdr(&resp.hdr, MANA_QUERY_VPORT_CONFIG,
> +				   sizeof(resp));
> +	if (err)
> +		return err;
> +
> +	if (resp.hdr.status)
> +		return -EPROTO;
> +
> +	*max_sq = resp.max_num_sq;
> +	*max_rq = resp.max_num_rq;
> +	*num_indir_entry = resp.num_indirection_ent;
> +
> +	apc->port_handle = resp.vport;
> +	memcpy(apc->mac_addr, resp.mac_addr, ETH_ALEN);

You could use ether_addr_copy here.


> +int mana_do_attach(struct net_device *ndev, enum mana_attach_caller caller)
> +{
> +	struct mana_port_context *apc = netdev_priv(ndev);
> +	struct gdma_dev *gd = apc->ac->gdma_dev;
> +	u32 max_txq, max_rxq, max_queues;
> +	int port_idx = apc->port_idx;
> +	u32 num_indirect_entries;
> +	int err;
> +
> +	if (caller == MANA_OPEN)
> +		goto start_open;
> +
> +	err = mana_init_port_context(apc);
> +	if (err)
> +		return err;
> +
> +	err = mana_query_vport_cfg(apc, port_idx, &max_txq, &max_rxq,
> +				   &num_indirect_entries);
> +	if (err) {
> +		netdev_err(ndev, "Failed to query info for vPort 0\n");
> +		goto reset_apc;
> +	}
> +
> +	max_queues = min_t(u32, max_txq, max_rxq);
> +	if (apc->max_queues > max_queues)
> +		apc->max_queues = max_queues;
> +
> +	if (apc->num_queues > apc->max_queues)
> +		apc->num_queues = apc->max_queues;
> +
> +	memcpy(ndev->dev_addr, apc->mac_addr, ETH_ALEN);

And here use ether_addr_copy().

