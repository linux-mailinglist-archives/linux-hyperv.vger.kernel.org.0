Return-Path: <linux-hyperv+bounces-6679-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F8AB3D4A4
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 19:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841F03BB57B
	for <lists+linux-hyperv@lfdr.de>; Sun, 31 Aug 2025 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBDD274652;
	Sun, 31 Aug 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px+YDGJG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6325F7A5;
	Sun, 31 Aug 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756661914; cv=none; b=HaUcoh/4cea/L5BEePwldUj30V7I5h+e+3VlmP0rFsUIMvM5o7tBngroe7VjL2pHYyZdae5oHADl3jvnYuC5s4YMmNOjH+Lz1sIvJ5K925HjsCFa1sjGl2EJG4QZ8fy2gG2iOkRJboHpGOVlWXip0XxnnZUDMq9WLMQPCAqS/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756661914; c=relaxed/simple;
	bh=3hYtiSB1bita0VH3Br12n9/2l1ftfvSAlztbr52K/+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8Be0MfcEjZa6DcjKyC1bBcDgJnHJkoSzhiTu+8kqLo1g+kBe9iCL+n/Q4gxwcXjp5t46tb9kXuAkJUY4PJru1qg+iefq/H6D6lrOQ9LfxnVs9EiYzz8nOXRVcrxsGXXKRGHZ94gLPFwIHxyrutMrvZpm9i+JHEXNy7DdEYLsV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px+YDGJG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-327aa47c928so2998551a91.3;
        Sun, 31 Aug 2025 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756661912; x=1757266712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlwerZOMDd8NX9+kt0uKIyECi+13IfTQs20ddjfYWfM=;
        b=Px+YDGJGFVxP0BoLyigGIE6lLpl96L5BowyAtWYsdJSM20DryjHRkWyFF7CTZx6Qo5
         9VNvCgyZ6XkPRfLiFFz+O9nbwsqZ//ml7oTKBGSEqKZ3Y1ovYDxlBJzdVHGl/dlw2Ehs
         ILZeJUJMJ8FUDU3hf7tQkExFk4aiXVXwt6T8zM+fN84s3SMF0eT7QLb8Dgf/6FSeipiO
         FeOMfEcXvtGYPKWtRumVkb4WtmovVOR1TNw+kCcM/jTDmybhg6vGcGFDi8s8imFiE9PA
         CO5+zoz/Ptw6C5YbpBv/qG1XyKOgkF9lX+BRSW0ElIVnSH22HxWBucndWcyE50syXilz
         Rd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756661912; x=1757266712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlwerZOMDd8NX9+kt0uKIyECi+13IfTQs20ddjfYWfM=;
        b=s6iJCQ48wIHYv0alE51aeRjYFlWz1wZzGZ0nXEIVvwmmnY40SWdgA8t7FDnSsqUsj4
         Vz3Blg83qYoPWldOAYsAC6N1HAsA6C4INVkX0M038prfDbPLq05PVUE5crn5fjMEDjGd
         W8/Iy96F9VhHuGna6PDN6Q8dY7/1ORPEUw+GKl4cxkm7L2J6T/kzOaczlyM74hxqx2lV
         N2a3/vEIKeJmpkDMUuHzFrWDKU3Ou9ULAArcaZJKgZ9rQEn/mAncvMYi1jcVOiEy68jS
         oTfjOBcvo16SLkULYaI+ftpY3iK544joPCgHFZABc6PjMEz2tzj9qnylUjwMI/moE+WH
         9ZAg==
X-Forwarded-Encrypted: i=1; AJvYcCUjY5NKDyStzoOmphzOs+tVLM3o9nBt6CllgnGuBsV3mJOtVNvaR+QbhRqQtfm87xgF2VciWy9f7/zoEsY=@vger.kernel.org, AJvYcCXgMlMQ7yO8gttEAVJML0jCnp85Zi7NqqsyqDFAHKKf14xqbJP0iC6RGfWGyqADQlD9r4lKlkDnLpTK57t8@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcEV5siJPUcwMety4itUdIDwi6ayA25QrdMxOXggPlJtEWJjI
	xORdsu2UX36DWKIjlQWh6PwMNzZFldQCrbYZcv5DNZofISWvh8so5/rBYsX/AReiZsAMNSKqpMY
	OCiYsXll1GSzy5DFFOLesOKkCPyDAgZk=
