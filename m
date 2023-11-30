Return-Path: <linux-hyperv+bounces-1166-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EDD7FFB06
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 20:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C551C20C69
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C365FF19;
	Thu, 30 Nov 2023 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqL993bS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE553D40;
	Thu, 30 Nov 2023 11:17:33 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a16594723so7858916d6.3;
        Thu, 30 Nov 2023 11:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701371853; x=1701976653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etUM6pU7GXADCSsGQkpd5054784+nonMf6sWSZzwGYM=;
        b=WqL993bSPJ3P0krJh3GMyD+48RvzR0P39KMN4cHA9SnuwLhC+5ptSwOyRkw4Pu3Jb1
         nr/RicHqZaGsUJvKz4rwoWvTQA1B5EY/QZqJc0ke4KWbfSy6+sDNa0L64vsjvcDgn8l+
         LFCPvaLYOtFuRUZ47O203OrkVn1f8ZGnLMfQfMQHpOSUA6Ul46JR7tGUfH5bgrFCLfaU
         AwLGOwf7xLDT3Di8P2cM+XCtyryVfHRaSUolZ9lBfWgvvwkiCcncvmcEhN91Jx3LGH7Z
         +OQWChjcEVQg8LX3wyDBOGKbbt1Hp1W6fY2nWauE09e5OrheT28FK1Eprp7KkyxS8NLS
         h+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371853; x=1701976653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etUM6pU7GXADCSsGQkpd5054784+nonMf6sWSZzwGYM=;
        b=mu5R4sTFWiSu8kbLoItycy261eP56B9ArBunS+GeynV6WgjnTnBBgDl8k2GgJcpKJC
         jBr7KT84gxpkksdy8wjGCHNtsUjXMN63bDjmKBX79r55WXuHHF8Za/PTG3KcgewN2fca
         kDpJ6YbGfD2h1/ON6jMZgIMr5p6gd4TaPjBMfOmjsUzyijin3GSdnzuCeXXILpFsb0si
         PPQSwKtsjI6bXDRt+QY/y55/T4pW874AjARD2Oo4B1NBXSaKh36ALIHaGnbU+D39G1P/
         2dqlXdoCTFE8KSLfsloKwzbRbNUYTfroywQTPdk/dhk/lQe3d2F1AShZHC7ZvytQBuZL
         JXyw==
X-Gm-Message-State: AOJu0YyEmufByx4vKOfN354cOl6roU5Ti9RWu90yUkzx90AgYBu9rqD3
	0LWCFjx8zYjAj3UTrae8zFU=
X-Google-Smtp-Source: AGHT+IFAWhUr/yE2JZT6y5PJ/CEuhIyHZFjS0A1ebEQ0q3gRm/MJ4sdkECbsHKEhmpJ3ZcxO9niMZA==
X-Received: by 2002:a05:6214:1d02:b0:67a:150e:45fd with SMTP id e2-20020a0562141d0200b0067a150e45fdmr32703340qvd.49.1701371852962;
        Thu, 30 Nov 2023 11:17:32 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k12-20020a05621414ec00b0067a8fe21448sm282885qvw.2.2023.11.30.11.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:17:32 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 1C26927C005B;
	Thu, 30 Nov 2023 14:17:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 30 Nov 2023 14:17:32 -0500
X-ME-Sender: <xms:y99oZZyvD2IR7XICgTNkjNHZGCoteeLV6tMARdTPCp7RJSO3SpDRvA>
    <xme:y99oZZQJOkyfoErwRlSJP6KbOB1A2tA9uEbCel5uQrqUH9if7IUBckyDfUithYA-G
    irRQ_trPo1I4-6HVA>
