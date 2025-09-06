Return-Path: <linux-hyperv+bounces-6774-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65684B475E7
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Sep 2025 19:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF8B3AF9FF
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Sep 2025 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93CD24169A;
	Sat,  6 Sep 2025 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwBY1zmM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7181E221264;
	Sat,  6 Sep 2025 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757180119; cv=none; b=EG3WQQh/eB99fDWsQzbafeFUgFpqvuqyGIt63EXYpqDWt5MrU3ABPm52F+jkbF4iaN8o9bpZ991UXV6m8vQKBRFSxmkKHa9E77yv086HJqOI0z964H89/qd7pGC/ZHqR3KKDBHcqWddDNHbhtz1bXFdBMaT3UgPX1r1P7R9VXX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757180119; c=relaxed/simple;
	bh=RU8Bt/rlHmJM3S55eOvRYSiB/XQLgaFrE5yusatrGmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSy6SjeTWeHdTY5/wUMMSFuz9ZiQAX8aliRPlkfLvapNQm42i73XkN6R3OJRbxEyaEYrziiTDU3Kf0mMY5wcTMeoOZUQx4ii7Z4wmyOg78fryKRV7fLUDymaEdIU5e58Qxxc0yckW8vxwHD+5fTvUyg9o25fypEutHfaTSD59vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwBY1zmM; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so2513604a91.2;
        Sat, 06 Sep 2025 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757180118; x=1757784918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZS2trNMG7XChbOGA2TYJNbZdcXZfxnFPyfuldcejaY=;
        b=MwBY1zmM/g0HaG0RxrZq4Q44EIo2OeR7M2bHu3vr3gHeap4S3YJbSPwFB9oW21g2mt
         bnHGn1VXflFynPXf07q9GRNXpyD+NleJ7piw3xRIUJv3OaQkHoF+n0rETEwIhE5z1Zti
         ucPoP1S0w+pC5TTvURGVRFe52Et4o5QVG+imr0VjJLBnzO/zfDpCP3sUxUUrdk8S9SZS
         bOIjfJ9RRyGdNN4VxSP7dfyd9FDBPIk0GEN317SzweHJQeR+2k9aawpz6GpjeVO8flfI
         i9UuMB3Y9B+3G0uGAF/p621i+uRKUGsKqVapWYKHjxx6LzNRhR2wEkk2dZ7ZY5NFAiPx
         nCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757180118; x=1757784918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZS2trNMG7XChbOGA2TYJNbZdcXZfxnFPyfuldcejaY=;
        b=OQmfNziZOaT5qiO8t5aIu07E2g04r1IBk/t2OrplQeSskFUwWkTaxmiBf2cKQyViKZ
         ARncXizRJ8ZkbMIYcmSZE8ZJDsxLAXl7bZlAv/DA30N0fcs7B00CAb/ugbVAT7EVU6xE
         A0bJ7zNUkqwv5yikpmZIK9A+qw0m/IzemxsflR/7JlaQkK3dtmA4IFwQBk32GiREzV6X
         1/NBx/0ukUGAfJtNEkDyJfWvGS4CSjEhS7614NexJ9sedD2oNIE6MU3s2htbwxx03FQZ
         iYSUgVHcQkt7lxHgUcFnudrqFWavVj8SB7OFZXGsiRU1MPeSsSAVWr9hRNucfTGNMT1r
         /U8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5wZFE2uHFrDLH04jMlsf9W7vfDXlxVhJ7kAsiQiB47p3CUqwBVuG/ewhVPFmzrtz68GDpECAXKi6kat0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxzdfuLuWGjRkIjm4M/IBl3Dw2txR1bsQUzi5GvtCT4dtCynZ
	ZQ5wF7f8SI1epmuUTEZ3bd1ZDoUyXPvoJoGlJEtHjwKrufh+9ROlop7NIQs71S35yaeXs5RYsAu
	UgHm8opVXo3RwyHitTn6XHmv35+UE5fO0DSo/
