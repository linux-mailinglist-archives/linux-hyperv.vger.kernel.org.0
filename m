Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5303613FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Apr 2021 23:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhDOVP7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Apr 2021 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbhDOVP7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Apr 2021 17:15:59 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365AAC061574
        for <linux-hyperv@vger.kernel.org>; Thu, 15 Apr 2021 14:15:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t23so12779850pjy.3
        for <linux-hyperv@vger.kernel.org>; Thu, 15 Apr 2021 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+zzLPV6n+5kowpZE/IEJBo10o+qQ1Ks/Ky4ezSQr08=;
        b=lBPOF7HUcnVEuaiUK1v7fYM3nLPcU8cI7Q8MC89mb0K9L4eoZWdBRTf+6kKSHke9XH
         hLNJaim9Jw5PoXWWPIDMAOsbHLJzFzOjIcVvDVUJuIgyFqNNGZ3VDn6OFVodLDjbgRpH
         4ZWFKMk7KvkYI6Uz/tLNGUcIXWz++rZtxdRc3P5HM56ZB4YKxtWiPCm9DGf37NNxZnb9
         8FCkGVBTZgmhNaUdyYZVEA2ruNxoVhze7YeiZG3sWKc0BzQcHgMfGDsb49zEE4eYkuTB
         BFGUz0rQIs81g53nIanFPkUgxMpLWh69r6/Fxapc70XQZ0XKh44DJVwGJme087pv9uw6
         H1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+zzLPV6n+5kowpZE/IEJBo10o+qQ1Ks/Ky4ezSQr08=;
        b=HDdo5lFctfeyPtbJ02nFxiNA5B2ZNdfq2N4keDKssSc9dF7hItBuIiUXhB45wJn8jk
         UoE9sO4ljDa01Fex91zccPMpCve2LmSnhRQ5Hv3am6iEM4xB7GR+XGWufsQ3EEnCDViM
         +Xtfj4TKVPvRa28NtsDObtlD3zmW8XG8hetYcN55Pjjn2nP0Yorjv3DnSFs0MmMEvACj
         3ymUwBF6mfHJy6N5ToZ6CEUe/w/21GkZOk1IbnkmLdzhYm02Pdab8sc7A3s112TsIJUi
         dlWxzPFKMU9Y7+bdKqdxNJWjOpk47GAQM0PQrqitBqQKGMd3oWgtpNZ9oYHF65qjnGH0
         Dhxw==
X-Gm-Message-State: AOAM5304GnxWtqYMdJ55dE0y9//HGmjtKo1YjIz3kfV9CG97xbAm9gRN
        g4NnwqdVO+sP9V8KntilZbbJ2A==
X-Google-Smtp-Source: ABdhPJzboDjwMtKCULcXbojj82kIWXz6OPo28zEldC+ah1zGc+8yn3plPpmZXVbNr6sOK+w2ebG2hQ==
X-Received: by 2002:a17:90a:488a:: with SMTP id b10mr5944052pjh.2.1618521333789;
        Thu, 15 Apr 2021 14:15:33 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id x1sm2905627pfj.209.2021.04.15.14.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:15:33 -0700 (PDT)
Date:   Thu, 15 Apr 2021 14:15:25 -0700
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
Message-ID: <20210415141525.69c12844@hermes.local>
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

> +static int mana_probe_port(struct mana_context *ac, int port_idx,
> +			   struct net_device **ndev_storage)
> +{
> +	struct gdma_context *gc = ac->gdma_dev->gdma_context;
> +	struct mana_port_context *apc;
> +	struct net_device *ndev;
> +	int err;
> +
> +	ndev = alloc_etherdev_mq(sizeof(struct mana_port_context),
> +				 gc->max_num_queues);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	*ndev_storage = ndev;
> +
> +	apc = netdev_priv(ndev);
> +	apc->ac = ac;
> +	apc->ndev = ndev;
> +	apc->max_queues = gc->max_num_queues;
> +	apc->num_queues = min_t(uint, gc->max_num_queues, MANA_MAX_NUM_QUEUES);
> +	apc->port_handle = INVALID_MANA_HANDLE;
> +	apc->port_idx = port_idx;
> +
> +	ndev->netdev_ops = &mana_devops;
> +	ndev->ethtool_ops = &mana_ethtool_ops;
> +	ndev->mtu = ETH_DATA_LEN;
> +	ndev->max_mtu = ndev->mtu;
> +	ndev->min_mtu = ndev->mtu;
> +	ndev->needed_headroom = MANA_HEADROOM;
> +	SET_NETDEV_DEV(ndev, gc->dev);
> +
> +	netif_carrier_off(ndev);
> +
> +	get_random_bytes(apc->hashkey, MANA_HASH_KEY_SIZE);

Current practice for network drivers is to use netdev_rss_key_fill() for this.
