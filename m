Return-Path: <linux-hyperv+bounces-3665-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C10DA09D15
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 22:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B44F16A5D5
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 21:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B8220897F;
	Fri, 10 Jan 2025 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKkb3zEE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60C208986;
	Fri, 10 Jan 2025 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736543901; cv=none; b=XUN4tr9EyGs9tCgOuVuOnaHAdVXYJBL1FWqmopOf57eJcU2vVdB4PIzxEPefN7Ygiu4S8D2+JqwLNIu4ftmknxUK+9Wb7EYdlaBY+Zwb3m1n4mINNezXxbDlk49GmseMZnnTFvUA3pk685SoLHeQnSi83LcpGMQ/bnvtWBdvmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736543901; c=relaxed/simple;
	bh=k/cWx3A8tZkBkV0S+P90DTFz/tdSr2r/yFAt+WY2NyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL4oQGztwQ6ahE10I0vcuIn6ETa4DRx1WwolzpkRQ0RTjWmikR/5csjDcisoIOSfh8FjA/JqHxbL35Z1DjdAYXSWgFWG8ENs/l89ttV0MYLmOEkurW78HJX0tLp7V+4H47puVkOdLdlPZB5n85smatXkrHlxm7G1cZKrHxhsKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKkb3zEE; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dcdd9a3e54so22404936d6.3;
        Fri, 10 Jan 2025 13:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736543899; x=1737148699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AalUMGwKp+1ccsODYGzT5joDKpnUYbuMqzUxVAyxzg=;
        b=kKkb3zEE5Nfd3+VNARZuNnjcaLaHlvcgaMYuoxtzg4ACT+E/FfBHFvK1TS6zJmOHo3
         7cr+EseLUGUD4QtKI8QWgUpKL7iZwA+TvmY5VwHijaHRMmhlLP54aDExW/EkSUXReQrL
         /pLKxSwOkcYAa2hQ/w+lPrqhIwrdzBQH7r/JQnSeEtQxQKIHNg05F97gOD22nX/NHMWs
         myS0EHmjiPe1PXvuHxfRGUR2TyOtAJdI6VVSHkqHlD9gPz46tmzUlZtdJe+h99AKEr33
         JizV+GGVRMlYH3J6pIKiCrMw11OxywZEklip0kbfQYV0fXHOVd+0MocQRPuNN0hSar93
         SyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736543899; x=1737148699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AalUMGwKp+1ccsODYGzT5joDKpnUYbuMqzUxVAyxzg=;
        b=auNf7UKMhZ8heeTaVHYI+aifN7B2aNWOVku5Zpv8HzR7O5RpH7yI4Ltazxzql2i/+i
         oD322aRVxRNos/kLZFsqA6GVvA/kJ6SViw1eyw4twtJZN2dSWP3lj/tQlg2cK4tPyAl3
         1KcqHcdaGCMwaNRm+Lgcu0n5C1cPxbe6ELNFi1ZF0uO/c/90fBQoXInWBdciVmWKPCSs
         13PZsDCOABcnVoj6uoM+HASEhlgSZ/tpcHE+p35la31AFdkpSN4goThE/vgK8qAUYDta
         xdyo4Cnh16pxsbtpbyOv4WNe5BB8Xtse2T52nsAVhBViHSZi2Yzwagtozjyq3xfm5SLX
         joug==
X-Forwarded-Encrypted: i=1; AJvYcCWhLW+MZH9DnaydWEa05lyfn3uZSoQ8+Dd3haH+pIuC/v1Win2g1wg3oXj5WxJ+85EBpDnVH7cw6RF3ioc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsh/QQqeH9SCK/UfYgXUIti7Km1hBMwwp0dp5GRUSJ1FeUA0mQ
	I4/fnxGNTTVTib33CLQlMmQqaewL6KFM1sPeuDsqGghdWjKsGwZXBaagNA==