X-Gm-Gg: ASbGncuccLIrHVr6whQv7NVtmjoPkm5z925xuVMHt+TsNNvQjrVtmDkZ3P+r5Ny7VoA
	SKexn3RwfDoU+m8i6tq1xW0/c17Z52ZUEdd8jyJTOexQTX2i2N23TMWmRyKcnRz66ysI9Txq4jX
	d+vJM7UQgoNlQi/gcFLTxp4aPBs+ZRCAHLOpfpJ5lu9pdHu+M2GHRQ7WDrfNapwXEQZNEcMV3m8
	YJVRR7p
X-Google-Smtp-Source: AGHT+IHIQ/TwkUqnG3Yvkdjgei9ZgJ1+SUcV3kxV9AtLoAVScJcAxWPCdWBWxEi7aF6VQ0HhzJwrMujmtPjhpDMzpCk=
X-Received: by 2002:a17:902:d4c4:b0:248:96af:51e with SMTP id
 d9443c01a7336-24944ad0aedmr65936155ad.45.1756661911600; Sun, 31 Aug 2025
 10:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828091618.884950-1-vkuznets@redhat.com> <SN6PR02MB41571C1A6DE8756D72176E93D43AA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41571C1A6DE8756D72176E93D43AA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 1 Sep 2025 01:37:55 +0800
X-Gm-Features: Ac12FXy7hb5-D9Rthveefhgcq8rJD7ROMbAamRM7DEg7W5u-C0aHcB6G508ys8E
Message-ID: <CAMvTesBgOCdu7KCn57Lf2LU3Lsvg4zkePGd6L9Zp7sVB-VjT0A@mail.gmail.com>
Subject: Re: [PATCH v4] x86/hyperv: Fix kdump on Azure CVMs
To: Michael Kelley <mhklinux@outlook.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, Tianyu Lan <tiala@microsoft.com>, 
	Li Tian <litian@redhat.com>, Philipp Rudo <prudo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 1:03=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Thursday, August 28, 2=
