Return-Path: <linux-hyperv+bounces-7007-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F48BA7FE7
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 07:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF343BB24D
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 05:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3D22853EF;
	Mon, 29 Sep 2025 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9+CVI3t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89985194098
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Sep 2025 05:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123920; cv=none; b=Mxk4YOPulLYCTg2aBP2gxnE7FrBfFATed2lJ0IkukGy8BNcRuraYPibmJpw2xkSmoIRWgAj4CG/sMtEre6D4i0gtc9l7sSHCA/yAwJCLw/qXCtFRpufDGEHYdJ4IRD1T5XjW2S63QTyHN1C3LLC4SGQ8T9UfE6SodWeV0xLNMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123920; c=relaxed/simple;
	bh=CecNPkdUQccra+tZmBoz5JgHynC4Wll2ZTqb0pfjaRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sn6fNdcGQQW+wT/5VG2kg/Hgu6ceB6oeRCVMiRONlva6oGYvcFQpBdGBzgBHMlA/Xc5u6UhUDmHWvpCnNENGfniB9EXwMblzg6j/S9iwgmfZDhT/ra6epGglvb8QpAZlZg/bmS5ASo3rpu1ULMTHxQ0mlL0dG6R3QRJY8zWzVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9+CVI3t; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b523fb676efso4098252a12.3
        for <linux-hyperv@vger.kernel.org>; Sun, 28 Sep 2025 22:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759123918; x=1759728718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAaaYirlZjj8WAjFmLwdR9NT4S9TojNMpC7uhhfhzzs=;
        b=f9+CVI3tnFDWe9ibe6IssT0M+lIoGheCPCshv1Aj2q0pgHDgOz8/jzP0bwH3pjjbku
         IsTvOVbMfmtqudWnSaHEuDrxx9Jxre1dh71cCT9xwigKUyiRXU9EL3UoVr+j8gVH0dvC
         XnLcBnpb/bwOj/v0HJ+RLqQ2pq+6ImZkblSvmEyEZQirznSnblfJYign9azHM3NIIiEb
         mMmagsZ4k1SNpz+b0k2Y+mshi8hM/3XU+HUeasC6T4XqH59z/mmHfTxFugEbF3uOjo9V
         oEYus0yhiZ6/3wwd4eWpVp03h8xjBfWOwD8090wQYgXiIOjIPm9F2UmRxYf7KpzS3OpO
         aGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759123918; x=1759728718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAaaYirlZjj8WAjFmLwdR9NT4S9TojNMpC7uhhfhzzs=;
        b=q5nl7oe7nC02PxVfqv5HGPBnABuBIDr7YyIVXjJeOLDCztQduLDFHP9hb06JwKoZPt
         OIUfajp+yCgyyyUSq5AAcpXoSu8arRyNpeVRnBU0XXY80JRPrKg/9BzyttgVg6kmU3Zu
         dXZ1/L3haVciEWw+BTVTD0YAXIZOPalLi5FjpIoy8bQltAarI8z4Vva/lo7C3uGfp5tV
         CF4+UrP+JtC2Jd1VA4szW/Ekied2kVZhtv2ZcsUAix6tZnBCFDZn33hBEk1ILPt1gI44
         cuikJP63SwTSWi5lqgkwjknnE2ZSB3zyrw0ZlfDFuphmevcyOdzPLAqyRJGY6Jf3Zc96
         pCNA==
X-Gm-Message-State: AOJu0Yw3R+IExlL2uyMKQg4N+Y5H2ekIXD552sLx9Xkw8JhDBOLitO5P
	YAiSbg772LguUKvIbYZ0Vgswob7UpHTo+nWXTo2UMrdYrzCG0dZM2bGUv39LJlElquwtEIAI3ra
	XnYkIhc4eZYNMJrYrdRBHwouO/BKGZ/0=
X-Gm-Gg: ASbGncvuj8NH4Od3AVAS24/7zyyv/mflCJ2YDpxAuSLJDFH65vu73hSyEUddblWbOHx
	+aMExqD95ihZF02fz0m82HzPXSLu76y2CYu0VY2kIW9VRNW5BVatmCx91LO2t/AcabB+4qc+sLf
	QSjim8NjaRnc08LuEL4h97yLi8eHiyqm56LDa64chhbRHBOvgOy/p2sQ0eGr+iKhyvkmOXLBztU
	q6igkefsICkHqY4lV2mJqPzeA==