X-Gm-Gg: ASbGncsez8oGifS33LKATebuWY24Ou6741PHnM8x/Ww2eWtN0fM8wD12LYMzZjkrlIA
	z4Km8uuTHdltlrHuhB2PLpImQjvPh39TyGM7dppz//R7M7wmGl42OkyaDGWekv77N2WrJ6Me+Rl
	7yUbMk8+Hm5PE4zigwD73sAc/B6SgYt4hpzXPn9lOrMUqBkPZByaPT/Ax/nBPHahR12gTOFxeh9
	dO0Wmf33YbiQBzvsoOuWLHLekcIMOekXk3EH4OJ/n+ZPgHXR4VhZqGjIfU6BSk1irzP3yRpOnmz
	E7ATSRqDNYqgkkcd+5zftRvhgXJfLwepXiCOamsdIQn+Mpk=
X-Google-Smtp-Source: AGHT+IEUdtrNWcE/Tny8zs1FI1vRJ1WRD7+omV3fqpiMmhFMXXkD1su5w4vJf2q5eSFNGhvPKlXdAg==
X-Received: by 2002:a05:6214:20ce:b0:6dd:d24:3072 with SMTP id 6a1803df08f44-6df9b1f453fmr188880686d6.3.1736543898680;
        Fri, 10 Jan 2025 13:18:18 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade89e0csm13142906d6.104.2025.01.10.13.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 13:18:18 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id AD49F1200043;
	Fri, 10 Jan 2025 16:18:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jan 2025 16:18:17 -0500
X-ME-Sender: <xms:mY6BZ2mp0Y7Lgp1LlgOpp_7pZ_wcXsU2cj1oZiieuejrOOMfQbYAWA>
    <xme:mY6BZ92TO7Dry0Xt7lYKVzBuDkWqlj9Qyw6Rg6nBuIlCky02L0gWgNQQDQMd03azp
    0BJR-eXz1MyLQdJkQ>
X-ME-Received: <xmr:mY6BZ0rbUn0ZCcPb62HRKuA-P9g_w5Un8vOGzKO3IrKQ5NkjlWwcVeEcB-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    ephhgrmhiirghmrghhfhhoohiisehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqhhihphgvrhhvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepfigvihdrlhhiuheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhih
    shesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopehhrghihigrnhhgiiesmhhitg
    hrohhsohhfthdrtghomhdprhgtphhtthhopeguvggtuhhisehmihgtrhhoshhofhhtrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:mY6BZ6lGZ2a-PHhJ6ApKH29fW4A91P220djCJkzdXMQXS1oY3MB0Gg>
    <xmx:mY6BZ02whFH9Ow-MiCnvwFeePL1pvNLkchfnmVoNiZ72iR1Ns_7vTA>
    <xmx:mY6BZxvbxrlcW2yTu9VzneE5Rp720YNojI9gqoNzy2pqfcZPdPZU6A>
    <xmx:mY6BZwUeB5wF1GLlNybndrA4pqI_0tyMQBQj4eSc4HNirP2PcZCmqg>
    <xmx:mY6BZ_0STd9F7_RStKcWSMl7gVOKeum96X4O6LmQCzv7Ii4tA4ELvFLE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 16:18:17 -0500 (EST)
Date: Fri, 10 Jan 2025 13:17:12 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/hv: add CPU offlining support
Message-ID: <Z4GOWBkqX-vx_0sO@boqun-archlinux>
References: <20250110200507.120452-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110200507.120452-1-hamzamahfooz@linux.microsoft.com>

Hi Hamza,

Thanks for the patch, a few comments below:

