Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1A4DC84D
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Mar 2022 15:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiCQOFv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Mar 2022 10:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiCQOFu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Mar 2022 10:05:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BECBCAB;
        Thu, 17 Mar 2022 07:04:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id j21so4449332qta.0;
        Thu, 17 Mar 2022 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FL38fgvsvawpITDbC9x4Hhdt+mogk5h23hg/e1hTAsg=;
        b=qUgi3dijFX91rXXgftDNfUYEzWuN2MlBVV/5I0nr+NxMuH19Rp30Sta9udsLgUGPYJ
         wu/RIss1Sl3lgW3eCnGa0ZiEO9BEPRKervXIVp1+DwGuNX3e/wX/u9CpX/yQVUovDY2S
         FLCpKBgYGBWtg/FTyxaNJsrc+7f7uw2l6q8vTtAGURNYNCG6MXzfMtNl7/FjtEFeeqwq
         S0YTSXxUIUUXEXZF//wrtvWcEq0BUo/J/OWgx8mgRPvarUw8OGMhr7gFlg/SnjbFfJUn
         f0z3ePFUjgWyV3xxof2MRdyZLbTUhw0DvPkvPPxJYw6keJvuwVOgQL/RB6ATDvEwweUF
         FBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FL38fgvsvawpITDbC9x4Hhdt+mogk5h23hg/e1hTAsg=;
        b=U3vr77fXodTsmD8pJzvbHiozdd5o1q/4p0OnHIB/HE4NzPDYJzZLNRPhtouV//za2+
         +anzWRWfzEsEoUjgqYAcHIHpO/wq1RAXCwO5/jMHobzhRtZZwne6YFCAAGEbyR1MwrD0
         gh7D+XePZNQGNZPgkXbQS08p+oh1DBF46xF6uDc1gZqu5W/7ZXZDYKLEKYaadgik/ivx
         pMb4y17HJ76mzi7iGFW+3MBUcHOTNBfdFTdIXnmFJ8uhN97M9ESZqtIPuyUKhcuKsuIh
         8y9VBWN3yVVp85HXZNlaFexHZlhLbviyFTJEyjX/md1PwIvPJGJgksNsUOnhu6O7ZqkT
         nY6A==
X-Gm-Message-State: AOAM530Qnc3DzXAvuP9hCRJcVug9LcY0L/9tKdDDteR4+QcVTKwhDn+r
        HG4L/TAxoC03NRm37UIoHA0=
X-Google-Smtp-Source: ABdhPJzxoaeAL+NryPJhrxknqODcVoYAVObjeqyZn7qk7WeVe42H5tavc1HD90UMV5DZDZr+HlNl+Q==
X-Received: by 2002:ac8:5703:0:b0:2e1:edc3:cee1 with SMTP id 3-20020ac85703000000b002e1edc3cee1mr3806343qtw.645.1647525873618;
        Thu, 17 Mar 2022 07:04:33 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g5-20020ac87f45000000b002e125ef0ba3sm3595329qtk.82.2022.03.17.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 07:04:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1187827C005A;
        Thu, 17 Mar 2022 10:04:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Mar 2022 10:04:32 -0400
X-ME-Sender: <xms:6T8zYu4uu-GNUQDC2S3yRUFqdYa4GvQOHM_3uNFmTtiQsBXJJEkCjQ>
    <xme:6T8zYn7rOjj_paIRL1uuurIJxOFOyNKglxDMRsMMChLcXQqfOUCWPBQvjwBf5gSVE
    EEbmERvhoGRvveCqA>
X-ME-Received: <xmr:6T8zYtfQMTTh482VhShqDIR63v9YB756e4SsVg2IvOlQdsJxHxqQ8wxiy8Bmnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefgedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
    ertddttdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghes
    ghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvddvkefhleetudejueehvedtfe
    eufeehheefueektdehudefffelteeujedvjeeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgv
    nhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:6j8zYrKB7jeA6fmdyQk80dDKggggeS4pFT1zW_WVfjv_aj7LMRqV-w>
    <xmx:6j8zYiLpbkEYvybjlORHVG6PobvtU5tF_GoHdp9baGj_i6XlSkVFyg>
    <xmx:6j8zYsxr7Gljzs6BQJmjNh4NgTWC42BwJAmWdwaJ6H0_sIuklNZrzQ>
    <xmx:8D8zYkBc8wmOsGKQzmRBAaBxy86gwvj7I9kFBC-WI7rjQyGMeFpbMg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Mar 2022 10:04:25 -0400 (EDT)
Date:   Thu, 17 Mar 2022 22:03:59 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: hv: Remove unused function
 hv_set_msi_entry_from_desc()
Message-ID: <YjM/z4vlPlVhdfMu@boqun-archlinux>
References: <20220317085130.36388-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220317085130.36388-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Mar 17, 2022 at 04:51:30PM +0800, YueHaibing wrote:
> This patch fix the following build error:
> 
> drivers/pci/controller/pci-hyperv.c:769:13: error: ‘hv_set_msi_entry_from_desc’ defined but not used [-Werror=unused-function]
>   769 | static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> 
> On arm64 hv_set_msi_entry_from_desc() is not used anymore since
> commit d06957d7a692 ("PCI: hv: Avoid the retarget interrupt hypercall in irq_unmask() on ARM64").
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Good catch!

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  drivers/pci/controller/pci-hyperv.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index df84d221e3de..558b35aba610 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -766,14 +766,6 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *irqd)
>  	return irqd->parent_data->hwirq;
>  }
>  
> -static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> -				       struct msi_desc *msi_desc)
> -{
> -	msi_entry->address = ((u64)msi_desc->msg.address_hi << 32) |
> -			      msi_desc->msg.address_lo;
> -	msi_entry->data = msi_desc->msg.data;
> -}
> -
>  /*
>   * @nr_bm_irqs:		Indicates the number of IRQs that were allocated from
>   *			the bitmap.
> -- 
> 2.17.1
> 
