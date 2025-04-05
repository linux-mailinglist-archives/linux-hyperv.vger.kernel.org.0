Return-Path: <linux-hyperv+bounces-4796-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF64A7C7CC
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Apr 2025 08:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009BF18999CA
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Apr 2025 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E013D539;
	Sat,  5 Apr 2025 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE+t8c9e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA218EB0;
	Sat,  5 Apr 2025 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743833357; cv=none; b=LgRgZDlzKHeLZDxrqREstpBp+nxeLf9RV6+TdBmnmGzvY9NUF4cXa9OvabMAEpkSAGFJ23YHcmNhLmlG9cYYLk9NHs6n4yXhzoWW427kC947jOM8aUdWfvZcqW+VY8kfbeCc0jOUr177rLffgBQgc6jsWEiz5CWX4zPjmR68CW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743833357; c=relaxed/simple;
	bh=dF9pLRIGVFXU7OmYe2QafFHNXVnLtp+m8FdvydCZAWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUQL6FMHjukMUMyyTuokgj1cRGa/jpjI/8tX9NSumoshvVHyIrH/I7B7O7FBb7Y5JAkr7+CsDC8PZsKm+7Xwv2VsPNivB2qkpiiljHr8cAc5Z/Eko/R/+nhIpldFANgBuyeBrBmlafAvOjJZT+9cAhB6hpg2PkE18744NOFyxOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE+t8c9e; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abec8b750ebso443569766b.0;
        Fri, 04 Apr 2025 23:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743833354; x=1744438154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IrwI6EB2bkScgHThdFCUjtlZpaTDIqzS7IqE4WGkY8=;
        b=gE+t8c9eAzH/qDIPgHeU2s4bCJBL41kQT4TfCj0CVAoW/NTsbceYyufhqKTkuuxyhS
         Hl/hCt3mgC+ftqN3UMe7lhc+FSw5Zmsr47AtScgKsrEVYOAPf2607qd0G2NJ+fgDpdbv
         cjU5XIWnWXJpYFNT3091y/NbVF3JiL+bVZKroL+FHZsi3QTkN0dC+LoD8UkKN3PD40aj
         eIVrt/q0v56QvrC17ygbhqTYkmpFFzEzhSxPLOgbuMG1w31M0xi1kS5AXNSL4s1mW4Ip
         9ATv0dYsQSshWgo+ZHcpsd7CvDjhLD/lY6vYcO0cTFEGMYGbWC6c8JgKpNeBy6WsRxxS
         rvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743833354; x=1744438154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IrwI6EB2bkScgHThdFCUjtlZpaTDIqzS7IqE4WGkY8=;
        b=i6CaMVOyV1bo8B4pV2nreKgwny1aV8UYgi1D+66ogQszMiPqkO6MjQqiC8fcybscSm
         HFXZ6JfAxLAM/iYfQKcDfstoFAEiYLK9hJZ/MlEnfA7wJ3eTfn1NRp3YRzwybEQjhcJ8
         mjJ5KCsGdEGMIwPYrL7x8zLv7ojdcm/JOO6Cw0yGxAf8LttoSy12VzlmBbqj8Y4DBjLz
         srkFx8DXTR93b+DMveM1hyaFWbbzLY82y+cd8K8lVbM5B+ahY5fOniRAvmu83kumKWFK
         iBqAyLgjvYcYEfXCKwV1D6XsI/T7Uo/kq8Rgh329i2Gh7rjrArgLvRnd7ukZZr78Myfx
         R8qA==
X-Forwarded-Encrypted: i=1; AJvYcCVp6bcb1w/3CSD6Z9CKUzmY8Q8Zro0m9HnbAolVneigZ6eKBo/8tIqxELVF1tKqOkBUHi/rYn0xPpu2smU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqP2jfEimtWBKzYLspeXm02j38wFozymiwOPmQPQLfquzoWX5k
	2gtN7lYRaj5XF5g0SxnlUt0b+b3ctI2x+9iuK9UgeiafC/zXHpv/o9SFgjfr7NJpB+ce9qefuSh
	8PXcyGpWZxJPNWs+CwozCvkA8eac=
