Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B648F4C530B
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Feb 2022 02:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiBZBcT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Feb 2022 20:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBZBcT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Feb 2022 20:32:19 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A8C21A991;
        Fri, 25 Feb 2022 17:31:44 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id t11so8550520ioi.7;
        Fri, 25 Feb 2022 17:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/KigQdnFd5mFTT/93mRvjhtdUhjTO09/KSQEMEs3KFI=;
        b=ePKrTyejrbbuJ4qUkTVosSdwluGgYxR2Of5TCKLu2sB9aAHTvnrXLN0+DC1+G3yKoi
         aPffeu+ERqhWMFl+NXg4qWoDX1YrGAICWJxS4gVdNX4bqQGtAvES1k4cjdqm7cm89nK2
         ki/GgN83Ni+kVVoU/GYAZFcsECYmfVdkeHzQMgJ5sSamg++8uWfQVQP6h5+qimeTADnd
         lUSrdmNXN9S3k82uTfzJ+Iagp9lMlpt3Laoulu8RQoIbdMasPA6dTjZK9uYMWmUsyXfr
         ZuVhLJpTxA6p3N+7ig/jKfV4fQD93LZV3IdQiNGumnqkVbqCwvySaE6EPamaVx9tCyEJ
         1A+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/KigQdnFd5mFTT/93mRvjhtdUhjTO09/KSQEMEs3KFI=;
        b=xnWH+gNYIVqaexYmDAoqC72Jqv5nECcY5B+g4tFokDFOtjaE5LG6+V0NYkoBoBXdcN
         Ol8v7cilZDO4eJHooxF2NaL8YhIGT9eqD1rnl4BdLtGrtMU2uYxTobZ9e3um5QQJp5YX
         VOpGS0M482YY1tEEYm/9y5CkS58IKBkoAQcyWrP8wk5V6k6xlaKhgoc8LAYEnqEnpsGQ
         c58hzNLbR5j5KSMHtaZ5Y7cEjIUERjabWdpQJv9pumKLBD1x9IsZ0fzU10dbBGHpRFzN
         laSSGmCgiYmRSzx3HU3dRrRq4bzdraVywTfBu2zSX1TlF29CS+HSjbRMCbPtNEWXL5RZ
         pV/Q==
X-Gm-Message-State: AOAM531rfboZDnfkh8dQ3VwTigDVTYhm1dPUOWa8oh2S1F9h7BXY5UA0
        rJyul9YWrdYMKCt5DTCfv7o6Ycw9nmo=
X-Google-Smtp-Source: ABdhPJwGUiQfHMvd3qeTcik90U4eh7FPqrYTFZMLIedkR4WVy4o0ha4wrvn7YV4TG0hR/CyWdI2ALQ==
X-Received: by 2002:a02:ccd7:0:b0:30d:21d0:51d6 with SMTP id k23-20020a02ccd7000000b0030d21d051d6mr8057635jaq.138.1645839103954;
        Fri, 25 Feb 2022 17:31:43 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h9-20020a92c089000000b002b8b3ce939fsm2481444ile.9.2022.02.25.17.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 17:31:42 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9201D27C0054;
        Fri, 25 Feb 2022 20:31:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 25 Feb 2022 20:31:41 -0500
X-ME-Sender: <xms:_IIZYmf6Gpmt9TJ0m2gN87pJlSp6v9EvBA35BLt7xNWFmBjSrhbbIQ>
    <xme:_IIZYgNEX96pyJWpQX0Ekp1JO2qNJlBRsDszBetVMMpIt3aQYPuL6_y_7j5AjtwE5
    y9uP0RWln8VN92mnQ>
X-ME-Received: <xmr:_IIZYnj_zokPVA1ArHPQHy1HfQx5Dp1Aww2QBc5xz0i2O6xdn9Iy900Aa_p8QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleehgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:_IIZYj8CLH6If-LKX-TuCSx4k6fpWYXLqgwM2iDsPbli_jKofEcWig>
    <xmx:_IIZYitTGTNFbEWPbnG8Bfr4OZMfTb_hdzV1RdI2HJMbrExSaFydUg>
    <xmx:_IIZYqGnC_m6XVUbiDQZUdTu1hN0ZCeBSxi2kEmkpQgnIr8eO7M6hA>
    <xmx:_YIZYsIw0iK8tbD71AgSwXo0v2buHVGpyggl-x0f5xCaJj0sdl8e55wgcs4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Feb 2022 20:31:40 -0500 (EST)
Date:   Sat, 26 Feb 2022 09:30:50 +0800
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
Subject: Re: [RFC v1.1] Drivers: hv: balloon: Disable balloon and hot-add
 accordingly