X-ME-Received: <xmr:y99oZTVkIb1seBYeptOw18fVW1a2VSbbcwtOkXl7tPSwS92yFZ9bMyoY5LI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:y99oZbi0_iJWExJ-Ph0TKNP_qnWpepzYHVJ06hhgZL3_jYrcandH6w>
    <xmx:y99oZbAGtCJB-5Z_DiBlxuyJH9kIENsMMsAA-7t15jQmkC8rpcF9dQ>
    <xmx:y99oZUKVz8-kW8YJOQ4EBJGGtQ-rTDYle2n6IfNDTb_45k3WjiD-bA>
    <xmx:zN9oZd0zeMMeiibri4n-ZQnFT1GdGrJAM4TPH7v6N0UNIB00RfLO0Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 14:17:31 -0500 (EST)
Date: Thu, 30 Nov 2023 11:16:43 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: pmartincic@linux.microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
Message-ID: <ZWjfm25xAqvbQYSf@boqun-archlinux>
References: <20231127213524.52783-1-pmartincic@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127213524.52783-1-pmartincic@linux.microsoft.com>

On Mon, Nov 27, 2023 at 01:35:24PM -0800, pmartincic@linux.microsoft.com wrote:
> From: Peter Martincic <pmartincic@microsoft.com>
> 
> Hyper-V hosts can omit the _SYNC flag to due a bug on resume from modern
> suspend. In such a case, the guest may fail to update its time-of-day to
> account for the period when it was suspended, and could proceed with a
> significantly wrong time-of-day. In such a case when the guest is
> significantly behind, fix it by treating a _SAMPLE the same as if _SYNC
> was received so that the guest time-of-day is updated.
> 
> This is hidden behind param hv_utils.timesync_implicit.
> 
> Signed-off-by: Peter Martincic <pmartincic@microsoft.com>

Looks good to me.

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  drivers/hv/hv_util.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> index 42aec2c5606a..9c97c4065fe7 100644
> --- a/drivers/hv/hv_util.c
> +++ b/drivers/hv/hv_util.c
> @@ -296,6 +296,11 @@ static struct {
>  	spinlock_t			lock;
>  } host_ts;
>  
> +static bool timesync_implicit;
> +
> +module_param(timesync_implicit, bool, 0644);
> +MODULE_PARM_DESC(timesync_implicit, "If set treat SAMPLE as SYNC when clock is behind");
> +
>  static inline u64 reftime_to_ns(u64 reftime)
>  {
>  	return (reftime - WLTIMEDELTA) * 100;
> @@ -344,6 +349,29 @@ static void hv_set_host_time(struct work_struct *work)
>  		do_settimeofday64(&ts);
>  }
>  
> +/*
> + * Due to a bug on Hyper-V hosts, the sync flag may not always be sent on resume.
> + * Force a sync if the guest is behind.
> + */
> +static inline bool hv_implicit_sync(u64 host_time)
> +{
> +	struct timespec64 new_ts;
> +	struct timespec64 threshold_ts;
> +
> +	new_ts = ns_to_timespec64(reftime_to_ns(host_time));
> +	ktime_get_real_ts64(&threshold_ts);
> +
> +	threshold_ts.tv_sec += 5;
> +
> +	/*
> +	 * If guest behind the host by 5 or more seconds.
> +	 */
> +	if (timespec64_compare(&new_ts, &threshold_ts) >= 0)
> +		return true;
> +
> +	return false;
> +}
> +
>  /*
>   * Synchronize time with host after reboot, restore, etc.
>   *
> @@ -384,7 +412,8 @@ static inline void adj_guesttime(u64 hosttime, u64 reftime, u8 adj_flags)
>  	spin_unlock_irqrestore(&host_ts.lock, flags);
>  
>  	/* Schedule work to do do_settimeofday64() */
> -	if (adj_flags & ICTIMESYNCFLAG_SYNC)
> +	if ((adj_flags & ICTIMESYNCFLAG_SYNC) ||
> +	    (timesync_implicit && hv_implicit_sync(host_ts.host_time)))
>  		schedule_work(&adj_time_work);
>  }
>  
> -- 
> 2.34.1
> 

