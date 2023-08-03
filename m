Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734C576EC01
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbjHCOLa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Aug 2023 10:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjHCOLL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Aug 2023 10:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C03C23
        for <linux-hyperv@vger.kernel.org>; Thu,  3 Aug 2023 07:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBA3861DC2
        for <linux-hyperv@vger.kernel.org>; Thu,  3 Aug 2023 14:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E1AC433C8;
        Thu,  3 Aug 2023 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691071804;
        bh=Rx0WClHmnNKVmsFeZGA3nBlclFqEd5ganx10t5XvSmU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ckTD8ivVPsqOxgZZCRUD5ATL34b1ZWDoD5CkDZhe5TxEToNzmRmtJXVZvB4mN5Oll
         l2H4er3bia0MfNWNGQwxNKI/Q12GiCxM/Ht6CXwhudw0TWiMBx3YIN8IkpCq/UIhWr
         j4i11pO4aU02hjw24mkd5xXS2IlcVBnI5Qe3rPUrqusTo6EgbQZDSuSsEhh5F5Rgrs
         st/Sc1g9pWpM9ntF6rrCJogSeiiey76UfezwHD3M5FtEgt14ifdO0XIl6nSIm4r73G
         aOUhmDJZPNGJFkp8tl9JG8UXkiE7PgyfBW45TcFo5/GQz9B4FvQdYaBG5qKqmbcycC
         B2XZCBtAVmDhQ==
Message-ID: <01fcf1f1-d2d8-f26c-dd5c-be2655ef39a2@kernel.org>
Date:   Thu, 3 Aug 2023 16:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 1/3] eth: add missing xdp.h includes in
 drivers
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, ast@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        amritha.nambiar@intel.com, aleksander.lobakin@intel.com,
        Wei Fang <wei.fang@nxp.com>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        j.vosburgh@gmail.com, andy@greyhouse.net, shayagr@amazon.com,
        akiyano@amazon.com, ioana.ciornei@nxp.com, claudiu.manoil@nxp.com,
        vladimir.oltean@nxp.com, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, linux-imx@nxp.com, dmichail@fungible.com,
        jeroendb@google.com, pkaligineedi@google.com, shailend@google.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, grygorii.strashko@ti.com,
        longli@microsoft.com, sharmaajay@microsoft.com,
        daniel@iogearbox.net, john.fastabend@gmail.com,
        simon.horman@corigine.com, leon@kernel.org,
        linux-hyperv@vger.kernel.org
References: <20230803010230.1755386-1-kuba@kernel.org>
 <20230803010230.1755386-2-kuba@kernel.org>
From:   Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230803010230.1755386-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



On 03/08/2023 03.02, Jakub Kicinski wrote:
> Handful of drivers currently expect to get xdp.h by virtue
> of including netdevice.h. This will soon no longer be the case
> so add explicit includes.
> 
> Reviewed-by: Wei Fang<wei.fang@nxp.com>
> Reviewed-by: Gerhard Engleder<gerhard@engleder-embedded.com>
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

