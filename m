Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED418771C58
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Aug 2023 10:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjHGIfP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Aug 2023 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHGIfO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Aug 2023 04:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688A10EF;
        Mon,  7 Aug 2023 01:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEF8861666;
        Mon,  7 Aug 2023 08:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E921C433CC;
        Mon,  7 Aug 2023 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691397312;
        bh=dQQYVCV202V1fkp+H9UYGcqK9NudKTkhkMb/AaQNtto=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=AHBpwm2yXk/zDdi/IuT5WptLqTuta3FroC6SuurxaOy3UnmeMYJzT2/FD+N7S1K99
         VhT+tOE4K5IzfA7Fc+lS6dkK72uTWhw9BtgS+9LVnJRUeUxGgPNTMpySIt0JLqlEkV
         CdHA10dcbgLn97pcYK+cxXKYzI2Ymw5wpMempKkf5GT8ZwG7JJ1iZDVlsBHVt011k1
         Gy6JhhtpXZkdXr6F+4I6nCoRusAMES8rB2YZYQp3nVyWmkEoEDitjcx+MASrmXOVgu
         g5mtLIEZOKj9z38imh4oKyzKDQdX+O5vjGrnlWeDICBFLN2uxAMHMj17h9WWWIHlJn
         q//0thIlNzCyA==
Message-ID: <6f69bd92-a063-1934-2bd8-42a5950254a7@kernel.org>
Date:   Mon, 7 Aug 2023 10:35:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
        ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com,
        bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
        hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6,net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
References: <1691181233-25286-1-git-send-email-haiyangz@microsoft.com>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <1691181233-25286-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 04/08/2023 22.33, Haiyang Zhang wrote:
> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> usage.
> 
> The standard page pool API is used.
> 
> With iperf and 128 threads test, this patch improved the throughput
> by 12-15%, and decreased the IRQ associated CPU's usage from 99-100% to
> 10-50%.
> 
> Signed-off-by: Haiyang Zhang<haiyangz@microsoft.com>
> Reviewed-by: Jesse Brandeburg<jesse.brandeburg@intel.com>

For the record I want to provide my ACK as page_pool maintainer:

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

As patch was applied Sunday, my ACK will not reach the git tree
  https://git.kernel.org/netdev/net-next/c/b1d13f7a3b53

--Jesper
