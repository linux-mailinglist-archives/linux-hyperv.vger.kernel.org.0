Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B094C21CF
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Feb 2022 03:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiBXCpa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 21:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiBXCp3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 21:45:29 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BBF23585D;
        Wed, 23 Feb 2022 18:45:00 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id j5so720647ila.2;
        Wed, 23 Feb 2022 18:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ni7aw7fzEAC4IJ89u6tGZffcuH52CHQfyjKILVom/D8=;
        b=grdV9eAR1ENIl71q4henMp7Uizhrnas9AUa3ibHRhbcdHs1Nk2TQR2Hv3+RfENp+6T
         YTf8ayaXuNOUU0j5r07n+4W1LnX8z71OoefloePhkv5QXHRbQXMPPAeOJZ4XQ7mrxmix
         s40H/yy4h/cd+BBy1PGyhO1044kltJa8c3G5VaF6P3+SRnVc2m89uTVi6JPGdHbjtH6W
         PuSLIb80oQtE490viqcR17+CMRQPeMAwt+fhoLRXSyrUhnJjJvEr26v7Qw6FpRnLVmy3
         mqDlhDAS1UGj1B8D4Ua5TQaM28PVhJcItJauSet7r2HLt+Ta09twUqXhZrk8KYfgJHCe
         wV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ni7aw7fzEAC4IJ89u6tGZffcuH52CHQfyjKILVom/D8=;
        b=3wRo+CGRvwyezf0dVB80RaXgZawVp3yg+LrBNBKQepWIWPOwpiD44/zHxk9XhVfyC6
         BchTzM6GR47WDtesU8cRtJUpXtTXT2XWGPeamxir6BjzxfWce2jAqdB0KydII0X7USyI
         NvXuRzZvM9RwVm0omrhCRHzZIun+v7eltHDwNnfijWFPtxu0SI0Iy4nObNEbs/fw5SKw
         lAmDazTdPVSs6qMJ4Nbz5BkeQS6iqn24SDjYm71wIqnBb+x++JZ60JPJ/bJry8GBYLtM
         ndn1+wJra0R7d1gYdWsWjY0LGifPoQEv5L7DlJioMGAH4o7Kp3MH7ntyx3IRLs7PJv5s
         cFnA==
X-Gm-Message-State: AOAM532/x1wzL5thEeqkGqjOOy+XfYqvu0EUBSB0f63fVrRhD6WKxoNn
        cBm+QV+z+tWnRqIlggTjj0h1Rr5N4Nk=
X-Google-Smtp-Source: ABdhPJwowva+eL8X4cZJF03dY6edeb1YihDWsDFAiLffyvznXpxaYo/Qjeo1YTBNtQVzgYBMbH58kQ==
X-Received: by 2002:a05:6e02:1947:b0:2c1:7096:8c8a with SMTP id x7-20020a056e02194700b002c170968c8amr520868ilu.309.1645670700063;
        Wed, 23 Feb 2022 18:45:00 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w19sm1051167iov.16.2022.02.23.18.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 18:44:58 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8BAAF27C0054;
        Wed, 23 Feb 2022 21:44:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 23 Feb 2022 21:44:57 -0500
X-ME-Sender: <xms:KPEWYr76W8u_S51tWQ_LzCVJK5J2DXTJNCP_DGVFRVFS6JSxj1xEGA>
    <xme:KPEWYg6TjmypgoaNc8yvrz9gXD305DGu0N85bfkpL4gJq9syHW0Muje7qtPc8JSjx
    -B0elrULqv5RWJS6A>
X-ME-Received: <xmr:KPEWYieJG_2WgEHvkJ5gZTKmMrqtZfZh3JsXx5N8IUNaeIpfzW5jtnFu_4jaRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledugdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:KPEWYsLbyQilqktlSfl-SWpCC7Hgs-mipbBaDhgx80mjedGrSu7feQ>
    <xmx:KPEWYvKhfiieceUa1Z9c7eemJaqptJLoelAk0ZFIvDNX7yoq8RgUSQ>
    <xmx:KPEWYlz8aKs6CdxO8g0LEt0-Zo1sWiVElV9UUo1_5irO2FviupQ8kA>
    <xmx:KfEWYgVx9T-i-JGWxqjsiX03iIN2TyqDFXt9gaJ7UATn24ghHx102HI96Nw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Feb 2022 21:44:56 -0500 (EST)
Date:   Thu, 24 Feb 2022 10:44:11 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2/2] Drivers: hv: balloon: Disable balloon and hot-add
 accordingly
