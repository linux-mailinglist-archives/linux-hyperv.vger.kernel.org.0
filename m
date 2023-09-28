Return-Path: <linux-hyperv+bounces-316-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145297B212E
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 17:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BB4E028268F
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBE74F126;
	Thu, 28 Sep 2023 15:26:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E338DF9;
	Thu, 28 Sep 2023 15:26:22 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40564B7;
	Thu, 28 Sep 2023 08:26:21 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6c4a25f6390so7178653a34.2;
        Thu, 28 Sep 2023 08:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695914779; x=1696519579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYPUiAEm0lZNQbU6hKmoJKqPGRAnrTCwSSHfRdZ7LfA=;
        b=D35ZnhvzMmw2WuYdeCJawE0603JXMboMFtqOwpQGEMiwgpDNmYh3h2L20CfGNw2pyr
         nHtgHCu/RHLLu3IJt3mm2gkMQlgppdFTDbaLpSWjNy6EUk8+ZUWJM43q3HZXewZCvgEl
         HJYiGyO3GdUW9SVMOjYhyOWQQprWBtY/0O3Ef0qfJtDVdMtQ3/Yd5wA/oDyXrKtM0tOi
         HNmiJislJpx8eOAVRIr3ALu5F6W1zdr9isBJ+vlP8uXVuMoR9T5nWmh08tFybtgz/i3O
         TKTKZebWmr87iSZUSTqA+IeHSuZCU4VofXJE1lWPTRhaySQy5tl/U+JGRg6v1y11agpE
         FKtQ==
X-Gm-Message-State: AOJu0Yw/INZPUbsTGC2B9p5kmnNHMMqkX4MszrP840JVtv1KlTSvxYOY
	9LJoCF/wQjqo00jQjZSQry0=
X-Google-Smtp-Source: AGHT+IEkFDTusLpYox11EoA1Tl2MJIdC5Ad7Ua286wH6ql8JYqDg2cQ1Wc6Zlzvv071aY+VufA88gQ==
X-Received: by 2002:a9d:73d5:0:b0:6c4:b339:2528 with SMTP id m21-20020a9d73d5000000b006c4b3392528mr1632381otk.16.1695914778722;
        Thu, 28 Sep 2023 08:26:18 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id j14-20020aa78dce000000b006906aaf1e4dsm13514673pfr.150.2023.09.28.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 08:26:18 -0700 (PDT)
Date: Thu, 28 Sep 2023 15:26:16 +0000
From: Wei Liu <wei.liu@kernel.org>
To: j.granados@samsung.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
	josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
	Phillip Potter <phil@philpotter.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Doug Gilbert <dgilbert@interlog.com>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Corey Minyard <minyard@acm.org>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>,
	Russ Weight <russell.h.weight@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Song Liu <song@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-serial@vger.kernel.org, linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-raid@vger.kernel.org, linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/15] hyper-v/azure: Remove now superfluous sentinel
 element from ctl_table array
Message-ID: <ZRWbGDlXCS4t8tMf@liuwe-devbox-debian-v2>
References: <20230928-jag-sysctl_remove_empty_elem_drivers-v1-0-e59120fca9f9@samsung.com>
 <65157da8.050a0220.fb263.fdb1SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65157da8.050a0220.fb263.fdb1SMTPIN_ADDED_BROKEN@mx.google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Please change the prefix to "Drivers: hv:" in the subject line in the
two patches.

On Thu, Sep 28, 2023 at 03:21:39PM +0200, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Remove sentinel from hv_ctl_table
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  drivers/hv/hv_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ccad7bca3fd3..bc7d678030aa 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -147,8 +147,7 @@ static struct ctl_table hv_ctl_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE
> -	},
> -	{}
> +	}

Please keep the comma at the end.

>  };
>  
>  static int hv_die_panic_notify_crash(struct notifier_block *self,
> 
> -- 
> 2.30.2
> 

