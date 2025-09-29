Return-Path: <linux-hyperv+bounces-7006-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E81BA7FE1
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 07:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9693B849D
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Sep 2025 05:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C12853EF;
	Mon, 29 Sep 2025 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrBhjsih"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D3299922
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Sep 2025 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123882; cv=none; b=o1wv3E67nkpu/mnSCnBXZuvWD4UTBKXpVBXDaZID2LhnKY4FwhsrE34LFeesLWzYgdGruZclWIKDt0Nc5e3NPhiQrHDtvKys3r3aOuCkvM/TVwXbzHh6iz19AmX8sX0prsUeJ3Ur8KmYvxucBUOuSJNFrXp07RbE5SacxYHC6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123882; c=relaxed/simple;
	bh=oJQ8FWvGBZEHTGeu87YeEHFqEIzWJWu8F4gNq+bGfkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFQHy2W1MqflTcGIxtc6td44bjvnSrWNzaCLdHZgjroPGNHLw00bd4T3Fe7p/249T2aKUacC128pHEiH3Ol0yrjbGx8z/vQ4899fhg+/6SVWZxmA4jTiYsyU7zfOfYbOXAJm3r6lNHt6eQc+5m5FOc7ihwZhcTuzq+2abqK2A0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrBhjsih; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b55517e74e3so4413339a12.2
        for <linux-hyperv@vger.kernel.org>; Sun, 28 Sep 2025 22:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759123880; x=1759728680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doWlcC8b0McMQiBWJiLoyDRmWpY9xHMMAXxcR9siitU=;
        b=LrBhjsihYIDplQY4dw7/DtJqd7BqDpPQX3bkFhAuan+R6WtRcnMPDuv69b6YYLm6Fl
         V78LX5dq7YI55kE/vZQYn+oMTZW9wOi9nGzCy9QMXQGTO8WybM/tJVTxMa/+iyCIDgeI
         o8x2SA3LJYBXdY0TKUTEZ0LS4WLq/kCl1hyUF5Uz3fFKQ9A1lMVL6L7C5dVcHdckSDyh
         YmpN3t+27olSD3GtsDCgg5O7Yxmbn7D5WaZFDG69FZXsf0TrlFK/NCQk8qjPNjwNdqc7
         AiqJv9Pw9kl5WujcOScdLZo2LlVZ1DHg1/liazjFKabFIzwBzhwJ06bdTu6YAg5uVYZC
         qn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759123880; x=1759728680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doWlcC8b0McMQiBWJiLoyDRmWpY9xHMMAXxcR9siitU=;
        b=GuM+Up9yM2sKPpAJHWxyKubQf+ILZuwKtxXKZQptxi1hQwIk1lCM1y4Z7TZyWjt273
         rwmAVdWOidkbtLViu/GFRRPI6f0mwolesmxnGHs/p/AUhTVMnq/0oz1AJYdvd1As4sbF
         ekl7Hoje/7HVj3xUiIGf+NvVNPPSn/PmluXETXw9kKxLVjgq49Hj1BD6UNNzL3bQONJy
         X/K4sGx3SpfSLSrjFaYAhIFAyOo2fP9uTsRtDorFIxgr5ohU/wSi27P8lZ2Ggszz78wW
         GYtWBsLPmExSywwz6KFspx1Q1f9CqSxqQCm/lCzdcHQmKwfTbiebtfFJgnJxZYcU3WLS
         d4kg==
X-Gm-Message-State: AOJu0Yxr5e5crisJUP0qmNqroBBQWUjNt7CnpLZ5cFf9hQ4I6/rBNyaN
	BNPLtKhOViRgignlvNeIduN5/Z0K0ZeHLmGKPQ9SvbB/YxZxxzftcljdNVl/EDUKqvUveF2SCSO
	3EJPhK67ra5r0P+kpi7V4BqBt33mwFVY=
