Return-Path: <linux-hyperv+bounces-701-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE65B7E1853
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 02:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A40EB20D12
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Nov 2023 01:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F1139B;
	Mon,  6 Nov 2023 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761E395
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Nov 2023 01:31:04 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879BEDD
	for <linux-hyperv@vger.kernel.org>; Sun,  5 Nov 2023 17:31:02 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1cc5fa0e4d5so36236935ad.0
        for <linux-hyperv@vger.kernel.org>; Sun, 05 Nov 2023 17:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699234262; x=1699839062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNvVWdQtx/XIrU0wpIGGT4pRtASMAfbqjRHKyDQtjk8=;
        b=JogGl1irIFOUTajxB88+KgDmJNnHkFm4OLrd2hdIwpzKolaLNjZaFbrXshv5Uvxrng
         J5LmCqBKq9V3VkQLTrraQUEMy3VPeLpmlfYFYdDR2ajWyBg9swd7VHMb27rE8GJksHPx
         LdmYsCU3VBl6y+Oz7OS0YI4888rZqv8beWGWsEOcjNqaI8IKO3xng5ARkImwwHXTLZC7
         0bsuC/Qfhd1tK6GCA7q3sGr+vwC51YjaEIIfUWZ5zyL+3h2de84APxQ6M5T2+mZv2+EW
         zLUxBUQvG08linUvyfBxaoKHVNm7b9ilZTTFEpZyVgjd0EzTE8zAUlxNZ5+dd6HIh+bK
         7WMA==
X-Gm-Message-State: AOJu0YyWv9hePVzGhfEOMGBLoDzWx1/zGX7dNf98SD+Ssi53dtKI0R3I
	OmGXik7Fjg1BRxhHafh3voc=
X-Google-Smtp-Source: AGHT+IE0Ecyk3a4CDw50fzaAJKPHVIhp9CCDPfGv5yTohZben0ryKwiymVfn1kjKqNr03wLCFQhHPA==
X-Received: by 2002:a17:902:f213:b0:1c3:4b24:d89d with SMTP id m19-20020a170902f21300b001c34b24d89dmr25367597plc.40.1699234262006;
        Sun, 05 Nov 2023 17:31:02 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001b890009634sm4667864plg.139.2023.11.05.17.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 17:31:01 -0800 (PST)
Date: Mon, 6 Nov 2023 01:30:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Peter Martincic <pmartincic@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	Boqun Feng <Boqun.Feng@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
Message-ID: <ZUhByoXhvb3ZowPH@liuwe-devbox-debian-v2>
References: <CY5PR21MB366066CE916AEB5289153F09D5DCA@CY5PR21MB3660.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR21MB366066CE916AEB5289153F09D5DCA@CY5PR21MB3660.namprd21.prod.outlook.com>

On Fri, Oct 27, 2023 at 08:42:33PM +0000, Peter Martincic wrote:
> From 529fcea5d296c22b1dc6c23d55bd6417794b3cda Mon Sep 17 00:00:00 2001
> From: Peter Martincic <pmartincic@microsoft.com>
> Date: Mon, 16 Oct 2023 16:41:10 -0700
> Subject: [PATCH] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
> 
> Windows hosts can omit the _SYNC flag to due a bug on resume from modern
> suspend. If the guest is sufficiently behind, treat a _SAMPLE the same
> as if _SYNC was received.
> 
> This is hidden behind param hv_utils.timesync_implicit.
> 
> Signed-off-by: Peter Martincic <pmartincic@microsoft.com>

Boqun, what do you think about this patch?

> ---
>  drivers/hv/hv_util.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index 42aec2c5606a..158f5ff4b809 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -296,6 +296,11 @@ static struct {
>         spinlock_t                      lock;
>  } host_ts;
> 
> +static bool timesync_implicit;
> +
> +module_param(timesync_implicit, bool, 0644);
> +MODULE_PARM_DESC(timesync_implicit, "If set treat SAMPLE as SYNC when clock is behind");
> +
>  static inline u64 reftime_to_ns(u64 reftime)
>  {
>         return (reftime - WLTIMEDELTA) * 100;
> @@ -344,6 +349,29 @@ static void hv_set_host_time(struct work_struct *work)
>                 do_settimeofday64(&ts);
>  }
> 
> +/*
> + * Due to a bug on Windows hosts, the sync flag may not always be sent on resume.
> + * Force a sync if it's behind.
> + */
> +static inline bool hv_implicit_sync(u64 host_time)
> +{
> +       struct timespec64 new_ts;
> +       struct timespec64 threshold_ts;
> +
> +       new_ts = ns_to_timespec64(reftime_to_ns(host_time));
> +       ktime_get_real_ts64(&threshold_ts);
> +
> +       threshold_ts.tv_sec += 5;
> +
> +       /*
> +        * If guest behind the host by 5 or more seconds.
> +        */
> +       if (timespec64_compare(&new_ts, &threshold_ts) >= 0)
> +               return true;
> +
> +       return false;
> +}
> +
>  /*
>   * Synchronize time with host after reboot, restore, etc.
>   *
> @@ -384,7 +412,8 @@ static inline void adj_guesttime(u64 hosttime, u64 reftime, u8 adj_flags)
>         spin_unlock_irqrestore(&host_ts.lock, flags);
> 
>         /* Schedule work to do do_settimeofday64() */
> -       if (adj_flags & ICTIMESYNCFLAG_SYNC)
> +       if ((adj_flags & ICTIMESYNCFLAG_SYNC) ||
> +           (timesync_implicit && hv_implicit_sync(host_ts.host_time)))
>                 schedule_work(&adj_time_work);
>  }
> 
> --
> 2.34.1
> 

