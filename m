Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC23D344188
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 13:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhCVMeL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhCVMdO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 08:33:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B4AC061764
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Mar 2021 05:33:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b16so19113708eds.7
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Mar 2021 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SVanQr0nOKD358IYkjRAx3PCoRE9oI5X2zMEqx499hk=;
        b=In/2zB5DflwheyajBKF2sx8W9MNDzsh1OSXWuUfKtL/FRN8c9FQQ2cj+JpRaMJ8aAU
         XCEdMl5E1nKXsJ7LPr/dtmRUfPx5+I1x5doeJjGnHJs2u9wPfhjKCteG52TK/mXsWmp0
         r9Anh7nKKI7VMsuXAdYXcsCGpZElkzpp47nt0czliuc/sgnYDu/CCcQloeUW02Hubge7
         sWrpe/oCUN6WhcZa9kKsbPAqAXLDiS1XaNnARw1txUwxLHGsZeVRD+wmAVt2sQW9eS55
         UyTJMvhgC22uRmJJA3ffzwFbfulqEQ+Y37qGJg3epzU8Qv8Y9P3aSJ9V5kCcRG0/y2iv
         oQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVanQr0nOKD358IYkjRAx3PCoRE9oI5X2zMEqx499hk=;
        b=CO8QqGPvNZCXJAubqn3RAfU25to9XafPQTRuINSUFYqPJ9QB3MriAsz2tGCYv2ZX9m
         uJRl277A1sKYcNJO4Jg4uVXitGn9iNqQaMpa4j5V8FOzwhCYT78bwyzxYzoS832YqOtx
         QfY3BQOOk8eWFyo/ZNkjaU7W3rPxD0sNMLEvQdvgIXb52sS+ljstO6NJJDmzoGEzEpAp
         tXep4b+UC0Om+Gw3M9SCqkspPHkrZqjrcGuey4PzWieWYKzz/YErt5Sf2l6k2BbgBjnm
         JZiCa8lvYErYuhsv1mVUBoOim5xG0ryi/hJT1JQbcW/StPg/iFxoa4rzWKBUr1DLClnp
         fnTQ==
X-Gm-Message-State: AOAM532uACS07+Vgsohz2cTmgHecsWVRcg5cfNUN6aavP7ZiQgZanjGi
        MuKxioDzYBHGgqzrZWYAe0xFJw==
X-Google-Smtp-Source: ABdhPJzU8lxBAEHdWAbezgHwbSa71swddR2DYb7EY4LfoVvJcbMJx1acYwfadWxsyNH4XNxBLRVo6A==
X-Received: by 2002:a50:f391:: with SMTP id g17mr25306211edm.26.1616416392520;
        Mon, 22 Mar 2021 05:33:12 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::e05? ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id t27sm9618783ejc.62.2021.03.22.05.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 05:33:12 -0700 (PDT)
Subject: Re: [PATCH 03/13] PCI: xilinx: Convert to MSI domains
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, michal.simek@xilinx.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
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
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-4-maz@kernel.org>
 <20210322122100.GA11469@e121166-lin.cambridge.arm.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <74cffc38-df12-7d92-1bfe-20eed4b60e86@monstr.eu>
Date:   Mon, 22 Mar 2021 13:33:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322122100.GA11469@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

On 3/22/21 1:21 PM, Lorenzo Pieralisi wrote:
> On Thu, Feb 25, 2021 at 03:10:13PM +0000, Marc Zyngier wrote:
>> In anticipation of the removal of the msi_controller structure, convert
>> the ancient xilinx host controller driver to MSI domains.
>>
>> We end-up with the usual two domain structure, the top one being a
>> generic PCI/MSI domain, the bottom one being xilinx-specific and handling
>> the actual HW interrupt allocation.
>>
>> This allows us to fix some of the most appaling MSI programming, where
>> the message programmed in the device is the virtual IRQ number instead
>> of the allocated vector number. The allocator is also made safe with
>> a mutex. This should allow support for MultiMSI, but I decided not to
>> even try, since I cannot test it.
>>
>> Also take the opportunity to get rid of the cargo-culted memory allocation
>> for the MSI capture address. *ANY* sufficiently aligned address should
>> be good enough, so use the physical address of the xilinx_pcie_host
>> structure instead.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/pci/controller/Kconfig       |   2 +-
>>  drivers/pci/controller/pcie-xilinx.c | 238 +++++++++++----------------
>>  2 files changed, 96 insertions(+), 144 deletions(-)
> 
> Michal,
> 
> can you please test these changes or make sure someone does and report
> back on the mailing list please ?
> 
> I would like to merge this series for v5.13.

I got just private response (not sure why) from Bharat March 5 that
changes are fine.
It means go ahead with it.

Thanks,
Michal

