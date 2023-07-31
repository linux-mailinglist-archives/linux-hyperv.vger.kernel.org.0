Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F141F76A299
	for <lists+linux-hyperv@lfdr.de>; Mon, 31 Jul 2023 23:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjGaV0I (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 31 Jul 2023 17:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaV0G (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 31 Jul 2023 17:26:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C762210FA;
        Mon, 31 Jul 2023 14:26:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99b9421aaebso716288666b.2;
        Mon, 31 Jul 2023 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690838760; x=1691443560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWdvfPMdd3Z4Bi7ET0NlW+NFmuLNOzv1g7PWf7bswYg=;
        b=jP/CUWfHWI/KIxPHYQ64OqYxAxWX+v0iZ/KEMDwrSKzDg0aKG/ErLnbCXtOF98pJ5m
         OGsBl8hPmckbioKyFz2XziDBvNC3+YPLIAsjvs6qifMkL4LfE9IEgK7PpinOrKKomcBZ
         gh5ulDvd0Qo2QExZpTi+ZLqlP9kbnMNSW8/Lw+fThpSlzVeG1aTvp6Mx9HQv4/hIWyAm
         YtiHWX7mOnzJYze74MTLF8l1IePFRrW8K9kthholAWHCFcZohaOXeQ77RVrkwNxmy+KV
         +dgcsHHi+0rt2uUn+38mBBNs5/ctuTM9Q/9Jw3cSWbiZsdx6e/7TKds5aQDREIjdbinn
         OYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690838760; x=1691443560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWdvfPMdd3Z4Bi7ET0NlW+NFmuLNOzv1g7PWf7bswYg=;
        b=C0K/Zq4neQf7UFOdSd7W73fpz8VSGPLRWmj9mTEI5ySFQiccI4mB9Goa7WDVA8iHr4
         IhlYoLrHlRwgCOfazRHaebSw3q+1c7Jvp4uA8U3DUVvUw63qEBlkv/RFqz5JMWhdeGMc
         reW92vJQYJUbCdE783ZsVXY6lHJGcoJFSeHV8l2EuFreqIZvlZU9kf3biSHIa4kLzqkD
         ps33J1gv6fCW21GiIExdkLKVvO5ScGvNEN4aTo3kg8IhMPvx5cAxMF7E4wUDI+wrXiH9
         uRKxfDgsKCQajE9QRw3axEHnbnSRGKirBREm1/RpN0WU/5Q0cHzzzGvAhbvxTVtAgOza
         4aBg==
X-Gm-Message-State: ABy/qLargrHkp5qzQzAwE0NThLqEO++JKsgUoCon9WDTlFtkRZt5YDw8
        N7iB+lMC3QYKqHcSR+FpbZw=
X-Google-Smtp-Source: APBJJlGyayX2kMV/BORcoY2b5p6wFQToutl8CaU1C+19vlPqCzAu3hhRpkrY+asgVYnKsVHKQ/bGxw==
X-Received: by 2002:a17:907:b0e:b0:997:e959:be3e with SMTP id h14-20020a1709070b0e00b00997e959be3emr701513ejl.76.1690838759994;
        Mon, 31 Jul 2023 14:25:59 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709064e5600b0099b7276235esm6710787ejw.93.2023.07.31.14.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:25:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A391C27C0054;
        Mon, 31 Jul 2023 17:25:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 31 Jul 2023 17:25:57 -0400
X-ME-Sender: <xms:5SbIZE636MnsA0O1F5f6hOWArmfdCwgNtoYJ7rF9ndi1WZE0PXNt0Q>
    <xme:5SbIZF48pPTwb1R4UFuit_YWLhBQzVJJVDshCqXHinfZ4ZqTUbxhdhe4WDyaGCGhD
    ux2wSwSM7yA8wKf5g>
X-ME-Received: <xmr:5SbIZDeAMtrx_jaNR-C4MxTIO1vB7dVhvunB6oWETfcfq9AZwgrCF_iNENcuSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:5SbIZJJtSXBArbrlO7Pklr7y_WN-wmpuOH9nDLEmq7J07IidrD6ilg>
    <xmx:5SbIZIKXkKIpxAbyVL9E_rKEGZxyvbuMsDFWAoUMkp_uLFrubZvE9A>
    <xmx:5SbIZKzqbQgM7C1wtmpQ0O-CaSmXft0F3CfjqYCQBI23xHRBxU7hEw>
    <xmx:5SbIZH_kbbwO3R3L4tx3vk6OdI7zvteAanDvJe0LMH3WGnszXdTmfg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jul 2023 17:25:56 -0400 (EDT)
Date:   Mon, 31 Jul 2023 14:25:13 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     levymitchell0@gmail.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelly@microsoft.com, peterz@infradead.org
Subject: Re: [PATCH] hv_balloon: Update the balloon driver to use the SBRM API
Message-ID: <ZMgmuWmJu9Ppqm2t@boqun-archlinux>
References: <20230726-master-v1-1-b2ce6a4538db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-master-v1-1-b2ce6a4538db@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Mitchell,

On Wed, Jul 26, 2023 at 12:23:31AM +0000, Mitchell Levy via B4 Relay wrote:
> From: Mitchell Levy <levymitchell0@gmail.com>
> 
> 
> 
> ---

I don't know whether it's a tool issue or something else, but all words
after the "---" line in the email will be discarded from a commit log.
You can try to apply this patch yourself and see the result:

	b4 shazam 20230726-master-v1-1-b2ce6a4538db@gmail.com 

> This patch is intended as a proof-of-concept for the new SBRM
> machinery[1]. For some brief background, the idea behind SBRM is using
> the __cleanup__ attribute to automatically unlock locks (or otherwise
> release resources) when they go out of scope, similar to C++ style RAII.
> This promises some benefits such as making code simpler (particularly
> where you have lots of goto fail; type constructs) as well as reducing
> the surface area for certain kinds of bugs.
> 
> The changes in this patch should not result in any difference in how the
> code actually runs (i.e., it's purely an exercise in this new syntax
> sugar). In one instance SBRM was not appropriate, so I left that part
> alone, but all other locking/unlocking is handled automatically in this
> patch.
> 
> Link: https://lore.kernel.org/all/20230626125726.GU4253@hirez.programming.kicks-ass.net/ [1]
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: "Mitchell Levy (Microsoft)" <levymitchell0@gmail.com>

Beside the above format issue, the code looks good to me, nice job!

Feel free to add:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  drivers/hv/hv_balloon.c | 82 +++++++++++++++++++++++--------------------------
>  1 file changed, 38 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index dffcc894f117..2812601e84da 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -8,6 +8,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/cleanup.h>
>  #include <linux/kernel.h>
>  #include <linux/jiffies.h>
>  #include <linux/mman.h>
> @@ -646,7 +647,7 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
>  			      void *v)
>  {
>  	struct memory_notify *mem = (struct memory_notify *)v;
> -	unsigned long flags, pfn_count;
> +	unsigned long pfn_count;
>  
>  	switch (val) {
>  	case MEM_ONLINE:
> @@ -655,21 +656,22 @@ static int hv_memory_notifier(struct notifier_block *nb, unsigned long val,
>  		break;
>  
>  	case MEM_OFFLINE:
> -		spin_lock_irqsave(&dm_device.ha_lock, flags);
> -		pfn_count = hv_page_offline_check(mem->start_pfn,
> -						  mem->nr_pages);
> -		if (pfn_count <= dm_device.num_pages_onlined) {
> -			dm_device.num_pages_onlined -= pfn_count;
> -		} else {
> -			/*
> -			 * We're offlining more pages than we managed to online.
> -			 * This is unexpected. In any case don't let
> -			 * num_pages_onlined wrap around zero.
> -			 */
> -			WARN_ON_ONCE(1);
> -			dm_device.num_pages_onlined = 0;
> +		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> +			pfn_count = hv_page_offline_check(mem->start_pfn,
> +							  mem->nr_pages);
> +			if (pfn_count <= dm_device.num_pages_onlined) {
> +				dm_device.num_pages_onlined -= pfn_count;
> +			} else {
> +				/*
> +				 * We're offlining more pages than we
> +				 * managed to online. This is
> +				 * unexpected. In any case don't let
> +				 * num_pages_onlined wrap around zero.
> +				 */
> +				WARN_ON_ONCE(1);
> +				dm_device.num_pages_onlined = 0;
> +			}
>  		}
> -		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  		break;
>  	case MEM_GOING_ONLINE:
>  	case MEM_GOING_OFFLINE:
> @@ -721,24 +723,23 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  	unsigned long start_pfn;
>  	unsigned long processed_pfn;
>  	unsigned long total_pfn = pfn_count;
> -	unsigned long flags;
>  
>  	for (i = 0; i < (size/HA_CHUNK); i++) {
>  		start_pfn = start + (i * HA_CHUNK);
>  
> -		spin_lock_irqsave(&dm_device.ha_lock, flags);
> -		has->ha_end_pfn +=  HA_CHUNK;
> +		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> +			has->ha_end_pfn +=  HA_CHUNK;
>  
> -		if (total_pfn > HA_CHUNK) {
> -			processed_pfn = HA_CHUNK;
> -			total_pfn -= HA_CHUNK;
> -		} else {
> -			processed_pfn = total_pfn;
> -			total_pfn = 0;
> -		}
> +			if (total_pfn > HA_CHUNK) {
> +				processed_pfn = HA_CHUNK;
> +				total_pfn -= HA_CHUNK;
> +			} else {
> +				processed_pfn = total_pfn;
> +				total_pfn = 0;
> +			}
>  
> -		has->covered_end_pfn +=  processed_pfn;
> -		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +			has->covered_end_pfn +=  processed_pfn;
> +		}
>  
>  		reinit_completion(&dm_device.ol_waitevent);
>  
> @@ -758,10 +759,10 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  				 */
>  				do_hot_add = false;
>  			}
> -			spin_lock_irqsave(&dm_device.ha_lock, flags);
> -			has->ha_end_pfn -= HA_CHUNK;
> -			has->covered_end_pfn -=  processed_pfn;
> -			spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +			scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> +				has->ha_end_pfn -= HA_CHUNK;
> +				has->covered_end_pfn -=  processed_pfn;
> +			}
>  			break;
>  		}
>  
> @@ -781,10 +782,9 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  static void hv_online_page(struct page *pg, unsigned int order)
>  {
>  	struct hv_hotadd_state *has;
> -	unsigned long flags;
>  	unsigned long pfn = page_to_pfn(pg);
>  
> -	spin_lock_irqsave(&dm_device.ha_lock, flags);
> +	guard(spinlock_irqsave)(&dm_device.ha_lock);
>  	list_for_each_entry(has, &dm_device.ha_region_list, list) {
>  		/* The page belongs to a different HAS. */
>  		if ((pfn < has->start_pfn) ||
> @@ -794,7 +794,6 @@ static void hv_online_page(struct page *pg, unsigned int order)
>  		hv_bring_pgs_online(has, pfn, 1UL << order);
>  		break;
>  	}
> -	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  }
>  
>  static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
> @@ -803,9 +802,8 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
>  	struct hv_hotadd_gap *gap;
>  	unsigned long residual, new_inc;
>  	int ret = 0;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&dm_device.ha_lock, flags);
> +	guard(spinlock_irqsave)(&dm_device.ha_lock);
>  	list_for_each_entry(has, &dm_device.ha_region_list, list) {
>  		/*
>  		 * If the pfn range we are dealing with is not in the current
> @@ -852,7 +850,6 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
>  		ret = 1;
>  		break;
>  	}
> -	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  
>  	return ret;
>  }
> @@ -947,7 +944,6 @@ static unsigned long process_hot_add(unsigned long pg_start,
>  {
>  	struct hv_hotadd_state *ha_region = NULL;
>  	int covered;
> -	unsigned long flags;
>  
>  	if (pfn_cnt == 0)
>  		return 0;
> @@ -979,9 +975,9 @@ static unsigned long process_hot_add(unsigned long pg_start,
>  		ha_region->covered_end_pfn = pg_start;
>  		ha_region->end_pfn = rg_start + rg_size;
>  
> -		spin_lock_irqsave(&dm_device.ha_lock, flags);
> -		list_add_tail(&ha_region->list, &dm_device.ha_region_list);
> -		spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> +			list_add_tail(&ha_region->list, &dm_device.ha_region_list);
> +		}
>  	}
>  
>  do_pg_range:
> @@ -2047,7 +2043,6 @@ static void balloon_remove(struct hv_device *dev)
>  	struct hv_dynmem_device *dm = hv_get_drvdata(dev);
>  	struct hv_hotadd_state *has, *tmp;
>  	struct hv_hotadd_gap *gap, *tmp_gap;
> -	unsigned long flags;
>  
>  	if (dm->num_pages_ballooned != 0)
>  		pr_warn("Ballooned pages: %d\n", dm->num_pages_ballooned);
> @@ -2073,7 +2068,7 @@ static void balloon_remove(struct hv_device *dev)
>  #endif
>  	}
>  
> -	spin_lock_irqsave(&dm_device.ha_lock, flags);
> +	guard(spinlock_irqsave)(&dm_device.ha_lock);
>  	list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
>  		list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
>  			list_del(&gap->list);
> @@ -2082,7 +2077,6 @@ static void balloon_remove(struct hv_device *dev)
>  		list_del(&has->list);
>  		kfree(has);
>  	}
> -	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  }
>  
>  static int balloon_suspend(struct hv_device *hv_dev)
> 
> ---
> base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
> change-id: 20230725-master-bbcd9205758b
> 
> Best regards,
> -- 
> Mitchell Levy <levymitchell0@gmail.com>
> 