X-Google-Smtp-Source: AGHT+IGhRx8qpixoLgtTv7fh1XF2qnQhp4iiS1sNdN1Sp+W3/Qe8Dx1oxx0XuqziYnZ+xAR33NSGrhCTnTLP5iXNUVQ=
X-Received: by 2002:a17:903:110e:b0:266:64b7:6e38 with SMTP id
 d9443c01a7336-27ed4a47150mr166738315ad.46.1759123917708; Sun, 28 Sep 2025
 22:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758903795-18636-5-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1758903795-18636-5-git-send-email-nunodasneves@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 29 Sep 2025 13:31:41 +0800
X-Gm-Features: AS18NWAQZZ8De10I8yeYC5SAMr-1ACkihRLRDRijc7g8yhuh1pF2mEQqrh3QvQg
Message-ID: <CAMvTesDo=d9fr=o-+e=40DZWau81GybD-59ohiEGjHDgTDiaug@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mshv: Allocate vp state page for
 HVCALL_MAP_VP_STATE_PAGE on L1VH
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com, 
	tiala@microsoft.com, anirudh@anirudhrb.com, paekkaladevi@linux.microsoft.com, 
	skinsburskii@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, 
	Jinank Jain <jinankjain@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 12:48=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> From: Jinank Jain <jinankjain@linux.microsoft.com>
>
> Introduce mshv_use_overlay_gpfn() to check if a page needs to be
> allocated and passed to the hypervisor to map VP state pages. This is
> only needed on L1VH, and only on some (newer) versions of the
> hypervisor, hence the need to check vmm_capabilities.
>
> Introduce functions hv_map/unmap_vp_state_page() to handle the
> allocation and freeing.
>
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
>  drivers/hv/mshv_root.h         | 11 ++---
>  drivers/hv/mshv_root_hv_call.c | 61 ++++++++++++++++++++++++---
>  drivers/hv/mshv_root_main.c    | 76 +++++++++++++++++-----------------
>  3 files changed, 98 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 0cb1e2589fe1..dbe2d1d0b22f 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -279,11 +279,12 @@ int hv_call_set_vp_state(u32 vp_index, u64 partitio=
n_id,
>                          /* Choose between pages and bytes */
>                          struct hv_vp_state_data state_data, u64 page_cou=
nt,
>                          struct page **pages, u32 num_bytes, u8 *bytes);
> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> -                             union hv_input_vtl input_vtl,
> -                             struct page **state_page);
> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type=
,
> -                               union hv_input_vtl input_vtl);
> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +                        union hv_input_vtl input_vtl,
> +                        struct page **state_page);
> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +                          struct page *state_page,
> +                          union hv_input_vtl input_vtl);
>  int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>                         u64 connection_partition_id, struct hv_port_info =
*port_info,
>                         u8 port_vtl, u8 min_connection_vtl, int node);
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index 3fd3cce23f69..98c6278ff151 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -526,9 +526,9 @@ int hv_call_set_vp_state(u32 vp_index, u64 partition_=
id,
>         return ret;
>  }
>
> -int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> -                             union hv_input_vtl input_vtl,
> -                             struct page **state_page)
> +static int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32=
 type,
