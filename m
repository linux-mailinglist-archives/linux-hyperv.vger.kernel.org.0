Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A1269C9FF
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Feb 2023 12:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjBTLkJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Feb 2023 06:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjBTLkI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Feb 2023 06:40:08 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9AE1043A;
        Mon, 20 Feb 2023 03:40:07 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id c12so830594wrw.1;
        Mon, 20 Feb 2023 03:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrBZ8X1qHCN3IJfjc601rKRdpfSeCcwUgnMk+FSfQcA=;
        b=pou5E6XDkUt7jq6xkg4iFXYoOuTfN6yuX6K/0snId1At7OHIhU4Q/nkNjQPb+BPXH/
         sdxRZkd9UXwjzcSzkvlMEb9ADye6GVT1XN0b13D+W+59dlJ1v+JHBVCQhWnIRqOMZLAw
         HR9M78ozptlBUcL9qcGeFH7yCdQPOYD7swc62ofHMmiUm3m6b6r9NkShbDdW5Uy/utQD
         66DDSf/VV5OD34mE/wh5WWwnWLunzaGztDBDmcl9PSUksx4sihIIshBP/JLzjCu8au8b
         MjTZJP/011qxoxV6LUEWtsg7/XzUu1R1EmOXTYO50FaUSR5mLnBPaMaheJzH39J4D2N4
         Gaog==
X-Gm-Message-State: AO0yUKU5ZkV/985etrzv9UZFqFPl24BnWrwrepjxcbTKD6a2rNoGH4Gk
        jL1nVHKvOggZaK9VR+8fjNA=
X-Google-Smtp-Source: AK7set+vrrz5nkdsFBDOfOqdfB8PGO/yX0qrSKUvKk/+/8CYO+bV/+XsA3C/oPYfz/KYIVpLu9q8Zw==
X-Received: by 2002:adf:f309:0:b0:2c6:a953:850f with SMTP id i9-20020adff309000000b002c6a953850fmr2023294wro.19.1676893205693;
        Mon, 20 Feb 2023 03:40:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e16-20020adfe390000000b002c54c8e70b1sm1418661wrm.9.2023.02.20.03.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:40:04 -0800 (PST)
Date:   Mon, 20 Feb 2023 11:39:40 +0000
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
Message-ID: <Y/Nb/Ba36+2CnYKf@liuwe-devbox-debian-v2>
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

FWIW the max line length has been bumped to 100 in checkpatch.pl.

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