Message-ID: <YhmCys0dqkKCNQA0@boqun-archlinux>
References: <20220223131548.2234326-3-boqun.feng@gmail.com>
 <20220225021714.3815691-1-boqun.feng@gmail.com>
 <MN0PR21MB30984A8F1F71588DE6B1F366D73E9@MN0PR21MB3098.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR21MB30984A8F1F71588DE6B1F366D73E9@MN0PR21MB3098.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 25, 2022 at 05:06:45PM +0000, Michael Kelley (LINUX) wrote:
> From: Boqun Feng <boqun.feng@gmail.com> Sent: Thursday, February 24, 2022 6:17 PM
> > 
> > Currently there are known potential issues for balloon and hot-add on
> > ARM64:
> > 
> > *	Unballoon requests from Hyper-V should only unballoon ranges
> > 	that are guest page size aligned, otherwise guests cannot handle
> > 	because it's impossible to partially free a page.
> 
> The above problem occurs only when the guest page size is > 4 Kbytes.
> 

Ok, I wil call it out in next version.

> > 
> > *	Memory hot-add requests from Hyper-V should provide the NUMA
> > 	node id of the added ranges or ARM64 should have a functional
> > 	memory_add_physaddr_to_nid(), otherwise the node id is missing
> > 	for add_memory().
> > 
> > These issues require discussions on design and implementation. In the
> > meanwhile, post_status() is working and essiential to guest monitoring.
> 
> s/essiential/essential/
> 
> > Therefore instead of the entire hv_balloon driver, the balloon and
> > hot-add are disabled accordingly for now. Once the issues are fixed,
> > they can be re-enable in these cases.
> 
> Missing the word "disabling" in the first line?  Also the balloon

The phrasing that I was trying to use here is "Instead of A, B and C are
disabled" or "B and C are disabled instead of A". Looks like I'm
inventing my own English? Any I will add the "disabling" in the next
version ;-)

Regards,
Boqun

> function is disabled only if the page size is > 4 Kbytes.
> 
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > v1 --> v1.1:
> > 
> > *	Use HV_HYP_PAGE_SIZE instead of hard coding 4096 as suggested by
> > 	Michael.
> > 
> > *	Explicitly print out the disable message if a function is
> > 	disabled as suggested by Michael.
> > 
> >  drivers/hv/hv_balloon.c | 36 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 34 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > index 062156b88a87..eee7402cfc02 100644
> > --- a/drivers/hv/hv_balloon.c
> > +++ b/drivers/hv/hv_balloon.c
> > @@ -1660,6 +1660,38 @@ static void disable_page_reporting(void)
> >  	}
> >  }
> > 
> > +static int ballooning_enabled(void)
> > +{
> > +	/*
> > +	 * Disable ballooning if the page size is not 4k (HV_HYP_PAGE_SIZE),
> > +	 * since currently it's unclear to us whether an unballoon request can
> > +	 * make sure all page ranges are guest page size aligned.
> 
> My interpretation of the conversations with Hyper-V is that that they clearly
> don't guarantee page ranges are guest page aligned.
> 
> > +	 */
> > +	if (PAGE_SIZE != HV_HYP_PAGE_SIZE) {
> > +		pr_info("Ballooning disabled because page size is not 4096 bytes\n");
> > +		return 0;
> > +	}
> > +
> > +	return 1;
> > +}
> > +
> > +static int hot_add_enabled(void)
> > +{
> > +	/*
> > +	 * Disable hot add on ARM64, because we currently rely on
> > +	 * memory_add_physaddr_to_nid() to get a node id of a hot add range,
> > +	 * however ARM64's memory_add_physaddr_to_nid() always return 0 and
> > +	 * DM_MEM_HOT_ADD_REQUEST doesn't have the NUMA node information for
> > +	 * add_memory().
> > +	 */
> > +	if (IS_ENABLED(CONFIG_ARM64)) {
> > +		pr_info("Memory hot add disabled on ARM64\n");
> > +		return 0;
> > +	}
> > +
> > +	return 1;
> > +}
> > +
> >  static int balloon_connect_vsp(struct hv_device *dev)
> >  {
> >  	struct dm_version_request version_req;
> > @@ -1731,8 +1763,8 @@ static int balloon_connect_vsp(struct hv_device *dev)
> >  	 * currently still requires the bits to be set, so we have to add code
> >  	 * to fail the host's hot-add and balloon up/down requests, if any.
> >  	 */
> > -	cap_msg.caps.cap_bits.balloon = 1;
> > -	cap_msg.caps.cap_bits.hot_add = 1;
> > +	cap_msg.caps.cap_bits.balloon = ballooning_enabled();
> > +	cap_msg.caps.cap_bits.hot_add = hot_add_enabled();
> > 
> >  	/*
> >  	 * Specify our alignment requirements as it relates
> > --
> > 2.33.0
> 
> The code looks good to me.
> 
> Michael
