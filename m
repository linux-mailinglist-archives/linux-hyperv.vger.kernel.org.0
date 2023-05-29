Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534A47149C2
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 May 2023 14:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjE2M5X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 May 2023 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE2M5W (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 May 2023 08:57:22 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 May 2023 05:57:21 PDT
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9655091
        for <linux-hyperv@vger.kernel.org>; Mon, 29 May 2023 05:57:21 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3cJHqJjQi7PLm3cJHqd6v7; Mon, 29 May 2023 14:49:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685364558;
        bh=XoQbgvxypteKRvYSbooN/t9qEyY5FoztBSboiKjXBiQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZUl3C+/pW2OBrpSbLR2US9qae0y7TDuebI1UT8hnIJpqqhgkWIZKKMxycl1S8Kwj1
         u7CwGXoGvGndNcXntCrEbHCNbtICeSMWiAhl94fqu0xIQmU4vzzZbz5B3tZp9B1odC
         N33eNi0RIl1bELXMryoxSxUOQWWrD4JF5Pyw0doiwOue5cFwgSIYdV9SWqALvx37cS
         uTHWr0rPggRCPpel2Cn17l4eW10bcw0bG9Sr4FWMukmUgn0bTwDhxyRXygCVMGqud4
         oieR2iQn3PtBjCz5Ol2vAen+9MKF9bNhbj/eKcGyk7vOdrYoUT7m5nc/IYIidZIij+
         bvnClHqeKsq4g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 May 2023 14:49:18 +0200
X-ME-IP: 86.243.2.178
Message-ID: <92bc6f3e-4463-e0fe-5cab-54c6c5eecd3f@wanadoo.fr>
Date:   Mon, 29 May 2023 14:49:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] hv_netvsc: Allocate rx indirection table size
 dynamically
Content-Language: fr
To:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Simon Horman <simon.horman@corigine.com>
References: <1685080949-18316-1-git-send-email-shradhagupta@linux.microsoft.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1685080949-18316-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Le 26/05/2023 à 08:02, Shradha Gupta a écrit :
> Allocate the size of rx indirection table dynamically in netvsc
> from the value of size provided by OID_GEN_RECEIVE_SCALE_CAPABILITIES
> query instead of using a constant value of ITAB_NUM.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Tested-on: Ubuntu22 (azure VM, SKU size: Standard_F72s_v2)
> Testcases:
> 1. ethtool -x eth0 output
> 2. LISA testcase:PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-Synthetic
> 3. LISA testcase:PERF-NETWORK-TCP-THROUGHPUT-MULTICONNECTION-NTTTCP-SRIOV
> 
> ---

[...]

> @@ -1596,11 +1608,18 @@ void rndis_filter_device_remove(struct hv_device *dev,
>   				struct netvsc_device *net_dev)
>   {
>   	struct rndis_device *rndis_dev = net_dev->extension;
> +	struct net_device *net = hv_get_drvdata(dev);
> +	struct net_device_context *ndc = netdev_priv(net);
>   
>   	/* Halt and release the rndis device */
>   	rndis_filter_halt_device(net_dev, rndis_dev);
>   
>   	netvsc_device_remove(dev);
> +
> +	ndc->rx_table_sz = 0;
> +	kfree(ndc->rx_table);
> +	ndc->rx_table = NULL;
> +

Nit: useless empty NL

>   }
>   
>   int rndis_filter_open(struct netvsc_device *nvdev)

