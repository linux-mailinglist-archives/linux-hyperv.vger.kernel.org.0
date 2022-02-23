Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7594C1CF0
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiBWUNz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 15:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbiBWUNx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 15:13:53 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BFF4CD40
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 12:13:25 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AB125407C7
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645647201;
        bh=iwWa9JcbVhEYFFR9LsmnA7bsxJWJbrU0gOV0sfgjYeA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FRF9Pgg5bWRipui15FFpBEZN1uSSHMs/miMzo9T9FPGE6pVQlJ4ux0N0crD0aM4jF
         OEi3Gj0aKQZP0BsHlBKMJQ6pYOcUXI48UPh6lDpMw8RKYycciyVVk8UAoj32+O2xsv
         DAc4BDzr/0m+syBizxv5xmD2JQrS/tuTIpSv2WiuFQAtoPMr4A+PgB9JBN8FFboX/U
         SCmV1K1EUbZcZZz3mVxFY31n56JuTfSBYzCk4xLlDD9zyuye2CWxwsZKYpu0fFpm9j
         CghkfjLrXRlrYoJzKJz9+r397+Z/UsUbQicSkynMJ9vOeShVuRAtTJwf69/fUJt3dv
         L118XCxLizHXQ==
Received: by mail-ed1-f71.google.com with SMTP id o5-20020a50c905000000b00410effbf65dso14106437edh.17
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Feb 2022 12:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iwWa9JcbVhEYFFR9LsmnA7bsxJWJbrU0gOV0sfgjYeA=;
        b=SFSl1es9jb7uMBjd986o/++AJ8Rg3G0mQRCVJ0rf36E0zl/dBA82sNa17E0WOEPRD6
         tqKy1yELkaqksAlvkmUzP+XyYvqUoEABf9dseq74ipoNf3ZT48GtqPOZr8N1A2T6mpfi
         t/UjCV4YE2n+KFTdb5c9bG6y+AEw2BVIkqC67IL36g2VarXxwrgzHxFMYWuzgV/GSo2K
         2BgXjklsOb8B4Wlb1Onk/jierk/k5updR2JDtFxj0hX9BVMbnU3IYKNhAxPamptUQ18J
         hFAtAm8LPL6tuszzpWPcEVXqQSaC1Peuws5fmgPoCh3VUdoxtHau6hJ5dsyOOrc78cjt
         a0UQ==
X-Gm-Message-State: AOAM531bQRcWfQdcQK59OIuiHuSrJOGUsuPtaeOsjo4rg4v7SSwu+Cd6
        nC5zorj0b8ozteHpTwjZ4oyDayOJmTS8ZwdUXye3Lwib3F7GUhp9fLohHlb0iwXDP0T16zztIJt
        ACn3dAa6/0PmO05FCD5PovyZu+z0I+Jn/69wy2xIrSw==
X-Received: by 2002:a50:d4d2:0:b0:410:9fa2:60d6 with SMTP id e18-20020a50d4d2000000b004109fa260d6mr1046086edj.35.1645647190022;
        Wed, 23 Feb 2022 12:13:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz26puqYUhlyjvmoVu/kDMW076CFmPiGqR/4gF9iezSP9z6kTJySAPUmRGeoBQCBAPnogL/Qg==
X-Received: by 2002:a50:d4d2:0:b0:410:9fa2:60d6 with SMTP id e18-20020a50d4d2000000b004109fa260d6mr1046041edj.35.1645647189826;
        Wed, 23 Feb 2022 12:13:09 -0800 (PST)
Received: from [192.168.0.127] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id ee30sm359292edb.4.2022.02.23.12.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:13:09 -0800 (PST)
Message-ID: <ab308509-0f81-6f6b-7b94-0ac1086de53a@canonical.com>
Date:   Wed, 23 Feb 2022 21:13:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 07/11] spi: use helper for safer setting of
 driver_override
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
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
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
 <20220223191441.348109-1-krzysztof.kozlowski@canonical.com>
 <YhaTWiSQl6pTVxqC@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YhaTWiSQl6pTVxqC@sirena.org.uk>
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

On 23/02/2022 21:04, Mark Brown wrote:
> On Wed, Feb 23, 2022 at 08:14:37PM +0100, Krzysztof Kozlowski wrote:
> 
>> Remove also "const" from the definition of spi_device.driver_override,
>> because it is not correct.  The SPI driver already treats it as
>> dynamic, not const, memory.
> 
> We don't modify the string do we, we just allocate a new one?

Actually you're right - the SPI and VDPA implementations operate on
"const char *". The others do not, so I can convert them to "const char
*". Thanks!

Best regards,
Krzysztof
