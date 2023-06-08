Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080E4727635
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Jun 2023 06:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjFHEjV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Jun 2023 00:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjFHEjP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Jun 2023 00:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74872708;
        Wed,  7 Jun 2023 21:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CBE64163;
        Thu,  8 Jun 2023 04:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21990C433EF;
        Thu,  8 Jun 2023 04:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686199144;
        bh=H0CRIG596KcVniFPGVU2xyBR18yvldY55HfKmVq6wKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l/H9fd3CvvYLTKJ91XwoLMqXnTD4PFOOeOpNvt5aqQrSPbxQ5sqEm/46lkZ9ytdKh
         1jSnMDuyUUxUibN/htP2t1FPWSY3emN9CyY1Hmzsvu+Dcy0wz14gRLJjKW2dit0kms
         YfsAHcSeSjVO0vSj91BN04LeQQ2BX9TOhC89uPovMoPnvuIpylQcfooQchzmIy36SB
         Ng/2uph5uGvCZ9x6HPgw3YFcK2oWp9D40OWScXZ5ZLDmB4to8XBVYU2Kufsjh64hQW
         0t/wI4F4n83jPcfD3sJoSbyH5I+dc8ehpWUpPHPkAZSDnTONuG08EYPhSQXngv//Hc
         lKLnHnZZbbZ+Q==
Date:   Wed, 7 Jun 2023 21:39:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wei Hu <weh@microsoft.com>
Cc:     netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, longli@microsoft.com,
        sharmaajay@microsoft.com, jgg@ziepe.ca, leon@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, vkuznets@redhat.com,
        ssengar@linux.microsoft.com, shradhagupta@linux.microsoft.com
Subject: Re: [PATCH v2 1/1] RDMA/mana_ib: Add EQ interrupt support to mana
 ib driver.
Message-ID: <20230607213903.470f71ae@kernel.org>
In-Reply-To: <20230606151747.1649305-1-weh@microsoft.com>
References: <20230606151747.1649305-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue,  6 Jun 2023 15:17:47 +0000 Wei Hu wrote:
>  drivers/infiniband/hw/mana/cq.c               |  32 ++++-
>  drivers/infiniband/hw/mana/main.c             |  87 ++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h          |   4 +
>  drivers/infiniband/hw/mana/qp.c               |  90 +++++++++++-
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 131 ++++++++++--------
>  drivers/net/ethernet/microsoft/mana/mana_en.c |   1 +
>  include/net/mana/gdma.h                       |   9 +-

IB and netdev are different subsystem, can you put it on a branch 
and send a PR as the cover letter so that both subsystems can pull?

Examples:
https://lore.kernel.org/all/20230607210410.88209-1-saeed@kernel.org/
https://lore.kernel.org/all/20230602171302.745492-1-anthony.l.nguyen@intel.com/
