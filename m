Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EBC4F0BC1
	for <lists+linux-hyperv@lfdr.de>; Sun,  3 Apr 2022 20:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359762AbiDCS2x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 3 Apr 2022 14:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359750AbiDCS2v (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 3 Apr 2022 14:28:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0AF39156
        for <linux-hyperv@vger.kernel.org>; Sun,  3 Apr 2022 11:26:55 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u16so11383887wru.4
        for <linux-hyperv@vger.kernel.org>; Sun, 03 Apr 2022 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bdNSHlvxbLgeS5OtknPrJD9scGCCHGJswcOxfjpkj8k=;
        b=HJPxauClsE0np7DjAvay8A3qNO9yH3dZHFeONBhunsAye2QJjEwG8hC0V131BjTbQw
         vtyLN7WthuLgwwNhdCY6aF/k7R8txSC/qRMJ8xCwemdVY+KaeRBkvHINcZa7pp8B9n/4
         psP1HG8tSSfUDJ2zS0n2xwmmwSuh7hDUpNROy3vYRAbyHR3Q57BU0DgYPwekeLzw8ODZ
         H+QsFAuIO1JiJhRZbkQKkU+MKR7bpvvFeUkaLl+jN0kxpw3dXUqm7FpniWC9vVy3Mtjb
         RbhlTctNKmMP8B2cuuCA2Qn5LglXfvS2+fDopX/AruCsvwpY0kuwoNM7/EI3sZhhp1GW
         65HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bdNSHlvxbLgeS5OtknPrJD9scGCCHGJswcOxfjpkj8k=;
        b=n7Je0vG1Ic2fxaH8QO01HyOOnglc3We5iicGEfYr3yNtbM6+FRlpvfvOw2gxKXfdhy
         htT5lPjHLXQsWrMaYXOJdAcFynqfc4era1Jcz7Yqs7WoqxAyjDlIoPhE3I4GesKgqTXN
         yA499gAcx9QwAWjJtR4Of0yoeK6OXVidf1XNvtDWq1+LdXWx1guAQDaASkQxDlEtD7AN
         EvXh209c+MPQMiN9eNyPV55uhdAUwSNeFiECC8P4ZYzWR8UWsL0Xyw1jw5Ov6nTquego
         DU9sbp6OCL0jvg96cYQtcQlBBD2SuQYSLr3c8ZHsrsyCdqyYHXo9CzBSyH8geu4Lzl6G
         Z2nA==
X-Gm-Message-State: AOAM533lCL3d+N+kAEs1lrq/XjKvPdkHjfSdgxHiMADbzk6GJFLHS0Vk
        aZhFU8hWmQa8aWd3QcTOYP8xig==
X-Google-Smtp-Source: ABdhPJxZiOGK2egxD/5OYMyK+G/Qvkwdu5zqnF3HM5t2oE8lWspEjCw8qRMqkAP48HNYh0SvcBxiOQ==
X-Received: by 2002:a05:6000:1547:b0:204:213:ae28 with SMTP id 7-20020a056000154700b002040213ae28mr14429429wry.114.1649010413589;
        Sun, 03 Apr 2022 11:26:53 -0700 (PDT)
Received: from [192.168.0.172] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm14881579wmc.7.2022.04.03.11.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 11:26:52 -0700 (PDT)
Message-ID: <fb2b05f0-7609-1fa7-4d69-c64e082e2e2b@linaro.org>
Date:   Sun, 3 Apr 2022 20:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 01/11] driver: platform: Add helper for safer setting
 of driver_override
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
 <20220316150533.421349-2-krzysztof.kozlowski@canonical.com>
 <CAHp75VeaQdzUKJSKzH9FjbmON5asqH799AS8OzHGoDiRnJifNw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAHp75VeaQdzUKJSKzH9FjbmON5asqH799AS8OzHGoDiRnJifNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 16/03/2022 16:54, Andy Shevchenko wrote:
> On Wed, Mar 16, 2022 at 5:06 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
> 
> ...
> 
>> +int driver_set_override(struct device *dev, const char **override,
>> +                       const char *s, size_t len)
>> +{
>> +       const char *new, *old;
>> +       char *cp;

I focused on some other topics, so I did not respond to your questions
for some time.

> 
>> +       if (!dev || !override || !s)
>> +               return -EINVAL;
> 
> Sorry, I didn't pay much attention on this. First of all, I would drop
> dev checks and simply require that dev should be valid. Do you expect
> this can be called when dev is invalid?

No, I can skip the check.

> I would like to hear if it's
> anything but theoretical. Second one, is the !s requirement. Do I
> understand correctly that the string must be always present? But then
> how we NULify the override? Is it possible?

I did not change the convention of this sysfs hook, so removing of
override is passing empty string "". Have in mind that his interface is
mainly for sysfs, not for other drivers.

> Third one is absence of
> len check. See below.
> 
>> +       /*
>> +        * The stored value will be used in sysfs show callback (sysfs_emit()),
>> +        * which has a length limit of PAGE_SIZE and adds a trailing newline.
>> +        * Thus we can store one character less to avoid truncation during sysfs
>> +        * show.
>> +        */
>> +       if (len >= (PAGE_SIZE - 1))
>> +               return -EINVAL;
> 
> I would relax this to make sure we can use it if \n is within this limit.

Relax in what way? Store more than PAGE_SIZE? This is a user-visible
string and the name of a driver.

> 
>> +       cp = strnchr(s, len, '\n');
>> +       if (cp)
>> +               len = cp - s;
>> +
>> +       new = kstrndup(s, len, GFP_KERNEL);
> 
> Here is a word about the len check.
> 
>> +       if (!new)
> 
> If len == 0, this won't trigger and you have something very
> interesting as a result.

True, empty string would be set as override. The API says that empty
string clears the override, so len==0 should be valid (just like "\n" is
ok).

> 
> One way is to use ZERO_PTR_OR_NULL() another is explicitly check for 0
> and issue a (different?) error code.



Best regards,
Krzysztof