On Fri, Jan 10, 2025 at 03:05:06PM -0500, Hamza Mahfooz wrote:
> Currently, it is effectively impossible to offline CPUs. Since, most
> CPUs will have vmbus channels attached to them. So, as made mention of
> in commit d570aec0f2154 ("Drivers: hv: vmbus: Synchronize
> init_vp_index() vs. CPU hotplug"), rebind channels associated with CPUs
> that a user is trying to offline to a new "randomly" selected CPU.
> 
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/hv/hv.c        | 57 +++++++++++++++++++++++++++++++-----------
>  drivers/hv/vmbus_drv.c | 51 +++++++++++++++++++++----------------
>  include/linux/hyperv.h |  1 +
>  3 files changed, 73 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 36d9ba097ff5..42270a7a7a19 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -433,13 +433,40 @@ static bool hv_synic_event_pending(void)
>  	return pending;
>  }
>  
> +static int hv_pick_new_cpu(struct vmbus_channel *channel,
> +			   unsigned int current_cpu)
> +{
> +	int ret = 0;
> +	int cpu;
> +
> +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> +
> +	/*
> +	 * We can't assume that the relevant interrupts will be sent before
> +	 * the cpu is offlined on older versions of hyperv.
> +	 */
> +	if (vmbus_proto_version < VERSION_WIN10_V5_3)
> +		return -EBUSY;
> +
> +	cpus_read_lock();

hv_pick_new_cpu() is only called inside hv_synic_cleanup(), which is
only called with cpus_read_lock() held (because it's registered via
cpuhp_setup_state_nocalls_cpuslocked()). So the cpus_read_lock() is not
necessary here if I'm not missing anything. Moreover, given
cpus_read_lock() is a non-recursive read lock, it's actually incorrect
to re-acquire it here, see:

	https://docs.kernel.org/locking/lockdep-design.html#recursive-read-locks

for more information.

> +	cpu = cpumask_next(get_random_u32_below(nr_cpu_ids), cpu_online_mask);
> +
> +	if (cpu >= nr_cpu_ids || cpu == current_cpu)
> +		cpu = VMBUS_CONNECT_CPU;
> +
> +	ret = vmbus_channel_set_cpu(channel, cpu);
> +	cpus_read_unlock();
> +
> +	return ret;
> +}
> +
>  /*
>   * hv_synic_cleanup - Cleanup routine for hv_synic_init().
>   */
>  int hv_synic_cleanup(unsigned int cpu)
>  {
>  	struct vmbus_channel *channel, *sc;
> -	bool channel_found = false;
> +	int ret = 0;
>  
>  	if (vmbus_connection.conn_state != CONNECTED)
>  		goto always_cleanup;
> @@ -456,31 +483,31 @@ int hv_synic_cleanup(unsigned int cpu)
>  
>  	/*
>  	 * Search for channels which are bound to the CPU we're about to
> -	 * cleanup.  In case we find one and vmbus is still connected, we
> -	 * fail; this will effectively prevent CPU offlining.
> -	 *
> -	 * TODO: Re-bind the channels to different CPUs.
> +	 * cleanup.
>  	 */
>  	mutex_lock(&vmbus_connection.channel_mutex);
>  	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
>  		if (channel->target_cpu == cpu) {
> -			channel_found = true;
> -			break;
> +			ret = hv_pick_new_cpu(channel, cpu);
> +
> +			if (ret) {
> +				mutex_unlock(&vmbus_connection.channel_mutex);
> +				return ret;
> +			}
>  		}
>  		list_for_each_entry(sc, &channel->sc_list, sc_list) {
>  			if (sc->target_cpu == cpu) {
> -				channel_found = true;
> -				break;
> +				ret = hv_pick_new_cpu(channel, cpu);
> +
> +				if (ret) {
> +					mutex_unlock(&vmbus_connection.channel_mutex);
> +					return ret;
> +				}
>  			}
>  		}
> -		if (channel_found)
> -			break;
>  	}
>  	mutex_unlock(&vmbus_connection.channel_mutex);
>  
> -	if (channel_found)
> -		return -EBUSY;
> -
>  	/*
>  	 * channel_found == false means that any channels that were previously
>  	 * assigned to the CPU have been reassigned elsewhere with a call of
> @@ -497,5 +524,5 @@ int hv_synic_cleanup(unsigned int cpu)
>  
>  	hv_synic_disable_regs(cpu);
>  
> -	return 0;
> +	return ret;
>  }
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 2892b8da20a5..c256e02fa66b 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1611,16 +1611,15 @@ static ssize_t target_cpu_show(struct vmbus_channel *channel, char *buf)
>  {
>  	return sprintf(buf, "%u\n", channel->target_cpu);
>  }
> -static ssize_t target_cpu_store(struct vmbus_channel *channel,

It'll be nice if you could separate this change into a different patch,
that is one patch for refactoring target_cpu_store() with
vmbus_channel_set_cpu() and the other patch to introduce the support of
cpu offline. Make it easier for reviewing.

> -				const char *buf, size_t count)
> +
> +int vmbus_channel_set_cpu(struct vmbus_channel *channel, u32 target_cpu)
>  {
> -	u32 target_cpu, origin_cpu;
> -	ssize_t ret = count;
> +	u32 origin_cpu;
> +	int ret = 0;
>  
> -	if (vmbus_proto_version < VERSION_WIN10_V4_1)
> -		return -EIO;
> +	lockdep_assert_held(&vmbus_connection.channel_mutex);

Add

	lockdep_assert_cpus_held();

as well?

Regards,
Boqun

>  
> -	if (sscanf(buf, "%uu", &target_cpu) != 1)
> +	if (vmbus_proto_version < VERSION_WIN10_V4_1)
>  		return -EIO;
>  
>  	/* Validate target_cpu for the cpumask_test_cpu() operation below. */
> @@ -1630,22 +1629,17 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
>  	if (!cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
>  		return -EINVAL;
>  
> -	/* No CPUs should come up or down during this. */
> -	cpus_read_lock();
> -
> -	if (!cpu_online(target_cpu)) {
> -		cpus_read_unlock();
> +	if (!cpu_online(target_cpu))
>  		return -EINVAL;
> -	}
>  
>  	/*
> -	 * Synchronizes target_cpu_store() and channel closure:
> +	 * Synchronizes vmbus_channel_set_cpu() and channel closure:
>  	 *
>  	 * { Initially: state = CHANNEL_OPENED }
>  	 *
>  	 * CPU1				CPU2
>  	 *
> -	 * [target_cpu_store()]		[vmbus_disconnect_ring()]
> +	 * [vmbus_channel_set_cpu()]	[vmbus_disconnect_ring()]
>  	 *
>  	 * LOCK channel_mutex		LOCK channel_mutex
>  	 * LOAD r1 = state		LOAD r2 = state
> @@ -1660,7 +1654,6 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
>  	 * Note.  The host processes the channel messages "sequentially", in
>  	 * the order in which they are received on a per-partition basis.
>  	 */
> -	mutex_lock(&vmbus_connection.channel_mutex);
>  
>  	/*
>  	 * Hyper-V will ignore MODIFYCHANNEL messages for "non-open" channels;
> @@ -1668,17 +1661,17 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
>  	 */
>  	if (channel->state != CHANNEL_OPENED_STATE) {
>  		ret = -EIO;
> -		goto cpu_store_unlock;
> +		goto end;
>  	}
>  
>  	origin_cpu = channel->target_cpu;
>  	if (target_cpu == origin_cpu)
> -		goto cpu_store_unlock;
> +		goto end;
>  
>  	if (vmbus_send_modifychannel(channel,
>  				     hv_cpu_number_to_vp_number(target_cpu))) {
>  		ret = -EIO;
> -		goto cpu_store_unlock;
> +		goto end;
>  	}
>  
>  	/*
> @@ -1708,9 +1701,25 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
>  				origin_cpu, target_cpu);
>  	}
>  
> -cpu_store_unlock:
> -	mutex_unlock(&vmbus_connection.channel_mutex);
> +end:
> +	return ret;
> +}
> +
> +static ssize_t target_cpu_store(struct vmbus_channel *channel,
> +				const char *buf, size_t count)
> +{
> +	ssize_t ret = count;
> +	u32 target_cpu;
> +
> +	if (sscanf(buf, "%uu", &target_cpu) != 1)
> +		return -EIO;
> +
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	cpus_read_lock();
> +	ret = vmbus_channel_set_cpu(channel, target_cpu);
>  	cpus_read_unlock();
> +	mutex_unlock(&vmbus_connection.channel_mutex);
> +
>  	return ret;
>  }
>  static VMBUS_CHAN_ATTR(cpu, 0644, target_cpu_show, target_cpu_store);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 02a226bcf0ed..25e9e982f1b0 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1670,6 +1670,7 @@ int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
>  				  const guid_t *shv_host_servie_id);
>  int vmbus_send_modifychannel(struct vmbus_channel *channel, u32 target_vp);
>  void vmbus_set_event(struct vmbus_channel *channel);
> +int vmbus_channel_set_cpu(struct vmbus_channel *channel, u32 target_cpu);
>  
>  /* Get the start of the ring buffer. */
>  static inline void *
> -- 
> 2.47.1
> 

