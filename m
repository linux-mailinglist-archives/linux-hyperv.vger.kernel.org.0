Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308E23273DA
	for <lists+linux-hyperv@lfdr.de>; Sun, 28 Feb 2021 19:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhB1Ssv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 28 Feb 2021 13:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhB1Ssv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 28 Feb 2021 13:48:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4649C06174A;
        Sun, 28 Feb 2021 10:48:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v13so1345075edw.9;
        Sun, 28 Feb 2021 10:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6FN28+EGwV52y5fLBmFdolcmGnuxL558/53m8V0+MHs=;
        b=PuwnMKZfF9jVmm8oa8y3QjE7JCwENco3bvbHskHMb3lb0hCkpHCrfv5oB/+tl45q1r
         ZHDfY06rcWoX+6WMekZ9ezBMVVkUn/R7F2/6VDeXorStJJv5pwPOHQ7Llnwf9w3I4ubd
         9V3/vRCvqJahnk4JIO1RRwiLSf9Zs/HlhxMGUfYdkH516u37+LgOsRkqoGC1qXARYrgM
         HlmW1jIqUvg5vLyfvv1Fpz2EXuL/ILv2uNUgxP2xDb+f+NZXzQj51tBhdn1xWquiKvL8
         xds4df9amNmFsI8+KGeKEBQjYACEfjtqetU85PW/kjIotDeFloSLcyIN1IGcqwxIj9Tp
         ODQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6FN28+EGwV52y5fLBmFdolcmGnuxL558/53m8V0+MHs=;
        b=NA3gs50lOTf6eUiwoBvvR1NwoqckbMKJeyafYd9pJH6QL6+jO6n3i7+elg63Cim/8Z
         fl1yniQDfS3HNMTmzQzhG1Hcf68SCHL+mVKlloJ6IrFOwdCz4Cagr8ZrzPCDXeCLxbGG
         BJkh1fdKx5H61fsLtCCJehGeo6qJTqz0eEXUYLyScoRRAY9Zt4iv6G4bUutMNOnnpmOc
         9Hu/wvn5Hq0VfmJfPHYbQQelvOSUj7O1Cb1wfgLUr1N8Kyr4HwA+/NSwsiEuAkCKoLIE
         e/qAHgNY+NKNzLOKnY4n09yRKYgspBWnJxFSTCJ1Z1Ue4jBmtnsNO4fGE2S/y8qzy4gZ
         3wbQ==
X-Gm-Message-State: AOAM530PTXILCN52zuB3HU0o5ci+lLH0CCFNZ4+RxpQNDxPCUmemmEjJ
        28pTweXvu3xwp/lxTqd63cNP/milBuUGyg==
X-Google-Smtp-Source: ABdhPJyvjekRu+I/lGwxqSoORkOQNSsmlj+tMS3vgn/nZmYclX07Y31NzYvg3A/TchA4e9wvrpkp5g==
X-Received: by 2002:a50:da4f:: with SMTP id a15mr12866517edk.301.1614538089407;
        Sun, 28 Feb 2021 10:48:09 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id g25sm1425341edp.95.2021.02.28.10.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 10:48:08 -0800 (PST)
Subject: Re: [PATCH 02/13] PCI: rcar: Convert to MSI domains
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-3-maz@kernel.org>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <91e327df-49de-e0b5-34bc-eae8b62e88ee@gmail.com>
Date:   Sun, 28 Feb 2021 19:48:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225151023.3642391-3-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2/25/21 4:10 PM, Marc Zyngier wrote:
> In anticipation of the removal of the msi_controller structure, convert
> the Rcar host controller driver to MSI domains.
> 
> We end-up with the usual two domain structure, the top one being a
> generic PCI/MSI domain, the bottom one being Rcar-specific and handling
> the actual HW interrupt allocation.
> 
> Also take the opportunity to get rid of the cargo-culted memory allocation
> for the MSI capture address. *ANY* sufficiently aligned address should
> be good enough, so use the physical address of the msi structure instead.

On R8A7795 with Intel 600p NVMe SSD and IWLwifi 6235 card,
Tested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Thanks.