X-Gm-Gg: ASbGncsLATmz8j1vkiEPB65620ki/W84ZcQtW1ZCh6z+qcgwd91CL+Mk2SmC9vJQ/kf
	P77L2X/YKw5KrtvMBqwTa+ubqH5H+3FmfPmVL1aoVPDfuo4tT3NtOt6lHHwmTIKQNMl3qAOkRcd
	1Ujat9bVl301aj9KlQHn3UUt9Ghrbx
X-Google-Smtp-Source: AGHT+IGe3T5BfTqPFEa7XmOq9aO0+F4jbOxS4hKhhBF7Sto5DPyKo/X9Ku2MtVPLZWwt6PWDoUdeCIPFPzfaXarPwFo=
X-Received: by 2002:a17:906:6a22:b0:ac2:d6d1:fe65 with SMTP id
 a640c23a62f3a-ac7e76252aemr147426766b.41.1743833353882; Fri, 04 Apr 2025
 23:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322164709.500340-1-malayarout91@gmail.com>
In-Reply-To: <20250322164709.500340-1-malayarout91@gmail.com>
From: malaya kumar rout <malayarout91@gmail.com>
Date: Sat, 5 Apr 2025 11:39:02 +0530
X-Gm-Features: ATxdqUGjrQsoObmnh24CpNlPQs9JEn4cy0SihSDUbMlRf1HrduwqGGJiiO7ohFU
Message-ID: <CAE2+fR9kaSGz8pfi-vbmeXGXM84ANyBTD2C1VJg6aFSVyVffrA@mail.gmail.com>
Subject: Re: [PATCH] tools/hv: Memory Leak on realloc
To: malayarout91@gmail.com
Cc: linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 10:17=E2=80=AFPM Malaya Kumar Rout
<malayarout91@gmail.com> wrote:
>
> Static analysis for hv_kvp_daemon.c with cppcheck : error:
>
> hv_kvp_daemon.c:359:3: error: Common realloc mistake:
> 'record' nulled but not freed upon failure [memleakOnRealloc]
> record =3D realloc(record, sizeof(struct kvp_record) *
>
> If realloc() fails, record is now NULL.
> If we directly assign this NULL to record, the reference to the previousl=
y allocated memory is lost.
> This causes a memory leak because the old allocated memory remains but is=
 no longer accessible.
>
> A temporary pointer was utilized when invoking realloc() to prevent
> the loss of the original allocation in the event of a failure
>
> CC: linux-kernel@vger.kernel.org
>     linux-hyperv@vger.kernel.org
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>  tools/hv/hv_kvp_daemon.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 04ba035d67e9..6807832209f0 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -356,11 +356,14 @@ static int kvp_key_add_or_modify(int pool, const __=
u8 *key, int key_size,
>          */
>         if (num_records =3D=3D (ENTRIES_PER_BLOCK * num_blocks)) {
>                 /* Need to allocate a larger array for reg entries. */
> -               record =3D realloc(record, sizeof(struct kvp_record) *
> -                        ENTRIES_PER_BLOCK * (num_blocks + 1));
> -
> -               if (record =3D=3D NULL)
> +               struct kvp_record *temp =3D realloc(record, sizeof(struct=
 kvp_record) *
> +                               ENTRIES_PER_BLOCK * (num_blocks + 1));
> +               if (!temp) {
> +                       free(record);
> +                       record =3D NULL;
>                         return 1;
> +               }
> +               record =3D temp;
>                 kvp_file_info[pool].num_blocks++;
>
>         }
> --
> 2.43.0
>

This is a courteous reminder regarding the current patch.
Any feedback or insights you may have would be greatly appreciated.

Thanks & Regards,
Malaya Kumar Rout

