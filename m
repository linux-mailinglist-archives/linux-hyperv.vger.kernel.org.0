Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74C111AE84
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2019 15:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfLKO5O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Dec 2019 09:57:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35300 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727851AbfLKO5O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Dec 2019 09:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576076233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOuQ0JNluzXcS3sSfSKCvMxG138FinNcrFQnRo2BFGs=;
        b=LhZBO3A2s0a9r5N8DkcY/7spvaHr2dbY38TFt1CDKz6BUhBq3hSYHHsw4rYWHigCqkcw70
        ZvxIig3VsYC0ZgOx/EH7LXmnYpZ0L13DDeTnea9VzigPDeVbMEbyeDsHXV6hrbxOxHS/P0
        TZvgIstuMMTStBFGooa1XcZrWdd5yFM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-swJMpbCZMpilY0CkliXYQg-1; Wed, 11 Dec 2019 09:57:11 -0500
Received: by mail-wr1-f71.google.com with SMTP id z10so10469957wrt.21
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Dec 2019 06:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x0frXpADWjlwzRg+ikQlPyDtpxf8HnEMDPw/wa/ACXo=;
        b=AJDd8ik2xT/ZjkqRM1N01JGHhXmnyYRziFyn/ndBsYp1paP/QE4AwsALLNwXB+8irr
         87YYbZTKUwQ3BgPlnULezkLM5Nk00XrX8gC1svBORY6+zX8MKwTpvwhZyaEkHGCD1atK
         EsZlYB2isPHXsiiHSu1ZNci9XXGObP0VGpmlrfSd6febAQIo2ysa9AKcqQn6Ira/yfTS
         3NFI0nEttcPl3HqlEealhf+qZqma2CaJwaXclXCWDyeC/0D/uQWJrL9doarfrnrObpTh
         jpFjhVBx/73zvwFUJ0L2xTvXTKvczQ35ZnUJB9795wF68jS6cbudLf9+3HlZgQzwm13m
         +Ozw==
X-Gm-Message-State: APjAAAVSPN23NlnXcAWOaOr/uKfzaoZfy5xZNEKuuIke9Tj8WCArdec4
        uSKZI7cNNvYCCFLSee7w3oJelyvErqJEuNloe/msLsrevc987yWvC+1W3mLMhBEMGBG1E+lzqjX
        DDWKbTcMBo31YWgY9Dqk74g1A
X-Received: by 2002:a5d:6350:: with SMTP id b16mr246575wrw.132.1576076230260;
        Wed, 11 Dec 2019 06:57:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTsGgDClortHCsKXPy1CcyXDH1Pt0j/UZJSpYY+P8+o9yaMcWE6SEBiAAY4QjC/58yGmQ83A==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr246537wrw.132.1576076229967;
        Wed, 11 Dec 2019 06:57:09 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c9sm2469117wmc.47.2019.12.11.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:57:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.devolder@oracle.com
Subject: Re: [RFC PATCH 3/4] Hyper-V/Balloon: Call add_memory() with dm_device.ha_lock.
In-Reply-To: <20191210154611.10958-4-Tianyu.Lan@microsoft.com>
References: <20191210154611.10958-1-Tianyu.Lan@microsoft.com> <20191210154611.10958-4-Tianyu.Lan@microsoft.com>
Date:   Wed, 11 Dec 2019 15:57:08 +0100
Message-ID: <87pnguc3ln.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: swJMpbCZMpilY0CkliXYQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> The ha_lock is to protect hot-add region list ha_region_list.
> When Hyper-V delivers hot-add memory message, handle_pg_range()
> goes through the list to find the hot-add region state
> associated with message and do hot-add memory. The lock
> is released in the loop before calling hv_mem_hot_add()
> and is reacquired in hv_mem_hot_add(). There is a race
> that list entry maybe freed during the slot.

Do I understand correctly that without memory hot remove there's no
race? If yes than we should clarify this in the changelog.

