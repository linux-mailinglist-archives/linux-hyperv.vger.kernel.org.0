Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4D4E5C99
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Mar 2022 02:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347083AbiCXBLh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Mar 2022 21:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbiCXBLg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Mar 2022 21:11:36 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781BE91AEB;
        Wed, 23 Mar 2022 18:10:05 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v13so2508807qkv.3;
        Wed, 23 Mar 2022 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yB8Xhdcr1UmQH8x5bcI6sm+S/MTI1xulItthpHA07WI=;
        b=McdUogDwPYB9swFBm2FXkncFErKcszgRCGc2+vf+t4VBJPShVyXnSPpMv3YcxJWDED
         F3EzvLFhmqSIaYRhQoJJKcNqwxUThjiXAKoIAvLd0tBsCL0kSGVwJ2Vjr/7rmxOlfA0m
         t7ej0shvb++RaMQy2JZQFzk6Z/O4vPZx0NOFae+Ai9tcKD8LD7cTqpmOh/1rR2rysvnS
         w5Up28ZSSUKpvJc/qbuGM4gfYJFYhHzODtN/JwPJuXLc9XItIibJzge48Wgl+zp1cxHs
         J+cnD/Zp0tv7toQzqHnlImRzvh3I7XAkemv1mb7g0IBjUhCCeCx8kEek4LKyZvIhjzB7
         OHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yB8Xhdcr1UmQH8x5bcI6sm+S/MTI1xulItthpHA07WI=;
        b=Vhm8ci28pKBh1NYIYf0ZJ2kpmLLyJ1SuQB/Rp5MQReVElrcn4JPxuKuk3kVgJ2a2YQ
         U+cMcaZkBcvOeuMXd1h5K5uUGaEdi3NMuJQGob7VXWE6xyBDLJxipC6I+yPNa7guNIMu
         d7w0mRYtOryOjwQslkVmhkkJYJEy/tabx095z8S9fL4atSo1hQM6U9mv9hTiEgyRdjzA
         2RkBN7DY5HZaejSiul81MHHQKAz17BPCojdphUOWCsatWeLtBlR3l3Ns3cFR7TtOUM4h
         TXItYW2Luj8lOsroAxVZys/x7onMwXiGWq2oRVbXD+SeCFmTxntMqt1gwidNoQtsqTxx
         /AsA==
X-Gm-Message-State: AOAM530BOIa8PRz41Zzz3w4qdZSwF508Yw3FvNdUoAQuRXqipnNQovLB
        XTRO1wjuR8nqvbHZozzc3nE=
X-Google-Smtp-Source: ABdhPJyOkEF06bgFmKyQhBb+A0wmpygZlW/7H7ia7YahrrMcQBz4D9XJ0EDr8NY3ZI4WwKEs5GrHkA==
X-Received: by 2002:a05:620a:294e:b0:67e:704d:7c55 with SMTP id n14-20020a05620a294e00b0067e704d7c55mr1865658qkp.118.1648084204497;
        Wed, 23 Mar 2022 18:10:04 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id o15-20020ae9f50f000000b0067d27e196f1sm729885qkg.133.2022.03.23.18.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 18:10:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id BFA8127C0054;
        Wed, 23 Mar 2022 21:10:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 23 Mar 2022 21:10:02 -0400
X-ME-Sender: <xms:6cQ7Yv14XCzJ365b4Jqxuq1yNfSLClI1w5uiWCXa0ixK2_r6dHbuwQ>
    <xme:6cQ7YuHtRC-vWlBHjbbLS1yQGN6jcE69QnWjlVhZv6rAJYgTlzz_A7huNMPtrj7ZZ
    rxR0VJT-63j7Xvn5w>
X-ME-Received: <xmr:6cQ7Yv7G3W5Hg3KFn9xzZqcA1ilzEHjjc2or0DEwd9BvoHwhE6b534ps5NYx3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegkedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:6cQ7Yk1aQXDv7c6Kky7fz7Ax1u6QICsQXHEPa5BNv3LSMZAOfhAK5w>
    <xmx:6cQ7YiFlNMRafLKMQALAlK-PDKP1FMuf0MMyyVROfchzWrwxQhyB0A>
    <xmx:6cQ7Yl9RffYNrNvz3ypcwkw5KOId3nS45xF1wl7DTs4klKDcIFLPlw>
    <xmx:6sQ7YiIIKzTS6Q0leKUkgVjkgN_eoduPzGJriRDFY3p7HYT21Wv-dw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Mar 2022 21:10:01 -0400 (EDT)
Date:   Thu, 24 Mar 2022 09:09:16 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
        lenb@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/2] PCI: hv: Propagate coherence from VMbus device to
 PCI device
Message-ID: <YjvEvFFuKJiV/NU+@boqun-archlinux>
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
 <1648067472-13000-3-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648067472-13000-3-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 23, 2022 at 01:31:12PM -0700, Michael Kelley wrote:
> PCI pass-thru devices in a Hyper-V VM are represented as a VMBus
> device and as a PCI device.  The coherence of the VMbus device is
> set based on the VMbus node in ACPI, but the PCI device has no
> ACPI node and defaults to not hardware coherent.  This results
> in extra software coherence management overhead on ARM64 when
> devices are hardware coherent.
> 
> Fix this by setting up the PCI host bus so that normal
> PCI mechanisms will propagate the coherence of the VMbus
> device to the PCI device. There's no effect on x86/x64 where
> devices are always hardware coherent.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  drivers/pci/controller/pci-hyperv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ae0bc2f..88b3b56 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3404,6 +3404,15 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hbus->bridge->domain_nr = dom;
>  #ifdef CONFIG_X86
>  	hbus->sysdata.domain = dom;
> +#elif defined(CONFIG_ARM64)
> +	/*
> +	 * Set the PCI bus parent to be the corresponding VMbus
> +	 * device. Then the VMbus device will be assigned as the
> +	 * ACPI companion in pcibios_root_bridge_prepare() and
> +	 * pci_dma_configure() will propagate device coherence
> +	 * information to devices created on the bus.
> +	 */
> +	hbus->sysdata.parent = hdev->device.parent;
>  #endif
>  
>  	hbus->hdev = hdev;
> -- 
> 1.8.3.1
> 
> 
