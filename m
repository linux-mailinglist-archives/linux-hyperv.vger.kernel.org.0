Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9A769CF48
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Feb 2023 15:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjBTOYT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Feb 2023 09:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjBTOYS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Feb 2023 09:24:18 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A6B6E9D;
        Mon, 20 Feb 2023 06:24:16 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id v3so1325449wrp.2;
        Mon, 20 Feb 2023 06:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+fSapDgkBbgNSNt0cRzvdKOtf3yuwjBomp8w+WTUwc=;
        b=8F7FF6wVbZbWOC2sl+ZLHR6NJxQeJ9OD1y8BvBUfk/Y90XIkOvZ9k8SqOYjYgSwvbU
         /6nUIC0kic+Q8hyzxw88JhbvZbwpm4KvunWXFOEoQIfeI1rFYULlvpn5vVkiJKq/gM+5
         et8YuCTp+tlVptvUQSC5wA8m8p0JNSOYPvtNqbpU8w3tlCybIzEzaymN+2YeE4trRTIj
         HI34AtvAwWoLDGb5NnSZNp3q6uSYPcnK7prq9FHrX8iPvkC6z81PblKIE5G8EC4zLjx3
         w1amhCeD/WoiiPdojijSHpMVa35dmLZkg30bowiwFaQgICG+nhPL3RcwTmEm0nci+x4n
         h+Mg==
X-Gm-Message-State: AO0yUKUY+lwqwZLWC+UjR3HuONyAXeM3P5U8RGiWsgk4Ut/yHlVfnDHn
        sM8grVZLU1OI32+EqEp90hedXHxAL68=
X-Google-Smtp-Source: AK7set86CotjvFsykGuzO8Ft3Mwc4wMPQcBbO+kn7XXdaQ8TC+/edJx/3wI5sLfXzSRH0GvwXoV5IA==
X-Received: by 2002:a5d:44d0:0:b0:2c5:5630:585d with SMTP id z16-20020a5d44d0000000b002c55630585dmr29107wrr.27.1676903054725;
        Mon, 20 Feb 2023 06:24:14 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm2733719wrn.97.2023.02.20.06.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 06:24:14 -0800 (PST)
Date:   Mon, 20 Feb 2023 14:23:50 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Mohammed Gamal <mgamal@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "xxiong@redhat.com" <xxiong@redhat.com>
Subject: Re: [PATCH v3] Drivers: vmbus: Check for channel allocation before
 looking up relids
Message-ID: <Y/OCdpnGndMo8DCG@liuwe-devbox-debian-v2>
References: <20230217204411.212709-1-mgamal@redhat.com>
 <SA1PR21MB1335BBA8DF84AFDDF2E1ABE6BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1335BBA8DF84AFDDF2E1ABE6BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 17, 2023 at 11:17:04PM +0000, Dexuan Cui wrote:
> > From: Mohammed Gamal <mgamal@redhat.com>
> > Sent: Friday, February 17, 2023 12:44 PM
> > ...
> > --- a/drivers/hv/connection.c
> > +++ b/drivers/hv/connection.c
> > @@ -409,6 +409,10 @@ void vmbus_disconnect(void)
> >   */
> >  struct vmbus_channel *relid2channel(u32 relid)
> >  {
> > +	if (vmbus_connection.channels == NULL) {
> > +		pr_warn_once("relid2channel: relid=%d: No channels mapped!\n",
> > relid);
> 
> Looks good to me except that the line exceeds 80 characters.
> Please run "scripts/checkpatch.pl" to detect that.
> For this patch, I guess Wei may be willing to help fix it.
> 
> > +		return NULL;
> > +	}
> >  	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS))
> >  		return NULL;
> >  	return READ_ONCE(vmbus_connection.channels[relid]);
> > --
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

I will pick this up via hyperv-fixes.