>
> To avoid the race and simply the code, make hv_mem_hot_add()
> under protection of ha_region_list lock. There is a dead lock
> case when run add_memory() under ha_lock. add_memory() calls
> hv_online_page() inside and hv_online_page() also acquires
> ha_lock again. Add lock_thread in the struct hv_dynmem_device
> to record hv_mem_hot_add()'s thread and check lock_thread
> in hv_online_page(). hv_mem_hot_add() thread already holds
> lock during traverse hot add list and so not acquire lock
> in hv_online_page().
>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/hv_balloon.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 34bd73526afd..4d1a3b1e2490 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -545,6 +545,7 @@ struct hv_dynmem_device {
>  =09 * regions from ha_region_list.
>  =09 */
>  =09spinlock_t ha_lock;
> +=09struct task_struct *lock_thread;
> =20
>  =09/*
>  =09 * A list of hot-add regions.
> @@ -707,12 +708,10 @@ static void hv_mem_hot_add(unsigned long start, uns=
igned long size,
>  =09unsigned long start_pfn;
>  =09unsigned long processed_pfn;
>  =09unsigned long total_pfn =3D pfn_count;
> -=09unsigned long flags;
> =20
>  =09for (i =3D 0; i < (size/HA_CHUNK); i++) {
>  =09=09start_pfn =3D start + (i * HA_CHUNK);
> =20
> -=09=09spin_lock_irqsave(&dm_device.ha_lock, flags);
>  =09=09has->ha_end_pfn +=3D  HA_CHUNK;
> =20
>  =09=09if (total_pfn > HA_CHUNK) {
> @@ -724,7 +723,6 @@ static void hv_mem_hot_add(unsigned long start, unsig=
ned long size,
>  =09=09}
> =20
>  =09=09has->covered_end_pfn +=3D  processed_pfn;
> -=09=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> =20
>  =09=09init_completion(&dm_device.ol_waitevent);
>  =09=09dm_device.ha_waiting =3D !memhp_auto_online;
> @@ -745,10 +743,8 @@ static void hv_mem_hot_add(unsigned long start, unsi=
gned long size,
>  =09=09=09=09 */
>  =09=09=09=09do_hot_add =3D false;
>  =09=09=09}
> -=09=09=09spin_lock_irqsave(&dm_device.ha_lock, flags);
>  =09=09=09has->ha_end_pfn -=3D HA_CHUNK;
>  =09=09=09has->covered_end_pfn -=3D  processed_pfn;
> -=09=09=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  =09=09=09break;
>  =09=09}
> =20
> @@ -771,8 +767,13 @@ static void hv_online_page(struct page *pg, unsigned=
 int order)
>  =09struct hv_hotadd_state *has;
>  =09unsigned long flags;
>  =09unsigned long pfn =3D page_to_pfn(pg);
> +=09int unlocked;
> +
> +=09if (dm_device.lock_thread !=3D current) {

With lock_thread checking you're trying to protect against taking the
spinlock twice (when this is called from add_memory()) but why not just
check that spin_is_locked() AND we sit on the same CPU as the VMBus
channel attached to the balloon device?=20

> +=09=09spin_lock_irqsave(&dm_device.ha_lock, flags);
> +=09=09unlocked =3D 1;
> +=09}

We set unlocked to '1' when we're actually locked, aren't we?

> =20
> -=09spin_lock_irqsave(&dm_device.ha_lock, flags);
>  =09list_for_each_entry(has, &dm_device.ha_region_list, list) {
>  =09=09/* The page belongs to a different HAS. */
>  =09=09if ((pfn < has->start_pfn) ||
> @@ -782,7 +783,9 @@ static void hv_online_page(struct page *pg, unsigned =
int order)
>  =09=09hv_bring_pgs_online(has, pfn, 1UL << order);
>  =09=09break;
>  =09}
> -=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +
> +=09if (unlocked)
> +=09=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  }
> =20
>  static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
> @@ -860,6 +863,7 @@ static unsigned long handle_pg_range(unsigned long pg=
_start,
>  =09=09pg_start);
> =20
>  =09spin_lock_irqsave(&dm_device.ha_lock, flags);
> +=09dm_device.lock_thread =3D current;
>  =09list_for_each_entry(has, &dm_device.ha_region_list, list) {
>  =09=09/*
>  =09=09 * If the pfn range we are dealing with is not in the current
> @@ -912,9 +916,7 @@ static unsigned long handle_pg_range(unsigned long pg=
_start,
>  =09=09=09} else {
>  =09=09=09=09pfn_cnt =3D size;
>  =09=09=09}
> -=09=09=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
>  =09=09=09hv_mem_hot_add(has->ha_end_pfn, size, pfn_cnt, has);
> -=09=09=09spin_lock_irqsave(&dm_device.ha_lock, flags);

Apart from the deadlock you mention in the commit message, add_memory
does lock_device_hotplug()/unlock_device_hotplug() which is a mutex. If
I'm not mistaken you now take the mutext under a spinlock
(&dm_device.ha_lock). Not good.


>  =09=09}
>  =09=09/*
>  =09=09 * If we managed to online any pages that were given to us,
> @@ -923,6 +925,7 @@ static unsigned long handle_pg_range(unsigned long pg=
_start,
>  =09=09res =3D has->covered_end_pfn - old_covered_state;
>  =09=09break;
>  =09}
> +=09dm_device.lock_thread =3D NULL;
>  =09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> =20
>  =09return res;

--=20
Vitaly

