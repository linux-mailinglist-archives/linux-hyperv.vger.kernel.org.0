Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F526AC4F9
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Mar 2023 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCFP3P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Mar 2023 10:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCFP3M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Mar 2023 10:29:12 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDCE32CF6;
        Mon,  6 Mar 2023 07:28:49 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso8454561wmi.4;
        Mon, 06 Mar 2023 07:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZY9PqhdBL88gnfamD45ZyVfP+qX3ujJEN5I1+HiNyo=;
        b=PmSbBqfXrImH6JSdee9018vYCd03bZeuRVVKFJbiB/a0iM7mmr3TY3h5yphe0KVfEK
         PB4xyX5YIbNsklMv/tGXiO07AXv7/ZfJocCIcufo/jiQB/8qOEu744zdytUfb8+m1L7/
         iXYVHeK0pGc5wCmhyTWYueb8BkEnd0mwVJ2DSNvfv919zumM4GuvwHa9Ke7Qa6Pv/szs
         +w2RSoYmUse8EZDD4MajtJQwV88wHPDMBL4IapdD4kThMMjPw2YsuYqQCtbcSrqiXCKk
         3EmBZxEAD0ANv9MQE3RslLtVyN5JEt9Jkr7sQebt/4RqDDiHxgMDfI98a9gkURYhT8Az
         fpRQ==
X-Gm-Message-State: AO0yUKUwnICExB26Qw3oLji56zI5xheTgJUtkZEvmjWdh/woxpqWWjRF
        1OJIT9n/sOy38jjPhdRCgCo=
X-Google-Smtp-Source: AK7set+rcRaSxU2ao8KC93PENYl7ZwEpzsStNZtPvJqXruNhWEGSLYmz0BpXVhmaIQxqPcF3aFqoaA==
X-Received: by 2002:a05:600c:c11:b0:3df:d431:cf64 with SMTP id fm17-20020a05600c0c1100b003dfd431cf64mr9644503wmb.39.1678116518769;
        Mon, 06 Mar 2023 07:28:38 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003eb2e33f327sm20577632wmc.2.2023.03.06.07.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:28:38 -0800 (PST)
Date:   Mon, 6 Mar 2023 15:28:33 +0000
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
Message-ID: <ZAYGoSOZ407Wr18W@liuwe-devbox-debian-v2>
References: <20230217204411.212709-1-mgamal@redhat.com>
 <SA1PR21MB1335BBA8DF84AFDDF2E1ABE6BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
 <Y/OCdpnGndMo8DCG@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/OCdpnGndMo8DCG@liuwe-devbox-debian-v2>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 20, 2023 at 02:23:50PM +0000, Wei Liu wrote:
> On Fri, Feb 17, 2023 at 11:17:04PM +0000, Dexuan Cui wrote:
> > > From: Mohammed Gamal <mgamal@redhat.com>
> > > Sent: Friday, February 17, 2023 12:44 PM
> > > ...
> > > --- a/drivers/hv/connection.c
> > > +++ b/drivers/hv/connection.c
> > > @@ -409,6 +409,10 @@ void vmbus_disconnect(void)
> > >   */
> > >  struct vmbus_channel *relid2channel(u32 relid)
> > >  {
> > > +	if (vmbus_connection.channels == NULL) {
> > > +		pr_warn_once("relid2channel: relid=%d: No channels mapped!\n",
> > > relid);
> > 
> > Looks good to me except that the line exceeds 80 characters.
> > Please run "scripts/checkpatch.pl" to detect that.
> > For this patch, I guess Wei may be willing to help fix it.
> > 
> > > +		return NULL;
> > > +	}
> > >  	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS))
> > >  		return NULL;
> > >  	return READ_ONCE(vmbus_connection.channels[relid]);
> > > --
> > 
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> 
> I will pick this up via hyperv-fixes.

Now applied to hyperv-fixes.

Thanks,
Wei.
