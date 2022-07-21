Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE0E57C694
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Jul 2022 10:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiGUIjr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Jul 2022 04:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiGUIjd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Jul 2022 04:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4B8D7E836
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658392770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHQddct22+s5hmZWBuML5igjaqME1krrl4DYXrpi1tg=;
        b=WSVl24JoDaDFsrQQhI9eSxB8EMRE0srmRNtFw2SdawZ6VaYOisFEdg4iO2tNNHkl2WSTAC
        muSrxnQKItSHjijToIPFOgHR0ehnxFkP10qy1DtMrvpOasnejQVlvEAeZfyG+diceERviW
        oVVpPaaTDCuJ8lQ4gbSJhlxfRzFzm+8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-ygyzZ5PQOESkKZz9Bu2uiQ-1; Thu, 21 Jul 2022 04:39:28 -0400
X-MC-Unique: ygyzZ5PQOESkKZz9Bu2uiQ-1
Received: by mail-wr1-f69.google.com with SMTP id h1-20020adfa4c1000000b0021e43452547so149052wrb.9
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Jul 2022 01:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rHQddct22+s5hmZWBuML5igjaqME1krrl4DYXrpi1tg=;
        b=up4rhQxjThtF/8v4rCdClCbsREFZrx//1QttEKY+AEytbz2+ILVGXUk5kv8z5qpbtu
         irQXby6hNFkB0oVExWm8HlbMfO0qqVTzgkJ9MAAns1FlbzzNgJhibuKJpvtuE0LbrHx7
         NtJZ4xDBx5c+I2RHc1lnwGS9j/5zOgODpwPA+q10YRpoNuH1SoxJqV7Uh/+qC3v8Sl6d
         MvFjzYspduJp5EcWUXkJfHzOZQrZ2nMTw0JJ/aFtCmrjk8BnxDXiZ9vrvt7vm4x7ODe9
         fwQc1spAz9Rh74Hl9JOx5Lm2JS4IE7Uytqk8sraqtzuAUL8z1ViRBBbjSdLwLZXGxFvu
         Gf9g==
X-Gm-Message-State: AJIora/vJKFYJa8WZ9xWfTKDkvwqVQSAAu94UfAdfqoYL5ns2yFuN2HN
        vsJlyWyxRkvf5AN2u48dFWasKuQb0+KAWO5kEJZw7OfFqo6R+PQ1Oc9RlQHvYugyFp7NxUrOXKC
        EctQkjd1jR7/eMxVceg3OOi83
X-Received: by 2002:a5d:59a9:0:b0:21d:7ee2:8f90 with SMTP id p9-20020a5d59a9000000b0021d7ee28f90mr33649031wrr.598.1658392767582;
        Thu, 21 Jul 2022 01:39:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tgI04aD7Jw1LlQvxlJXF9GNlLvKMC9uf9PkUQtkjjLkNil8vUimbCbuG4SwLNzapNrDsFc9Q==
X-Received: by 2002:a5d:59a9:0:b0:21d:7ee2:8f90 with SMTP id p9-20020a5d59a9000000b0021d7ee28f90mr33649009wrr.598.1658392767222;
        Thu, 21 Jul 2022 01:39:27 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d6e54000000b0021d65e9d449sm1168696wrz.73.2022.07.21.01.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 01:39:26 -0700 (PDT)
Message-ID: <c31541b0-ef84-6018-1ba1-cff3a33f4954@redhat.com>
Date:   Thu, 21 Jul 2022 10:39:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fbdev: Fix order of arguments to
 aperture_remove_conflicting_devices()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        dri-devel@lists.freedesktop.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <20220721081655.16128-1-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220721081655.16128-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Thomas,

On 7/21/22 10:16, Thomas Zimmermann wrote:
> Reverse the order of the final two arguments when calling
> aperture_remove_conflicting_devices(). An error report is available
> at [1].
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 8d69d008f44c ("fbdev: Convert drivers to aperture helpers")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org
> Link: https://lore.kernel.org/lkml/202207202040.jS1WcTzN-lkp@intel.com/ # 1
> ---
>  drivers/video/fbdev/aty/radeon_base.c | 2 +-
>  drivers/video/fbdev/hyperv_fb.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index e5e362b8c9da..0a8199985d52 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -2243,7 +2243,7 @@ static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
>  	resource_size_t base = pci_resource_start(pdev, 0);
>  	resource_size_t size = pci_resource_len(pdev, 0);
>  
> -	return aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME, false);
> +	return aperture_remove_conflicting_devices(base, size, false, KBUILD_MODNAME);
>  }

I also missed that the order wasn't correct when reviewing.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

