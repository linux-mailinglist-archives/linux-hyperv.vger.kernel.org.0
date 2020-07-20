Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A36226D34
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jul 2020 19:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgGTReg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jul 2020 13:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgGTRef (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jul 2020 13:34:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D377FC061794
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Jul 2020 10:34:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s189so10589285pgc.13
        for <linux-hyperv@vger.kernel.org>; Mon, 20 Jul 2020 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3j4oTHrOQZFqNUKygQYhUKPDy9BXvra1dSUQfhhnXXY=;
        b=kiYQdB66t89992BS5/3S9zupYvM9r4MMFbvkwh/BwIde6d1+Nm7rLriJMEYYgMEiPt
         KHARR+/kPm4txUgdOZB6Xgk2PrMunoQHuQkmL4WfRiaecPnLNiw84I5QsxXefK/yGn+k
         YJpsLsa0nZCy8fFXPiIqZECdXLSarRTTcDMjbdnEJsnq4k7/Zxm3EeNwC0ShcH/1aSUM
         j/rf2W5h8v1/UlhU9NA3KkELQ/8J3w+pNgD3jYv4HoD5B+cJbm7gsXd69YK4X599RO3S
         9d2crLPc6DssvDlGUkCAUwo2ojDdvcBJZ/cf5zT2eLGAZCwCviUTJxfYh8HfcRaQyrz/
         VrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3j4oTHrOQZFqNUKygQYhUKPDy9BXvra1dSUQfhhnXXY=;
        b=ikzDtj5Mu6RJXUeC9URqKCVVgX39cVLv+eNHFY6OlBeSWaNzvRje7EcE8ZWdkDwSjI
         fDTI3iemK6d9mx8wULwHXP32Rtklsglz9j8DqkKaN+p8KcO4bcL9b4iZ58oBAoQ9l9dd
         Z8NcFD/Hosybp2SSWjDRl13AMy51SZgwMD24Htd/oEMkbzRvE/zEKOKQUXUFBf0VrCx+
         kuh0IIsSultWBhWt6Nc5WJLAK6yUg9tuxieZUD2b2G8o+C+9g/laTspj11Pm+lhecL9S
         OE6oYzJuj6/X+p02v3gdppwWmhi++eVKCXiXWdRyQ3EZjwB58mOqZ5vm5BeviH6sWKb+
         GPtg==
X-Gm-Message-State: AOAM532MGjk5XCrb5dyIBtkwfuwV6YT9rx7AtriXMwP+gZVbVJQI6Z7n
        5O6x+Ez34KRPuPz7QioBoiy4yw==
X-Google-Smtp-Source: ABdhPJwqGvI6Z0Nhi8vxXNKPmGnXcK131taD73JvVDDzYMIa4O6e1nUPDjgBxRkPDoQbBuL7kKglcA==
X-Received: by 2002:a65:5c43:: with SMTP id v3mr19096111pgr.214.1595266475402;
        Mon, 20 Jul 2020 10:34:35 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id o129sm18190152pfg.14.2020.07.20.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 10:34:34 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:34:25 -0700
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
Subject: Re: [PATCH v3] net: hyperv: add support for vlans in netvsc driver
Message-ID: <20200720103425.03a05912@hermes.lan>
In-Reply-To: <20200720164551.14153-1-srirakr2@cisco.com>
References: <20200720164551.14153-1-srirakr2@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 20 Jul 2020 22:15:51 +0530
Sriram Krishnan <srirakr2@cisco.com> wrote:

>  
> +	/* When using AF_PACKET we need to remove VLAN from frame
> +	 * and indicate VLAN information in SKB so HOST OS will
> +	 * transmit the VLAN frame
> +	 */
> +	if (skb->protocol == htons(ETH_P_8021Q)) {
> +		u16 vlan_tci = 0;
> +		skb_reset_mac_header(skb);
> +		if (eth_type_vlan(eth_hdr(skb)->h_proto)) {
> +			int pop_err;
> +			pop_err = __skb_vlan_pop(skb, &vlan_tci);
> +			if (likely(pop_err == 0)) {
> +				__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
> +
> +				/* Update the NDIS header pkt lengths */
> +				packet->total_data_buflen -= VLAN_HLEN;
> +				rndis_msg->msg_len = packet->total_data_buflen;
> +				rndis_msg->msg.pkt.data_len = packet->total_data_buflen;
> +
> +			} else {
> +				netdev_err(net,"Pop vlan err %x\n",pop_err);
> +			}
> +		}
> +	}

Minor comments.

1. Blank line between declaration and code.
2. Error handling is different than other parts of this code.
   probably just need a goto drop on error.

It seems like you are putting into message, then driver is putting
it into meta-data in next code block. Maybe it should be combined?
