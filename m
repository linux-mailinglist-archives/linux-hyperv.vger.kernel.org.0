Return-Path: <linux-hyperv+bounces-5531-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9614FAB8727
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 14:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070173A460D
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7660E29898C;
	Thu, 15 May 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxPVOsPZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E627A935;
	Thu, 15 May 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313857; cv=none; b=sOCy7xCy/QD70SvCd8xvubKm3ohsorxDZRJ7m3LNdDoNG5Jro/MsnnVfsdwYKSWi9ZMzVWk3XYAI4nk4S+Tw1T0nnjHk42A1IiVI2v8+/vx4ORFNuFjDOgbPeVPjOal3fk5HisQrsfb7rzXLq9CtyBm5PMLYyTdTvqsaiFR9iyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313857; c=relaxed/simple;
	bh=XaKFKX1wryyv9mD5ofnIQ8ARck2qdPeXVeiAwmGRNzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXAYADAdbzdbysXQuShVF1zRZy1C0RZkp2H0lQleoLmHyFOa6js/DCfH9zXkHKJ41kBQcEmtyFLN5a1hoGtSlwPqMz7M0p24xt2VctVoTuOWoh6Vk8wLEodsgzoVjsSubWg3D1c1akDAHqupXWoEkNhMIMX3kgD7423FWwOnhIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxPVOsPZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73c17c770a7so1078884b3a.2;
        Thu, 15 May 2025 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747313855; x=1747918655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1VJIKQzn3Eg+DR16k2/eGqGBeABAciO/xNJ6ACvdIA=;
        b=mxPVOsPZ3nNHgTVYTDfvirZe0MyzMER+cjv0xm0y78aQPpdBNfp6GIwTKx9NbwYfSK
         QlEhonLNP++/CW31GZ54BBToEsofb2YVOczB2cOntDwjxDSoUjEdbwvY97dhKgvonG09
         OVC2O8aEbrL6/QY0KHCTGrpHKGvDtBLd66ATFMxe8gAsS9KShzInUt82yhSr4eKUYceq
         f6ulD3B+U0YYZ641+W2NiBx9wFutAZ2wL3a5UMhvRWwwdPDEYfSGrEwQVGWFlpMjtOEx
         JFaVXaqQsmELSjeE0ujEp0McBtgovx3VHRNY5FrJ58rL+hFmPTByfO8gcRerHye18Z/j
         h1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313855; x=1747918655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1VJIKQzn3Eg+DR16k2/eGqGBeABAciO/xNJ6ACvdIA=;
        b=Z31SOd1B4/S/6byKH1CQzp2qfgykWb+2l4svutbWqXaLfBen5RmTPSf2Vqc7C2a2Db
         o79Xgaxp3Nz6eOCFu20zdXCivMeQmvKnNzfk79bP0XaQcFe3QfGjaNuFKULmRyAFvLrD
         pD7alBQv1+ApKPcmNCzwmv9DhkCsRAeOrl8uxsK3zc29u8lOBTLBefl+JTy9XmVEGIU8
         SDS82G/tkfep6aAvqd/jBjV4gaNQa7HcgrV0RHbgiNx8XMui+2oXxrvqMHAeVgQD5yRY
         gM3lE+tK03Rh8ZgQSLJM7dsVQMf50s0JxNZRAZz9Y0gHCM6O24jI69QkgKsSujt4ZWri
         8g9g==
X-Forwarded-Encrypted: i=1; AJvYcCVpVE1oj7DQ6L45sTBTDSXuoeA3+VBpT5MQrKBkFNdj9q0X/gNpp1YXBJz4Ipqfj4TV4GZngke/0E6FQbI=@vger.kernel.org, AJvYcCXgWmExG5F7bG16/3MtSTTpcZ+PsYzpvay8ph+ZHfM0uTHYGF6lMjtZc1qU8ze/C2Iqhlmf+u1v5FIAz7TX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HqsYVjoKiRZ3J3vrkB5P4ausD5oS+zb8YM2HxLJPryZWpcHY
	uIu18iGFNLLDOV2j92PdYfJ9qKHHYBzbnSHdm/CZJj+wHDZuctDU8Hg7LWpkde9gcqnD4IxOSxQ
	f5pFEBSm2RHxf03o+ZarsYyvKqII=
X-Gm-Gg: ASbGncuU+8Iu6Mx4Mt5SdhdjhbyQN6KympJldMYsry7DisTxb9f9BnchrrsmxJoCz/O
	avqYtGT5zlIzJIjmdHjFpnhPPaRV3sZzM98Ue7WinCafln4zRb/4tTVj1wRlsvcyNMVWFz7NABH
	kxOHai8Nc9ryuRs4hWPlGcDWsQIxMUCO2L67pcWsv8FtaXjDow9oA=
X-Google-Smtp-Source: AGHT+IFF0P1onBZ/hyhfFLv6g0B78R2i66luVTvTXL1v7kzBsCt3CfDJxhT1b6SXjzCdc+9iL4Nlc1feiRZw+OLLGpg=
X-Received: by 2002:a17:902:d50d:b0:224:13a4:d61e with SMTP id
 d9443c01a7336-231983cefacmr95730245ad.51.1747313855162; Thu, 15 May 2025
 05:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506130712.156583-1-ltykernel@gmail.com> <20250506130712.156583-2-ltykernel@gmail.com>
 <SN6PR02MB4157A5928B486CF5D43C50F8D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157A5928B486CF5D43C50F8D491A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 15 May 2025 20:56:58 +0800
X-Gm-Features: AX0GCFugkEn3wtw4pmWDuOVpd7HhwrjuqmM_GwKvfoPaTH4qC8ia1Y50QUr2014
Message-ID: <CAMvTesBnO2crBYRbZQS=2RWta-M1azvsv7Q9RR1-he+iR-4jOA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] x86/Hyper-V: Not use hv apic driver when Secure
 AVIC is available
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>, 
	"yuehaibing@huawei.com" <yuehaibing@huawei.com>, "kvijayab@amd.com" <kvijayab@amd.com>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, 
	"tiala@microsoft.com" <tiala@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:54=E2=80=AFAM Michael Kelley <mhklinux@outlook.c=
om> wrote:
>
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, May 6, 2025 6:07 AM
> >
> >  void __init hv_apic_init(void)
> >  {
> > +     if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> > +             return;
> > +
> >       if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
> >               pr_info("Hyper-V: Using IPI hypercalls\n");
> >               /*
>
> It seems like this patch will cause a bisect problem if a bisect includes
> this patch but none of the subsequent patches in this series. The
> Hyper-V guest VM could see Secure AVIC is enabled, but the VM
> wouldn't boot because the code to allow Hyper-V to inject an interrupt
> haven't been added yet.
>
> This patch probably should come later in the patch series after Secure
> AVIC can be functional in a Hyper-V guest.
>

Good idea! Will rework patch order.

--=20
Thanks
Tianyu Lan

