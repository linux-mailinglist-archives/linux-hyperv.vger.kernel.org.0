Return-Path: <linux-hyperv+bounces-1726-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D55878E40
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 06:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120461F22515
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 05:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2921804C;
	Tue, 12 Mar 2024 05:46:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D710A12;
	Tue, 12 Mar 2024 05:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710222371; cv=none; b=QPBklSxauncsAjR5lp7M7vG0GlwW6PrYeMd9ExvMAKGGMbz5tUG1PScj9RRcPJo+T/H8kW7oJQUbY6F4yJ0OENc9o0LYw7IvtVWIW0ZEyD/FoouuvBZ0YJ4PyYv/9JZ3ejkqdYMe1eGp1h6WD/XwFP/UF/h1XnlIDzXqjOggB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710222371; c=relaxed/simple;
	bh=p/qM/uvqJknlkhIz++zsgYm5UEdegHpPBL/SEz1rPBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRPgx98qBWyW+Jj11PoOGqPV2/mQr+Aa7oemlIMWlel5ag95fN4zQ1ZGWff11tn7ZNZkzQsRLz8u5JwOVaEaLzgj9Q7Zpfat4gvkK6u9aAqmckjGZ3hDB+zBr+YX5eOsBXiHC3VUhgX47b5EV9UGQYvmv7a6TiIs3eSsaKxlNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4429c556efso412448466b.0;
        Mon, 11 Mar 2024 22:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710222367; x=1710827167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEgAABfrmv9f6da9s+EJl/QuGoeCFMl1ymUuyGPWf5k=;
        b=VyfCdKi3dAVj8QpPD05LBPsZlUGgKNFMFoK2gac22WHcPpLNjhEvBYEyGwnrl6V1hA
         zv2A+k+o3y3hxSaNwMiaka9/gVua3I4qsdGH5lSc/0vccADhaY6DW53sLNJ8puoNVAt1
         Igl8TJILhc3+4YnRNX4R6ZPFldo228FmC/0SKKJg4gp7cJgx6GyI6Wxm41/6Zi5PpBNc
         43GhLliCCUugeDvbQsKyOsf0PEQV6rv++SwRIFJiEiLBnCltxj6X0+miHMFvdZziR+wi
         foxQIRVHgKf8aWOSnLILlcJZe5+9lNtoxUtgKz/YAExyU4mdf9/ryKqjiKKcmDbUoBnI
         4Cfg==
X-Forwarded-Encrypted: i=1; AJvYcCXumGokw+oboMJu6UIeyDpDLC6Mqywnk2bxtDH9GTY77XZUqyjeOVI/jeXNX4HLK7gs+AKnKNIVOToXnUpmcJvZUgQKeEVf2Na0U26AMQnwB0SUqGwGr2IN4memhm9a1qJMqXwy0wRxmPXODqr4FW+TW3XYNs8Q4eWBguVpRH6h6U51
X-Gm-Message-State: AOJu0YxQyd5AY1J5zK7C8AIdZM0mByWrYcRHNZaUCkLT6bjkBtXvuv1X
	n4wTofPmEn1Rrac3HIdKwvL4nH0ZCiXZ3rHSBT/fkhRGQaBf0mCrjvNJRI+WI6EltA==
X-Google-Smtp-Source: AGHT+IHtYv9eZ0NExks4bz6UDwMuY2zHFIV7h+rZrwrs52ipFLTfRTqWDy2dfIl+mC4lJvmeJtk3Fg==
X-Received: by 2002:a17:906:3daa:b0:a3f:5144:ada2 with SMTP id y10-20020a1709063daa00b00a3f5144ada2mr5117620ejh.2.1710222366772;
        Mon, 11 Mar 2024 22:46:06 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id r24-20020a170906549800b00a45a62e0ed0sm3512226ejo.98.2024.03.11.22.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 22:46:06 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4429c556efso412446566b.0;
        Mon, 11 Mar 2024 22:46:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNSYnKA5F45lIyBdn7PlcZBypepjMFLGhV8U1VAnMMckA8K9N8/8EHiUtnsb64+hMeoPrGGOVaUHyEtFA/ZhC43f04RscS3cF9Ft99JgNmHrI2NqwjaMGOGv/1TWO7yMOXtLOWtbL06yKfAtmZr1h9yPt8L+wI07Pq2BPlUW+SK+HI
X-Received: by 2002:a17:906:4a89:b0:a46:2b4d:e3f8 with SMTP id
 x9-20020a1709064a8900b00a462b4de3f8mr2377402eju.19.1710222366228; Mon, 11 Mar
 2024 22:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311161558.1310-1-mhklinux@outlook.com> <20240311161558.1310-3-mhklinux@outlook.com>
 <13581af9-e5f0-41ca-939f-33948b2133e7@linux.intel.com>
