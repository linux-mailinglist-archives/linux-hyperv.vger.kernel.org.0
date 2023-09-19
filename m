Return-Path: <linux-hyperv+bounces-119-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3257C7A6B36
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Sep 2023 21:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0452814A4
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Sep 2023 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C36B28DDE;
	Tue, 19 Sep 2023 19:11:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCE1D6A7
	for <linux-hyperv@vger.kernel.org>; Tue, 19 Sep 2023 19:11:50 +0000 (UTC)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D30B3
	for <linux-hyperv@vger.kernel.org>; Tue, 19 Sep 2023 12:11:48 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-495d403034eso701300e0c.0
        for <linux-hyperv@vger.kernel.org>; Tue, 19 Sep 2023 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695150708; x=1695755508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW8mrO+WjM59lb43mHDFRdjvI6CRaJcDPnODWQA/f88=;
        b=harOWnhQGPrmNqMMNU4dpYP3dzOyS2fdS5/llW2TfUOZK5pPqaaabGm+PQlnFtRVph
         XLMwBRUleafmUCgPwEHltRi3l0PkIW+/G5z0Lf3AlCiGYdB2/K1TIEUJvDN9LsytJWZ9
         e/w37mlijuWnCnrhAjwR47nB22tgEeIRlIZX4sO6a1W968+hQdpyUEH+26lnosLtQ7R/
         K7HqkZ2n75urgtD6wOyTosjF+mrR9i83Y9GxCSmx/G5PHWmm5qPpMz8V/D7VXo8YBwMC
         YXfyQcmWU6L1GhAZiJHtGQT1LFqJAQLqilUNztT8AYiLBckH/CiEV/e8c006Bi1V9tCS
         zrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695150708; x=1695755508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cW8mrO+WjM59lb43mHDFRdjvI6CRaJcDPnODWQA/f88=;
        b=Zjn84ENMMWbUawOOEgS/6BDibxnZtqN6UPYs9fooAa2vyqhcpqFBoNw3ElZJCeNdst
         fieoBcyTnvYWZBBJMPw3Nckzp/0HV6z9h4qIjjQlIU7focEhKEikE9nwSu7qkBj+vhL6
         YGOqGCE8e7cJjvW3P1JtIO3axHbVx/krcROIRwwpaojRDCfhOslFYzzXiiuuHe6neOF/
         MXHVKyzlGK1qNJUyDDft0HP1TmJh/1V/dChwfe4bC7e5cO9bWmCQCA2ST7udKQuCJnI6
         n6kP8BfJFCGTNCJqXEJi0E1RxIMAC7GRMmFBJ+rjP93vI2jUC+T39QZbPYfdJtCqVo+y
         8yjw==
X-Gm-Message-State: AOJu0YxtRsOCaEKDBgsOLfyBDeXm5WOs9tY3DPnm7n1Yc5mIEha+gc63
	X4lrNB6uqJQjU6Nz4aNV0hsxuTK1HXL6bSQ+VJQ=
X-Google-Smtp-Source: AGHT+IF56BQ+B6GYdWypMvJ6B5mEiR8ZDO3WMSLdjX9RA1Vf2OLQPw4yOUoUCAVLgKmDH4sot7C3XebK8CyTb6CRfGU=
X-Received: by 2002:a05:6122:10cf:b0:493:5938:c8a1 with SMTP id
 l15-20020a05612210cf00b004935938c8a1mr712837vko.0.1695150707658; Tue, 19 Sep
 2023 12:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-90N+t92EfM3QSNcXgiw+ZP+jH1Haso2LiaCoXm-Qp34Anng@mail.gmail.com>
 <DS7PR21MB3127431C332A66480CE1F1F0A0FAA@DS7PR21MB3127.namprd21.prod.outlook.com>
In-Reply-To: <DS7PR21MB3127431C332A66480CE1F1F0A0FAA@DS7PR21MB3127.namprd21.prod.outlook.com>
From: Alex Ionescu <aionescu@gmail.com>
Date: Tue, 19 Sep 2023 15:11:35 -0400
Message-ID: <CAJ-90NJOg=AiX-8svwk54ar8N_HGdDnE2OEQ9PFPYDamRFE=gA@mail.gmail.com>
Subject: Re: [EXTERNAL] Question regarding patches/discussions
To: KY Srinivasan <kys@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, "Michael Kelley (LINUX)" <mikelley@microsoft.com>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for the confirmation KY.

And sorry for the HTML email, fixed.

Best regards,
Alex Ionescu


On Tue, Sep 19, 2023 at 1:10=E2=80=AFPM KY Srinivasan <kys@microsoft.com> w=
rote:
>
> Linux support for Hyper-V has been completely upstreamed and our goal is =
to upstream all new development we do in this space. We welcome contributio=
ns to extend/improve what we currently have and will be happy to review con=
tributions.
>
>
>
> Regards,
>
>
>
> K. Y
>
>
>
> Sent from Outlook
>
> From: Alex Ionescu <aionescu@gmail.com>
> Sent: Tuesday, September 19, 2023 9:59 AM
> To: linux-hyperv@vger.kernel.org
> Cc: KY Srinivasan <kys@microsoft.com>; Dexuan Cui <decui@microsoft.com>; =
Haiyang Zhang <haiyangz@microsoft.com>; Michael Kelley (LINUX) <mikelley@mi=
crosoft.com>; Saurabh Sengar <ssengar@linux.microsoft.com>
> Subject: [EXTERNAL] Question regarding patches/discussions
>
>
>
> You don't often get email from aionescu@gmail.com. Learn why this is impo=
rtant
>
> Dear linux-hyperv Maintainers,
>
>
>
> I understand that the main goal of this submodule/project is to provide a=
 first-class top-tier experience to delight both developers and users when =
running Linux hypervisor on Windows systems by Hyper-V (both in traditional=
 VM scenarios, as well as in Docker and WSL2 scenarios), as well as to prov=
ide a number of strategic capabilities for Azure-related workloads, both in=
ternal to Microsoft and external (including VTL2/HCL, TDX/SNP Isolation, Li=
nux-as-Root-Partition, etc) -- some of which are not expected to be used ou=
tside of specific Azure scenarios within Microsoft.
>
>
>
> That being said, there are some potential additional ideas and projects t=
hat could help improve the experience, stability, security, etc., of Linux-=
under-HyperV, which are not in Microsoft's current or future plans. Are you=
 able and willing to review patches (not necessarily promise to approve) fo=
r linux-hyperv as other linux kernel maintainers normally would, or do you =
consider this a "closed" project for Microsoft purposes only?
>
>
>
> For example, as part of a project at UC Berkeley, I would have some small=
 extensibility patches that I would like to try upstreaming, and some small=
 refactoring (for example, new definitions in the GDK headers were not made=
 available in the TLFS headers -- even stable ones, or some new hypercall s=
upport code was added, but only to the mshv driver/module, and not in the k=
ernel itself, etc...). As you've pushed more new code into the new mshv mod=
ule for VTL2/launching VMs, this prevents (or requires code duplication) li=
ghting up some of those features for other kernel-level functionality that =
I'd like to leverage for hardening/etc. I would also potentially like to in=
vestigate access to hypercalls/hyperv earlier than today (closer to Windows=
' model at UEFI boot).
>
>
>
> But before going too deep into those discussions/proposals, I wanted to s=
ee if such room exists to begin with (and of course assuming it doesn't con=
flict/harm Microsoft's goals/plans).
>
>
>
> Thank you!
>
>
>
>
>
> Best regards,
> Alex Ionescu