> +                                    union hv_input_vtl input_vtl,
> +                                    struct page **state_page)
>  {
>         struct hv_input_map_vp_state_page *input;
>         struct hv_output_map_vp_state_page *output;
> @@ -547,7 +547,14 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 =
vp_index, u32 type,
>                 input->type =3D type;
>                 input->input_vtl =3D input_vtl;
>
> -               status =3D hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, inpu=
t, output);
> +               if (*state_page) {
> +                       input->flags.map_location_provided =3D 1;
> +                       input->requested_map_location =3D
> +                               page_to_pfn(*state_page);
> +               }
> +
> +               status =3D hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, inpu=
t,
> +                                        output);
>
>                 if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY)=
 {
>                         if (hv_result_success(status))
> @@ -565,8 +572,39 @@ int hv_call_map_vp_state_page(u64 partition_id, u32 =
vp_index, u32 type,
>         return ret;
>  }
>
> -int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type=
,
> -                               union hv_input_vtl input_vtl)
> +static bool mshv_use_overlay_gpfn(void)
> +{
> +       return hv_l1vh_partition() &&
> +              mshv_root.vmm_caps.vmm_can_provide_overlay_gpfn;
> +}
> +
> +int hv_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +                        union hv_input_vtl input_vtl,
> +                        struct page **state_page)
> +{
> +       int ret =3D 0;
> +       struct page *allocated_page =3D NULL;
> +
> +       if (mshv_use_overlay_gpfn()) {
> +               allocated_page =3D alloc_page(GFP_KERNEL);
> +               if (!allocated_page)
> +                       return -ENOMEM;
> +               *state_page =3D allocated_page;
> +       } else {
> +               *state_page =3D NULL;
> +       }
> +
> +       ret =3D hv_call_map_vp_state_page(partition_id, vp_index, type, i=
nput_vtl,
> +                                       state_page);
> +
> +       if (ret && allocated_page)
> +               __free_page(allocated_page);
> +
> +       return ret;
> +}
> +
> +static int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u=
32 type,
> +                                      union hv_input_vtl input_vtl)
>  {
>         unsigned long flags;
>         u64 status;
> @@ -590,6 +628,17 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u3=
2 vp_index, u32 type,
>         return hv_result_to_errno(status);
>  }
>
> +int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
> +                          struct page *state_page, union hv_input_vtl in=
put_vtl)
> +{
> +       int ret =3D hv_call_unmap_vp_state_page(partition_id, vp_index, t=
ype, input_vtl);
> +
> +       if (mshv_use_overlay_gpfn() && state_page)
> +               __free_page(state_page);
> +
> +       return ret;
> +}
> +
>  int hv_call_get_partition_property_ex(u64 partition_id, u64 property_cod=
e,
>                                       u64 arg, void *property_value,
>                                       size_t property_value_sz)
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e199770ecdfa..2d0ad17acde6 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -890,7 +890,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition =
*partition,
>  {
>         struct mshv_create_vp args;
>         struct mshv_vp *vp;
> -       struct page *intercept_message_page, *register_page, *ghcb_page;
> +       struct page *intercept_msg_page, *register_page, *ghcb_page;
>         void *stats_pages[2];
>         long ret;
>
> @@ -908,28 +908,25 @@ mshv_partition_ioctl_create_vp(struct mshv_partitio=
n *partition,
>         if (ret)
>                 return ret;
>
> -       ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index=
,
> -                                       HV_VP_STATE_PAGE_INTERCEPT_MESSAG=
E,
> -                                       input_vtl_zero,
> -                                       &intercept_message_page);
> +       ret =3D hv_map_vp_state_page(partition->pt_id, args.vp_index,
> +                                  HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +                                  input_vtl_zero, &intercept_msg_page);
>         if (ret)
>                 goto destroy_vp;
>
>         if (!mshv_partition_encrypted(partition)) {
> -               ret =3D hv_call_map_vp_state_page(partition->pt_id, args.=
vp_index,
> -                                               HV_VP_STATE_PAGE_REGISTER=
S,
> -                                               input_vtl_zero,
> -                                               &register_page);
> +               ret =3D hv_map_vp_state_page(partition->pt_id, args.vp_in=
dex,
> +                                          HV_VP_STATE_PAGE_REGISTERS,
> +                                          input_vtl_zero, &register_page=
);
>                 if (ret)
>                         goto unmap_intercept_message_page;
>         }
>
>         if (mshv_partition_encrypted(partition) &&
>             is_ghcb_mapping_available()) {
> -               ret =3D hv_call_map_vp_state_page(partition->pt_id, args.=
vp_index,
> -                                               HV_VP_STATE_PAGE_GHCB,
> -                                               input_vtl_normal,
> -                                               &ghcb_page);
> +               ret =3D hv_map_vp_state_page(partition->pt_id, args.vp_in=
dex,
> +                                          HV_VP_STATE_PAGE_GHCB,
> +                                          input_vtl_normal, &ghcb_page);
>                 if (ret)
>                         goto unmap_register_page;
>         }
> @@ -960,7 +957,7 @@ mshv_partition_ioctl_create_vp(struct mshv_partition =
*partition,
>         atomic64_set(&vp->run.vp_signaled_count, 0);
>
>         vp->vp_index =3D args.vp_index;
> -       vp->vp_intercept_msg_page =3D page_to_virt(intercept_message_page=
);
> +       vp->vp_intercept_msg_page =3D page_to_virt(intercept_msg_page);
>         if (!mshv_partition_encrypted(partition))
>                 vp->vp_register_page =3D page_to_virt(register_page);
>
> @@ -993,21 +990,19 @@ mshv_partition_ioctl_create_vp(struct mshv_partitio=
n *partition,
>         if (hv_scheduler_type =3D=3D HV_SCHEDULER_TYPE_ROOT)
>                 mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
>  unmap_ghcb_page:
> -       if (mshv_partition_encrypted(partition) && is_ghcb_mapping_availa=
ble()) {
> -               hv_call_unmap_vp_state_page(partition->pt_id, args.vp_ind=
ex,
> -                                           HV_VP_STATE_PAGE_GHCB,
> -                                           input_vtl_normal);
> -       }
> +       if (mshv_partition_encrypted(partition) && is_ghcb_mapping_availa=
ble())
> +               hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +                                      HV_VP_STATE_PAGE_GHCB, ghcb_page,
> +                                      input_vtl_normal);
>  unmap_register_page:
> -       if (!mshv_partition_encrypted(partition)) {
> -               hv_call_unmap_vp_state_page(partition->pt_id, args.vp_ind=
ex,
> -                                           HV_VP_STATE_PAGE_REGISTERS,
> -                                           input_vtl_zero);
> -       }
> +       if (!mshv_partition_encrypted(partition))
> +               hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +                                      HV_VP_STATE_PAGE_REGISTERS,
> +                                      register_page, input_vtl_zero);
>  unmap_intercept_message_page:
> -       hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
> -                                   HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> -                                   input_vtl_zero);
> +       hv_unmap_vp_state_page(partition->pt_id, args.vp_index,
> +                              HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> +                              intercept_msg_page, input_vtl_zero);
>  destroy_vp:
>         hv_call_delete_vp(partition->pt_id, args.vp_index);
>         return ret;
> @@ -1748,24 +1743,27 @@ static void destroy_partition(struct mshv_partiti=
on *partition)
>                                 mshv_vp_stats_unmap(partition->pt_id, vp-=
>vp_index);
>
>                         if (vp->vp_register_page) {
> -                               (void)hv_call_unmap_vp_state_page(partiti=
on->pt_id,
> -                                                                 vp->vp_=
index,
> -                                                                 HV_VP_S=
TATE_PAGE_REGISTERS,
> -                                                                 input_v=
tl_zero);
> +                               (void)hv_unmap_vp_state_page(partition->p=
t_id,
> +                                                            vp->vp_index=
,
> +                                                            HV_VP_STATE_=
PAGE_REGISTERS,
> +                                                            virt_to_page=
(vp->vp_register_page),
> +                                                            input_vtl_ze=
ro);
>                                 vp->vp_register_page =3D NULL;
>                         }
>
> -                       (void)hv_call_unmap_vp_state_page(partition->pt_i=
d,
> -                                                         vp->vp_index,
> -                                                         HV_VP_STATE_PAG=
E_INTERCEPT_MESSAGE,
> -                                                         input_vtl_zero)=
;
> +                       (void)hv_unmap_vp_state_page(partition->pt_id,
> +                                                    vp->vp_index,
> +                                                    HV_VP_STATE_PAGE_INT=
ERCEPT_MESSAGE,
> +                                                    virt_to_page(vp->vp_=
intercept_msg_page),
> +                                                    input_vtl_zero);
>                         vp->vp_intercept_msg_page =3D NULL;
>
>                         if (vp->vp_ghcb_page) {
> -                               (void)hv_call_unmap_vp_state_page(partiti=
on->pt_id,
> -                                                                 vp->vp_=
index,
> -                                                                 HV_VP_S=
TATE_PAGE_GHCB,
> -                                                                 input_v=
tl_normal);
> +                               (void)hv_unmap_vp_state_page(partition->p=
t_id,
> +                                                            vp->vp_index=
,
> +                                                            HV_VP_STATE_=
PAGE_GHCB,
> +                                                            virt_to_page=
(vp->vp_ghcb_page),
> +                                                            input_vtl_no=
rmal);
>                                 vp->vp_ghcb_page =3D NULL;
>                         }
>
> --
> 2.34.1
>
>


--=20
Thanks
Tianyu Lan