Message-ID: <Yhbw+9rEmlBP3hNd@boqun-archlinux>
References: <20220223131548.2234326-1-boqun.feng@gmail.com>
 <20220223131548.2234326-3-boqun.feng@gmail.com>
 <MN0PR21MB30985DC877AB58DD1A849900D73C9@MN0PR21MB3098.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR21MB30985DC877AB58DD1A849900D73C9@MN0PR21MB3098.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 23, 2022 at 04:55:25PM +0000, Michael Kelley (LINUX) wrote:
> From: Boqun Feng <boqun.feng@gmail.com> Sent: Wednesday, February 23, 2022 5:16 AM
> > 
> > Currently there are known potential issues for balloon and hot-add on
> > ARM64:
> > 
> > *	Unballoon requests from Hyper-V should only unballoon ranges
> > 	that are guest page size aligned, otherwise guests cannot handle
> > 	because it's impossible to partially free a page.
> > 
> > *	Memory hot-add requests from Hyper-V should provide the NUMA
> > 	node id of the added ranges or ARM64 should have a functional
> > 	memory_add_physaddr_to_nid(), otherwise the node id is missing
> > 	for add_memory().
> > 
> > These issues require discussions on design and implementation. In the
> > meanwhile, post_status() is working and essiential to guest monitoring.
> > Therefore instead of the entire hv_balloon driver, the balloon and
> > hot-add are disabled accordingly for now. Once the issues are fixed,
> > they can be re-enable in these cases.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  drivers/hv/hv_balloon.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > index 062156b88a87..35dcda20be85 100644
> > --- a/drivers/hv/hv_balloon.c
> > +++ b/drivers/hv/hv_balloon.c
> > @@ -1730,9 +1730,19 @@ static int balloon_connect_vsp(struct hv_device *dev)
> >  	 * When hibernation (i.e. virtual ACPI S4 state) is enabled, the host
> >  	 * currently still requires the bits to be set, so we have to add code
> >  	 * to fail the host's hot-add and balloon up/down requests, if any.
> > +	 *
> > +	 * We disable balloon if the page size is larger than 4k, since
> > +	 * currently it's unclear to us whether an unballoon request can make
> > +	 * sure all page ranges are guest page size aligned.
> > +	 *
> > +	 * We also disable hot add on ARM64, because we currently rely on
> > +	 * memory_add_physaddr_to_nid() to get a node id of a hot add range,
> > +	 * however ARM64's memory_add_physaddr_to_nid() always return 0 and
> > +	 * DM_MEM_HOT_ADD_REQUEST doesn't have the NUMA node information for
> > +	 * add_memory().
> >  	 */
> > -	cap_msg.caps.cap_bits.balloon = 1;
> > -	cap_msg.caps.cap_bits.hot_add = 1;
> > +	cap_msg.caps.cap_bits.balloon = !(PAGE_SIZE > 4096UL);
> 
> Any reasons not to use HV_HYP_PAGE_SIZE vs. open coding "4096"?  So
> 
> 	cap_msg.caps.cap_bits.balloon = (PAGE_SIZE == HV_HYP_PAGE_SIZE);
> 

You're right. I will change that to it in the next version.

> > +	cap_msg.caps.cap_bits.hot_add = !IS_ENABLED(CONFIG_ARM64);
> 
> I think we should output a message so that there's no mystery as to 
> whether ballooning and/or hot_add are disabled, and why.  Each setting
> should have its own message.   Maybe something like:
> 
> 	if (!cap_msg.caps.cap_bits.balloon)
> 		pr_info("Ballooning disabled because page size is not 4096 bytes\n");
> 
> 	if (!cap_msg.cap_bits.hot_add)
> 		pr_info("Memory hot add disabled on ARM64\n");
> 

I agree with your suggestion, however, while I'm at it, I think it's
better that we have functions that check and print, and .balloon and
.hot_add can rely on the return value, for example:

static int balloon_enabled(void)
{
	if (PAGE_SIZE != HV_HYP_PAGE_SIZE) {
		pr_info("Ballooning disabled because page size is not 4096 bytes\n");
		return 0;
	}

	return 1;
}

// in balloon_vsp_connect()

	cap_msg.caps.cap_bits.balloon = balloon_enabled();

In this way, we keep the checking and reason printing in the same
function and it's easier to maintain the consistency.

Thoughts?

Regards,
Boqun

> > 
> >  	/*
> >  	 * Specify our alignment requirements as it relates
> > --
> > 2.35.1
> 