X-Gm-Gg: ASbGncsmDzCuSzkP+Z8qNw8vG9mL5KEXcE+gwxzYBPEaI17/dgeE86mW1zBHx2jDORH
	7cQDGVUtziRR5Hq9kJZcT0YJmXgDaTy4N6DjXehrdLhR3vlES2JRsQ7b0gdAcbqvs8gd6X+pGwW
	NV6D7fVp600VTOq8eSo2l7PAKgo4KRzvm8ocmIEe9PS/Wn+Yx67O2hLNgj1pTGSPpszlHn2ZwSz
	PftQDk4u2Dj0jxUgiml99ywCg==
X-Google-Smtp-Source: AGHT+IEPARn0z5jo3i6brNtiscZ9qzgCvgSAmevKNmZOauqFePR2TJLeWUsg7/RlFu97Vhp8VJsSGpH1vra3eNMYILs=
X-Received: by 2002:a17:903:1983:b0:24e:95bb:88b1 with SMTP id
 d9443c01a7336-27ed4a5a871mr165989565ad.34.1759123879994; Sun, 28 Sep 2025
 22:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758903795-18636-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1758903795-18636-3-git-send-email-nunodasneves@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 29 Sep 2025 13:31:04 +0800
X-Gm-Features: AS18NWCyb6eCvgRNb_f1HZ_10ol5VSJZqhZEvIjVmmts76emnLp_YoojriLbSXw
Message-ID: <CAMvTesAag+thUArW-EGL9dxOtGa6CX-8ALUjk9b17M5QBartPA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX hypercall
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com, 
	tiala@microsoft.com, anirudh@anirudhrb.com, paekkaladevi@linux.microsoft.com, 
	skinsburskii@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 12:23=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
>
> This hypercall can be used to fetch extended properties of a
> partition. Extended properties are properties with values larger than
> a u64. Some of these also need additional input arguments.
>
> Add helper function for using the hypercall in the mshv_root driver.
>
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.micros=
oft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
Reviewed-by: Tianyu Lan <tiala@microsoft.com>

>  drivers/hv/mshv_root.h         |  2 ++
>  drivers/hv/mshv_root_hv_call.c | 31 ++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h    |  1 +
>  include/hyperv/hvhdk.h         | 40 ++++++++++++++++++++++++++++++++++
>  include/hyperv/hvhdk_mini.h    | 26 ++++++++++++++++++++++
>  5 files changed, 100 insertions(+)
>
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index e3931b0f1269..4aeb03bea6b6 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -303,6 +303,8 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type=
 type,
