Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CED876F603
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Aug 2023 01:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjHCXK7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Aug 2023 19:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjHCXK4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Aug 2023 19:10:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4791F2688;
        Thu,  3 Aug 2023 16:10:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-523108efb36so1182206a12.1;
        Thu, 03 Aug 2023 16:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691104252; x=1691709052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqxbspyQbEJlhoOEMQdrs8QtKj8qZcrhIWPeVeENzWY=;
        b=kGO9D31BmKFmtrxmViY4ULIbTWfmB+CA7pwrTgR4mJEYVwn4VmEiw+YauC9Ip/pOg/
         6JkmzhDHgxhtFy+QEG4uFtc5ZLwnmdsNoeUrFhJRyYL2/24isiRMy8nHbegE5h1qPwdj
         2xyj97HwGVNr1hSsl+yKWm0153nWQc+92mfbi4u6bTRFMPx8OXH9/J/ph92eIdHYe5NP
         FqA9f7BkTqn/b5653egpOHt5vsi9QsZSLTc1NFUrn9aYQ8LLIeJtfJi0bjwoR9rSfCmN
         J937bAavWHcKDRu2t3Ea5HK6wvxPsTjVN8gsTgaYyxnv2LNsXPU6BtnoleFn30cFXLHn
         yYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691104252; x=1691709052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqxbspyQbEJlhoOEMQdrs8QtKj8qZcrhIWPeVeENzWY=;
        b=HmDPiVgGFLfhSuC0zSdXFXvqFvnYgt7ajTPbaa4xsNVb6rSqWr1QTZatdhMR1WgBxQ
         P4d/nPIfWsWAyR1xK4mutANQqA8YRlAq/uKGRHsX46nnWBWwZqexDpZwp6KPVCZvXXmo
         mjlSD0PZRQSJY6hyf6gk9PYogpGI+t4rR2UINAHpnsK6NdMkoUXrteWxxCxkX/MsR2M2
         jcBCIp4uy7wGbYcNE2Y/sYDcjQ2fI5F+fTh44U0ZQcTjVnpK9xu5q+c60sppzJ7b0IPf
         fiXDtpbGS47WuieUa5YjPGKtUG6/jwrg7xwRP8kH7YyCJSQ/LjRQDEZ6exoVwbPUiRXj
         VRmA==
X-Gm-Message-State: AOJu0YyrGlU7wIfa8XT8Xh6KUfFC/FIMshNy0BqqRnnZ6zMKqGGsd5ob
        KKU6X5B+SvUNNOaOFsw6YhgO5TcGtJ93FPmkxZ4=
X-Google-Smtp-Source: AGHT+IFL5zpcm1X3ejAnxVPGdZ5UyqhJp1LtcPedjNRhed4HRpIy+hTW2i8zTfJ8mXzd0hzabmlf6D/2jG0pbL42mTI=
X-Received: by 2002:a05:6402:1212:b0:522:2c9a:92b5 with SMTP id
 c18-20020a056402121200b005222c9a92b5mr149359edw.8.1691104252383; Thu, 03 Aug
 2023 16:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230726-master-v1-1-b2ce6a4538db@gmail.com> <BYAPR21MB16889DB462CEA394895BEBDBD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16889DB462CEA394895BEBDBD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Mitchell Levy <levymitchell0@gmail.com>
Date:   Thu, 3 Aug 2023 16:10:40 -0700
Message-ID: <CAMJwLcy=8vx3WDrFNP178gVUFXB8R2ZdU5dB7J+BnkRJ=W=r6w@mail.gmail.com>
Subject: Re: [PATCH] hv_balloon: Update the balloon driver to use the SBRM API
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mikelly@microsoft.com" <mikelly@microsoft.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 2, 2023 at 10:47=E2=80=AFAM Michael Kelley (LINUX)
<mikelley@microsoft.com> wrote:
>
> From: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.=
org> Sent: Tuesday, July 25, 2023 5:24 PM
> >
> > This patch is intended as a proof-of-concept for the new SBRM
> > machinery[1]. For some brief background, the idea behind SBRM is using
> > the __cleanup__ attribute to automatically unlock locks (or otherwise
> > release resources) when they go out of scope, similar to C++ style RAII=
.
> > This promises some benefits such as making code simpler (particularly
> > where you have lots of goto fail; type constructs) as well as reducing
> > the surface area for certain kinds of bugs.
> >
> > The changes in this patch should not result in any difference in how th=
e
> > code actually runs (i.e., it's purely an exercise in this new syntax
> > sugar). In one instance SBRM was not appropriate, so I left that part
> > alone, but all other locking/unlocking is handled automatically in this
> > patch.
> >
> > Link: https://lore.kernel.org/all/20230626125726.GU4253@hirez.programmi=
ng.kicks-ass.net/ [1]
>
> I haven't previously seen the "[1]" footnote-style identifier used with t=
he
> Link: tag.  Usually the "[1]" goes at the beginning of the line with the
> additional information, but that conflicts with the Link: tag.  Maybe I'm
> wrong, but you might either omit the footnote-style identifier, or the Li=
nk:
> tag, instead of trying to use them together.

