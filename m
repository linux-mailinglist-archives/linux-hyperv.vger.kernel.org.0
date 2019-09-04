Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC204A88DA
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2019 21:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfIDOg3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Sep 2019 10:36:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36521 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfIDOg3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Sep 2019 10:36:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so21557107wrd.3;
        Wed, 04 Sep 2019 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=thf6ZYT2fvljLGGoatMJVii4VlehtlAdeI7q9TGVUxs=;
        b=RWugBZGmQbZIL33HQqpOXcO6a9jK8uzlaKpqyvDmENzd1oA6GAQCPoMqebLtSEKZad
         Jh1Q64EKQ7FLsJMb/iKl335z5iX7H1dGWriR+kiu1OMMzstxdHR1eMDVUfmFtbV96kBe
         YxmoT6yQzVvW++V/KkTjF1z7yiOo6VFoaZgZgaeBiY/Zq5HrgJ4vteUw3jLgrEweLh8o
         fXBFIwu4rc8hzAxy9Z1fZU39zqZ+V0qizfDEM2+201OEdRaXkusGgI6wwBtDCtR/O7Jy
         KcN9NS7jXNaoV8+z3XYrYxULpPWqmdVkO5nRh4CoOYTbRt0mx5B1pH+Ham21vlqhRI+R
         ObsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=thf6ZYT2fvljLGGoatMJVii4VlehtlAdeI7q9TGVUxs=;
        b=MCjIfyhI+0yr01ZcRdIoPhDvT3CS6jh0J8Dj8yvT/zCDpvavgMYxGsQrqa/s4eyQqJ
         ZDUKWSyXcG0Asf5/FrP/wnVPbFWfszPx/1dA8a/AwRmUZABgPhnFMN4M2QARJUK9xHKU
         IJWyXFD/LTQZ5RgUm6tR1SQNgJwn8oA7zQr5cNqNuTFPmJ6VeHCKGPuI3lgJGsV7E4ZK
         vEParhg/hIXK6H9a6OgfZ7HOUSMOvwjekYAwdAtsQb6tXK3/dw2HQImxSNr+GQl6+E+s
         KUVtcEYvVMGmDuj9qUbx3SYmjfXFDhpYqICFOEWc/lm6DTq2yTbpUgfnrv0oPYZuTVEt
         M6tw==
X-Gm-Message-State: APjAAAUQGf7uh0lEGErsGv/+T940heZDVvO8RZ6tWiuv3Ezjg0J6jtlG
        kQWQaBCbaWr59gYmZoDEfOtkdZ8eEwT0ZA==
X-Google-Smtp-Source: APXvYqyb0is4E5rj/kA8576GYtmsudrqswsrKNcdR+wgIY3d/vLmEgWGUpL+o/uJjtWmDp2CWM2SAw==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr23568596wru.145.1567607786884;
        Wed, 04 Sep 2019 07:36:26 -0700 (PDT)
Received: from rocinante (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id e30sm33559424wra.48.2019.09.04.07.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 07:36:26 -0700 (PDT)
Date:   Wed, 4 Sep 2019 16:36:25 +0200
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: hv: Make functions static
Message-ID: <20190904143624.GA8393@rocinante>
References: <20190828221846.6672-1-kw@linux.com>
 <20190829091713.27130-1-kw@linux.com>
 <DM6PR21MB13372349374A473FF98AD7BCCAA20@DM6PR21MB1337.namprd21.prod.outlook.com>
 <20190904142737.GA28184@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904142737.GA28184@e121166-lin.cambridge.arm.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello Lorenzo,

[...]
> This patch should go via the net tree - the code it is fixing
> is queued there, I will drop this patch from the PCI review
> queue.
[...]

Thank you!  Appreciated.

Krzysztof