>  int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages=
,
>                                    u64 page_struct_count, u32 host_access=
,
>                                    u32 flags, u8 acquire);
> +int hv_call_get_partition_property_ex(u64 partition_id, u64 property_cod=
e, u64 arg,
> +                                     void *property_value, size_t proper=
ty_value_sz);
>
>  extern struct mshv_root mshv_root;
>  extern enum hv_scheduler_type hv_scheduler_type;
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_cal=
l.c
> index c9c274f29c3c..3fd3cce23f69 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -590,6 +590,37 @@ int hv_call_unmap_vp_state_page(u64 partition_id, u3=
2 vp_index, u32 type,
>         return hv_result_to_errno(status);
>  }
>
> +int hv_call_get_partition_property_ex(u64 partition_id, u64 property_cod=
e,
> +                                     u64 arg, void *property_value,
> +                                     size_t property_value_sz)
> +{
> +       u64 status;
> +       unsigned long flags;
> +       struct hv_input_get_partition_property_ex *input;
> +       struct hv_output_get_partition_property_ex *output;
> +
> +       local_irq_save(flags);
> +       input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +       output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +       memset(input, 0, sizeof(*input));
> +       input->partition_id =3D partition_id;
> +       input->property_code =3D property_code;
> +       input->arg =3D arg;
> +       status =3D hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY_EX, inpu=
t, output);
> +
> +       if (!hv_result_success(status)) {
> +               hv_status_debug(status, "\n");
> +               local_irq_restore(flags);
> +               return hv_result_to_errno(status);
> +       }
> +       memcpy(property_value, &output->property_value, property_value_sz=
);
> +
> +       local_irq_restore(flags);
> +
> +       return 0;
> +}
> +
>  int
>  hv_call_clear_virtual_interrupt(u64 partition_id)
>  {
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 1be7f6a02304..ff4325fb623a 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -490,6 +490,7 @@ union hv_vp_assist_msr_contents {    /* HV_REGISTER_V=
P_ASSIST_PAGE */
>  #define HVCALL_GET_VP_STATE                            0x00e3
>  #define HVCALL_SET_VP_STATE                            0x00e4
>  #define HVCALL_GET_VP_CPUID_VALUES                     0x00f4
> +#define HVCALL_GET_PARTITION_PROPERTY_EX               0x0101
>  #define HVCALL_MMIO_READ                               0x0106
>  #define HVCALL_MMIO_WRITE                              0x0107
>
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index b4067ada02cf..416c0d45b793 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -376,6 +376,46 @@ struct hv_input_set_partition_property {
>         u64 property_value;
>  } __packed;
>
> +union hv_partition_property_arg {
> +       u64 as_uint64;
> +       struct {
> +               union {
> +                       u32 arg;
> +                       u32 vp_index;
> +               };
> +               u16 reserved0;
> +               u8 reserved1;
> +               u8 object_type;
> +       } __packed;
> +};
> +
> +struct hv_input_get_partition_property_ex {
> +       u64 partition_id;
> +       u32 property_code; /* enum hv_partition_property_code */
> +       u32 padding;
> +       union {
> +               union hv_partition_property_arg arg_data;
> +               u64 arg;
> +       };
> +} __packed;
> +
> +/*
> + * NOTE: Should use hv_input_set_partition_property_ex_header to compute=
 this
> + * size, but hv_input_get_partition_property_ex is identical so it suffi=
ces
> + */
> +#define HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE \
> +       (HV_HYP_PAGE_SIZE - sizeof(struct hv_input_get_partition_property=
_ex))
> +
> +union hv_partition_property_ex {
> +       u8 buffer[HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE];
> +       struct hv_partition_property_vmm_capabilities vmm_capabilities;
> +       /* More fields to be filled in when needed */
> +};
> +
> +struct hv_output_get_partition_property_ex {
> +       union hv_partition_property_ex property_value;
> +} __packed;
> +
>  enum hv_vp_state_page_type {
>         HV_VP_STATE_PAGE_REGISTERS =3D 0,
>         HV_VP_STATE_PAGE_INTERCEPT_MESSAGE =3D 1,
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 858f6a3925b3..bf2ce27dfcc5 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -96,8 +96,34 @@ enum hv_partition_property_code {
>         HV_PARTITION_PROPERTY_XSAVE_STATES                      =3D 0x000=
60007,
>         HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE               =3D 0x000=
60008,
>         HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY         =3D 0x000=
60009,
> +
> +       /* Extended properties with larger property values */
> +       HV_PARTITION_PROPERTY_VMM_CAPABILITIES                  =3D 0x000=
90007,
>  };
>
> +#define HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT               1
> +#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT  59
> +
> +struct hv_partition_property_vmm_capabilities {
> +       u16 bank_count;
> +       u16 reserved[3];
> +       union {
> +               u64 as_uint64[HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT];
> +               struct {
> +                       u64 map_gpa_preserve_adjustable: 1;
> +                       u64 vmm_can_provide_overlay_gpfn: 1;
> +                       u64 vp_affinity_property: 1;
> +#if IS_ENABLED(CONFIG_ARM64)
> +                       u64 vmm_can_provide_gic_overlay_locations: 1;
> +#else
> +                       u64 reservedbit3: 1;
> +#endif
> +                       u64 assignable_synthetic_proc_features: 1;
> +                       u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESE=
RVED_BITFIELD_COUNT;
> +               } __packed;
> +       };
> +} __packed;
> +
>  enum hv_snp_status {
>         HV_SNP_STATUS_NONE =3D 0,
>         HV_SNP_STATUS_AVAILABLE =3D 1,
> --
> 2.34.1
>
>


--=20
Thanks
Tianyu Lan