In-Reply-To: <13581af9-e5f0-41ca-939f-33948b2133e7@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Mon, 11 Mar 2024 22:45:54 -0700
X-Gmail-Original-Message-ID: <CAC41dw9RKh1EzprEHqy+BpRbPNYiwOLvnWeauErdMLDCJdRyLA@mail.gmail.com>
Message-ID: <CAC41dw9RKh1EzprEHqy+BpRbPNYiwOLvnWeauErdMLDCJdRyLA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] Drivers: hv: vmbus: Track decrypted status in vmbus_gpadl
To: mhklinux@outlook.com, rick.p.edgecombe@intel.com, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
	gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kirill.shutemov@linux.intel.com, 
	dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-coco@lists.linux.dev
Cc: elena.reshetova@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 10:02=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 3/11/24 9:15 AM, mhkelley58@gmail.com wrote:
> > From: Rick Edgecombe <rick.p.edgecombe@intel.com>
> >
> > In CoCo VMs it is possible for the untrusted host to cause
> > set_memory_encrypted() or set_memory_decrypted() to fail such that an
> > error is returned and the resulting memory is shared. Callers need to
> > take care to handle these errors to avoid returning decrypted (shared)
> > memory to the page allocator, which could lead to functional or securit=
y
> > issues.
> >
> > In order to make sure callers of vmbus_establish_gpadl() and
> > vmbus_teardown_gpadl() don't return decrypted/shared pages to
> > allocators, add a field in struct vmbus_gpadl to keep track of the
> > decryption status of the buffers. This will allow the callers to
> > know if they should free or leak the pages.
> >
> > Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  drivers/hv/channel.c   | 25 +++++++++++++++++++++----
> >  include/linux/hyperv.h |  1 +
> >  2 files changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> > index 56f7e06c673e..bb5abdcda18f 100644
> > --- a/drivers/hv/channel.c
> > +++ b/drivers/hv/channel.c
> > @@ -472,9 +472,18 @@ static int __vmbus_establish_gpadl(struct vmbus_ch=
annel *channel,
> >               (atomic_inc_return(&vmbus_connection.next_gpadl_handle) -=
 1);
> >
> >       ret =3D create_gpadl_header(type, kbuffer, size, send_offset, &ms=
ginfo);
> > -     if (ret)
> > +     if (ret) {
> > +             gpadl->decrypted =3D false;
>
> Why not set it by default at the beginning of the function?
>
> >               return ret;
> > +     }
> >
> > +     /*
> > +      * Set the "decrypted" flag to true for the set_memory_decrypted(=
)
> > +      * success case. In the failure case, the encryption state of the
> > +      * memory is unknown. Leave "decrypted" as true to ensure the
> > +      * memory will be leaked instead of going back on the free list.
> > +      */
> > +     gpadl->decrypted =3D true;
> >       ret =3D set_memory_decrypted((unsigned long)kbuffer,
> >                                  PFN_UP(size));
> >       if (ret) {
> > @@ -563,9 +572,15 @@ static int __vmbus_establish_gpadl(struct vmbus_ch=
annel *channel,
> >
> >       kfree(msginfo);
> >
> > -     if (ret)
> > -             set_memory_encrypted((unsigned long)kbuffer,
> > -                                  PFN_UP(size));
> > +     if (ret) {
> > +             /*
> > +              * If set_memory_encrypted() fails, the decrypted flag is
> > +              * left as true so the memory is leaked instead of being
> > +              * put back on the free list.
> > +              */
> > +             if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(=
size)))
> > +                     gpadl->decrypted =3D false;
> > +     }
> >
> >       return ret;
> >  }
> > @@ -886,6 +901,8 @@ int vmbus_teardown_gpadl(struct vmbus_channel *chan=
nel, struct vmbus_gpadl *gpad
> >       if (ret)
> >               pr_warn("Fail to set mem host visibility in GPADL teardow=
n %d.\n", ret);
>
> Will this be called only if vmbus_establish_gpad() is successful? If not,=
 you might want to skip
> set_memory_encrypted() call for decrypted =3D false case.
>
> >
> > +     gpadl->decrypted =3D ret;
> > +
>
> IMO, you can set it to false by default. Any way with non zero return, us=
er know about the
> decryption failure.

I understand this change after looking at the rest of the patches. So
please ignore the above
comment.

>
> >       return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
> > diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> > index 2b00faf98017..5bac136c268c 100644
> > --- a/include/linux/hyperv.h
> > +++ b/include/linux/hyperv.h
> > @@ -812,6 +812,7 @@ struct vmbus_gpadl {
> >       u32 gpadl_handle;
> >       u32 size;
> >       void *buffer;
> > +     bool decrypted;
> >  };
> >
> >  struct vmbus_channel {
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