X-Gm-Gg: ASbGncuP8OZ9iXq5TKxDP6PRoUBISyw7oje0C6OyZk0ByHozn0OEURO271umOp4GEOS
	xwK5dIT6jfq+RXLmXBK2Nh2Ywxmr7zfCRc9DvE+zF/FUTWAbezbmJNp/yxNsK/RrzAN/82O7/em
	HNgO5BL+Q1Gi9ECo8ibCsLmmxzlmd/Lb5hZOiVchrL+YPQxykMnwyz5PYGxJ2vzFbJEYMktFNS7
	pUmJyw66iVn97k=
X-Google-Smtp-Source: AGHT+IEHKLHgXsvfLI8Fh4S3sa4UJkf0B3fvUzZJmAsTnAZpNhuGDBnHX4ZGCiCM8xi6LqgUAt/vwjo3QS3IPWarLSk=
X-Received: by 2002:a17:90b:4c0c:b0:32b:958a:51d4 with SMTP id
 98e67ed59e1d1-32d43f98fa1mr3371761a91.28.1757180117583; Sat, 06 Sep 2025
 10:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1756428230-3599-5-git-send-email-nunodasneves@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Sun, 7 Sep 2025 01:34:56 +0800
X-Gm-Features: AS18NWCEm0DjaUBPwLug4DGhtdCumLyQfXai0Yi1JJSgPUqLCDdhj8aER26I2Xw
Message-ID: <CAMvTesD0hOxh5NpqqELkWeKmwfZ0dSdiYSvXKFg4K50e0KtkOg@mail.gmail.com>
Subject: Re: [PATCH 4/6] mshv: Get the vmm capabilities offered by the hypervisor
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	mhklinux@outlook.com, decui@microsoft.com, paekkaladevi@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 8:44=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>
> Some newer hypervisor APIs are gated by feature bits in the so-called
> "vmm capabilities" partition property. Store the capabilities on
> mshv_root module init, using HVCALL_GET_PARTITION_PROPERTY_EX.
>
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.micros=
oft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

>  drivers/hv/mshv_root.h      |  1 +
>  drivers/hv/mshv_root_main.c | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 4aeb03bea6b6..0cb1e2589fe1 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -178,6 +178,7 @@ struct mshv_root {
>         struct hv_synic_pages __percpu *synic_pages;
>         spinlock_t pt_ht_lock;
>         DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
> +       struct hv_partition_property_vmm_capabilities vmm_caps;
>  };
>
>  /*
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 56ababab57ce..29f61ecc9771 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2327,6 +2327,28 @@ static int __init mshv_root_partition_init(struct =
device *dev)
>         return err;
>  }
>
> +static int mshv_init_vmm_caps(struct device *dev)
> +{
> +       int ret;
> +
> +       memset(&mshv_root.vmm_caps, 0, sizeof(mshv_root.vmm_caps));
> +       ret =3D hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> +                                               HV_PARTITION_PROPERTY_VMM=
_CAPABILITIES,
> +                                               0, &mshv_root.vmm_caps,
> +                                               sizeof(mshv_root.vmm_caps=
));
> +
> +       /*
> +        * HV_PARTITION_PROPERTY_VMM_CAPABILITIES is not supported in
> +        * older hyperv. Ignore the -EIO error code.
> +        */
> +       if (ret && ret !=3D -EIO)
> +               return ret;
> +
> +       dev_dbg(dev, "vmm_caps=3D0x%llx\n", mshv_root.vmm_caps.as_uint64[=
0]);
> +
> +       return 0;
> +}
> +
>  static int __init mshv_parent_partition_init(void)
>  {
>         int ret;
> @@ -2377,6 +2399,12 @@ static int __init mshv_parent_partition_init(void)
>         if (ret)
>                 goto remove_cpu_state;
>
> +       ret =3D mshv_init_vmm_caps(dev);
> +       if (ret) {
> +               dev_err(dev, "Failed to get VMM capabilities\n");
> +               goto exit_partition;
> +       }
> +
>         ret =3D mshv_irqfd_wq_init();
>         if (ret)
>                 goto exit_partition;
> --
> 2.34.1
>
>


--=20
Thanks
Tianyu Lan

