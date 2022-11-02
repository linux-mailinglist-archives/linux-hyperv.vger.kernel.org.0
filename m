Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DD46163E5
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 14:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKBNeN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBNeL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 09:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E3C29C8B;
        Wed,  2 Nov 2022 06:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 461AE619A0;
        Wed,  2 Nov 2022 13:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A33C433D7;
        Wed,  2 Nov 2022 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667396049;
        bh=UugxPTRum3GA6NT3cV3LetQcbxjAn1RP+8kL4YGxnKM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YXMF0zgqbQvF/pjj2HxQQQa9J9bzI3/R6OTwLzgKVRsHbi1W3SN9ZGEz2u9bHCRfJ
         pL4ihMstlNP7fJnmBQ5joVf01nLu+6YQnkkp75zt6SfG1JmvoB0xr1/NkBN86G8lNk
         3pv8/848z86RukEOGXNA1dN/6hAIBJqKrGqhnuK2zmCKLE5MQ9YUcqmR/Ebs8S3gnv
         KFtQ1ORomZtA1l7eH6Xz8vDg/YuDraoBdJOqBlJAB6YOD2G6G8wk+hAYG8xErZ1mb0
         sfXLwghCd63lyu9LpL73mP5z6e45eVZDQfIdpVj/m9VpjOf0Dav1tOj4+H8K09Z26O
         ODZga04GvBR7Q==
Date:   Wed, 2 Nov 2022 14:34:06 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
cc:     linux-input@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Subject: Re: [PATCH] HID: hyperv: fix possible memory leak in
 mousevsc_probe()
In-Reply-To: <20221028134043.1152629-1-yangyingliang@huawei.com>
Message-ID: <nycvar.YFH.7.76.2211021433580.29912@cbobk.fhfr.pm>
References: <20221028134043.1152629-1-yangyingliang@huawei.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, 28 Oct 2022, Yang Yingliang wrote:

> If hid_add_device() returns error, it should call hid_destroy_device()
> to free hid_dev which is allocated in hid_allocate_device().
> 
> Fixes: 74c4fb058083 ("HID: hv_mouse: Properly add the hid device")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/hid/hid-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index e0bc73124196..ab57b49a44ed 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -499,7 +499,7 @@ static int mousevsc_probe(struct hv_device *device,
>  
>  	ret = hid_add_device(hid_dev);
>  	if (ret)
> -		goto probe_err1;
> +		goto probe_err2;
>  

Good catch, applied, thank you.

-- 
Jiri Kosina
SUSE Labs