Will be sure to fix this (along with the other formatting issues
raised by you and Boqun) in a v2.

>
> Separately, have you built a kernel for ARM64 with these changes in
> place?  The Hyper-V balloon driver is used on both x86 and ARM64
> architectures.  There's nothing obviously architecture specific here,
> but given that SBRM is new, it might be wise to verify that all is good
> when building and running on ARM64.

I have built the kernel and confirmed that it's bootable on ARM64. I
also disassembled the hv_balloon.o output by clang and GCC and
compared the result to the disassembly of the pre-patch version. As
far as I can tell, all the changes should be non-functional (some
register renaming and flipping comparison instructions, etc.), but I
don't believe I can thoroughly test at the moment as memory hot-add is
disabled on ARM64.

>
> >
> > Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: "Mitchell Levy (Microsoft)" <levymitchell0@gmail.com>
> > ---
> >  drivers/hv/hv_balloon.c | 82 +++++++++++++++++++++++------------------=
--------
> >  1 file changed, 38 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > index dffcc894f117..2812601e84da 100644
> > --- a/drivers/hv/hv_balloon.c
> > +++ b/drivers/hv/hv_balloon.c
> > @@ -8,6 +8,7 @@
> >
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/kernel.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/mman.h>
> > @@ -646,7 +647,7 @@ static int hv_memory_notifier(struct notifier_block=
 *nb, unsigned long val,
> >                             void *v)
> >  {
> >       struct memory_notify *mem =3D (struct memory_notify *)v;
> > -     unsigned long flags, pfn_count;
> > +     unsigned long pfn_count;
> >
> >       switch (val) {
> >       case MEM_ONLINE:
> > @@ -655,21 +656,22 @@ static int hv_memory_notifier(struct notifier_blo=
ck *nb, unsigned long val,
> >               break;
> >
> >       case MEM_OFFLINE:
> > -             spin_lock_irqsave(&dm_device.ha_lock, flags);
> > -             pfn_count =3D hv_page_offline_check(mem->start_pfn,
> > -                                               mem->nr_pages);
> > -             if (pfn_count <=3D dm_device.num_pages_onlined) {
> > -                     dm_device.num_pages_onlined -=3D pfn_count;
> > -             } else {
> > -                     /*
> > -                      * We're offlining more pages than we managed to =
online.
> > -                      * This is unexpected. In any case don't let
> > -                      * num_pages_onlined wrap around zero.
> > -                      */
> > -                     WARN_ON_ONCE(1);
> > -                     dm_device.num_pages_onlined =3D 0;
> > +             scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> > +                     pfn_count =3D hv_page_offline_check(mem->start_pf=
n,
> > +                                                       mem->nr_pages);
> > +                     if (pfn_count <=3D dm_device.num_pages_onlined) {
> > +                             dm_device.num_pages_onlined -=3D pfn_coun=
t;
> > +                     } else {
> > +                             /*
> > +                              * We're offlining more pages than we
> > +                              * managed to online. This is
> > +                              * unexpected. In any case don't let
> > +                              * num_pages_onlined wrap around zero.
> > +                              */
> > +                             WARN_ON_ONCE(1);
> > +                             dm_device.num_pages_onlined =3D 0;
> > +                     }
> >               }
> > -             spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> >               break;
> >       case MEM_GOING_ONLINE:
> >       case MEM_GOING_OFFLINE:
> > @@ -721,24 +723,23 @@ static void hv_mem_hot_add(unsigned long start, u=
nsigned long size,
> >       unsigned long start_pfn;
> >       unsigned long processed_pfn;
> >       unsigned long total_pfn =3D pfn_count;
> > -     unsigned long flags;
> >
> >       for (i =3D 0; i < (size/HA_CHUNK); i++) {
> >               start_pfn =3D start + (i * HA_CHUNK);
> >
> > -             spin_lock_irqsave(&dm_device.ha_lock, flags);
> > -             has->ha_end_pfn +=3D  HA_CHUNK;
> > +             scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> > +                     has->ha_end_pfn +=3D  HA_CHUNK;
> >
> > -             if (total_pfn > HA_CHUNK) {
> > -                     processed_pfn =3D HA_CHUNK;
> > -                     total_pfn -=3D HA_CHUNK;
> > -             } else {
> > -                     processed_pfn =3D total_pfn;
> > -                     total_pfn =3D 0;
> > -             }
> > +                     if (total_pfn > HA_CHUNK) {
> > +                             processed_pfn =3D HA_CHUNK;
> > +                             total_pfn -=3D HA_CHUNK;
> > +                     } else {
> > +                             processed_pfn =3D total_pfn;
> > +                             total_pfn =3D 0;
> > +                     }
> >
> > -             has->covered_end_pfn +=3D  processed_pfn;
> > -             spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> > +                     has->covered_end_pfn +=3D  processed_pfn;
> > +             }
> >
> >               reinit_completion(&dm_device.ol_waitevent);
> >
> > @@ -758,10 +759,10 @@ static void hv_mem_hot_add(unsigned long start, u=
nsigned long size,
> >                                */
> >                               do_hot_add =3D false;
> >                       }
> > -                     spin_lock_irqsave(&dm_device.ha_lock, flags);
> > -                     has->ha_end_pfn -=3D HA_CHUNK;
> > -                     has->covered_end_pfn -=3D  processed_pfn;
> > -                     spin_unlock_irqrestore(&dm_device.ha_lock, flags)=
;
> > +                     scoped_guard(spinlock_irqsave, &dm_device.ha_lock=
) {
> > +                             has->ha_end_pfn -=3D HA_CHUNK;
> > +                             has->covered_end_pfn -=3D  processed_pfn;
> > +                     }
> >                       break;
> >               }
> >
> > @@ -781,10 +782,9 @@ static void hv_mem_hot_add(unsigned long start, un=
signed long size,
> >  static void hv_online_page(struct page *pg, unsigned int order)
> >  {
> >       struct hv_hotadd_state *has;
> > -     unsigned long flags;
> >       unsigned long pfn =3D page_to_pfn(pg);
> >
> > -     spin_lock_irqsave(&dm_device.ha_lock, flags);
> > +     guard(spinlock_irqsave)(&dm_device.ha_lock);
> >       list_for_each_entry(has, &dm_device.ha_region_list, list) {
> >               /* The page belongs to a different HAS. */
> >               if ((pfn < has->start_pfn) ||
> > @@ -794,7 +794,6 @@ static void hv_online_page(struct page *pg, unsigne=
d int order)
> >               hv_bring_pgs_online(has, pfn, 1UL << order);
> >               break;
> >       }
> > -     spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> >  }
> >
> >  static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
> > @@ -803,9 +802,8 @@ static int pfn_covered(unsigned long start_pfn, uns=
igned long pfn_cnt)
> >       struct hv_hotadd_gap *gap;
> >       unsigned long residual, new_inc;
> >       int ret =3D 0;
> > -     unsigned long flags;
> >
> > -     spin_lock_irqsave(&dm_device.ha_lock, flags);
> > +     guard(spinlock_irqsave)(&dm_device.ha_lock);
> >       list_for_each_entry(has, &dm_device.ha_region_list, list) {
> >               /*
> >                * If the pfn range we are dealing with is not in the cur=
rent
> > @@ -852,7 +850,6 @@ static int pfn_covered(unsigned long start_pfn, uns=
igned long pfn_cnt)
> >               ret =3D 1;
> >               break;
> >       }
> > -     spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> >
> >       return ret;
> >  }
> > @@ -947,7 +944,6 @@ static unsigned long process_hot_add(unsigned long =
pg_start,
> >  {
> >       struct hv_hotadd_state *ha_region =3D NULL;
> >       int covered;
> > -     unsigned long flags;
> >
> >       if (pfn_cnt =3D=3D 0)
> >               return 0;
> > @@ -979,9 +975,9 @@ static unsigned long process_hot_add(unsigned long =
pg_start,
> >               ha_region->covered_end_pfn =3D pg_start;
> >               ha_region->end_pfn =3D rg_start + rg_size;
> >
> > -             spin_lock_irqsave(&dm_device.ha_lock, flags);
> > -             list_add_tail(&ha_region->list, &dm_device.ha_region_list=
);
> > -             spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> > +             scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> > +                     list_add_tail(&ha_region->list, &dm_device.ha_reg=
ion_list);
> > +             }
> >       }
> >
> >  do_pg_range:
> > @@ -2047,7 +2043,6 @@ static void balloon_remove(struct hv_device *dev)
> >       struct hv_dynmem_device *dm =3D hv_get_drvdata(dev);
> >       struct hv_hotadd_state *has, *tmp;
> >       struct hv_hotadd_gap *gap, *tmp_gap;
> > -     unsigned long flags;
> >
> >       if (dm->num_pages_ballooned !=3D 0)
> >               pr_warn("Ballooned pages: %d\n", dm->num_pages_ballooned)=
;
> > @@ -2073,7 +2068,7 @@ static void balloon_remove(struct hv_device *dev)
> >  #endif
> >       }
> >
> > -     spin_lock_irqsave(&dm_device.ha_lock, flags);
> > +     guard(spinlock_irqsave)(&dm_device.ha_lock);
> >       list_for_each_entry_safe(has, tmp, &dm->ha_region_list, list) {
> >               list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, li=
st) {
> >                       list_del(&gap->list);
> > @@ -2082,7 +2077,6 @@ static void balloon_remove(struct hv_device *dev)
> >               list_del(&has->list);
> >               kfree(has);
> >       }
> > -     spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> >  }
> >
> >  static int balloon_suspend(struct hv_device *hv_dev)
> >
> > ---
> > base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
> > change-id: 20230725-master-bbcd9205758b
> >
> > Best regards,
> > --
> > Mitchell Levy <levymitchell0@gmail.com>
>
> These lines at the end of the patch look spurious.  But Boqun has
> already commented on that.
>
> Michael
