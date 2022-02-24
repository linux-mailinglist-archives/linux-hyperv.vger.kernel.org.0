Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790854C24A3
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Feb 2022 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiBXHtt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Feb 2022 02:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiBXHts (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Feb 2022 02:49:48 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E2917CC61
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 23:49:18 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 720473FCA6
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Feb 2022 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645688957;
        bh=tIIHXtnNxTvsUSqBUvFfmiqo64/DEPmMQ0dgIpM1aoU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=l5Feig8W/a9EpyEsGmaBuW4/w3EmEkOSouuGl+9XeKDCXv56PZw/PP3KPcsHmesaG
         ePQK/Ar4/6eX/APXZcD0jRJs8sCubwfH2Xp3r767F65vPMRVm2G9JG0w7vIifE1m6M
         cVCttXU4nHFGAZQ9Dom03/Qu4QHL1oxxr+u7qxuszJY3iAvgBuByBf+TEiPBWQszKH
         YxhSlVkHiitxSP3ozHVCfq+NKrG20Mn0PPCYUM9MbUqZSKozlYRTTS3tlUhPVhHrx2
         CLbHv7BbIe5TRPZTFDlbVXO626e4ScceOy81feTLTNaSNEePT7yP0Qc8cGiJMV/GFr
         oC3q4ZZ2evxhA==
Received: by mail-ej1-f69.google.com with SMTP id h22-20020a1709060f5600b006b11a2d3dcfso824901ejj.4
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 23:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tIIHXtnNxTvsUSqBUvFfmiqo64/DEPmMQ0dgIpM1aoU=;
        b=Pwx4yHvv0umxiwnumoL5T1Pi18xB1jp+B+xENl2fqHBXJKw1M2dLYyqQdhZvllidER
         47ebEgxS9W9sL+/kkwOwwUqfTh5U0yQjs/6hQ86WNDRaajSxcI4VK8IV5f0VikYyP7dc
         5msAhEd5WbwN5/YT8aF1iEshUVdn8o6iw+DtrGJ1+TVH72WvH+/lnOzf2SQcXyV6ttiN
         fGIqKzZzuhWM0nP/qGPJnrZAQiN2FreBeiLURQU4KiAr7piR+YxDZFQ/gSJCflTY6Z7B
         XafcPdNVr4188944nL9BrpdTdNquCOz46ux+NN6UO/gZ/qES++FvcQrGeiZLYtZi3AUe
         KnrA==
X-Gm-Message-State: AOAM533xxXIinyWKrHwP8PszIx9deap9NkZUkeVv7PditS8xU05bdJNh
        8ZF3PFJN42oPxhbIFJ0oAaunBzng8KNdOb2Gi+P6SV/Rr2cc8i2bCEqSCVDPgtuJ0Aeuz0BmSKa
        DlS1gRgn0arxLmH5rq9XOgunGrR05eCLhSBu+Futx4g==
X-Received: by 2002:a05:6402:177b:b0:413:2822:1705 with SMTP id da27-20020a056402177b00b0041328221705mr1116375edb.270.1645688957129;
        Wed, 23 Feb 2022 23:49:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZ4T6vTJDSRNBttoRjN0CBDIUiJLcd/AByD7b5Uhgs6BBbS824OeS6Yj6e4iHov1EozcksnA==
X-Received: by 2002:a05:6402:177b:b0:413:2822:1705 with SMTP id da27-20020a056402177b00b0041328221705mr1116367edb.270.1645688956871;
        Wed, 23 Feb 2022 23:49:16 -0800 (PST)
Received: from [192.168.0.127] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id s15sm954628ejm.70.2022.02.23.23.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 23:49:16 -0800 (PST)
Message-ID: <f7347531-8aa4-c011-d405-dea93e29779f@canonical.com>
Date:   Thu, 24 Feb 2022 08:49:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 05/11] pci: use helper for safer setting of
 driver_override
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220223215115.GA155125@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220223215115.GA155125@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 23/02/2022 22:51, Bjorn Helgaas wrote:
> In subject, to match drivers/pci/ convention, do something like:
> 
>   PCI: Use driver_set_override() instead of open-coding
> 
> On Wed, Feb 23, 2022 at 08:13:04PM +0100, Krzysztof Kozlowski wrote:
>> Use a helper for seting driver_override to reduce amount of duplicated
>> code.
> 
> s/seting/setting/
> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  drivers/pci/pci-sysfs.c | 24 ++++--------------------
>>  1 file changed, 4 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 602f0fb0b007..16a163d4623e 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -567,31 +567,15 @@ static ssize_t driver_override_store(struct device *dev,
>>  				     const char *buf, size_t count)
>>  {
>>  	struct pci_dev *pdev = to_pci_dev(dev);
>> -	char *driver_override, *old, *cp;
>> +	int ret;
>>  
>>  	/* We need to keep extra room for a newline */
>>  	if (count >= (PAGE_SIZE - 1))
>>  		return -EINVAL;
> 
> This check makes no sense in the new function.  Michael alluded to
> this as well.

I am not sure if I got your comment properly. You mean here:
1. Move this check to driver_set_override()?
2. Remove the check entirely?

> 
>> -	driver_override = kstrndup(buf, count, GFP_KERNEL);
>> -	if (!driver_override)
>> -		return -ENOMEM;
>> -
>> -	cp = strchr(driver_override, '\n');
>> -	if (cp)
>> -		*cp = '\0';
>> -
>> -	device_lock(dev);
>> -	old = pdev->driver_override;
>> -	if (strlen(driver_override)) {
>> -		pdev->driver_override = driver_override;
>> -	} else {
>> -		kfree(driver_override);
>> -		pdev->driver_override = NULL;
>> -	}
>> -	device_unlock(dev);
>> -
>> -	kfree(old);
>> +	ret = driver_set_override(dev, &pdev->driver_override, buf);
>> +	if (ret)
>> +		return ret;
>>  
>>  	return count;
>>  }
>> -- 
>> 2.32.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


Best regards,
Krzysztof