025 2:16 AM
> >
> > Azure CVM instance types featuring a paravisor hang upon kdump. The
> > investigation shows that makedumpfile causes a hang when it steps on a =
page
> > which was previously share with the host
> > (HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY). The new kernel has no
> > knowledge of these 'special' regions (which are Vmbus connection pages,
> > GPADL buffers, ...). There are several ways to approach the issue:
> > - Convey the knowledge about these regions to the new kernel somehow.
> > - Unshare these regions before accessing in the new kernel (it is uncle=
ar
> > if there's a way to query the status for a given GPA range).
> > - Unshare these regions before jumping to the new kernel (which this pa=
tch
> > implements).
> >
> > To make the procedure as robust as possible, store PFN ranges of shared
> > regions in a linked list instead of storing GVAs and re-using
> > hv_vtom_set_host_visibility(). This also allows to avoid memory allocat=
ion
> > on the kdump/kexec path.
> >
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Looks good!
>
> Adding Confidential Computing mailing list (linux-coco@lists.linux.dev)
> for visibility.
>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>
> > ---
> > Changes since v3 [Michael Kelley]:
> >  - Employ x86_platform.guest.enc_kexec_{begin,finish} hooks.
> >  - Don't use spinlock in what's now hv_vtom_kexec_finish().
> >  - Handle possible hypercall failures in hv_mark_gpa_visibility()
> >    symmetrically; change hv_list_enc_remove() to return -ENOMEM as well=
.
> >  - Rebase to the latest hyperv/next.
> > ---
> >  arch/x86/hyperv/ivm.c | 211 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 210 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> > index ade6c665c97e..a4615b889f3e 100644
> > --- a/arch/x86/hyperv/ivm.c
> > +++ b/arch/x86/hyperv/ivm.c
> > @@ -462,6 +462,195 @@ void hv_ivm_msr_read(u64 msr, u64 *value)
> >               hv_ghcb_msr_read(msr, value);
> >  }
> >
> > +/*
> > + * Keep track of the PFN regions which were shared with the host. The =
access
> > + * must be revoked upon kexec/kdump (see hv_ivm_clear_host_access()).
> > + */
> > +struct hv_enc_pfn_region {
> > +     struct list_head list;
> > +     u64 pfn;
> > +     int count;
> > +};
> > +
> > +static LIST_HEAD(hv_list_enc);
> > +static DEFINE_RAW_SPINLOCK(hv_list_enc_lock);
> > +
> > +static int hv_list_enc_add(const u64 *pfn_list, int count)
> > +{
> > +     struct hv_enc_pfn_region *ent;
> > +     unsigned long flags;
> > +     u64 pfn;
> > +     int i;
> > +
> > +     for (i =3D 0; i < count; i++) {
> > +             pfn =3D pfn_list[i];
> > +
> > +             raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> > +             /* Check if the PFN already exists in some region first *=
/
> > +             list_for_each_entry(ent, &hv_list_enc, list) {
> > +                     if ((ent->pfn <=3D pfn) && (ent->pfn + ent->count=
 - 1 >=3D pfn))
> > +                             /* Nothing to do - pfn is already in the =
list */
> > +                             goto unlock_done;
> > +             }
> > +
> > +             /*
> > +              * Check if the PFN is adjacent to an existing region. Gr=
owing
> > +              * a region can make it adjacent to another one but mergi=
ng is
> > +              * not (yet) implemented for simplicity. A PFN cannot be =
added
> > +              * to two regions to keep the logic in hv_list_enc_remove=
()
> > +              * correct.
> > +              */
> > +             list_for_each_entry(ent, &hv_list_enc, list) {
> > +                     if (ent->pfn + ent->count =3D=3D pfn) {
> > +                             /* Grow existing region up */
> > +                             ent->count++;
> > +                             goto unlock_done;
> > +                     } else if (pfn + 1 =3D=3D ent->pfn) {
> > +                             /* Grow existing region down */
> > +                             ent->pfn--;
> > +                             ent->count++;
> > +                             goto unlock_done;
> > +                     }
> > +             }
> > +             raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> > +
> > +             /* No adjacent region found -- create a new one */
> > +             ent =3D kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KER=
NEL);
> > +             if (!ent)
> > +                     return -ENOMEM;
> > +
> > +             ent->pfn =3D pfn;
> > +             ent->count =3D 1;
> > +
> > +             raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> > +             list_add(&ent->list, &hv_list_enc);
> > +
> > +unlock_done:
> > +             raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int hv_list_enc_remove(const u64 *pfn_list, int count)
> > +{
> > +     struct hv_enc_pfn_region *ent, *t;
> > +     struct hv_enc_pfn_region new_region;
> > +     unsigned long flags;
> > +     u64 pfn;
> > +     int i;
> > +
> > +     for (i =3D 0; i < count; i++) {
> > +             pfn =3D pfn_list[i];
> > +
> > +             raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> > +             list_for_each_entry_safe(ent, t, &hv_list_enc, list) {
> > +                     if (pfn =3D=3D ent->pfn + ent->count - 1) {
> > +                             /* Removing tail pfn */
> > +                             ent->count--;
> > +                             if (!ent->count) {
> > +                                     list_del(&ent->list);
> > +                                     kfree(ent);
> > +                             }
> > +                             goto unlock_done;
> > +                     } else if (pfn =3D=3D ent->pfn) {
> > +                             /* Removing head pfn */
> > +                             ent->count--;
> > +                             ent->pfn++;
> > +                             if (!ent->count) {
> > +                                     list_del(&ent->list);
> > +                                     kfree(ent);
> > +                             }
> > +                             goto unlock_done;
> > +                     } else if (pfn > ent->pfn && pfn < ent->pfn + ent=
->count - 1) {
> > +                             /*
> > +                              * Removing a pfn in the middle. Cut off =
the tail
> > +                              * of the existing region and create a te=
mplate for
> > +                              * the new one.
> > +                              */
> > +                             new_region.pfn =3D pfn + 1;
> > +                             new_region.count =3D ent->count - (pfn - =
ent->pfn + 1);
> > +                             ent->count =3D pfn - ent->pfn;
> > +                             goto unlock_split;
> > +                     }
> > +
> > +             }
> > +unlock_done:
> > +             raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> > +             continue;
> > +
> > +unlock_split:
> > +             raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> > +
> > +             ent =3D kzalloc(sizeof(struct hv_enc_pfn_region), GFP_KER=
NEL);
> > +             if (!ent)
> > +                     return -ENOMEM;
> > +
> > +             ent->pfn =3D new_region.pfn;
> > +             ent->count =3D new_region.count;
> > +
> > +             raw_spin_lock_irqsave(&hv_list_enc_lock, flags);
> > +             list_add(&ent->list, &hv_list_enc);
> > +             raw_spin_unlock_irqrestore(&hv_list_enc_lock, flags);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/* Stop new private<->shared conversions */
> > +static void hv_vtom_kexec_begin(void)
> > +{
> > +     if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> > +             return;
> > +
> > +     /*
> > +      * Crash kernel reaches here with interrupts disabled: can't wait=
 for
> > +      * conversions to finish.
> > +      *
> > +      * If race happened, just report and proceed.
> > +      */
> > +     if (!set_memory_enc_stop_conversion())
> > +             pr_warn("Failed to stop shared<->private conversions\n");
> > +}
> > +
> > +static void hv_vtom_kexec_finish(void)
> > +{
> > +     struct hv_gpa_range_for_visibility *input;
> > +     struct hv_enc_pfn_region *ent;
> > +     unsigned long flags;
> > +     u64 hv_status;
> > +     int cur, i;
> > +
> > +     local_irq_save(flags);
> > +     input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +
> > +     if (unlikely(!input))
> > +             goto out;
> > +
> > +     list_for_each_entry(ent, &hv_list_enc, list) {
> > +             for (i =3D 0, cur =3D 0; i < ent->count; i++) {
> > +                     input->gpa_page_list[cur] =3D ent->pfn + i;
> > +                     cur++;
> > +
> > +                     if (cur =3D=3D HV_MAX_MODIFY_GPA_REP_COUNT || i =
=3D=3D ent->count - 1) {
> > +                             input->partition_id =3D HV_PARTITION_ID_S=
ELF;
> > +                             input->host_visibility =3D VMBUS_PAGE_NOT=
_VISIBLE;
> > +                             input->reserved0 =3D 0;
> > +                             input->reserved1 =3D 0;
> > +                             hv_status =3D hv_do_rep_hypercall(
> > +                                     HVCALL_MODIFY_SPARSE_GPA_PAGE_HOS=
T_VISIBILITY,
> > +                                     cur, 0, input, NULL);
> > +                             WARN_ON_ONCE(!hv_result_success(hv_status=
));
> > +                             cur =3D 0;
> > +                     }
> > +             }
> > +
> > +     }
> > +
> > +out:
> > +     local_irq_restore(flags);
> > +}
> > +
> >  /*
> >   * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
> >   *
> > @@ -475,6 +664,7 @@ static int hv_mark_gpa_visibility(u16 count, const =
u64 pfn[],
> >       struct hv_gpa_range_for_visibility *input;
> >       u64 hv_status;
> >       unsigned long flags;
> > +     int ret;
> >
> >       /* no-op if partition isolation is not enabled */
> >       if (!hv_is_isolation_supported())
> > @@ -486,6 +676,13 @@ static int hv_mark_gpa_visibility(u16 count, const=
 u64 pfn[],
> >               return -EINVAL;
> >       }
> >
> > +     if (visibility =3D=3D VMBUS_PAGE_NOT_VISIBLE)
> > +             ret =3D hv_list_enc_remove(pfn, count);
> > +     else
> > +             ret =3D hv_list_enc_add(pfn, count);
> > +     if (ret)
> > +             return ret;
> > +
> >       local_irq_save(flags);
> >       input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >
> > @@ -506,8 +703,18 @@ static int hv_mark_gpa_visibility(u16 count, const=
 u64 pfn[],
> >
> >       if (hv_result_success(hv_status))
> >               return 0;
> > +
> > +     if (visibility =3D=3D VMBUS_PAGE_NOT_VISIBLE)
> > +             ret =3D hv_list_enc_add(pfn, count);
> >       else
> > -             return -EFAULT;
> > +             ret =3D hv_list_enc_remove(pfn, count);
> > +     /*
> > +      * There's no good way to recover from -ENOMEM here, the accounti=
ng is
> > +      * wrong either way.
> > +      */
> > +     WARN_ON_ONCE(ret);
> > +
> > +     return -EFAULT;
> >  }
> >
> >  /*
> > @@ -669,6 +876,8 @@ void __init hv_vtom_init(void)
> >       x86_platform.guest.enc_tlb_flush_required =3D hv_vtom_tlb_flush_r=
equired;
> >       x86_platform.guest.enc_status_change_prepare =3D hv_vtom_clear_pr=
esent;
> >       x86_platform.guest.enc_status_change_finish =3D hv_vtom_set_host_=
visibility;
> > +     x86_platform.guest.enc_kexec_begin =3D hv_vtom_kexec_begin;
> > +     x86_platform.guest.enc_kexec_finish =3D hv_vtom_kexec_finish;
> >
> >       /* Set WB as the default cache mode. */
> >       guest_force_mtrr_state(NULL, 0, MTRR_TYPE_WRBACK);
> > --
> > 2.50.1
>
>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

--=20
Thanks
Tianyu Lan

