Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2515E788E
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiIWKno (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Sep 2022 06:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiIWKnj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Sep 2022 06:43:39 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CC7106F7B;
        Fri, 23 Sep 2022 03:43:36 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso3022965wmq.4;
        Fri, 23 Sep 2022 03:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=eNfIgiLSNV6f0ZyHgCkJcOePoKamQ5V91T6STNV4q+w=;
        b=sy29S1qDwGnYjHNxfg/JFv955zHVaHrCpAt2CjhRuhwb/YQtICPPMvVWb4Y7/34P21
         TKi2Pk5C+vot8P07Tsnhu4aPjvssuNpWD89ZsEMcRUXfX7VKpF/aNXh18H3lDUCh3W4J
         VO7wOgRtsuddN4xxOipuCZtAyY09tNxkbwJyFYkdOg1WVYVfIBK1dGZmEqrhUApMjutH
         LdsPffgAwbZJAPiH4V7iFb9YmQ+gc9J7SSOJlv7WutuqjW2hIM6F9hqsmCmHLnsNhv4D
         CZ0PAuUQhWgB2Y0P03KRREBVb1w+Uu6Bu2nz1EkSN3SIBTLEyN20c/PK8mKNCMjVzpyd
         8N5Q==
X-Gm-Message-State: ACrzQf3E3sFIiysDwrtdDhJOFdhug391yFSr4WXUShXgMfVYU624MpaK
        207X3v715diQSvaW4notLRc=
X-Google-Smtp-Source: AMsMyM4j0IYUy0eqBd/jiz7HRuaIDFcUisGkN52qei1q/PDTAzwzRA4KgNW7F2Vb71cpjUnlKm6jiQ==
X-Received: by 2002:a05:600c:4e90:b0:3b4:cb93:7d11 with SMTP id f16-20020a05600c4e9000b003b4cb937d11mr5425540wmq.43.1663929814791;
        Fri, 23 Sep 2022 03:43:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm10472621wms.1.2022.09.23.03.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 03:43:34 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:43:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] drivers/scsi: fix repeated words in comments
Message-ID: <Yy2N1JhuuR3+B9eI@liuwe-devbox-debian-v2>
References: <20220908130754.34999-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908130754.34999-1-wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 08, 2022 at 09:07:54PM +0800, wangjianli wrote:
> Delete the redundant word 'to'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

I changed the commit message a bit and pushed this patch to hyperv-next.
Thanks.

> ---
>  drivers/scsi/storvsc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 573f89eade3b..9f7c71a8c80e 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -2059,7 +2059,7 @@ static int storvsc_probe(struct hv_device *device,
>  err_out2:
>  	/*
>  	 * Once we have connected with the host, we would need to
> -	 * to invoke storvsc_dev_remove() to rollback this state and
> +	 * invoke storvsc_dev_remove() to rollback this state and
>  	 * this call also frees up the stor_device; hence the jump around
>  	 * err_out1 label.
>  	 */
> -- 
> 2.36.1
> 
